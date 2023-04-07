import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/db/db_functions.dart';
import 'package:flutter_application_1/screen/single_view.dart';

import '../model/image_model.dart';

class Gallary extends StatelessWidget {
  const Gallary({super.key});

  @override
  Widget build(BuildContext context) {
    getImage();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon:const Icon(Icons.arrow_back),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text('Photo Gallery'),
                ),
              ],
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(10),
              child: ValueListenableBuilder(
                valueListenable: imageNotifier,
                builder: (BuildContext context, List<ImageModel> image,
                    Widget? child) {
                  return GridView.builder(
                    itemCount: image.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (BuildContext context, int index) {
                      final img = image[index];
                      File imgFile = File(img.imagePath);
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => SingleView(
                                  imageFile: imgFile, keyToDel: img.key))));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            imgFile,
                            width: 25,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
