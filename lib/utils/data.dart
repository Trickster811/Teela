import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/local.dart';

class DatabaseConnection {
  static late Db teelaDBToken;

  static Future init() async {
    if (!await Internet.checkInternetAccess()) {
      LocalPreferences.showFlashMessage('Pas d\'internet', Colors.red);
      return;
    }
    //
    teelaDBToken = await Db.create(
      'mongodb+srv://${dotenv.env['DB_USER']}:${dotenv.env['USER_PASSWORD']}@teela.we6eknj.mongodb.net/${dotenv.env['DB_NAME']}?retryWrites=true&w=majority&appName=${dotenv.env['APP_NAME']}',
    );
    await teelaDBToken.open(secure: true);
    // inspect(teelaDBToken);
    // await teelaDBToken.collection('users').insert({'a': 4});
  }
}

class CloundinaryConnection {
  static late Cloudinary clTeela;

  static Future init() async {
    if (!await Internet.checkInternetAccess()) {
      LocalPreferences.showFlashMessage('Pas d\'internet', Colors.red);
      return;
    }
    //
    clTeela = Cloudinary.fromStringUrl('${dotenv.env['CLOUDINARY_URL']}');
  }
}

class Auth {
  // Get a reference your MongoDB connection Token
  static Db db = DatabaseConnection.teelaDBToken;
  static Map<String, dynamic>? user = LocalPreferences.getUserInfo();

  static Future signIn({required String phone}) async {
    // Checks if the user is already registered. If they are, it sends an OTP to their phone for verification.
    Map<String, dynamic>? userExists = await db
        .collection('users')
        .findOne(where.eq('phone', phone));

    return userExists;
  }

  static Future signUp({
    required String username,
    required String phone,
    required String password,
  }) async {
    // Checks if the user is already registered.
    Map<String, dynamic>? userExists = await signIn(phone: phone);
    if (userExists == null) {
      final response = await db.collection('users').insertOne({
        'username': username,
        'phone': phone,
        'password': password,
      });
      if (response.isSuccess) {
        await LocalPreferences.setUserInfo({
          'username': username,
          'phone': phone,
          'password': password,
        });
        // user = {'username': username, 'phone': phone, 'password': password};
        return response;
      }
    } else {
      return null;
    }
  }

  static Future updateUser({
    required String username,
    required String password,
    required String phone,
  }) async {
    final response = await db
        .collection('users')
        .updateOne(
          where.eq('username', username),
          modify.set('password', password),
        );
    if (response.isSuccess) {
      await LocalPreferences.setUserInfo({
        'username': username,
        'phone': phone,
        'password': password,
      });
      user = {'username': username, 'phone': phone, 'password': password};
      return response;
    }
  }

  static Future verifyOTP({
    required OtpType otp,
    required String phone,
    required String token,
  }) async {
    // final res = await supabase.auth.verifyOTP(
    //   type: otp,
    //   token: token,
    //   phone: phone,
    // );

    // session = res.session;
    // user = res.user;

    // return res;
  }
}

class CatalogueTeela {
  // Get a reference your MongoDB connection Token
  static Db db = DatabaseConnection.teelaDBToken;
  static List<Map<String, dynamic>> catalogues = [];
  static List<Map<String, dynamic>> ownerCatalogues = [];

  //Set of all Catalogue
  static Future<List<Map<String, dynamic>>> retrieveMultiCatalogue({
    required int limit,
    int? startAfter,
    String? owner,
  }) async {
    late List<Map<String, dynamic>> refCatalogue;
    try {
      if (owner == null) {
        refCatalogue =
            await db
                .collection('Catalogue')
                .find(where.limit(limit))
                .skip(catalogues.length)
                .toList();
        // .range(startAfter + 1, startAfter + limit);
        catalogues.addAll(
          refCatalogue.where((item) => !catalogues.contains(item)),
        );
      } else {
        refCatalogue =
            await db
                .collection('Catalogue')
                .find(where.eq('user', owner).limit(limit).sortBy('title'))
                .skip(ownerCatalogues.length)
                .toList();

        // .range(startAfter + 1, startAfter + limit);
        ownerCatalogues.addAll(
          refCatalogue.where((item) => !ownerCatalogues.contains(item)),
        );
      }

      return refCatalogue;
    } catch (erno) {
      print(erno);
      return refCatalogue;
    }
  }

