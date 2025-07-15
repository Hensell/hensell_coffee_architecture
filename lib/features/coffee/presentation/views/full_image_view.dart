import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImageView extends StatelessWidget {
  const FullImageView({
    required this.imagePath,
    super.key,
    this.isNetwork = true,
  });
  final String imagePath;
  final bool isNetwork;

  @override
  Widget build(BuildContext context) {
    ImageProvider provider;

    if (isNetwork) {
      provider = NetworkImage(imagePath);
    } else {
      provider = FileImage(File(imagePath));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista completa'),
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        imageProvider: provider,
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3,
        heroAttributes: PhotoViewHeroAttributes(tag: imagePath),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        loadingBuilder: (context, event) =>
            const Center(child: CircularProgressIndicator()),
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.broken_image, color: Colors.white, size: 64),
        ),
      ),
    );
  }
}
