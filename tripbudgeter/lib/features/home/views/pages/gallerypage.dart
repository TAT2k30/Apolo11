import 'package:flutter/material.dart';
import 'package:tripbudgeter/features/home/views/widgets/trip_item.dart';

class GalleryPage extends StatelessWidget {
  final String status;

  const GalleryPage({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: /*NavigationTest()*/Navigation(),
      appBar: AppBar(
        title: const Text("Gallery"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[galleryPage(status)],
        ),
      ),
    );
  }
}
