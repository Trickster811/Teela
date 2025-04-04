import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teela/auth/otp_success.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/data.dart';
import 'package:teela/utils/local.dart';

class Otp extends StatefulWidget {
  final String phone;
  final bool register;
  const Otp({super.key, required this.phone, required this.register});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final pinSMSCodeController = TextEditingController();

  bool wrongPin = false;

  final focusNode = FocusNode();

  final otpFormKey = GlobalKey<FormState>();
  bool onGoingProcess = false;

  // Manage Time Count Down to resend the sms verification code
  static const Duration countdownDuration = Duration(minutes: 0, seconds: 30);
  final ValueNotifier<Duration> durationNotifier = ValueNotifier<Duration>(
    countdownDuration,
  );
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // otpVerification();
  }

  @override
  void dispose() {
    pinSMSCodeController.dispose();
    focusNode.dispose();
    timer?.cancel();
    durationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: Theme.of(context).iconTheme.color,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Theme.of(context).iconTheme.color!),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            'assets/icons/arrow-left-2.4.svg',
            semanticsLabel: 'Arriw left',
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color!,
              BlendMode.srcIn,
            ),
            height: 30,
          ),
        ),
        title: const Text('Changer de numero', style: TextStyle(fontSize: 16)),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * .22,
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
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          SvgPicture.asset(
                            'assets/images/auth/icon.svg',
                            semanticsLabel: 'message send/receive',
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).iconTheme.color!,
                              BlendMode.srcIn,
                            ),
                            height: 50,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Regardez votre telephone',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Nous vous avons envoye un sms\nsur votre numero',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: otpFormKey,
                            child: Pinput(
                              length: 6,
                              controller: pinSMSCodeController,
                              focusNode: focusNode,
                              defaultPinTheme: defaultPinTheme,
                              separatorBuilder:
                                  (index) => const SizedBox(width: 8),
                              validator: (value) {
                                return value == null || value.length != 6
                                    ? 'Code incomplet'
                                    : null;
                              },
                              onClipboardFound: (value) {
                                pinSMSCodeController.setText(value);
                              },
                              hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                              onCompleted: (pin) {
                                debugPrint('onCompleted: $pin');
                              },
                              onChanged: (value) {
                                setState(() {
                                  wrongPin = false;
                                });
                                debugPrint('onChanged: $value');
                              },
                              onSubmitted: (smsPinCode) async {
                                debugPrint('onSubmitted: $smsPinCode');
                              },
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 9),
                                    width: 22,
                                    height: 1,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration: defaultPinTheme.decoration!
                                    .copyWith(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: primary200),
                                    ),
                              ),
                              submittedPinTheme: defaultPinTheme.copyWith(
                                decoration: defaultPinTheme.decoration!.copyWith(
                                  // color: Theme.of(context).iconTheme.color,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: neutral800),
                                ),
                              ),
                              errorPinTheme: defaultPinTheme.copyBorderWith(
                                border: Border.all(color: primary200),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              if (timer != null) return;
                              setState(() {
                                timer = Timer.periodic(
                                  const Duration(seconds: 1),
                                  (_) => addTime(),
                                );
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (timer != null) ...[
                                  SvgPicture.asset(
                                    'assets/icons/time-circle.2.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).iconTheme.color!,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                ],
                                timer != null
                                    ? ValueListenableBuilder<Duration>(
                                      valueListenable: durationNotifier,
                                      builder: (context, duration, child) {
                                        return Text(
                                          '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')} sec restantes',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            decorationColor: primary200,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).iconTheme.color,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        );
                                      },
                                    )
                                    : const Text(
                                      'Renvoyer le code',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: primary200,
                                        color: primary200,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    focusNode.unfocus();
                    if (wrongPin || !otpFormKey.currentState!.validate()) {
                      return;
                    }
                    return await verifyOtp();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    margin: const EdgeInsets.all(20.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: wrongPin ? neutral200 : primary200,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child:
                        onGoingProcess
                            ? SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: CircularProgressIndicator(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            )
                            : Text(
                              wrongPin ? 'Code incorrect' : 'Verifier',
                              style: TextStyle(
                                color:
                                    wrongPin
                                        ? neutral800
                                        : Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Real-time update for the count down
  void addTime() {
    final seconds = durationNotifier.value.inSeconds - 1;
    if (seconds == 0) {
      timer?.cancel();
      setState(() {
        timer = null;
      });
      durationNotifier.value = countdownDuration;
    } else {
      durationNotifier.value = Duration(seconds: seconds);
    }
  }

  Future verifyOtp() async {
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
      final verifyOTPToken = await Auth.verifyOTP(
        otp: OtpType.sms,
        phone: widget.phone,
        token: pinSMSCodeController.text.trim(),
      );
      if (verifyOTPToken != null) {
        setState(() {
          onGoingProcess = false;
        });
        await LocalPreferences.setFirstTime(true);

        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OtpSuccess()),
        );
      }
    } on AuthException catch (e) {
      setState(() {
        onGoingProcess = false;
      });
      LocalPreferences.showFlashMessage(e.message, Colors.red);
      print(e);
    } catch (erno) {
      setState(() {
        onGoingProcess = false;
      });
      debugPrint(erno.toString());
    }
  }
}
