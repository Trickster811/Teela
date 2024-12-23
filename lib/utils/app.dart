import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Internet {
  static Future<bool> checkInternetAccess() async {
    final List<ConnectivityResult> checker =
        await (Connectivity().checkConnectivity());
    if (checker.contains(ConnectivityResult.none)) {
      return false;
    }
    final isInternetPresent = await InternetConnectionChecker().hasConnection;
    if (!isInternetPresent) {
      return false;
    }

    return true;
  }
}

class FileManager {
  /// Get from Camera
  static Future getImageFromDevice({
    required bool multiImage,
  }) async {
    final ImagePicker picker = ImagePicker();
    try {
      if (multiImage) {
        final pickedFile = await picker.pickMultiImage();
        List<File?> imagesFiles = [];
        for (var pic in pickedFile) {
          imagesFiles.add(File(pic.path));
        }
        return imagesFiles;
      }
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) return;
      return File(pickedFile.path);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }
}

// class SmsRetrieverImpl implements SmsRetriever {
//   const SmsRetrieverImpl(this.smartAuth);

//   final SmartAuth smartAuth;

//   @override
//   Future<void> dispose() {
//     return smartAuth.removeSmsListener();
//   }

//   @override
//   Future<String?> getSmsCode() async {
//     final res = await smartAuth.getSmsCode(
//       useUserConsentApi: true,
//     );
//     if (res.succeed && res.codeFound) {
//       return res.code!;
//     }
//     return null;
//   }

//   @override
//   bool get listenForMultipleSms => false;
// }
