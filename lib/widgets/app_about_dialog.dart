import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppAboutDialog extends StatelessWidget {
  AppAboutDialog({super.key});
  final TextStyle textStyle1 = TextStyle(fontSize: 14,fontWeight: FontWeight.w300);
  final TextStyle textStyle2 = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 200.h,
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Text("About", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(
                child: Row(
                  children: [
                    Text("Developer name: ", style: textStyle1),
                    SelectableText("Muhammad Shoaib", style: textStyle2),
                  ],
                ),
              ),

              SizedBox(
                child: Row(
                  children: [
                    Text("Phone or Whatsapp: ", style: textStyle1),
                    SelectableText("03238602527", style: textStyle2),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Text("email: ", style: textStyle1),
                    SelectableText("shoaibsn54321@gmail.com", style: textStyle2),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(onPressed: () => context.pop(), child: Text("OK")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
