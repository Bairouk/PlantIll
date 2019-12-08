import 'package:flutter/material.dart';
import 'package:ocp/services/auth.dart';
import 'package:ocp/services/auth_provider.dart';
import 'package:ocp/services/root_page.dart';

void main() => runApp(MyApp());
//test
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Flutter login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(),
      ),
    );
  }
}
