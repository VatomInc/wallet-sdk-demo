class Location {
  final String country;
  final double latitude;
  final String? locality;
  final double longitude;
  final String? postalCode;
  final String? region;

  Location({
    required this.country,
    required this.latitude,
    this.locality,
    required this.longitude,
    this.postalCode,
    this.region,
  });

  Map<String, dynamic> toJson() => {
        "country": country,
        "latitude": latitude,
        "locality": locality,
        "longitude": longitude,
        "postal_code": postalCode,
        "region": region,
      };

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      country: json['country'],
      latitude: json['latitude'].toDouble(),
      locality: json['locality'],
      longitude: json['longitude'].toDouble(),
      postalCode: json['postal_code'],
      region: json['region'],
    );
  }
}

class UserData {
  final String? bio;
  final String? defaultBusinessId;
  final String? defaultSpaceId;
  final String? email;
  final bool? emailVerified;
  final Location? location;
  final String? name;
  final String? phoneNumber;
  final bool? phoneNumberVerified;
  final String? picture;
  final String? sub;
  final int? expiresAt;
  final int? updatedAt;
  final String? walletAddress;
  final String? website;
  final bool? guest;
  final String? deferredDeeplink;

  UserData({
    this.bio,
    this.defaultBusinessId,
    this.defaultSpaceId,
    this.email,
    this.emailVerified,
    this.location,
    this.name,
    this.phoneNumber,
    this.phoneNumberVerified,
    this.picture,
    this.sub,
    this.expiresAt,
    this.updatedAt,
    this.walletAddress,
    this.website,
    this.guest,
    this.deferredDeeplink,
  });

  Map<String, dynamic> toJson() => {
        "bio": bio,
        "default_business_id": defaultBusinessId,
        "default_space_id": defaultSpaceId,
        "email": email,
        "email_verified": emailVerified,
        "location": location?.toJson(),
        "name": name,
        "phone_number": phoneNumber,
        "phone_number_verified": phoneNumberVerified,
        "picture": picture,
        "sub": sub,
        "updated_at": updatedAt,
        "wallet_address": walletAddress,
        "website": website,
        "guest": guest,
        "deferred_deeplink": deferredDeeplink,
      };

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      bio: json['bio'],
      defaultBusinessId: json['default_business_id'],
      defaultSpaceId: json['default_space_id'],
      email: json['email'],
      emailVerified: json['email_verified'],
      location: Location.fromJson(json['location']),
      name: json['name'],
      phoneNumber: json['phone_number'],
      phoneNumberVerified: json['phone_number_verified'],
      picture: json['picture'],
      sub: json['sub'],
      updatedAt: json['updated_at'],
      walletAddress: json['wallet_address'],
      website: json['website'],
      guest: json['guest'],
      deferredDeeplink: json['deferred_deeplink'],
    );
  }
}

class ScannerFeatures {
  bool? enabled;
  ScannerFeatures({this.enabled});
  Map<String, dynamic> toJson() => {
        "enabled": enabled,
      };
}

class PageThemeHeader {
  String logo;

  PageThemeHeader({required this.logo});

  Map<String, dynamic> toJson() => {
        "logo": logo,
      };
}

class PageThemeIconTitle {
  // Define properties if needed

  Map<String, dynamic> toJson() => {};
}

class PageThemeIcon {
  // Define properties if needed

  Map<String, dynamic> toJson() => {};
}

class PageThemeMain {
  // Define properties if needed

  Map<String, dynamic> toJson() => {};
}

class PageThemeEmptyState {
  // Define properties if needed

  Map<String, dynamic> toJson() => {};
}

class PageTheme {
  PageThemeHeader header;
  PageThemeIconTitle iconTitle;
  PageThemeIcon icon;
  PageThemeMain main;
  PageThemeEmptyState emptyState;
  String mode;
  String pageTheme;

