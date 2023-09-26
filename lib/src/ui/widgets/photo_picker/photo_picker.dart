import 'dart:io';

import 'package:fitness_time/src/ui/widgets/bottom_sheet_options/bottom_sheet_options.dart';
import 'package:fitness_time/src/ui/widgets/default_avatar/default_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef PictureChoosenCallback = void Function(File);

class PhotoPicker extends StatefulWidget {
  final PictureChoosenCallback onPictureChoosen;

  PhotoPicker({
    this.onPictureChoosen,
  });
  @override
  _PhotoPickerState createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  File fileImage = null;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DefaultAvatar(
          fileImage: fileImage,
        ),
        SizedBox(
          height: 18,
        ),
        InkWell(
          child: Text(
            'Alterar',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          onTap: _showPhotoOptionBottomSheet,
        ),
      ],
    );
  }

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);

    setState(() {
      fileImage = File(pickedFile.path);

      widget.onPictureChoosen?.call(fileImage);
    });
  }

  Future<void> _showPhotoOptionBottomSheet() async {
    FocusScope.of(context).unfocus();

    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return BottomSheetOptionsList(
          options: [
            BottomSheetOption(
              label: 'Galeria',
              onTap: () {
                getImage(ImageSource.gallery);
              },
            ),
            BottomSheetOption(
              label: 'Câmera',
              onTap: () {
                getImage(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }
}
