import 'package:flutter/material.dart';

class MagicSquareScreen extends StatelessWidget {
  const MagicSquareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Magic Square"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Column(children: [
            
          ]),
        ),
      ),
    );
  }
}
