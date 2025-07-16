import 'package:flutter/material.dart';
import 'package:permission_panic/models/permission_card.dart';
import 'package:permission_panic/utils/constants/helpers.dart';

class PermissionCardWidget extends StatelessWidget {
  final PermissionCard permissionCard;
  const PermissionCardWidget({super.key, required this.permissionCard});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: PPHelpers.getScreenWidth(context) > 400
          ? 500
          : PPHelpers.getScreenWidth(context) * 0.8,
      height: 600,
      child: Card(
        color: Color(0xFF161B22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Image(image: AssetImage(permissionCard.appIcon)),
                  ),
                  const SizedBox(width: 15),
                  Text(permissionCard.appName),
                ],
              ),
              Text(permissionCard.permissions),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "<- DENY",
                      style: TextStyle(color: Color(0xFF3DDC84)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "ALLOW ->",
                      style: TextStyle(color: Color(0xFFFF4C4C)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
