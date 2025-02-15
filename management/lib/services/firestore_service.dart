import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(String title, String description, DateTime dueDate,
      String priority) async {
    await tasksCollection.add({
      'title': title,
      'description': description,
      'dueDate': Timestamp.fromDate(dueDate), // 🔥 Store as Timestamp
      'priority': priority,
      'isCompleted': false,
    });
  }

  // 🔄 Real-time Task Stream
  Stream<QuerySnapshot> getTasksStream() {
    return tasksCollection.snapshots();
  }

  Future<void> updateTask(String taskId, bool isCompleted) async {
    await tasksCollection.doc(taskId).update({'isCompleted': isCompleted});
  }

  Future<void> deleteTask(String taskId) async {
    await tasksCollection.doc(taskId).delete();
  }
}
