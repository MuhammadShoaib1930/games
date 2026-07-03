import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games/services/hive_service.dart';
import 'package:games/services/image_picker_service.dart';
import 'package:go_router/go_router.dart';

class AppDrawerDialog extends StatelessWidget {
  final bool isImagePicker;
  final TextEditingController nameController = TextEditingController();
  AppDrawerDialog({super.key, this.isImagePicker = true});

  @override
  Widget build(BuildContext context) {
    nameController.text = HiveService().getAppSettings().userName;
    return Dialog(
      child: SizedBox(
        height: 200.h,
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (isImagePicker) ? "Pick Image" : "Write Name",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(
              child: (isImagePicker)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            await ImagePickerService().imagePick(isCamer: true);
                          },
                          label: Text("Camera"),
                          icon: Icon(Icons.camera),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            ImagePickerService().imagePick(isCamer: false);
                          },
                          label: Text("Gallery"),
                          icon: Icon(Icons.image),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name",

                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 15,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (isImagePicker) {
                          await ImagePickerService().imageSave().then((value) {
                            if (context.mounted) context.pop();
                          });
                        } else {
                          if (nameController.value.text.toString().isNotEmpty) {
                            HiveService().updateAppSettings(
                              userName: nameController.value.text.toString().trim().toUpperCase(),
                            );
                            if (context.mounted) context.pop();
                          }
                        }
                      },
                      child: Text("Save"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text("Close"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
