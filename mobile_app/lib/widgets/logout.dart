import 'package:flutter/material.dart';
import 'package:mobile_app/theme/colors.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onYes;
  const LogoutButton({Key? key, required this.onYes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(15),
                title: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                    onPressed: onYes,
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.logout));
  }
}
