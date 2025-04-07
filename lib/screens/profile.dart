import 'package:flutter/material.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/data.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 80.0,
            width: 80.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child:
                  Auth.user!['image'] != null
                      ? ItemBuilder.imageCardBuilder(Auth.user!['image'])
                      : Image.asset(
                        'assets/images/catalogue/img_1.png',
                        height: double.maxFinite,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
            ),
          ),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
