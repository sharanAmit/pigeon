import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../providers/api_client_provider.dart';

class UserUpdate extends ConsumerWidget {
  UserUpdate({Key? key}) : super(key: key);
  TextEditingController userIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userGenderController = TextEditingController();
  TextEditingController userStatusController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            child: ListView(children: [
              TextFormField(
                controller: userIdController,
                decoration:
                    InputDecoration(hintText: "User Id", labelText: "ID"),
              ),
              TextFormField(
                controller: userNameController,
                decoration:
                    InputDecoration(hintText: "Name", labelText: "Name"),
              ),
              TextFormField(
                controller: userEmailController,
                decoration:
                    InputDecoration(hintText: "Email", labelText: "Email"),
              ),
              TextFormField(
                controller: userGenderController,
                decoration: InputDecoration(
                    hintText: "Male/Female", labelText: "Gender"),
              ),
              TextFormField(
                controller: userStatusController,
                decoration: InputDecoration(
                    hintText: "Active/Inactive", labelText: "Status"),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () async {
                    try {
                      User resp = await ref.read(apiClientProvider).updateUser(
                            (userIdController.text),
                            User(
                              int.parse(userIdController.text),
                              userNameController.text,
                              userEmailController.text,
                              userGenderController.text,
                              userStatusController.text,
                            ),
                          );
                      final snackbar = SnackBar(
                        content: Wrap(
                          children: [
                            Text('Congrats 🥳'),
                            Text(userNameController.text,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                                " updated successfully with id : ${userIdController.text}")
                          ],
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      userIdController.clear();
                      userNameController.clear();
                      userEmailController.clear();
                      userGenderController.clear();
                      userStatusController.clear();
                      // print(resp[0].toJson());
                    } catch (e) {
                      print(e.toString());
                      final snackbar = SnackBar(
                        content: Text('Error occurs ${e.runtimeType}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  },
                  child: Text("Done"))
            ]),
          )),
    );
  }
}
