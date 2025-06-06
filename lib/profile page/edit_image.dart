import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sugar_iq/main.dart';
import 'package:sugar_iq/widgets/app_theme.dart';

import 'user/user.dart';
import 'user/user_data.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({super.key});

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = UserData.getUser();
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final location = await getApplicationDocumentsDirectory();
    final name = basename(image.path);
    final imageFile = File('${location.path}/$name');
    final newImage = await File(image.path).copy(imageFile.path);

    setState(() {
      user = user.copy(imagePath: newImage.path, aboutMeDescription: '');
    });

    await UserData.setUser(user);
    profileImageNotifier.updateImage(newImage.path);
    UserData.updateImage(newImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: 330,
            child: Text(
              "Upload a photo of yourself:",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: pickImage,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: user.image.startsWith('http')
                        ? NetworkImage(user.image)
                        : FileImage(File(user.image)) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    await UserData.setUser(UserData.myUser);
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
