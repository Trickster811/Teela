import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teela/screens/components/command/details.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/local.dart';
import 'package:teela/utils/model.dart';

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

class ItemBuilder {
  static CachedNetworkImage imageCardBuilder(String image) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder:
          (context, imageProvider) => Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
      placeholder:
          (context, url) => Container(
            decoration: BoxDecoration(
              color: neutral400,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5.0,
                  width: 5.0,
                  decoration: BoxDecoration(
                    color: neutral800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 5.0),
                Container(
                  height: 5.0,
                  width: 5.0,
                  decoration: BoxDecoration(
                    color: neutral800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 5.0),
                Container(
                  height: 5.0,
                  width: 5.0,
                  decoration: BoxDecoration(
                    color: neutral800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
      errorWidget:
          (context, url, error) => Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: const Center(child: Text('Erreur\nréseau')),
          ),
    );
  }

  static GestureDetector commandeItemBuilder({
    required BuildContext context,
    required CommandeModel commande,
  }) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsCommande(commande: commande),
            ),
          ),
      child: SizedBox(
        height: 80.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 80.0,
              width: 80.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: ItemBuilder.imageCardBuilder(
                  commande.modele.images[0],
                  // 'https://img.freepik.com/free-photo/portrait-stylish-adult-male-looking-away_23-2148466055.jpg?t=st=1738419204~exp=1738422804~hmac=f8441cfa1e1fc3eb8720246d815d69a1b9a5cce90a8410b3de3c07b15ea7ecf3&w=360',
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commande.modele.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    commande.customerName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color:
                          commande.date
                                      .add(Duration(days: commande.duration))
                                      .difference(commande.date)
                                      .inDays <=
                                  3
                              ? primary200
                              : Colors.transparent,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      '${commande.date.add(Duration(days: commande.duration)).difference(commande.date).inDays} jour${commande.duration > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color:
                            commande.date
                                        .add(Duration(days: commande.duration))
                                        .difference(commande.date)
                                        .inDays <=
                                    3
                                ? Colors.white
                                : Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80.0,
              width: 60,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: -10,
                    right: 0,
                    child: Text(
                      '${commande.date.day}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 49,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -0,
                    child: Text(
                      DateFormat.MMM('fr_FR').format(commande.date),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 29,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
    } catch (e) {
      debugPrint(e.toString());
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
