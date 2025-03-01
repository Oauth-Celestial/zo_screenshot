import 'package:flutter/material.dart';

class NonSecure extends StatelessWidget {
  const NonSecure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Text("Non Secure Route"),
      ),
    );
  }
}
