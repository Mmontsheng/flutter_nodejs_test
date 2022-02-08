import 'package:flutter/material.dart';
import 'package:mobile_app/services/authentication.dart';
import 'package:mobile_app/theme/colors.dart';
import 'package:mobile_app/widgets/buttons/primary.dart';
import 'package:mobile_app/widgets/no_glow_behaviour.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final passwordInputController = TextEditingController();
  final usernameInputController = TextEditingController();
  bool isPasswordVisible = false;
  String message = '';
  bool isLoading = false;
  late AuthenticationService service;
  @override
  void dispose() {
    super.dispose();
    usernameInputController.dispose();
    passwordInputController.dispose();
  }

  @override
  void initState() {
    super.initState();
    initServices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScrollConfiguration(
            behavior: NoGlowBehaviour(),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    'Let\'s Sign you in.',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Expanded(
                                  child: Text(
                                    'Welcome back, you have been missed.',
                                    style: TextStyle(
                                        color: AppColors.grey, fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please provide email address';
                                }
                                if (!RegExp(
                                        r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid Email';
                                }
                                return null;
                              },
                              controller: usernameInputController,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 13.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.primary),
                                  ),
                                  labelStyle: TextStyle(color: Colors.black),
                                  labelText: 'Your email address',
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              obscureText: !isPasswordVisible,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please provide a password';
                                }

                                return null;
                              },
                              controller: passwordInputController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 13.0),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                    child: Icon(
                                      isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  labelText: 'Your password',
                                  border: const OutlineInputBorder()),
                            ),
                          ),
                          if (message.isNotEmpty) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(message,
                                  style:
                                      const TextStyle(color: AppColors.danger)),
                            ),
                          ],
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: PrimaryButton(
                              onPressed: () async {
                                final bool isValid =
                                    _formKey.currentState!.validate();
                                if (!isValid || isLoading) {
                                  return;
                                }
                                setState(() {
                                  isLoading = true;
                                  message = "";
                                });
                                String? response = await service.login(
                                    usernameInputController.text,
                                    passwordInputController.text);
                                if (response != null && response.isNotEmpty) {
                                  setState(() {
                                    isLoading = false;
                                    message = response;
                                  });
                                } else {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/');
                                }
                              },
                              isLoading: isLoading,
                              text: 'Login',
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                    color: AppColors.grey, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/register');
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColors.primary,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            )),
      ),
    );
  }

  initServices() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    service = AuthenticationService(localStorage: localStorage);
  }
}
