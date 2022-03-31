import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';
import '../../providers/api_client_provider.dart';

class UserPage extends ConsumerWidget {
  UserPage({Key? key}) : super(key: key);

  TextEditingController userIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userGenderController = TextEditingController();
  TextEditingController userStatusController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isError = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Create User Account",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const UsersListView()));
                  },
                  child: Text("See all user"),
                ),
                const SizedBox(
                  width: 30,
                ),
                IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => UserEditPage()));
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.deepPurple,
                    )),
                const SizedBox(
                  width: 30,
                ),
                IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => UserDeletePage()));
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    )),
              ],
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 2),
      body: Form(
        key: _formkey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Center(
            child: Container(
              width: 400,
              // color: Colors.red,
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      controller: userNameController,
                      decoration: const InputDecoration(
                        labelText: "Enter Name",
                        hintText: "Enter Name",
                        // hintStyle: TextStyle(color: Colors.deepPurple)
                      )),
                  const SizedBox(height: 5),
                  TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      controller: userEmailController,
                      decoration: const InputDecoration(
                        labelText: "Enter eMail",
                        hintText: "Enter eMail",
                        // hintStyle: TextStyle(color: Colors.deepPurple)
                      )),
                  const SizedBox(height: 5),
                  TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      controller: userGenderController,
                      decoration: const InputDecoration(
                        labelText: "Male/Female",

                        hintText: "Male/Female",
                        // hintStyle: TextStyle(color: Colors.deepPurple)
                      )),
                  const SizedBox(height: 5),
                  TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      controller: userStatusController,
                      decoration: const InputDecoration(
                        labelText: "Status(Active/Inactive)",
                        hintText: "Status(Active/Inactive)",
                        // hintStyle: TextStyle(color: Colors.deepPurple)
                      )),
                  const SizedBox(height: 15),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
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
                            final snackbar = SnackBar(
                              content: Wrap(
                                children: [
                                  Text('Congrats 🥳'),
                                  Text(userNameController.text,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                      " created Successfully with id : ${resp.id}")
                                ],
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                            userNameController.clear();
                            userEmailController.clear();
                            userGenderController.clear();
                            userStatusController.clear();
                          } catch (e) {
                            print(e.toString());
                            final snackbar = SnackBar(
                              content: Text('Error occurs ${e.runtimeType}'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        }
                      },
                      child: const Text("Submit"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



                      // if (userNameController == null &&
                      //     userEmailController == null &&
                      //     userGenderController == null &&
                      //     userStatusController == null) {
                      //   final snackbar = SnackBar(
                      //     content: const Text('Hello world, Snackbar here!'),
                      //   );
                      //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      // }else {
                        
                      // }