import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserServices {
  addBoxes<User>(List<User> items, String containerName) {
    final box = Hive.box<User>(containerName);
    for (var item in items) {
      box.add(item);
    }
  }

  List<User> getBoxes<User>(String containername) {
    List<User> boxList = <User>[];
    final openLid = Hive.box<User>(containername);
    int length = openLid.length;
    for (int i = 0; i < length; i++) {
      boxList.add(openLid.getAt(i)!);
    }

    return boxList;
  }

  deleteBoxes<User>(String containername) async {
    final openLid = Hive.box<User>(containername);
    await openLid.deleteAll(openLid.keys);
  }
}
