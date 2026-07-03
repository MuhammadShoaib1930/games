import 'dart:io';

import 'package:games/services/hive_service.dart';
import 'package:games/models/app_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerService {
  static final ImagePickerService _instance = ImagePickerService._internal();
  ImagePickerService._internal();
  factory ImagePickerService() => _instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;
  Future<void> imagePick({bool isCamer = false}) async {
    image = await picker.pickImage(source: (isCamer) ? ImageSource.camera : ImageSource.gallery);
  }

  Future<void> imageSave() async {
    if (image != null) {
      final sourceFile = File(image!.path);
      final oldPath = HiveService().getDataFormBox<AppSettings>(box: HiveService().settingBox).profileImagePath;
      if (oldPath.isNotEmpty) {
        final oldFile = File(oldPath);
        if (await oldFile.exists()) {
          await oldFile.delete();
        }
      }
      final fileName = image!.name;
      final dir = await getApplicationDocumentsDirectory();
      final targetPath = "${dir.path}/$fileName";
      await sourceFile.copy(targetPath);

      HiveService().updateBoxData<AppSettings>(
        box: HiveService().settingBox,
        isDark: HiveService().getDataFormBox<AppSettings>(box: HiveService().settingBox).isDark,
        profileImagePath: targetPath,
      );
    }
  }
}
