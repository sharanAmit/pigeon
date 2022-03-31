import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'networking/models/comment.dart';
import 'networking/models/post.dart';
import 'networking/models/todo.dart';
import 'networking/models/user.dart';
import 'networking/pages/post/post.dart';
import 'networking/pages/signUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(CommentsAdapter());

  await Hive.openBox('SignUp');
  await Hive.openBox<User>('Users');
  await Hive.openBox<Post>('Posts');
  await Hive.openBox<Comments>('Comments');
  await Hive.openBox<Todo>('Todos');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUp(),
    );
  }
}
