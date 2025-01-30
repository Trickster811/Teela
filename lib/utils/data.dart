import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  // Get a reference your Supabase client
  static SupabaseClient supabase = Supabase.instance.client;
  static Session? session = supabase.auth.currentSession;
  static User? user = supabase.auth.currentUser;

  // Checks if the user is already registered. If they are, it sends an OTP to their phone for verification.
  static Future<bool> login(String phoneNumber) async {
    // final response = await _supabase
    //     .from(SupabaseTables.appUsers)
    //     .select()
    //     .or('phone.eq.${phoneNumber},email.eq.${email}');

    // if (!response.isNotEmpty) {
    //   throw const AuthException('User does not exist, please register first');
    // }

    return true;
  }

  static Future signIn({required String phone}) async {
    try {
      await supabase.auth.signInWithOtp(
        phone: phone,
        shouldCreateUser: false,
      );
      return 1;
    } on AuthException {
      rethrow;
    }
  }

  static Future signInAnonymously() async {
    return await supabase.auth.signInAnonymously();
  }

  static Future signInWithOAuth() async {
    return await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      authScreenLaunchMode: LaunchMode.inAppWebView,
    );
  }

  static Future signUp({
    required String username,
    required String phone,
    required String password,
  }) async {
    final res = await supabase.auth.signUp(
      data: {
        'username': username,
      },
      phone: phone,
      password: password,
    );
    session = res.session;
    user = res.user;
    return res;
  }

  static Future verifyOTP({
    required OtpType otp,
    required String phone,
    required String token,
  }) async {
    final res = await supabase.auth.verifyOTP(
      type: otp,
      token: token,
      phone: phone,
    );

    session = res.session;
    user = res.user;

    return res;
  }
}

class CatalogueTeela {
  // Get a reference your Supabase client
  static SupabaseClient supabase = Supabase.instance.client;
  static List<Map<String, dynamic>> catalogues = [];
  static List<Map<String, dynamic>> ownerCatalogues = [];

  //Set of all Catalogue
  static Future<List<Map<String, dynamic>>> retrieveMultiCatalogue({
    required int limit,
    int? startAfter,
    String? owner,
  }) async {
    List<Map<String, dynamic>> refCatalogue;

    if (owner != null) {
      refCatalogue = await supabase.from('Catalogue').select('*, Modele(*)');
      // .range(startAfter + 1, startAfter + limit);
      catalogues.addAll(refCatalogue);
    } else {
      refCatalogue = await supabase
          .from('Catalogue')
          .select('*, Modele(*)')
          .eq('user', owner!);
      // .range(startAfter + 1, startAfter + limit);
      ownerCatalogues.addAll(refCatalogue);
    }

    return refCatalogue;
  }

  static Future createCatalogue({required Map<String, dynamic> data}) async {
    return await supabase.from('Catalogue').insert(data);
  }

  static Future updateCatalogue({
    required Map<String, dynamic> data,
    required String id,
  }) async {
    return await supabase.from('Catalogue').update(data).eq('id', id);
  }

  static Future deleteCatalogue({required int id}) async {
    return await supabase.from('Catalogue').delete().eq('id', id);
  }

  static Future deleteMultiCatalogue({required List<int> ids}) async {
    return await supabase.from('Catalogue').delete().inFilter('id', ids);
  }
}

class CommandeTeela {
  // Get a reference your Supabase client
  static SupabaseClient supabase = Supabase.instance.client;
  static List<Map<String, dynamic>> commandes = [];

  //Set of all Commande
  static Future retrieveMultiCommande({
    required int limit,
    required int startAfter,
  }) async {
    final refCommande = await supabase
        .from('Commande')
        .select()
        .range(startAfter + 1, startAfter + limit);

    commandes.addAll(refCommande);
  }

  static Future createCommande({required Map<String, dynamic> data}) async {
    return await supabase.from('Commande').insert(data);
  }

  static Future updateCommande({
    required Map<String, dynamic> data,
    required String id,
  }) async {
    return await supabase.from('Commande').update(data).eq('id', id);
  }

  static Future deleteCommande({required int id}) async {
    return await supabase.from('Commande').delete().eq('id', id);
  }

  static Future deleteMultiCommande({required List<int> ids}) async {
    return await supabase.from('Commande').delete().inFilter('id', ids);
  }
}

class ModeleTeela {
  // Get a reference your Supabase client
  static SupabaseClient supabase = Supabase.instance.client;
  static List<Map<String, dynamic>> modeles = [];

  //Set of all Modele
  static Future retrieveMultiModele({
    required int limit,
    // required int startAfter,
  }) async {
    final refModele = await supabase.from('Modele').select();
    // .range(startAfter + 1, startAfter + limit);
    modeles.addAll(refModele);
  }

  static Future createModele({required Map<String, dynamic> data}) async {
    return await supabase.from('Modele').insert(data);
  }

  static Future updateModele({
    required Map<String, dynamic> data,
    required String id,
  }) async {
    return await supabase.from('Modele').update(data).eq('id', id);
  }

  static Future deleteModele({required int id}) async {
    return await supabase.from('Modele').delete().eq('id', id);
  }

  static Future deleteMultiModele({required List<int> ids}) async {
    return await supabase.from('Modele').delete().inFilter('id', ids);
  }
}
