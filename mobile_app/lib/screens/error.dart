import 'package:flutter/material.dart';
import 'package:mobile_app/theme/colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/error.png', width: 250, height: 250),
              const Text('We\'re sorry',
                  style: TextStyle(color: AppColors.primary, fontSize: 25)),
              const SizedBox(height: 10),
              const Text('But an error occurred. Please try again.',
                  style: TextStyle(color: AppColors.grey)),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Go back'),
                // child: PrimaryButton(
                //   onPressed: () {
                //     final user = FirebaseAuth.instance.currentUser;

                //     Navigator.of(context)
                //         .pushReplacementNamed(user != null ? '/' : '/welcome');
                //   },
                //   isLoading: false,
                //   text: 'Go Back',
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
