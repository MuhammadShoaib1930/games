import 'dart:io';

import 'package:games/services/hive_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerService {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  Future<void> imagePick({bool isCamer = false}) async {
    image = await picker.pickImage(source: (isCamer) ? ImageSource.camera : ImageSource.gallery);
  }

  Future<void> imageSave() async {
    if (image != null) {
      final sourceFile = File(image!.path);
      final oldPath = HiveService().getAppSettings().profileImagePath;
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

      HiveService().updateAppSettings(
        isDark: HiveService().getAppSettings().isDark,
        profileImagePath: targetPath,
      );
    }
  }
}
