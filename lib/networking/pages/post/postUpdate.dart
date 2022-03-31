import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../models/post.dart';
import '../../providers/api_client_provider.dart';

class EditPostPage extends ConsumerWidget {
  EditPostPage({Key? key}) : super(key: key);
  TextEditingController editpostIdController = TextEditingController();
  TextEditingController editPostUserIdController = TextEditingController();
  TextEditingController editPostTitleController = TextEditingController();
  TextEditingController editPostBodyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Post"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Center(
            child: Container(
              width: 400,
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      controller: editpostIdController,
                      decoration: const InputDecoration(
                        hintText: "Enter Id",
                      )),
                  const SizedBox(height: 5),
                  TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      controller: editPostUserIdController,
                      decoration: const InputDecoration(
                        hintText: "Enter User_ID",
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
                      controller: editPostTitleController,
                      decoration: const InputDecoration(
                        hintText: "Enter Title",
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
                      controller: editPostBodyController,
                      decoration: const InputDecoration(
                        hintText: "Enter Body",
                        // hintStyle: TextStyle(color: Colors.deepPurple)
                      )),
                  const SizedBox(height: 5),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            Post resp =
                                await ref.read(apiClientProvider).updatePost(
                                    editpostIdController.text,
                                    Post(
                                      int.parse(editpostIdController.text),
                                      int.parse(editPostUserIdController.text),
                                      editPostTitleController.text,
                                      editPostBodyController.text,
                                    ));

                            final snackbar = SnackBar(
                              content: Wrap(
                                children: [
                                  Text('Congrats 🥳'),
                                  Text(editpostIdController.text,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                      " updated successfully with id : ${editPostUserIdController.text}")
                                ],
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                            editpostIdController.clear();
                            editPostUserIdController.clear();
                            editPostTitleController.clear();
                            editPostBodyController.clear();
                            // print(resp[0].toJson());
                          } on DioError catch (e) {
                            print(e.message);
                            print(e.response);
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
    ;
  }
}
