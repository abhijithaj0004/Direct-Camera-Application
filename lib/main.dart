import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/db_functions.dart';
import 'package:flutter_application_1/model/image_model.dart';
import 'package:flutter_application_1/screen/gallary.dart';
import 'package:flutter_application_1/screen/screen_home.dart';
import 'package:hive_flutter/adapters.dart';

late List<CameraDescription> cameras;

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  final appDocumentDirectory = await getDirectory();
  await Hive.initFlutter(appDocumentDirectory?.path);
  if (!Hive.isAdapterRegistered(ImageModelAdapter().typeId)) {
    Hive.registerAdapter(ImageModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'homeScreen': (context) => const ScreenHome(),
        'gallary': (context) => const Gallary()
      },
      debugShowCheckedModeBanner: false,
      home: const ScreenHome(),
    );
  }
}
