import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(maind());
}

class maind extends StatefulWidget {
  const maind({super.key});

  @override
  State<maind> createState() => _maindState();
}

class _maindState extends State<maind> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: setup());
  }
}
