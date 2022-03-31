import 'dart:html';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/comment.dart';
import '../../providers/api_client_provider.dart';

class CommentPage extends ConsumerWidget {
  CommentPage({Key? key}) : super(key: key);

  TextEditingController commentIdController = TextEditingController();
  TextEditingController postIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController commentbodyController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "User Comment",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.deepPurple,
                )),
            SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                )),
          ],
          backgroundColor: Colors.white,
          elevation: 2),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(
          child: Container(
            width: 400,
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                // TextFormField(
                //     decoration: const InputDecoration(hintText: "Enter Id")),
                // const SizedBox(height: 5),
                TextFormField(
                    controller: postIdController,
                    decoration:
                        const InputDecoration(hintText: "Enter post_id")),
                const SizedBox(height: 5),
                TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(hintText: "Enter name")),
                const SizedBox(height: 5),
                TextFormField(
                    controller: userEmailController,
                    decoration: const InputDecoration(hintText: "Enter email")),
                const SizedBox(height: 5),
                TextFormField(
                    controller: commentbodyController,
                    decoration: const InputDecoration(hintText: "Enter body")),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        Comments resp = await ref
                            .read(apiClientProvider)
                            .createComment(Comments(
                                null,
                                int.parse(postIdController.text),
                                userNameController.text,
                                userEmailController.text,
                                commentbodyController.text));
                        final snackbar = SnackBar(
                          content: Wrap(
                            children: [
                              const Text('Congrats 🥳'),
                              Text(userNameController.text,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(" created Successfully with id : ${resp.id}")
                            ],
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        postIdController.clear();
                        userNameController.clear();
                        userEmailController.clear();
                        commentbodyController.clear();
                      } on DioError catch (e) {
                        print(e.message);
                        print(e.response);
                      } catch (e) {
                        print(e.toString());
                        final snackbar = SnackBar(
                          content: Text('Error occurs ${e.runtimeType}'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
