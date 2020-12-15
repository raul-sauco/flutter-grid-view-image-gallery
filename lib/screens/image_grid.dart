import 'package:flutter/material.dart';
import 'package:gridview/widgets/grid_image.dart';

/// This widget renders a grid of images to the screen.
class ImageGrid extends StatefulWidget {
  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  final _link = "https://placeimg.com/{w}/{h}";
  int _itemsPerRow = 4;
  int _batches = 1;

  @override
  Widget build(BuildContext context) {
    // Calculate parameters based on desired zoom and screen size.
    final _size = getSize(context, _itemsPerRow);
    final _itemCount =
        getItemBatchSize(context, _size, _itemsPerRow) * _batches;
    final _requestSize = _size.ceil().toString();
    final _src =
        _link.replaceFirst('{w}', _requestSize).replaceAll('{h}', _requestSize);

    return Stack(
      children: [
        GridView.count(
          crossAxisCount: _itemsPerRow,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(_itemCount, (index) {
            return GridImage(src: _src, index: index);
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
                  print('Updating value to $value');
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
