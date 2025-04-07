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
      return await init();
    }
    //
    try {
      teelaDBToken = await Db.create(
        'mongodb+srv://${dotenv.env['DB_USER']}:${dotenv.env['USER_PASSWORD']}@teela.we6eknj.mongodb.net/${dotenv.env['DB_NAME']}?retryWrites=true&w=majority&appName=${dotenv.env['APP_NAME']}',
      );
      await teelaDBToken.open(secure: true);
    } catch (e) {
      return await init();
    }
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
        await LocalPreferences.setUserInfo(response.document!);
        user = LocalPreferences.getUserInfo();
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
  static Future retrieveMultiCatalogue({
    required int limit,
    int? startAfter,
    Object? owner,
  }) async {
    late List<Map<String, dynamic>> refCatalogue;
    try {
      if (owner == null) {
        refCatalogue =
            await db
                .collection('Catalogue')
                .find(
                  where.sortBy('title').skip(catalogues.length).limit(limit),
                )
                .toList();

        for (var element in refCatalogue) {
          List<Map<String, dynamic>> models =
              await ModeleTeela.retrieveMultiModele(
                limit: limit,
                catalogueId: element['_id'],
              );
          refCatalogue[refCatalogue.indexOf(element)]['Modele'] = models;
        }
        // .range(startAfter + 1, startAfter + limit);
        refCatalogue.map((element) async {
          List<Map<String, dynamic>> models =
              await ModeleTeela.retrieveMultiModele(
                limit: limit,
                catalogueId: element['_id'],
              );
          element['Modele'] = models;
        });
        catalogues.addAll(
          refCatalogue.where((item) => !catalogues.contains(item)),
        );
      } else {
        refCatalogue =
            await db
                .collection('Catalogue')
                .find(
                  where
                      .eq('user', owner)
                      .sortBy('title')
                      .skip(ownerCatalogues.length)
                      .limit(limit),
                )
                .toList();
        for (var element in refCatalogue) {
          List<Map<String, dynamic>> models =
              await ModeleTeela.retrieveMultiModele(
                limit: limit,
                catalogueId: element['_id'],
              );
          refCatalogue[refCatalogue.indexOf(element)]['Modele'] = models;
        }

        // .range(startAfter + 1, startAfter + limit);
        ownerCatalogues.addAll(
          refCatalogue.where((item) => !ownerCatalogues.contains(item)),
        );
      }

      return refCatalogue;
    } catch (erno) {
      debugPrint(erno.toString());
    }
  }

  static Future createCatalogue({required Map<String, dynamic> data}) async {
    return await db.collection('Catalogue').insertOne(data);
  }

  static Future updateCatalogue({
    required Map<String, dynamic> data,
    required Object id,
  }) async {
    return await db.collection('Catalogue').update(where.eq('_id', id), {
      r'$set': data,
    });
  }

  static Future deleteCatalogue({required Object id}) async {
    return await db.collection('Catalogue').deleteOne(where.eq('_id', id));
  }

  static Future deleteMultiCatalogue({required List<Object> ids}) async {
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
  static Future retrieveMultiCommande({
    required int limit,
    int? startAfter,
    Object? owner,
  }) async {
    List<Map<String, dynamic>> refCommande;
    Map<String, dynamic>? model;
    try {
      if (owner == null) {
        refCommande =
            await db
                .collection('Commande')
                .find(where.sortBy('date').skip(commandes.length).limit(limit))
                .toList();

        for (var element in refCommande) {
          if (!element['modele'].toString().contains('http')) {
            model = await ModeleTeela.retrieveModele(
              modeleId: element['modele'],
            );
          } else {
            model = {
              '_id': ObjectId.parse('000000000000000000000000'),
              'description': 'RAS',
              'duration': [1, 1],
              'images': [element['modele']],
              'max_price': 1,
              'min_price': 1,
              'title': 'Modele Anonyme',
            };
          }
          refCommande[refCommande.indexOf(element)]['Modele'] = model;
        }
        // .range(startAfter + 1, startAfter + limit);
        commandes.addAll(
          refCommande.where((item) => !commandes.contains(item)),
        );
      } else {
        refCommande =
            await db
                .collection('Commande')
                .find(
                  where
                      .eq('user', owner)
                      .sortBy('date')
                      .skip(ownerCommandes.length)
                      .limit(limit),
                )
                .toList();

        for (var element in refCommande) {
          if (!element['modele'].toString().contains('http')) {
            model = await ModeleTeela.retrieveModele(
              modeleId: element['modele'],
            );
          } else {
            model = {
              '_id': ObjectId.parse('000000000000000000000000'),
              'description': 'RAS',
              'duration': [1, 1],
              'images': [element['modele']],
              'max_price': 1,
              'min_price': 1,
              'title': 'Modele Anonyme',
            };
          }
          refCommande[refCommande.indexOf(element)]['Modele'] = model;
        }

        ownerCommandes.addAll(
          refCommande.where((item) => !ownerCommandes.contains(item)),
        );
      }
      return refCommande;
    } catch (erno) {
      debugPrint(erno.toString());
    }
  }

  static Future createCommande({required Map<String, dynamic> data}) async {
    try {
      return await db.collection('Commande').insert(data);
    } catch (erno) {
      print(erno);
    }
  }

  static Future updateCommande({
    required Map<String, dynamic> data,
    required Object id,
    required bool singleFieldUpdate,
  }) async {
    try {
      return await db
          .collection('Commande')
          .updateOne(
            where.eq('_id', id),
            singleFieldUpdate
                ? {r'$set': data}
                : modify.set(data.keys.first, data.values.first),
          );
    } catch (erno) {
      print('hello $erno');
    }
  }

  static Future deleteCommande({required Object id}) async {
    return await db.collection('Commande').deleteOne(where.eq('_id', id));
  }

  static Future deleteMultiCommande({required List<Object> ids}) async {
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
  static Future<List<Map<String, dynamic>>> retrieveMultiModele({
    required int limit,
    required Object catalogueId,
    // required int startAfter,
  }) async {
    final refModele =
        await db
            .collection('Modele')
            .find(where.eq('catalogue', catalogueId))
            .skip(modeles.length)
            .toList();
    // .range(startAfter + 1, startAfter + limit);
    // modeles.addAll(refModele);
    return refModele;
  }

  // Find modele by id
  static Future<Map<String, dynamic>?> retrieveModele({
    required Object modeleId,
    // required int startAfter,
  }) async {
    final refModele = await db
        .collection('Modele')
        .findOne(where.eq('_id', modeleId));
    // .range(startAfter + 1, startAfter + limit);
    // modeles.addAll(refModele);
    return refModele;
  }

  static Future createModele({required Map<String, dynamic> data}) async {
    return await db.collection('Modele').insert(data);
  }

  static Future updateModele({
    required Map<String, dynamic> data,
    required Object id,
  }) async {
    return await db.collection('Modele').updateOne(where.eq('_id', id), {
      r'$set': data,
    });
  }

  static Future deleteModele({required Object id}) async {
    return await db.collection('Modele').deleteOne(where.eq('_id', id));
  }

  static Future deleteMultiModele({required List<Object> ids}) async {
    return await db.collection('Modele').deleteMany({
      '_id': {r'$in': ids},
    });
  }
}
