import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/color_scheme.dart';

class ImageViewer extends StatefulWidget {
  final List<dynamic> images;
  const ImageViewer({super.key, required this.images});

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  int currentImage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral1000,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            'assets/icons/arrow-left-2.4.svg',
            semanticsLabel: 'Arriw left',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            height: 30,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child:
                      widget.images[currentImage] is File
                          ? Image.file(
                            widget.images[currentImage],
                            fit: BoxFit.cover,
                          )
                          : ItemBuilder.imageCardBuilder(
                            widget.images[currentImage],
                            // 'https://img.freepik.com/free-photo/portrait-stylish-adult-male-looking-away_23-2148466055.jpg?t=st=1738419204~exp=1738422804~hmac=f8441cfa1e1fc3eb8720246d815d69a1b9a5cce90a8410b3de3c07b15ea7ecf3&w=360',
                          ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width / 2 - 40.0),
                for (dynamic image in widget.images) ...[
                  GestureDetector(
                    onTap:
                        () => setState(() {
                          currentImage = widget.images.indexOf(image);
                        }),
                    child: SizedBox(
                      height: 80.0,
                      width: 80.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child:
                            image is File
                                ? Image.file(
                                  image,
                                  fit: BoxFit.cover,
                                  opacity:
                                      currentImage ==
                                              widget.images.indexOf(image)
                                          ? const AlwaysStoppedAnimation(1)
                                          : const AlwaysStoppedAnimation(.3),
                                )
                                : ItemBuilder.imageCardBuilder(
                                  image,
                                  // 'https://img.freepik.com/free-photo/portrait-stylish-adult-male-looking-away_23-2148466055.jpg?t=st=1738419204~exp=1738422804~hmac=f8441cfa1e1fc3eb8720246d815d69a1b9a5cce90a8410b3de3c07b15ea7ecf3&w=360',
                                  // fit: BoxFit.cover,
                                  // opacity:
                                  //     currentImage ==
                                  //             widget.images.indexOf(image)
                                  //         ? const AlwaysStoppedAnimation(1)
                                  //         : const AlwaysStoppedAnimation(.3),
                                  // height: 80.0,
                                  // width: 80.0,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