  PageTheme({
    required this.header,
    required this.iconTitle,
    required this.icon,
    required this.main,
    required this.emptyState,
    required this.mode,
    required this.pageTheme,
  });

  Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "iconTitle": iconTitle.toJson(),
        "icon": icon.toJson(),
        "main": main.toJson(),
        "emptyState": emptyState.toJson(),
        "mode": mode,
        "pageTheme": pageTheme,
      };
}

class PageText {
  String emptyState;

  PageText({required this.emptyState});

  Map<String, dynamic> toJson() => {
        "emptyState": emptyState,
      };
}

class PageFeaturesNotifications {
  // Define properties if needed

  Map<String, dynamic> toJson() => {};
}

class PageFeaturesCard {
  // Define properties if needed

  Map<String, dynamic> toJson() => {};
}

class PageFeaturesFooterIcon {
  String id;
  String src;
  String title;

  PageFeaturesFooterIcon({
    required this.id,
    required this.src,
    required this.title,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
        "title": title,
      };
}

class PageFeaturesFooter {
  bool enabled;
  List<PageFeaturesFooterIcon> icons;

  PageFeaturesFooter({
    required this.enabled,
    required this.icons,
  });

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "icons": icons.map((icon) => icon.toJson()).toList(),
      };
}

class PageFeaturesVatom {
  // Define properties if needed

  Map<String, dynamic> toJson() => {};
}

class PageFeaturesIcon {
  // Define properties if needed
  bool badges;
  bool editions;
  bool titles;

  PageFeaturesIcon({
    required this.badges,
    required this.editions,
    required this.titles,
  });

  Map<String, dynamic> toJson() => {
        "badges": badges,
        "editions": editions,
        "titles": titles,
      };
}

class PageFeatures {
  PageFeaturesNotifications? notifications;
  PageFeaturesCard? card;
  PageFeaturesFooter? footer;
  PageFeaturesVatom? vatom;
  PageFeaturesIcon? icon;
  int? maxDistanceForPickup;

  PageFeatures(
      {this.notifications,
      this.card,
      this.footer,
      this.vatom,
      this.icon,
      this.maxDistanceForPickup});

  Map<String, dynamic> toJson() => {
        "notifications": notifications?.toJson(),
        "card": card?.toJson(),
        "footer": footer?.toJson(),
        "vatom": vatom?.toJson(),
        "icon": icon?.toJson(),
        "maxDistanceForPickup": maxDistanceForPickup
      };
}

class PageConfig {
  PageTheme? theme;
  PageText? text;
  PageFeatures? features;

  PageConfig({
    this.theme,
    this.text,
    this.features,
  });

  Map<String, dynamic> toJson() => {
        "theme": theme?.toJson(),
        "text": text?.toJson(),
        "features": features?.toJson(),
      };
}

class VatomConfigFeatures {
  PageConfig? pageConfig;
  String? baseUrl;
  String? path;
  String? language;
  ScannerFeatures? scanner;
  List<String>? visibleTabs;
  bool? hideNavigation;
  bool? hideDrawer;
  bool? hideTokenActions;
  bool? disableNewTokenToast;
  bool? disableArPickup;
  List<Map<String, Object>>? mapStyle;
  String? emptyStateImage;
  String? emptyStateTitle;
  String? emptyStateMessage;
  String? systemThemeOverride;
  AppConfiguration? walletConfig;

  VatomConfigFeatures({
    this.baseUrl,
    this.path,
    this.language,
    this.scanner,
    this.visibleTabs,
    this.hideNavigation,
    this.hideDrawer,
    this.hideTokenActions,
    this.disableNewTokenToast,
    this.pageConfig,
    this.mapStyle,
    this.disableArPickup,
    this.emptyStateImage,
    this.emptyStateTitle,
    this.emptyStateMessage,
    this.systemThemeOverride,
    this.walletConfig,
  });

