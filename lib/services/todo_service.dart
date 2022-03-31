import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoServices {
  addBoxes<ToDo>(List<ToDo> items, String containerName) {
    final box = Hive.box<ToDo>(containerName);
    for (var item in items) {
      box.add(item);
    }
  }

  List<ToDo> getBoxes<ToDo>(String containername) {
    List<ToDo> boxList = <ToDo>[];
    final openLid = Hive.box<ToDo>(containername);
    int length = openLid.length;
    for (int i = 0; i < length; i++) {
      boxList.add(openLid.getAt(i)!);
    }

    return boxList;
  }

  deleteBoxes<ToDo>(String containername) async {
    final openLid = Hive.box<ToDo>(containername);
    await openLid.deleteAll(openLid.keys);
  }
}
