import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DisplayImage extends StatefulWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  _DisplayImageState createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.imagePath;
  }

  Future<void> uploadImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

        // Upload the file to Firebase Storage
        await storageRef.putFile(file);
        final downloadUrl = await storageRef.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });

        // Update Firestore with the new image URL
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'imagePath': downloadUrl});
        }
      }
    } catch (e) {
      // Show an error message if the upload fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(0xFF85C26F);

    return Center(
        child: Stack(children: [
      buildImage(color),
      Positioned(
        child: GestureDetector(
          onTap: uploadImage,
          child: buildEditIcon(color),
        ),
        right: 4,
        top: 10,
      )
    ]));
  }

  //Profile Image
  Widget buildImage(Color color) {
    final image = imageUrl.contains('http')
        ? NetworkImage(imageUrl)
        : AssetImage(imageUrl) as ImageProvider;

    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
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
        color: color,
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