  Map<String, dynamic> toJson() => {
        "baseUrl": baseUrl,
        "path": path,
        "language": language,
        "scanner": scanner?.toJson(),
        "visibleTabs": visibleTabs,
        "hideNavigation": hideNavigation,
        "hideTokenActions": hideTokenActions,
        "disableNewTokenToast": disableNewTokenToast,
        "pageConfig": pageConfig?.toJson(),
        "mapStyle": mapStyle,
        "hideDrawer": hideDrawer,
        "disableArPickup": disableArPickup,
        "emptyStateImage": emptyStateImage,
        "emptyStateTitle": emptyStateTitle,
        "emptyStateMessage": emptyStateMessage,
        "systemThemeOverride": systemThemeOverride,
        "appConfiguration": walletConfig?.toJson(),
      };
}

class Inventory {
  List<String>? fqdnWhitelist;
  List<String>? tvBlacklist;
  List<String>? objectDefinitionBlacklist;
  bool? splashContent;
  List<String>? pinned;

  Inventory({
    this.fqdnWhitelist = const [],
    this.tvBlacklist = const [],
    this.objectDefinitionBlacklist = const [],
    this.splashContent = true,
    this.pinned = const [],
  });

  Map<String, dynamic> toJson() => {
        "fqdnWhitelist": fqdnWhitelist,
        "tvBlacklist": tvBlacklist,
        "objectDefinitionBlacklist": objectDefinitionBlacklist,
        "splashContent": splashContent,
        "pinned": pinned,
      };
}

class LinearGradient {
  List<String> colors;
  List<double>? start;
  List<double>? end;
  List<double>? locations;

  LinearGradient({
    required this.colors,
    this.start,
    this.end,
    this.locations,
  });

  Map<String, dynamic> toJson() => {
        "colors": colors,
        "start": start,
        "end": end,
        "locations": locations,
      };
}

class NativeBaseColor {
  String? color;
  LinearGradient? linearGradient;

  NativeBaseColor({
    this.color,
    this.linearGradient,
  });

  Map<String, dynamic> toJson() => {
        "color": color,
        "linearGradient": linearGradient?.toJson(),
      };
}

class ARConfig {
  double visibleRadius;
  int maxItems;
  bool resizeObjects;
  double desiredRadius;
  String scalingStrategy;
  double distanceFromCamera;
  double objectBaseHeight;
  double minDistance;
  double additionalRandomDistance;
  String ambientLightColor;

  ARConfig({
    this.visibleRadius = 500,
    this.maxItems = 5,
    this.resizeObjects = true,
    this.desiredRadius = 1,
    this.scalingStrategy = 'new',
    this.distanceFromCamera = 5,
    this.objectBaseHeight = 2,
    this.minDistance = 5,
    this.additionalRandomDistance = 10,
    this.ambientLightColor = '0x404040',
  });

  Map<String, dynamic> toJson() => {
        "visibleRadius": visibleRadius,
        "maxItems": maxItems,
        "resizeObjects": resizeObjects,
        "desiredRadius": desiredRadius,
        "scalingStrategy": scalingStrategy,
        "distanceFromCamera": distanceFromCamera,
        "objectBaseHeight": objectBaseHeight,
        "minDistance": minDistance,
        "additionalRandomDistance": additionalRandomDistance,
        "ambientLightColor": ambientLightColor,
      };
}

class Version {
  String recommended;
  String minimum;
  String link;

  Version({
    required this.recommended,
    required this.minimum,
    required this.link,
  });

  Map<String, dynamic> toJson() => {
        "recommended": recommended,
        "minimum": minimum,
        "link": link,
      };
}

class ApiConfig {
  String? vatom;
  String? vatoms;
  String? userVatom;
  String? oidc;
  String? geo;
  String? billing;
  String? businesses;
  String? studio;
  String? points;
  String? events;
  String? loyalty;
  String? network;
  String? users;

