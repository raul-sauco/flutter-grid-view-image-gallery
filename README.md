# Flutter GridView demo.

This project was created for an assignment in the Open University of Catalonia [UOC](https://www.uoc.edu)'s _new technologies in mobile development_ 2020/21 course. It is a demo of the [**Flutter** **GridView**](https://api.flutter.dev/flutter/widgets/GridView-class.html) widget, it uses the widget to display a grid of random images obtained from the [placeimg API](https://placeimg.com/).

The demo project consists of:

- A **GridView** widget, in charge of displaying the images in a grid.
- A **Slider** widget, at the bottom of the screen, that lets the user adjust how many images per row are displayed.

Example screen at 5 images per row:

![Example image grid](res/grid-view-1.png)

## What is this widget good for?

The **Flutter** **GridView** widget lets us easily display collections of widgets, just like the **ListView** widget, with the difference that we can use **GridView** when we don't want each widget to occupy all the available _cross-axis space_.

In the most common case, when the scrolling direction is vertical, that means that each widget in the grid does not need to take up all the available horizontal space, and we can have several widgets side by side in each row.

## When should this widget be used?

There are several useful user cases that come to mind; items in an online store, a preview of news clips, tracks in a music app, but, perhaps, the most obvious one, ought to be an **image gallery**, this is the use case used to illustrate the widget.

The widget has several constructors and, in a real world use, most likely the [`GridView.builder`](https://api.flutter.dev/flutter/widgets/GridView/GridView.builder.html) method would be used due to its flexibility. This example project uses [`GridView.count`](https://api.flutter.dev/flutter/widgets/GridView/GridView.count.html) for simplicity.

## Why is this widget so cool?

**GridView** is just a thin wrapper for **CustomScrollView**, the docs already let us know:

> A GridView is basically a CustomScrollView with a single SliverGrid in its CustomScrollView.slivers property.

But, like many other widgets in **Flutter**, **GridView** offers us a simple, declarative, way to get done what we need. We want to display a _grid_, and we use code that will be similar to this:

```dart
GridView.count(
    controller: _scrollController,
    crossAxisCount: _itemsPerRow,
    children: List.generate(_itemCount, (index) {
    return GridImage(src: _src, index: index, key: ValueKey(index));
    }),
),

```

It gets the job done, it is very simple, robust and, even more important, when at a later time someone else, or the future you, needs to review the code, it is very clear what we are trying to do, and how we are doing it, so the code will be easy to maintain and/or update.

This simplicity does not mean that we are locked in a box, and have only one way to use the widget, if we need to customize any of its properties to fit our project, **GridView** probably offers us a _property_ that we can use in one of its constructors, if we cannot find it, or need more fine-tuned customization than the widget offers, we can revert to using **CustomScrollView** and, if that were not enough customization for us, we could write our own widget using **Dart** or even native code.

## References.

- [Flutter online documentation](https://flutter.dev/docs)
- [Documentation for the GridView widget](https://api.flutter.dev/flutter/widgets/GridView-class.html)
- [GridView Cookbook page](https://flutter.dev/docs/cookbook/lists/grid-lists)
- The widget was featured on the [Flutter Widget of the Week video series](https://www.youtube.com/watch?v=bLOtZDTm4H8)
