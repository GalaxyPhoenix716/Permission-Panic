class PermissionCard {
  final String appName;
  final String appIcon;
  final String permissions;
  final bool isSafe;

  PermissionCard({
    required this.appName,
    required this.appIcon,
    required this.permissions,
    required this.isSafe,
  });

  factory PermissionCard.fromJson(Map<String, dynamic> json) {
    return PermissionCard(
      appName: json['appName'],
      permissions: json['permissions'],
      isSafe: json['isSafe'],
      appIcon: json['appIcon'],
    );
  }
}
