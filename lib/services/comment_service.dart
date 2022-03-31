import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CommentServices {
  addBoxes<Comment>(List<Comment> items, String containerName) {
    final box = Hive.box<Comment>(containerName);
    for (var item in items) {
      box.add(item);
    }
  }

  List<Comment> getBoxes<Comment>(String containername) {
    List<Comment> boxList = <Comment>[];
    final openLid = Hive.box<Comment>(containername);
    int length = openLid.length;
    for (int i = 0; i < length; i++) {
      boxList.add(openLid.getAt(i)!);
    }

    return boxList;
  }

  deleteBoxes<Comment>(String containername) async {
    final openLid = Hive.box<Comment>(containername);
    await openLid.deleteAll(openLid.keys);
  }
}
