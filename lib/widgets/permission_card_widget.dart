import 'package:flutter/material.dart';
import 'package:permission_panic/models/permission_card.dart';

class PermissionCardWidget extends StatelessWidget {
  final PermissionCard permissionCard;
  const PermissionCardWidget({super.key, required this.permissionCard});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF161B22),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(image: AssetImage(permissionCard.appIcon)),
              const SizedBox(width: 15,),
              Text(permissionCard.appName),
            ],
          ),
          Text(permissionCard.permissions),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(onPressed: () {}, child: const Text("<- DENY")),
              TextButton(onPressed: () {}, child: const Text("ALLOW ->")),
            ],
          ),
          ],
        ),
      ),
    );
  }
}
