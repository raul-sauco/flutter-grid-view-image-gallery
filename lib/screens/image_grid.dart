import 'package:flutter/material.dart';
import 'package:gridview/widgets/grid_image.dart';

/// This widget renders a grid of images to the screen.
class ImageGrid extends StatelessWidget {
  final link = "https://placeimg.com/{w}/{h}";
  final size = '100';

  @override
  Widget build(BuildContext context) {
    // Calculate values based on screen size and desired thumbnail size.
    var src = link.replaceFirst('{w}', size).replaceAll('{h}', size);
    var itemsPerRow = 4;

    return GridView.count(
      crossAxisCount: itemsPerRow,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(200, (index) {
        return GridImage(src: src, index: index);
      }),
    );
  }
}
