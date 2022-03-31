import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:password_strength/password_strength.dart';
import 'package:pigeon/networking/pages/login.dart';
import 'package:dio/dio.dart';
import 'package:pigeon/networking/providers/api_client_provider.dart';
import '../models/user.dart';

class SignUp extends ConsumerWidget {
  SignUp({Key? key}) : super(key: key);

  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userGenderController = TextEditingController();
  TextEditingController userStatusController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userPasswordController1 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  final _signBox = Hive.box('SignUp');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SignUp",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            child: ListView(
              children: [
                TextFormField(
                  controller: userNameController,
                  validator: (text) {
                    if (text == null ||
                        text.isEmpty ||
                        text.replaceAll(" ", "").isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter Name", labelText: "Enter Name"),
                ),
                TextFormField(
                  controller: userEmailController,
                  validator: (text) {
                    if (text == null ||
                        text.isEmpty ||
                        text.replaceAll(" ", "").isEmpty) {
                      return "Required";
                    } else if (text.length < 4) {
                      return "Too short";
                    } else if (!EmailValidator.validate(text)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter eMail", labelText: "Enter eMail"),
                ),
                TextFormField(
                  controller: userGenderController,
                  validator: (text) {
                    if (text == null ||
                        text.isEmpty ||
                        text.replaceAll(" ", "").isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Male/Female", labelText: "Male/Female"),
                ),
                TextFormField(
                  controller: userStatusController,
                  decoration: const InputDecoration(
                      hintText: "Active/Inactive",
                      labelText: "Active/Inactive"),
                ),
                TextFormField(
                  obscureText: ref.read(isObscure1),
                  controller: userPasswordController,
                  validator: (text) {
                    if (text != null) {
                      final strength = estimatePasswordStrength(text);
                      if (strength < 0.3) return 'This password is weak!';
                    } else {
                      return "Enter your password";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref.read(isObscure1.notifier).state =
                              !ref.read(isObscure1);
                        },
                        icon: Icon(ref.watch(isObscure1)
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      hintText: "Password",
                      labelText: "Password"),
                ),
                const SizedBox(
                  height: 5,
                ),
                FlutterPwValidator(
                  controller: userPasswordController,
                  minLength: 8,
                  uppercaseCharCount: 1,
                  numericCharCount: 3,
                  specialCharCount: 1,
                  normalCharCount: 3,
                  width: 400,
                  height: 150,
                  onSuccess: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text("Password is matched")));
                  },
                  onFail: () {},
                ),
                TextFormField(
                  controller: userPasswordController1,
                  validator: (text) {
                    if (text != null) {
                      if (text != userPasswordController.text) {
                        return 'This password is not matched';
                      }
                    } else {
                      return "Enter confirm password";
                    }

                    return null;
                  },
                  decoration:
                      const InputDecoration(hintText: "Re-Enter your password"),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ref.read(isLoading.notifier).state = true;
                      try {
                        User resp =
                            await ref.read(apiClientProvider).createUser(
                                  User(
                                      null,
                                      userNameController.text,
                                      userEmailController.text,
                                      userGenderController.text,
                                      userStatusController.text),
                                );
                        _signBox.put("Id", resp.id);
                        _signBox.put('Name', userNameController.text);
                        _signBox.put('Email', userEmailController.text);
                        _signBox.put('Gender', userGenderController.text);
                        _signBox.put('Status', userStatusController.text);
                        _signBox.put('Password', userPasswordController.text);

                        final snackBar = SnackBar(
                          content: Wrap(
                            children: [
                              const Text("Congrats 🥳"),
                              Text(
                                userNameController.text,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(" created succesfully with id : ${resp.id}"),
                            ],
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        userNameController.clear();
                        userEmailController.clear();
                        userGenderController.clear();
                        userStatusController.clear();

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LogIn()));
                      } on DioError catch (e) {
                        final snackbar = SnackBar(
                          content: Text(
                              "${e.response!.statusMessage!}  - ${e.response!.statusCode}"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      } catch (e) {
                        final snackBar = SnackBar(
                          content: Text("Error Occurs ${e.runtimeType}"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: ref.watch(isLoading)
                      ? const CircularProgressIndicator()
                      : const Text("Submit"),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
