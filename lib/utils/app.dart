import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/local.dart';

class FormDecoration {
  static InputDecoration inputDecoaration({
    required BuildContext context,
    required String placeholder,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
      ),
      focusedBorder: OutlineInputBorder(
        gapPadding: 0,
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
      ),
      errorBorder: OutlineInputBorder(
        gapPadding: 0,
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: primary200),
      ),
      focusedErrorBorder: OutlineInputBorder(
        gapPadding: 0,
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: primary200),
      ),
      hintStyle: TextStyle(
        color: Theme.of(context).iconTheme.color!.withValues(alpha: .4),
        fontWeight: FontWeight.normal,
      ),
      hintText: placeholder,
    );
  }
}

class Internet {
  static Future<bool> checkInternetAccess() async {
    final List<ConnectivityResult> checker =
        await (Connectivity().checkConnectivity());
    if (checker.contains(ConnectivityResult.none)) {
      return false;
    }
    final isInternetPresent =
        await InternetConnectionChecker.instance.hasConnection;
    if (!isInternetPresent) {
      return false;
    }

    return true;
  }
}

class FileManager {
  // Get a reference your Supabase client
  static SupabaseClient supabase = Supabase.instance.client;

  /// Get from Camera
  static Future getImageFromDevice({
    required bool multiImage,
    ImageSource? source,
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
      final pickedFile = await picker.pickImage(source: source!);

      if (pickedFile == null) return;
      return File(pickedFile.path);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  static Future uploadFile({
    required File image,
    required String folder,
    required String uploadPath,
  }) async {
    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/${dotenv.env['CLOUD_NAME']}/upload',
      );
      var request =
          http.MultipartRequest('POST', url)
            ..fields['upload_preset'] = '${dotenv.env['UPLOAD_PRESET']}'
            ..files.add(await http.MultipartFile.fromPath('file', image.path));
      final resp = await request.send();
      // await http.post(
      //   Uri.parse(
      //     'https://api.cloudinary.com/v1_1/${dotenv.env['CLOUD_NAME']}/upload?file=${image.path}&upload_preset=${dotenv.env['UPLOAD_PRESET']}&api_key=${dotenv.env['API_KEY']}&public_id=$uploadPath',
      //   ),
      // );
      if (resp.statusCode == 200) {
        final responseData = await resp.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        var data = jsonDecode(responseString);
        return data['url'];
      }
      return null;
      return await supabase.storage
          .from(folder)
          .upload(
            uploadPath,
            image,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
    } catch (e) {
      print(e);
      LocalPreferences.showFlashMessage('$e', Colors.red);
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
