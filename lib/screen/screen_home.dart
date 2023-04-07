import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/db_functions.dart';
import 'package:flutter_application_1/model/image_model.dart';
import 'package:flutter_application_1/screen/white_screen.dart';
import 'package:path/path.dart';

import '../main.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  late CameraController cameraController;
  @override
  void initState() {
    // TODO: implement initState
    startCamera();
    super.initState();
  }

  startCamera() async {
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('Access Denied');
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }

  late XFile picture;
  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text('M Y    C A M E R A'),
        ),
        body: Stack(
          children: [
            CameraPreview(cameraController),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                height: 70,
                color: Colors.black54,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Colors.amber,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('gallary');
                            },
                            icon: const Icon(Icons.photo),
                            iconSize: 35,
                          ),
                        )),
                    const SizedBox(
                      width: 100,
                    ),
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 50, 44, 44),
                      radius: 30,
                      child: IconButton(
                        onPressed: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const WhiteScreen(),
                            ),
                          );
                          if (!cameraController.value.isInitialized) {
                            return;
                          }
                          if (cameraController.value.isTakingPicture) {
                            return;
                          }
                          try {
                            picture = await cameraController.takePicture();
                          } on CameraException catch (e) {
                            debugPrint('Error ocured while taking picture:$e');
                            return;
                          }
                          final fileName = basename(picture.path);
                          final imagePath =
                              await saveImage(File(picture.path), fileName);
                          ImageModel img = ImageModel(
                              imagePath: imagePath, imageName: fileName);
                          addImage(img);
                        },
                        icon: const Icon(Icons.camera),
                        iconSize: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
