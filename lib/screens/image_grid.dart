import 'package:flutter/material.dart';
import 'package:gridview/widgets/grid_image.dart';

/// This widget renders a grid of images to the screen.
///
/// The grid allows for zooming in/out and it implements endless scrolling,
/// loading more images before the user reaches the bottom of the grid.
class ImageGrid extends StatefulWidget {
  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  final _link = "https://placeimg.com/{w}/{h}";
  final _scrollController = ScrollController();
  int _itemsPerRow = 4;
  int _batches = 1;
  bool _fetching = false;

  @override
  Widget build(BuildContext context) {
    // Reset the flag on every build.
    _fetching = false;
    // Bind the scrollController event.
    _scrollController.addListener(() {
      var limit = 0.8 * _scrollController.position.maxScrollExtent;
      if (!_fetching && _scrollController.position.pixels > limit) {
        setState(() {
          _fetching = true;
          _batches++;
        });
      }
    });

    // We need to do this inside the build because we need BuildContext.
    // Calculate parameters based on desired zoom and screen size.
    final _size = getSize(context, _itemsPerRow);
    final _itemCount =
        getItemBatchSize(context, _size, _itemsPerRow) * _batches;
    final _requestSize = _size.ceil().toString();
    final _src =
        _link.replaceFirst('{w}', _requestSize).replaceAll('{h}', _requestSize);

    return Stack(
      children: [
        // Generate a grid of random images with the chosen zoom ratio.
        GridView.count(
          controller: _scrollController,
          crossAxisCount: _itemsPerRow,
          children: List.generate(_itemCount, (index) {
            return GridImage(src: _src, index: index, key: ValueKey(index));
          }),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 64,
            child: Slider(
              value: _itemsPerRow.toDouble(),
              min: 1,
              max: 6,
              divisions: 5,
              label: _itemsPerRow.toString(),
              onChanged: (double value) {
                setState(() {
                  _itemsPerRow = value.round();
                });
              },
            ),
          ),
        )
      ],
    );
  }
}

// Get the desired image size.
double getSize(BuildContext context, int itemsPerRow) {
  final _width = MediaQuery.of(context).size.width;
  // TODO take into account grid gutter.
  return _width / itemsPerRow;
}

// Get the desired number of rows and total items to request initially.
int getItemBatchSize(BuildContext context, double size, int itemsPerRow) {
  final _height = MediaQuery.of(context).size.height;
  final _padding = MediaQuery.of(context).padding;
  final _safeHeight = _height - _padding.top - _padding.bottom;
  // Add 20% extra non-visible rows at the end to make endless scroll smooth.
  final _desiredExtraRows = 1.2;
  final _desiredRows = (_safeHeight / size * _desiredExtraRows).ceil();
  return _desiredRows * itemsPerRow;
}
