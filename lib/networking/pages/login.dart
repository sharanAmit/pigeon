import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:pigeon/networking/providers/api_client_provider.dart';
import 'post/post.dart';

class LogIn extends ConsumerWidget {
  LogIn({Key? key}) : super(key: key);

  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _signUp = Hive.box('SignUp');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 12, right: 12),
            child: ListView(
              children: [
                TextFormField(
                  controller: userEmailController,
                  validator: (text) {
                    if (text == null ||
                        text.isEmpty ||
                        text.replaceAll(" ", "").isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Email", labelText: "Email"),
                ),
                TextFormField(
                  obscureText: ref.read(isObscure),
                  controller: userPasswordController,
                  validator: (text) {
                    if (text == null ||
                        text.isEmpty ||
                        text.replaceAll(" ", "").isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref.read(isObscure.notifier).state =
                              !ref.read(isObscure);
                        },
                        icon: Icon(ref.watch(isObscure)
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      hintText: "Enter password",
                      labelText: "Password"),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (userEmailController.text == _signUp.get('Email') &&
                            userPasswordController.text ==
                                _signUp.get('Password')) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostPage()));
                        }
                      }
                    },
                    child: const Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
