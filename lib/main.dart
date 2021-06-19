import 'package:flutter/material.dart';
import 'package:musicui/screens/homescreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(behavior: MyBehaviour(), child: child!);
      },
      debugShowCheckedModeBanner: false,
      title: 'Music UI',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class MyBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
