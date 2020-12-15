import 'package:flutter/material.dart';

/// GridImage renders a single image intended to be used inside a grid.
class GridImage extends StatelessWidget {
  GridImage({this.src, this.index});
  final src;
  final index;

  @override
  Widget build(BuildContext context) {
    // Nice looking card container for the image found here
    // https://stackoverflow.com/a/53866811/2557030
    return Stack(
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(),
        ),
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // TODO update to use a FadeInImage widget
          // https://flutter.dev/docs/cookbook/images/fading-in-images
          child: Image.network(
            '$src?v=$index',
            // Use frameBuilder to fade in the image once loaded.
            frameBuilder: (BuildContext context, Widget child, int frame,
                bool wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              // If the image has not loaded yet, we do not want any opacity,
              // we want the loading icon behind to be visible.
              return AnimatedOpacity(
                child: child,
                opacity: frame == null ? 0 : 1,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            },
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[700], width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: EdgeInsets.all(8),
        ),
      ],
    );
  }
}
