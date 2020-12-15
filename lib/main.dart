import 'package:flutter/material.dart';
import 'package:gridview/screens/image_grid.dart';

void main() {
  runApp(App());
}

/// This app is a demo of the Flutter GridView widget.
///
/// The docs for the widget live here:
/// https://api.flutter.dev/flutter/widgets/GridView-class.html
///
/// The widget was featured on the 'Flutter Widget of the Week' series:
/// https://www.youtube.com/watch?v=bLOtZDTm4H8
class App extends StatelessWidget {
  final title = 'GridView Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: title),
    );
  }
}

/// HomePage renders the application bar and calls the screen rendering widget.
class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(title)),
      body: ImageGrid(),
    );
  }
}
