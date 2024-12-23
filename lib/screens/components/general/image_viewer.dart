import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teela/utils/color_scheme.dart';

class ImageViewer extends StatefulWidget {
  final List<dynamic> images;
  const ImageViewer({
    super.key,
    required this.images,
  });

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
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            'assets/icons/arrow-left-2.4.svg',
            semanticsLabel: 'Arriw left',
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
            height: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: widget.images[currentImage] is String &&
                        !widget.images[currentImage].contains('http')
                    ? Image.asset(
                        widget.images[currentImage],
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                      )
                    : widget.images[currentImage] is File
                        ? Image.file(
                            widget.images[currentImage],
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                          )
                        : Image.network(
                            widget.images[currentImage],
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                          ),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 40.0,
                ),
                for (dynamic image in widget.images) ...[
                  GestureDetector(
                    onTap: () => setState(() {
                      currentImage = widget.images.indexOf(image);
                    }),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: image is String && !image.contains('http')
                          ? Image.asset(
                              image,
                              fit: BoxFit.cover,
                              opacity:
                                  currentImage == widget.images.indexOf(image)
                                      ? const AlwaysStoppedAnimation(1)
                                      : const AlwaysStoppedAnimation(.3),
                              height: 80.0,
                              width: 80.0,
                            )
                          : image is File
                              ? Image.file(
                                  image,
                                  fit: BoxFit.cover,
                                  opacity: currentImage ==
                                          widget.images.indexOf(image)
                                      ? const AlwaysStoppedAnimation(1)
                                      : const AlwaysStoppedAnimation(.3),
                                  height: 80.0,
                                  width: 80.0,
                                )
                              : Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                  opacity: currentImage ==
                                          widget.images.indexOf(image)
                                      ? const AlwaysStoppedAnimation(1)
                                      : const AlwaysStoppedAnimation(.3),
                                  height: 80.0,
                                  width: 80.0,
                                ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