  ApiConfig({
    this.vatom = 'https://api.vi.vatom.network',
    this.vatoms = 'https://vatoms.api.vatominc.com',
    this.userVatom = 'https://api.vi.vatom.network',
    this.oidc = 'https://id.vatom.com',
    this.geo = 'https://maps.googleapis.com',
    this.billing = 'https://billing.api.vatominc.com',
    this.businesses = 'https://businesses.api.vatominc.com',
    this.studio = 'https://studio.api.vatominc.com',
    this.points = 'https://points.api.vatominc.com',
    this.events = 'https://events.api.vatominc.com',
    this.loyalty = 'https://loyalty.api.vatominc.com',
    this.network = 'https://network.api.vatominc.com',
    this.users = 'https://users.vatom.com/',
  });

  Map<String, dynamic> toJson() => {
        "vatom": vatom,
        "vatoms": vatoms,
        "userVatom": userVatom,
        "oidc": oidc,
        "geo": geo,
        "billing": billing,
        "businesses": businesses,
        "studio": studio,
        "points": points,
        "events": events,
        "loyalty": loyalty,
        "network": network,
        "users": users,
      };
}

class PickupConfig {
  bool enabled;
  String redirect;

  PickupConfig({
    this.enabled = true,
    this.redirect = 'https://maps.google.com',
  });

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "redirect": redirect,
      };
}

class MapsConfig {
  PickupConfig pickup;
  List<String> fqdnWhitelist;
  int maxItems;

  MapsConfig({
    required this.pickup,
    this.fqdnWhitelist = const [],
    this.maxItems = 20,
  });

  Map<String, dynamic> toJson() => {
        "pickup": pickup.toJson(),
        "fqdnWhitelist": fqdnWhitelist,
        "maxItems": maxItems,
      };
}

class FirebaseConfig {
  String apiKey;
  String authDomain;
  String databaseURL;
  String projectId;
  String storageBucket;
  String messagingSenderId;
  String appId;
  String measurementId;

  FirebaseConfig({
    this.apiKey = '',
    this.authDomain = 'ydangle-high-fidelity-test-2.firebaseapp.com',
    this.databaseURL = 'https://ydangle-high-fidelity-test-2.firebaseio.com',
    this.projectId = 'ydangle-high-fidelity-test-2',
    this.storageBucket = 'ydangle-high-fidelity-test-2.appspot.com',
    this.messagingSenderId = '190616353628',
    this.appId = '1:190616353628:ios:4cb17f49c64e79342a1f99',
    this.measurementId = 'G-WJ1NRS9JKW',
  });

  Map<String, dynamic> toJson() => {
        "apiKey": apiKey,
        "authDomain": authDomain,
        "databaseURL": databaseURL,
        "projectId": projectId,
        "storageBucket": storageBucket,
        "messagingSenderId": messagingSenderId,
        "appId": appId,
        "measurementId": measurementId,
      };
}

class IconConfig {
  String? icon;
  Object? style; // Placeholder for ImageStyle

  IconConfig({this.icon, this.style});

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "style": style,
      };
}

class ActionConfig {
  String? text;
  String? leftIcon;
  Object? style; // Placeholder for TextStyle
  String action;

  ActionConfig({
    this.text,
    this.leftIcon,
    this.style,
    required this.action,
  });

  Map<String, dynamic> toJson() => {
        "text": text,
        "leftIcon": leftIcon,
        "style": style,
        "action": action,
      };
}

class WalletSchema {
  bool scanner;
  String? emptyStateImage;
  String emptyStateTitle;
  String emptyStateMessage;
  String? inventoryFilter;
  bool showInventory;

  WalletSchema({
    this.scanner = true,
    this.emptyStateImage,
    this.emptyStateTitle = 'Welcome to your Wallet!',
    this.emptyStateMessage =
        'Looks like your wallet is empty. Add your wallet address to show your NFTs',
    this.inventoryFilter,
    this.showInventory = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'scanner': scanner,
      'emptyStateImage': emptyStateImage,
      'emptyStateTitle': emptyStateTitle,
      'emptyStateMessage': emptyStateMessage,
      'inventoryFilter': inventoryFilter,
      'showInventory': showInventory,
    };
  }
}

