import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sugar_iq/widgets/app_theme.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const DisplayImage({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.primary;

    return Center(
        child: Stack(children: [
      buildImage(color),
      Positioned(
        right: 4,
        top: 10,
        child: buildEditIcon(color),
      )
    ]));
  }

  Widget buildImage(Color color) {
    final image = (imagePath.isEmpty || !File(imagePath).existsSync())
        ? const AssetImage('assets/logo.png')
        : FileImage(File(imagePath)) as ImageProvider;

    return CircleAvatar(
      radius: 75,
      backgroundColor: AppTheme.primary,
      child: CircleAvatar(
        backgroundImage: image,
        radius: 70,
      ),
    );
  }

  //Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: AppTheme.primary,
        size: 20,
      ));

  //Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
