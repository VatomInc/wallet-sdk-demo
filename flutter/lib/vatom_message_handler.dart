import 'dart:async';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:uuid/uuid.dart';

class VatomMessage {
  final String id;
  final String? name;
  final bool request;
  final dynamic payload;
  final String? error;

  VatomMessage(
      {required this.id,
      this.name,
      required this.request,
      required this.payload,
      this.error});
}

class PendingRequest {
  final Function resolve;
  final Function reject;
  final Timer timer;

  PendingRequest(
      {required this.resolve, required this.reject, required this.timer});
}

class VatomMessageHandler {
  late WebViewController controller;
  Map<String, PendingRequest> pending = {};
  Map<String, Function> handlers = {};

  set setController(WebViewController controller) {
    this.controller = controller;
  }

  onMessage(JavaScriptMessage msg) {
    var data = decodeMessage(msg);
    final name = data?.name;
    final id = data?.id;
    final request = data?.request;
    final payload = data?.payload;
    final error = data?.error;

    if (id == null) {
      return;
    }

    if (request != null && request) {
      Future(() {
        final handler = handlers[name];
        if (handler == null) throw Exception('No handler registered for $name');
        if (payload != null && payload != {}) {
          return handler(payload);
        } else {
          return handler();
        }
      }).then((payload) {
        sendPayload({'id': id, 'payload': payload, 'request': false});
      }).catchError((err) {
        sendPayload({'id': id, 'error': err.toString(), 'request': false});
      });
    } else {
      if (!pending.containsKey(id)) {
        return;
      }

      if (error != null) {
        pending[id]?.reject(Exception(error));
      } else {
        pending[id]?.resolve(payload);
      }

      pending[id]?.timer.cancel();
      pending.remove(id);
    }
  }

  VatomMessage? decodeMessage(JavaScriptMessage message) {
    try {
      final decodedData = jsonDecode(message.message.toString());
      return VatomMessage(
          id: decodedData["id"],
          name: decodedData["name"],
          request: decodedData["request"],
          payload: decodedData["payload"]);
    } catch (e) {
      // print('Error decoding message: $e');
      return null;
    }
  }

  sendPayload(Map<Object, Object?> payload) {
    try {
      controller.runJavaScript('''
        window.postMessage(${jsonEncode(payload)});
      ''');
    } catch (e) {
      // print('Error sending message: $e');
    }
  }

  void handle(String name, Function callback) {
    handlers[name] = callback;
  }

  Future sendMsg(String name, [Object? payload]) {
    var id = Uuid().v4();
    sendPayload({"id": id, "name": name, "payload": payload, "request": true});

    // Create pending promise
    final completer = Completer();

    // Create timeout timer
    final timer = Timer(const Duration(seconds: 15), () {
      pending[id]?.reject(ArgumentError('Timed out waiting for response.'));
      pending.remove(id);
    });

    // Store pending promise
    pending[id] = PendingRequest(
        resolve: completer.complete,
        reject: completer.completeError,
        timer: timer);

    return completer.future;
  }
}
