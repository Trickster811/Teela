import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:teela/auth/otp_success.dart';
import 'package:teela/auth/sign_up.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/data.dart';
import 'package:teela/utils/local.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _controllerPhone = TextEditingController();
  // Form key
  final signInFormKey = GlobalKey<FormState>();
  bool onGoingProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/auth/bg_login.png',
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Votre numero',
                          style: TextStyle(
                            height: 1,
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Renseigner votre numero',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10.0),
                        Form(
                          key: signInFormKey,
                          child: InternationalPhoneNumberInput(
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.DIALOG,
                              showFlags: true,
                              useEmoji: false,
                              setSelectorButtonAsPrefixIcon: false,
                              useBottomSheetSafeArea: false,
                            ),
                            initialValue: PhoneNumber(isoCode: 'CM'),
                            countries: const ["CM"],
                            onInputChanged: (PhoneNumber number) {
                              setState(() {
                                _controllerPhone.text = number.phoneNumber!;
                              });
                            },
                            // textFieldController: _controllerPhone,
                            textStyle: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontWeight: FontWeight.normal,
                            ),
                            selectorTextStyle: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontWeight: FontWeight.normal,
                            ),
                            spaceBetweenSelectorAndTextField: 0,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false,
                            ),
                            inputDecoration: FormDecoration.inputDecoaration(
                              context: context,
                              placeholder: 'téléphone',
                            ),
                            validator:
                                (phone) =>
                                    phone != null &&
                                            _controllerPhone.text
                                                    .trim()
                                                    .length <
                                                13
                                        ? 'Veuillez saisir une numéro de téléphone valide'
                                        : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (onGoingProcess || !signInFormKey.currentState!.validate()) {
                return;
              }
              return showCupertinoModalPopup(
                context: context,
                builder:
                    (context) => CupertinoActionSheet(
                      message: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Deja inscrit?',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                                Text(
                                  'Un compte existe deja sur ce numero',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await authenfication();
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
                                    child: Text(
                                      'Restaurer',
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).scaffoldBackgroundColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Changer de numero',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: primary200,
                                      color: primary200,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Montserrat',
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
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              margin: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primary200,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child:
                  onGoingProcess
                      ? SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CupertinoActivityIndicator(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      )
                      : Text(
                        'Continuer',
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }

  Future authenfication() async {
    setState(() {
      onGoingProcess = true;
    });
    try {
      if (!await Internet.checkInternetAccess()) {
        LocalPreferences.showFlashMessage('Pas d\'internet', Colors.red);
        setState(() {
          onGoingProcess = false;
        });
      }
      Map<String, dynamic>? user = await Auth.signIn(
        phone: _controllerPhone.text.trim(),
      );
      if (user != null && user.isNotEmpty) {
        await LocalPreferences.setFirstTime(true);
        // Update local storage
        await LocalPreferences.setUserInfo(user);
        Auth.user = user;
        setState(() {
          onGoingProcess = false;
          // Navigate to the Home app screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => OtpSuccess(
                    // phone: _controllerPhone.text.trim(),
                    // register: true,
                  ),
            ),
          );
        });
      } else {
        LocalPreferences.showFlashMessage(
          'Compte inexistant avec ce numero\nVeuillez creer un compte',
          Colors.red,
        );
        setState(() {
          onGoingProcess = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => SignUp(
                    phone: _controllerPhone.text.trim(),
                    // register: true,
                  ),
            ),
          );
        });
      }
    } catch (erno) {
      setState(() {
        onGoingProcess = false;
      });
      LocalPreferences.showFlashMessage('Une erreur est survenue', Colors.red);
      print(erno);
      debugPrint(erno.toString());
    }
  }
}
