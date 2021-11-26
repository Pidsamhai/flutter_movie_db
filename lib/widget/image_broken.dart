import 'package:flutter/material.dart';

class ImageBrokenWidget extends StatelessWidget {
  const ImageBrokenWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.broken_image_rounded),
    );
  }
}