class RoomSchema {
  bool? hideBackButton;

  RoomSchema({this.hideBackButton = false});

  Map<String, dynamic> toJson() {
    return {
      'hideBackButton': hideBackButton,
    };
  }
}

class IconSchema {
  String? icon;
  String? style;

  IconSchema({this.icon, this.style});
  Map<String, dynamic> toJson() {
    return {"icon": icon, "style": style};
  }
}

class ActionSheetSchema {
  final List<ActionSchema> customActions;
  final List<String> generalInfo;

  ActionSheetSchema({
    List<ActionSchema>? customActions,
    List<String>? generalInfo,
  })  : customActions = customActions ?? [],
        generalInfo = (generalInfo ?? [])
            .map((v) => v.replaceAll(RegExp(r'\s+'), '').toLowerCase())
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'customActions': customActions.map((action) => action.toJson()).toList(),
      'generalInfo': generalInfo,
    };
  }
}

class ActionSchema {
  String? text;
  String? leftIcon;
  String? action;

  ActionSchema(
    this.text,
    this.leftIcon,
    this.action,
  );

  Map<String, dynamic> toJson() {
    return {"text": text, "leftIcon": leftIcon, "action": action};
  }
}

class NftDetalSchema {
  bool? hideCloseButton;
  bool? hideTokenActions;
  IconSchema? customActionBtn;
  ActionSchema? actionsheet;

  NftDetalSchema(
      {this.hideCloseButton = false,
      this.customActionBtn,
      this.hideTokenActions = false,
      this.actionsheet});

  Map<String, dynamic> toJson() {
    return {
      "hideCloseButton": hideCloseButton,
      "customActionBtn": customActionBtn,
      "hideTokenActions": hideTokenActions,
      "actionsheet": actionsheet
    };
  }
}

class MapSchema {
  final dynamic mapStyle;
  final bool disableArPickup;

  MapSchema({
    this.mapStyle,
    this.disableArPickup = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'mapStyle': mapStyle,
      'disableArPickup': disableArPickup,
    };
  }
}

class LoginSchema {
  final bool showUsername;
  final bool showUserQRCode;
  final bool showUserRelations;
  final bool showEditProfile;
  final bool showManageAccountButton;
  final bool showBusinessProfile;

  LoginSchema({
    this.showUsername = true,
    this.showUserQRCode = true,
    this.showUserRelations = true,
    this.showEditProfile = true,
    this.showManageAccountButton = true,
    this.showBusinessProfile = true,
  });

  factory LoginSchema.fromJson(Map<String, dynamic> json) {
    return LoginSchema(
      showUsername: json['showUsername'] ?? true,
      showUserQRCode: json['showUserQRCode'] ?? true,
      showUserRelations: json['showUserRelations'] ?? true,
      showEditProfile: json['showEditProfile'] ?? true,
      showManageAccountButton: json['showManageAccountButton'] ?? true,
      showBusinessProfile: json['showBusinessProfile'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'showUsername': showUsername,
      'showUserQRCode': showUserQRCode,
      'showUserRelations': showUserRelations,
      'showEditProfile': showEditProfile,
      'showManageAccountButton': showManageAccountButton,
      'showBusinessProfile': showBusinessProfile,
    };
  }
}

class ScreensConfigSchema {
  WalletSchema? wallet;
  RoomSchema? roomSchema;
  NftDetalSchema? nftDetalSchema;
  MapSchema? mapSchema;
  LoginSchema? profileUser;

  ScreensConfigSchema(
      {this.wallet,
      this.roomSchema,
      this.nftDetalSchema,
      this.mapSchema,
      this.profileUser});

