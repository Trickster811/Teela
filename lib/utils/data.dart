import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  // Get a reference your Supabase client
  static SupabaseClient supabase = Supabase.instance.client;
  static Session? session = supabase.auth.currentSession;
  static User? user = supabase.auth.currentUser;

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
      channel: OtpChannel.whatsapp,
    );
    session = res.session;
    user = res.user;
    return res;
  }

  static Future verifyOTP({
    required OtpType otp,
    required String phone,
    required String token,
  }) async =>
      await supabase.auth.verifyOTP(
        type: otp,
        token: token,
        phone: phone,
      );
}
