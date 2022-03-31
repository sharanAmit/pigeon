import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../providers/api_client_provider.dart';

class DeleteUser extends ConsumerWidget {
  DeleteUser({Key? key}) : super(key: key);
  TextEditingController userIdController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete User"),
      ),
      body: Form(
          child: Container(
        child: ListView(
          children: [
            TextFormField(
              controller: userIdController,
              validator: (text) {
                if (text == null ||
                    text.isEmpty ||
                    text.replaceAll(" ", "").isEmpty) {
                  return "Required";
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () async {
                  try {
                    await ref
                        .read(apiClientProvider)
                        .deleteUser(int.parse(userIdController.text));

                    final snackbar = SnackBar(
                      content: Text(
                          'Id ${userIdController.text} deleted sucessfully'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    userIdController.clear();
                  } on DioError catch (e) {
                    if (e.response != null && e.response!.statusCode == 404) {
                      const snackbar = SnackBar(
                        content: Text("Already deleted"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  } catch (e) {
                    const snackbar = SnackBar(
                      content: Text("An Error occurs "),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
                child: Text("Delete"))
          ],
        ),
      )),
    );
  }
}
