import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() => runApp(GalleryApp());

class GalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(home: ImageGallery());
  }
}

class ImageGallery extends StatefulWidget {
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  Iterable images = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _GetImages();
    });
  }

  List<Container> _buildGridImages() {
    List<Container> gridImages = [];
    for (var image in images)
      gridImages.add(Container(child: Image.asset(image)));
    return gridImages;
  }

  void _GetImages() async {
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final imageList = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith('images'));

    setState(() {
      images = imageList;
    });
  }

  Widget build(BuildContext ctx) {
    return Scaffold(
        body: Center(
            child: GridView.count(
                crossAxisCount: 2, children: _buildGridImages())));
  }
}
