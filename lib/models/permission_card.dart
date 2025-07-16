class PermissionCard {
  final String appName;
  final String appIcon;
  final String permissions;
  final bool isSafe;
  final bool allowOnRight;

  PermissionCard({
    required this.appName,
    required this.appIcon,
    required this.permissions,
    required this.isSafe,
    required this.allowOnRight
  });

  factory PermissionCard.fromJson(Map<String, dynamic> json) {
    return PermissionCard(
      appName: json['appName'],
      permissions: json['permissions'],
      isSafe: json['isSafe'],
      appIcon: json['appIcon'],
      allowOnRight: true
    );
  }

  PermissionCard copyWith({
    String? appName,
    String? appIcon,
    String? permissions,
    bool? isSafe,
    bool? allowOnRight,
  }) {
    return PermissionCard(
      appName: appName ?? this.appName,
      appIcon: appIcon ?? this.appIcon,
      permissions: permissions?? this.permissions,
      isSafe: isSafe ?? this.isSafe,
      allowOnRight: allowOnRight ?? this.allowOnRight,
    );
  }
}