  Map<String, dynamic> toJson() {
    return {
      'Wallet': wallet != null ? wallet!.toJson() : WalletSchema().toJson(),
      'Room': roomSchema != null ? roomSchema!.toJson() : RoomSchema().toJson(),
      'CommunitiesRoom':
          roomSchema != null ? roomSchema!.toJson() : RoomSchema().toJson(),
      'NFTDetail': nftDetalSchema != null
          ? nftDetalSchema!.toJson()
          : NftDetalSchema().toJson(),
      "Map": mapSchema != null ? mapSchema!.toJson() : MapSchema().toJson(),
      "profileUser":
          profileUser != null ? profileUser!.toJson() : LoginSchema().toJson(),
    };
  }
}

class FeaturesConfig {
  Inventory? inventory;
  ARConfig? ar;
  MapsConfig? maps;
  List<String> allowedChains;
  String? favicon;
  IconConfig? customActionBtn;
  List<ActionConfig>? customActions;
  bool hideCloseButtonOnNft = false;
  String? inventoryFilter;
  ScreensConfigSchema? screensConfig;

  FeaturesConfig(
      {this.inventory,
      this.ar,
      this.maps,
      this.allowedChains = const ['sol', 'eth', 'cspr'],
      this.favicon,
      this.customActionBtn,
      this.customActions,
      this.hideCloseButtonOnNft = false,
      this.inventoryFilter,
      this.screensConfig});

  Map<String, dynamic> toJson() => {
        "inventory": inventory?.toJson(),
        "ar": ar?.toJson(),
        "maps": maps?.toJson(),
        "allowedChains": allowedChains,
        "favicon": favicon,
        "customActionBtn": customActionBtn?.toJson(),
        "customActions":
            customActions?.map((action) => action.toJson()).toList(),
        "hideCloseButtonOnNft": hideCloseButtonOnNft,
        "inventoryFilter": inventoryFilter,
        "screensConfig": screensConfig
      };
}

class AuthConfig {
  String clientId;
  bool useProxy;
  String discoveryUrl;
  String redirectUri;
  List<String> scopes;

  AuthConfig({
    this.clientId = '94JHkdj8jF83jfFF2LI8Q4',
    this.useProxy = false,
    this.discoveryUrl = 'https://id.vatom.com',
    this.redirectUri = 'com.vatom://auth',
    this.scopes = const ['openid', 'profile', 'email', 'offline_access'],
  });

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "useProxy": useProxy,
        "discoveryUrl": discoveryUrl,
        "redirectUri": redirectUri,
        "scopes": scopes,
      };
}

class AppConfiguration {
  String appID;
  String appTitle;
  String businessId;
  List<String>? subBusinesses;
  String viewerId;
  String oauthServer;
  String oidcAuthority;
  String oidcClientId;
  String? mapBoxKey;
  String? studioServer;
  String? googleMapsKey;
  String? googleContactsClientID;
  String? analyticsTrackingID;
  String? geoLocationApi;
  String? algoliaApiKey;
  String algoliaAppId;
  FirebaseConfig? firebase;
  String? websocketServer;
  FeaturesConfig? features;
  String firebaseVapidKey;
  String? appKey8thWall;
  AuthConfig? authentication;
  String? server;
  ApiConfig? api;
  List<String>? browserCompatbilityRegexes;
  Map<String, Version>? versions;
  String? termsOfUseURL;
  String? privacyPolicyURL;
  String? supportURL;
  List<String>? showGeneralInfo;
  bool showProductSelector;
  bool showUsername;
  bool showUserQRCode;
  bool showUserRelations;
  bool showEditProfile;
  bool showManageAccountButton;
  bool showBusinessProfile;
  NativeBaseColor? profileHeaderBackgroundColor;

