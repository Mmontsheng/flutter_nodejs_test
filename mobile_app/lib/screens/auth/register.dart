import 'package:flutter/material.dart';
import 'package:mobile_app/models/authentication/login.dart';
import 'package:mobile_app/models/authentication/register.dart';
import 'package:mobile_app/services/authentication.dart';
import 'package:mobile_app/services/bearer_token.dart';
import 'package:mobile_app/theme/colors.dart';
import 'package:mobile_app/widgets/buttons/primary.dart';
import 'package:mobile_app/widgets/no_glow_behaviour.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final nameInputController = TextEditingController();
  final surnameInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final usernameInputController = TextEditingController();

  bool isPasswordVisible = false;
  bool _isPasswordEightCharacters = false;

  String message = '';
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameInputController.dispose();
    surnameInputController.dispose();
    usernameInputController.dispose();
    passwordInputController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bearerTokenService = Provider.of<BearerTokenService>(context);
    final authenticationService = Provider.of<AuthenticationService>(context);

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
                                    'Register to get started',
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
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please provide a name';
                                }

                                return null;
                              },
                              controller: nameInputController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 13.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelStyle: TextStyle(color: Colors.black),
                                  labelText: 'Your name',
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please provide a surname';
                                }

                                return null;
                              },
                              controller: surnameInputController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 13.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelStyle: TextStyle(color: Colors.black),
                                  labelText: 'Your surname',
                                  border: OutlineInputBorder()),
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
                              onChanged: (password) =>
                                  onPasswordChanged(password),
                              obscureText: !isPasswordVisible,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please provide a password';
                                }
                                if (!isPasswordValid()) {
                                  return 'Password does not meet the criteria';
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
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: _isPasswordEightCharacters
                                        ? Colors.green
                                        : Colors.transparent,
                                    border: _isPasswordEightCharacters
                                        ? Border.all(color: Colors.transparent)
                                        : Border.all(
                                            color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Contains at least 8 characters",
                                style: TextStyle(color: AppColors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
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
                                Map<String, String> body =
                                    getRegistrationRequestBody();
                                RegistrationResponse response =
                                    await authenticationService.register(body);
                                if (response.status != 201) {
                                  setState(() {
                                    isLoading = false;
                                    message = response.message;
                                  });
                                } else {
                                  Map<String, String> body =
                                      getLoginRequestBody();
                                  LoginResponse response =
                                      await authenticationService.login(body);
                                  if (response.status != 200) {
                                    setState(() {
                                      isLoading = false;
                                      message = response.message!;
                                    });
                                  } else {
                                    bearerTokenService.save(response.result);

                                    Navigator.pushNamedAndRemoveUntil(context,
                                        "/", (Route<dynamic> route) => false);
                                  }
                                }
                              },
                              isLoading: isLoading,
                              text: 'Register',
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
                                'Already have an account?',
                                style: TextStyle(
                                    color: AppColors.grey, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/login');
                                },
                                child: const Text(
                                  'Login',
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

  Map<String, String> getRegistrationRequestBody() {
    return {
      "firstName": nameInputController.text,
      "lastName": surnameInputController.text,
      "username": usernameInputController.text,
      "password": passwordInputController.text,
    };
  }

  Map<String, String> getLoginRequestBody() {
    return {
      "username": usernameInputController.text,
      "password": passwordInputController.text,
    };
  }

  bool isPasswordValid() {
    return _isPasswordEightCharacters;
  }

  onPasswordChanged(String password) {
    setState(() {
      message = "";
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;
    });
  }
}
