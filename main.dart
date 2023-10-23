import 'package:book/screens/book_screen.dart';
import 'package:book/screens/comment.dart';
import 'package:book/screens/sellar_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(236, 231, 225, 1),
        primaryColor: const Color.fromRGBO(236, 231, 225, 1),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Color.fromRGBO(236, 231, 225, 1),
            titleTextStyle: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
            centerTitle: true),
      ),
      routes: {
        '/': (context) => const BookScreen(),
        Comment.routName: (context)=>Comment(),
        SellerInfo.routName:(context)=>SellerInfo(),
      },
    );
  }
}
