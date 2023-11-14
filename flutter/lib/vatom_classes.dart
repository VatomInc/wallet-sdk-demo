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
        "expires_at": expiresAt,
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
      expiresAt: json['expires_at'],
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

class PageFeatures {
  PageFeaturesNotifications notifications;
  PageFeaturesCard card;
  PageFeaturesFooter footer;
  PageFeaturesVatom vatom;

  PageFeatures({
    required this.notifications,
    required this.card,
    required this.footer,
    required this.vatom,
  });

  Map<String, dynamic> toJson() => {
        "notifications": notifications.toJson(),
        "card": card.toJson(),
        "footer": footer.toJson(),
        "vatom": vatom.toJson(),
      };
}

class PageConfig {
  PageTheme theme;
  PageText text;
  PageFeatures features;

  PageConfig({
    required this.theme,
    required this.text,
    required this.features,
  });

  Map<String, dynamic> toJson() => {
        "theme": theme.toJson(),
        "text": text.toJson(),
        "features": features.toJson(),
      };
}

class VatomConfigFeatures {
  PageConfig? pageConfig;
  String? baseUrl;
  String? language;
  ScannerFeatures? scanner;
  List<String>? visibleTabs;
  bool? hideNavigation;
  bool? hideTokenActions;
  bool? disableNewTokenToast;

  VatomConfigFeatures(
      {this.baseUrl,
      this.language,
      this.scanner,
      this.visibleTabs,
      this.hideNavigation,
      this.hideTokenActions,
      this.disableNewTokenToast,
      this.pageConfig});

  Map<String, dynamic> toJson() => {
        // "hideNavigation": hideNavigation,
        // "scanner": scanner?.toJson(),

        "baseUrl": baseUrl,
        "language": language,
        "scanner": scanner?.toJson(),
        "visibleTabs": visibleTabs,
        "hideNavigation": hideNavigation,
        "hideTokenActions": hideTokenActions,
        "disableNewTokenToast": disableNewTokenToast,
        "pageConfig": pageConfig?.toJson()
      };
}
