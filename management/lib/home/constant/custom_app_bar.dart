import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final Function(String) onSearch;
  final VoidCallback onMorePressed;

  const CustomAppBar({
    super.key,
    required this.selectedIndex,
    required this.onSearch,
    required this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat("d MMM, yyyy").format(DateTime.now());

    return PreferredSize(
      preferredSize: const Size.fromHeight(120), // Ensure full visibility
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Row: Grid Icon | Search Field | More Button
              Row(
                children: [
                  Icon(Icons.grid_view_outlined, color: Colors.white, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search tasks...",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          prefixIcon: Icon(Icons.search, color: Colors.white70),
                        ),
                        onChanged: onSearch,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.white, size: 28),
                    onPressed: onMorePressed,
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Second Row: Date Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Date",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      Text(
                        todayDate,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.calendar_today, color: Colors.white70, size: 22),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
