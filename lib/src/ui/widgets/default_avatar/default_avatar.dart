import 'dart:io';

import 'package:flutter/material.dart';

class DefaultAvatar extends StatelessWidget {
  final String url;
  final double borderWidth;
  final double size;
  final double elevation;
  final Color borderColor;
  final Color backgroundColor;
  final File fileImage;

  DefaultAvatar({
    @required this.url,
    this.borderWidth = 2,
    this.borderColor = Colors.white,
    this.backgroundColor,
    this.size = 128,
    this.elevation = 6,
    this.fileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: this.elevation,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(this.size),
      child: Container(
          width: this.size,
          height: this.size,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(this.size),
              border: Border.all(
                color: this.borderColor,
                width: this.borderWidth,
              ),
              image:
                  DecorationImage(image: this._getImage(), fit: BoxFit.cover))),
    );
  }

  ImageProvider _getImage() {
    if (fileImage == null && (this.url == null || this.url.isEmpty)) {
      return AssetImage(
        'assets/images/avatar.png',
      );
    }

    return NetworkImage(this.url);
  }
}