  AppConfiguration({
    this.appID = 'd9fd1482-3625-4746-854f-726b9032d4ff',
    this.appTitle = 'Vatom Viewer',
    this.businessId = 'system',
    this.subBusinesses,
    this.viewerId = '94JHkdj8jF83jfFF2LI8Q4',
    this.oauthServer = 'https://id.vatom.com',
    this.oidcAuthority = 'https://id.vatom.com',
    this.oidcClientId = '94JHkdj8jF83jfFF2LI8Q4',
    this.mapBoxKey =
        'pk.eyJ1IjoiYXNoaXNoYXR2YXRvbWluYyIsImEiOiJjazlpdXR3M2YwMGNjM2xwcGE1ZDhqMm5jIn0.xBI8uwwTY1H-NOAgtTBvOg',
    this.studioServer,
    this.googleMapsKey = '',
    this.googleContactsClientID = "",
    this.analyticsTrackingID,
    this.geoLocationApi =
        'https://api.ipstack.com/check?access_key=f6c1392b737ae773c32e839ccd03e87f&fields=country_code,latitude,longitude',
    this.algoliaApiKey = 'be2a4102cb0d9d9d6e3cadd46dbf24dc',
    this.algoliaAppId = '1WB4E7CA90',
    this.firebase,
    this.websocketServer,
    this.features,
    this.firebaseVapidKey =
        'BKVxCEXAz6fv-PP0B6ThsF56acxr4bJ14ku-LDZR-vb2LH4ejeeAvCaxGvq2YPpuVX6JWw80_6EE6XeLPwTiMGs',
    this.appKey8thWall =
        'q6f9KSydWOgg0tZAqX7lKHT1kXBa8GNvgQqwxk6UGTadk8Io1pqPBUMt9HTlTLJx4d49lR',
    this.authentication,
    this.server = 'https://api.vi.vatom.network',
    this.api,
    this.browserCompatbilityRegexes,
    this.versions,
    this.termsOfUseURL = 'https://www.vatom.com/terms-of-service/',
    this.privacyPolicyURL = 'http://www.vatom.com/privacy-policy',
    this.supportURL = 'https://support.vatom.com/hc/en-us/requests/new',
    this.showGeneralInfo,
    this.showProductSelector = false,
    this.showUsername = true,
    this.showUserQRCode = true,
    this.showUserRelations = true,
    this.showEditProfile = true,
    this.showManageAccountButton = true,
    this.showBusinessProfile = true,
    this.profileHeaderBackgroundColor,
  });

  Map<String, dynamic> toJson() => {
        "appID": appID,
        "appTitle": appTitle,
        "businessId": businessId,
        "subBusinesses": subBusinesses,
        "viewerId": viewerId,
        "oauthServer": oauthServer,
        "oidcAuthority": oidcAuthority,
        "oidcClientId": oidcClientId,
        "mapBoxKey": mapBoxKey,
        "studioServer": studioServer,
        "googleMapsKey": googleMapsKey,
        "googleContactsClientID": googleContactsClientID,
        "analyticsTrackingID": analyticsTrackingID,
        "geoLocationApi": geoLocationApi,
        "algoliaApiKey": algoliaApiKey,
        "algoliaAppId": algoliaAppId,
        "firebase": firebase?.toJson() ?? FirebaseConfig(),
        "websocketServer": websocketServer,
        "features": features?.toJson() ?? FeaturesConfig(),
        "firebaseVapidKey": firebaseVapidKey,
        "appKey8thWall": appKey8thWall,
        "authentication": authentication?.toJson() ?? AuthConfig(),
        "server": server,
        "api": api?.toJson(),
        "browserCompatbilityRegexes": browserCompatbilityRegexes,
        "versions":
            versions?.map((key, value) => MapEntry(key, value.toJson())),
        "termsOfUseURL": termsOfUseURL,
        "privacyPolicyURL": privacyPolicyURL,
        "supportURL": supportURL,
        "showGeneralInfo": showGeneralInfo,
        "showProductSelector": showProductSelector,
        "showUsername": showUsername,
        "showUserQRCode": showUserQRCode,
        "showUserRelations": showUserRelations,
        "showEditProfile": showEditProfile,
        "showManageAccountButton": showManageAccountButton,
        "showBusinessProfile": showBusinessProfile,
        "profileHeaderBackgroundColor": profileHeaderBackgroundColor?.toJson(),
      };
}
