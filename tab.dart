import 'package:flutter/material.dart';
import '../screens/book_screen.dart';
class TabeScreen extends StatefulWidget {
  @override
  State<TabeScreen> createState() => _TabeScreenState();
}
class _TabeScreenState extends State<TabeScreen> {
  late List pages;
  @override
  void initState() {
    pages=[
      const BookScreen()
    ];
    super.initState();
  }
  int _selectedPage=1;
  void _selectPage(int value)
  {
    setState(() {
      _selectedPage=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return
       BottomNavigationBar(
        backgroundColor:Theme.of(context).primaryColor,
        selectedItemColor: Color.fromRGBO(130, 198, 208, 0.89),
        unselectedItemColor: Color.fromRGBO(205, 205, 205, 1),
        currentIndex: _selectedPage,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "")
        ],
    );
  }
}