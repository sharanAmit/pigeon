import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PostServices {
  addBoxes<Post>(List<Post> items, String containerName) {
    final box = Hive.box<Post>(containerName);
    for (var item in items) {
      box.add(item);
    }
  }

  List<Post> getBoxes<Post>(String containername) {
    List<Post> boxList = <Post>[];
    final openLid = Hive.box<Post>(containername);
    int length = openLid.length;
    for (int i = 0; i < length; i++) {
      boxList.add(openLid.getAt(i)!);
    }

    return boxList;
  }

  deleteBoxes<Post>(String containername) async {
    final openLid = Hive.box<Post>(containername);
    await openLid.deleteAll(openLid.keys);
  }
}
