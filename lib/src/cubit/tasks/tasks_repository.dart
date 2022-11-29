import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_fb_june_ndz/src/helpers/storage_helper.dart';
import 'package:task_fb_june_ndz/src/helpers/storage_keys.dart';
import 'package:task_fb_june_ndz/src/models/task_model.dart';

class TasksRepository {
  // Params
  // TodoModel
  createTasks(TaskModel taskModel) async {
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference reference = FirebaseFirestore.instance
        .collection("users")
        .doc("$uid")
        .collection("tasks");
    reference.add(taskModel.toJson());
  }

  Future<QuerySnapshot> getTasks() async {
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference reference = FirebaseFirestore.instance
        .collection("users")
        .doc("$uid")
        .collection("tasks");
    QuerySnapshot snapshot = await reference.get();
    return snapshot;
  }

  updateTask(TaskModel updatedTask) async {
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference reference = FirebaseFirestore.instance
        .collection("users")
        .doc("$uid")
        .collection("tasks");
    reference.doc("${updatedTask.id}").update(updatedTask.toJson());
  }

  deleteTask(TaskModel updatedTask) async{
    String? uid = await StorageHelper.readData(StorageKeys.uid.name);
    CollectionReference reference = FirebaseFirestore.instance
        .collection("users")
        .doc("$uid")
        .collection("tasks");
    reference.doc("${updatedTask.id}").delete();
  }
}
