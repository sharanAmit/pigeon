import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pigeon/networking/providers/api_client_provider.dart';
import 'package:dio/dio.dart';
import '../../models/post.dart';
import 'postUpdate.dart';

class PostPage extends ConsumerWidget {
  PostPage({Key? key}) : super(key: key);
  TextEditingController userIdController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditPostPage()));
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.deepPurple,
              )),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => DeletePostPage()));
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 300,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 12,
                      right: 12,
                    ),
                    width: 400,
                    height: 205,
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    child: Column(
                      children: [
                        TextField(
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic),
                          controller: titleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                gapPadding: 0, borderSide: BorderSide.none),
                            hintText: "Post title",
                            hintStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                        TextField(
                          maxLines: 5,
                          controller: bodyController,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                gapPadding: 0, borderSide: BorderSide.none),
                            hintText: "Title Body",
                            hintStyle: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        Post resp =
                            await ref.read(apiClientProvider).createPost(
                                  Post(
                                      null,
                                      // int.parse(userIdController.text),
                                      ref.read(userIdProvider),
                                      titleController.text,
                                      bodyController.text),
                                );
                        final snackbar = SnackBar(
                          content: Wrap(
                            children: [
                              const Text('Congrats 🥳'),
                              Text(userIdController.text,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(" created Successfully with id : ${resp.id}")
                            ],
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        userIdController.clear();
                        titleController.clear();
                        bodyController.clear();
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
                    child: const Text("Post"),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: 100,
                width: 400,
                child: ref.watch(postProvider).when(
                    data: (postResponse) {
                      return ListView.separated(
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () => ref
                                  .read(selectedUserProvider.notifier)
                                  .update(postResponse[index].id!),
                              child: ListTile(
                                  title: Text(postResponse[index].title),
                                  subtitle: Text(postResponse[index].body)),
                            );
                          },
                          separatorBuilder: (_, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: postResponse.length);
                    },
                    error: (error, stackTrace) => Center(
                          child: Text('$error'),
                        ),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ))),
            SizedBox(
                height: 400,
                child: StreamBuilder(
                  stream: Stream.periodic(Duration(seconds: 1))
                      .asyncMap((i) => ref.read(postProvider).when(
                          data: (postResponse) {
                            print(postResponse[0].body);
                            return ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  return GestureDetector(
                                    onTap: () => ref
                                        .read(selectedUserProvider.notifier)
                                        .update(postResponse[index].id!),
                                    child: ListTile(
                                        title: Text(postResponse[index].title),
                                        subtitle:
                                            Text(postResponse[index].body)),
                                  );
                                },
                                separatorBuilder: (_, index) => const SizedBox(
                                      height: 10,
                                    ),
                                itemCount: postResponse.length);
                          },
                          error: (error, stackTrace) => Center(
                                child: Text(
                                  '$error \n $stackTrace',
                                  maxLines: 10,
                                ),
                              ),
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ))), // i is null here (check periodic docs)
                  builder: (context, snapshot) => Text(snapshot.data
                      .toString()), // builder should also handle the case when data is not fetched yet
                ))
          ],
        ),
      ),
    );
  }
}
