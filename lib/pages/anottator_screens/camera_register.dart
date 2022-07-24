import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_page.dart';

class CameraRegisterScreen extends StatelessWidget {
  CameraRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {},
          child: const Text('Launch Camera'),
        ),
      ),
    );
  }
}
