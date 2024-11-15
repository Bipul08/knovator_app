import 'package:flutter/material.dart';
import 'package:knovator_app/views/home_screen.dart';
import 'package:provider/provider.dart'; // Import provider
import 'controllers/post_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Post App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