  static Future createCatalogue({required Map<String, dynamic> data}) async {
    return await db.collection('Catalogue').insertOne(data);
  }

  static Future updateCatalogue({
    required Map<String, dynamic> data,
    required String id,
  }) async {
    return await db.collection('Catalogue').update(where.eq('_id', id), data);
  }

  static Future deleteCatalogue({required int id}) async {
    return await db.collection('Catalogue').deleteOne(where.eq('_id', id));
  }

  static Future deleteMultiCatalogue({required List<int> ids}) async {
    return await db.collection('Catalogue').deleteMany({
      '_id': {r'$in': ids},
    });
  }
}

class CommandeTeela {
  // Get a reference your MongoDB connection Token
  static Db db = DatabaseConnection.teelaDBToken;
  static List<Map<String, dynamic>> commandes = [];
  static List<Map<String, dynamic>> ownerCommandes = [];

  //Set of all Commande
  static Future<List<Map<String, dynamic>>> retrieveMultiCommande({
    required int limit,
    int? startAfter,
    String? owner,
  }) async {
    List<Map<String, dynamic>> refCommande;

    if (owner == null) {
      refCommande =
          await db
              .collection('Commande')
              .find(where.limit(limit))
              .skip(commandes.length)
              .toList();
      // find('*,Modele(*)').toList();
      // .range(startAfter + 1, startAfter + limit);
      commandes.addAll(refCommande.where((item) => !commandes.contains(item)));
    } else {
      refCommande =
          await db
              .collection('Commande')
              .find(where.limit(limit))
              .skip(commandes.length)
              .toList();
      // refCommande = await supabase
      //     .from('Commande')
      //     .select('*,Modele(*, Catalogue(*))')
      //     .eq('Modele.Catalogue.user', owner);
      // .range(startAfter + 1, startAfter + limit);

      ownerCommandes.addAll(
        refCommande.where((item) => !ownerCommandes.contains(item)),
      );
    }
    return refCommande;
  }

  static Future createCommande({required Map<String, dynamic> data}) async {
    return await db.collection('Commande').insert(data);
  }

  static Future updateCommande({
    required Map<String, dynamic> data,
    required String id,
  }) async {
    return await db.collection('Commande').updateOne(where.eq('_id', id), data);
  }

  static Future deleteCommande({required int id}) async {
    return await db.collection('Commande').deleteOne(where.eq('_id', id));
  }

  static Future deleteMultiCommande({required List<int> ids}) async {
    return await db.collection('Commande').deleteMany({
      '_id': {r'$in': ids},
    });
  }
}

class ModeleTeela {
  // Get a reference your MongoDB connection Token
  static Db db = DatabaseConnection.teelaDBToken;
  static List<Map<String, dynamic>> modeles = [];

  //Set of all Modele
  static Future retrieveMultiModele({
    required int limit,
    required String,
    // required int startAfter,
  }) async {
    final refModele =
        await db
            .collection('Modele')
            .find(where.limit(limit))
            .skip(modeles.length)
            .toList();
    // .range(startAfter + 1, startAfter + limit);
    // modeles.addAll(refModele);
    return refModele;
  }

  static Future createModele({required Map<String, dynamic> data}) async {
    return await db.collection('Modele').insert(data);
  }

  static Future updateModele({
    required Map<String, dynamic> data,
    required String id,
  }) async {
    return await db.collection('Modele').updateOne(where.eq('_id', id), data);
  }

  static Future deleteModele({required int id}) async {
    return await db.collection('Modele').deleteOne(where.eq('_id', id));
  }

  static Future deleteMultiModele({required List<int> ids}) async {
    return await db.collection('Modele').deleteMany({
      '_id': {r'$in': ids},
    });
  }
}
