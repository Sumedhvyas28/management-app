import 'package:flutter/material.dart';
import 'package:management/home/constant/custom_app_bar.dart';
import 'package:management/home/constant/custom_nav_bar.dart';
import 'package:management/home/more.dart';
import 'package:management/services/firestore_service.dart';
import 'package:management/home/dashboard_content.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  String _searchQuery = "";
  String _selectedPriority = "All"; // Default: Show all priorities
  String _selectedStatus = "All"; // Default: Show all statuses

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  void _onMorePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MorePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        selectedIndex: _selectedIndex,
        onSearch: _onSearch,
        onMorePressed: _onMorePressed,
      ),
      body: Column(
        children: [
          // Dropdown for Sorting & Filtering
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Priority Filter Dropdown
                DropdownButton<String>(
                  value: _selectedPriority,
                  items: ["All", "High", "Medium", "Low"]
                      .map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Text("Priority: $priority"),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                ),

                // Status Filter Dropdown
                DropdownButton<String>(
                  value: _selectedStatus,
                  items: ["All", "Completed", "Incomplete"]
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text("Status: $status"),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value!;
                    });
                  },
                ),
              ],
            ),
          ),

          // Pass filters to DashboardContent
          Expanded(
            child: DashboardContent(
              searchQuery: _searchQuery,
              selectedPriority: _selectedPriority,
              selectedStatus: _selectedStatus,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    String priority = "Medium";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Title")),
              TextField(
                  controller: descController,
                  decoration: InputDecoration(labelText: "Description")),
              DropdownButton<String>(
                value: priority,
                onChanged: (String? newValue) {
                  if (newValue != null) priority = newValue;
                },
                items: ["Low", "Medium", "High"]
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            TextButton(
              onPressed: () async {
                await FirestoreService().addTask(titleController.text,
                    descController.text, selectedDate, priority);
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
