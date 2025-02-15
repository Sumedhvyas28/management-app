import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:management/services/firestore_service.dart';

class DashboardContent extends StatelessWidget {
  final String searchQuery;
  final String selectedPriority;
  final String selectedStatus;

  const DashboardContent({
    super.key,
    required this.searchQuery,
    required this.selectedPriority,
    required this.selectedStatus,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreService().getTasksStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<DocumentSnapshot> tasks = snapshot.data!.docs;

        List<Map<String, dynamic>> filteredTasks = tasks.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id; // Store document ID
          return data;
        }).toList();

        // Filter by Priority
        if (selectedPriority != "All") {
          filteredTasks = filteredTasks
              .where((task) => task['priority'] == selectedPriority)
              .toList();
        }

        // Filter by Status
        if (selectedStatus == "Completed") {
          filteredTasks = filteredTasks
              .where((task) => task['status'] == "Completed")
              .toList();
        } else if (selectedStatus == "Incomplete") {
          filteredTasks = filteredTasks
              .where((task) => task['status'] != "Completed")
              .toList();
        }

        // Filter by Search Query
        if (searchQuery.isNotEmpty) {
          filteredTasks = filteredTasks
              .where(
                  (task) => task['title'].toLowerCase().contains(searchQuery))
              .toList();
        }

        return ListView.builder(
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) {
            var task = filteredTasks[index];

            // Extract Date (YYYY-MM-DD)
            String dueDateText;
            if (task['dueDate'] is Timestamp) {
              DateTime dueDate = task['dueDate'].toDate();
              dueDateText = "${dueDate.year}-${dueDate.month}-${dueDate.day}";
            } else if (task['dueDate'] is String) {
              dueDateText = task['dueDate']
                  .substring(0, 10); // First 10 chars (YYYY-MM-DD)
            } else {
              dueDateText = "Unknown Date";
            }

            return Slidable(
              key: Key(task['id']),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      await FirestoreService().deleteTask(task['id']);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Card(
                color: Colors.white, // Blue Accent
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: ListTile(
                  title: Text(task['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  subtitle: Text(
                    "Due: $dueDateText", // Only show YYYY-MM-DD
                    style: const TextStyle(color: Colors.black),
                  ),
                  trailing: Text(
                    task['priority'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: task['priority'] == "High"
                          ? Colors.red
                          : (task['priority'] == "Medium"
                              ? Colors.orange
                              : Colors.green),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
