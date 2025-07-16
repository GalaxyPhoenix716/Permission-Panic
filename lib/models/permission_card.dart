class PermissionCard {
  final String id;
  final String appName;
  final String appIcon;
  final String permissions;
  final bool isSafe;
  final bool allowOnRight;

  PermissionCard({
    required this.id,
    required this.appName,
    required this.appIcon,
    required this.permissions,
    required this.isSafe,
    required this.allowOnRight
  });

  factory PermissionCard.fromJson(Map<String, dynamic> json) {
    return PermissionCard(
      id: json['id'],
      appName: json['appName'],
      permissions: json['permissions'],
      isSafe: json['isSafe'],
      appIcon: json['appIcon'],
      allowOnRight: true
    );
  }

  PermissionCard copyWith({
    String? id,
    String? appName,
    String? appIcon,
    String? permissions,
    bool? isSafe,
    bool? allowOnRight,
  }) {
    return PermissionCard(
      id: id ?? this.id,
      appName: appName ?? this.appName,
      appIcon: appIcon ?? this.appIcon,
      permissions: permissions?? this.permissions,
      isSafe: isSafe ?? this.isSafe,
      allowOnRight: allowOnRight ?? this.allowOnRight,
    );
  }
}
