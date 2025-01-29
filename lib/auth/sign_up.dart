import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teela/auth/otp.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/data.dart';
import 'package:teela/utils/local.dart';

class SignUp extends StatefulWidget {
  final String phone;
  const SignUp({
    super.key,
    required this.phone,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _controllerFullName = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerConfirmPassword = TextEditingController();
  // Form key
  final signUpFormKey = GlobalKey<FormState>();
  bool onGoingProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * .12,
            child: KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                if (!isKeyboardVisible) {
                  return SvgPicture.asset(
                    'assets/images/auth/lines.svg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Form(
                      key: signUpFormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bienvenue',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              'Pour effectuer la creation de votre compte, veuillez remplir les informations suivantes',
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            const Text(
                              'Nom complet',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextFormField(
                              cursorColor: Theme.of(context).iconTheme.color,
                              cursorErrorColor: primary500,
                              decoration: FormDecoration.inputDecoaration(
                                context: context,
                                placeholder: 'julie queen',
                              ),
                              controller: _controllerFullName,
                              validator: (fullName) => fullName == null ||
                                      _controllerFullName.text.trim() == ''
                                  ? 'Veuillez saisir votre nom complet'
                                  : null,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Mot de passe',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  height: 15.0,
                                  width: 15.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _controllerConfirmPassword.text
                                                    .trim() !=
                                                '' &&
                                            _controllerPassword.text.trim() ==
                                                _controllerConfirmPassword.text
                                                    .trim()
                                        ? secondary500
                                        : primary300,
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                  // child: SvgPicture.asset('assets/icons/'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextFormField(
                              cursorColor: Theme.of(context).iconTheme.color,
                              cursorErrorColor: primary500,
                              obscureText: true,
                              obscuringCharacter: '#',
                              decoration: FormDecoration.inputDecoaration(
                                context: context,
                                placeholder: '_',
                              ),
                              controller: _controllerPassword,
                              onChanged: (value) => setState(() {
                                // _controllerPassword.text = value;
                              }),
                              validator: (fullName) => fullName == null ||
                                      _controllerPassword.text.trim() == '' ||
                                      !_controllerPassword.text
                                          .contains(RegExp(r'\d')) ||
                                      _controllerPassword.text.length < 6
                                  ? 'votre mot de passe doit contenir au moins 06 caracteres et un chiffre'
                                  : null,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Confirmer le mot de passe',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  height: 15.0,
                                  width: 15.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _controllerConfirmPassword.text
                                                    .trim() !=
                                                '' &&
                                            _controllerPassword.text.trim() ==
                                                _controllerConfirmPassword.text
                                                    .trim()
                                        ? secondary500
                                        : primary300,
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                  // child: SvgPicture.asset('assets/icons/'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextFormField(
                              cursorColor: Theme.of(context).iconTheme.color,
                              cursorErrorColor: primary500,
                              obscureText: true,
                              obscuringCharacter: '#',
                              decoration: FormDecoration.inputDecoaration(
                                context: context,
                                placeholder: '_',
                              ),
                              controller: _controllerConfirmPassword,
                              onChanged: (value) => setState(() {
                                // _controllerConfirmPassword.text = value;
                              }),
                              validator: (fullName) => fullName == null ||
                                      _controllerPassword.text.trim() !=
                                          _controllerConfirmPassword.text.trim()
                                  ? 'Veuillez comfirmer votre mot de passe'
                                  : null,
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            const Text('Le mot de passe doit contenir:'),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 15.0,
                                  width: 15.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _controllerPassword.text.length >= 6
                                        ? secondary500
                                        : neutral300,
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                  // child: SvgPicture.asset('assets/icons/'),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                const Text('Au moins 6 caracteres'),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 15.0,
                                  width: 15.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _controllerPassword.text
                                            .contains(RegExp(r'\d'))
                                        ? secondary500
                                        : neutral300,
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                  // child: SvgPicture.asset('assets/icons/'),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                const Text('Au moins un chiffre'),
                              ],
                            ),
                            const SizedBox(
                              height: 30.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (onGoingProcess ||
                          !signUpFormKey.currentState!.validate()) {
                        return;
                      }
                      await registration();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primary200,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: onGoingProcess
                          ? SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: CupertinoActivityIndicator(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            )
                          : Text(
                              'Commencer',
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future registration() async {
    setState(() {
      onGoingProcess = true;
    });
    try {
      if (!await Internet.checkInternetAccess()) {
        LocalPreferences.showFlashMessage(
          'Pas d\'internet',
          Colors.red,
        );
        setState(() {
          onGoingProcess = false;
        });
      }
      final user = await Auth.signUp(
        username: _controllerFullName.text.trim(),
        phone: widget.phone,
        password: _controllerPassword.text.trim(),
      );
      if (user != null) {
        setState(() {
          onGoingProcess = false;
        });

        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Otp(
              phone: widget.phone,
            ),
          ),
        );
      }
    } on AuthException catch (e) {
      setState(() {
        onGoingProcess = false;
      });
      LocalPreferences.showFlashMessage(
        e.message,
        Colors.red,
      );
    } catch (erno) {
      setState(() {
        onGoingProcess = false;
      });
      debugPrint(erno.toString());
    }
  }
}
