import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/sketching_controller.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/sketching_painter.dart';
import 'package:my_sketch/com/juice/mysketch/transform/transformations_gesture_transformable.dart';
import 'package:provider/provider.dart';

class SketchingCanvas extends StatelessWidget {
  const SketchingCanvas({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SketchingController>(context);
    var expandableController = ExpandableController.of(context);

    //print("===sketching_canvas===");
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Draw the scene as big as is available, but allow the user to
        // translate beyond that to a visibleSize that's a bit bigger.
        final Size size = Size(constraints.maxWidth, constraints.maxHeight);
        final Size visibleSize = Size(size.width * 3, size.height * 2);

        return GestureTransformable(
          reset: controller.transformReset,
          onResetEnd: () {
            controller.transformReset=false;
          },
          /*child: ClipRect(
            child: RepaintBoundary(
              key: controller.sketchKey,
              child: CustomPaint(
                *//*painter: SketchingPainter(
                  history: controller.history,
                  repaint: controller,
                ),*//*
                painter: StarView(context,Colors.yellow),
                size: Size.infinite,
              ),
            ),
          ),*/
          /*child: CustomPaint(
            painter: SketchingPainter(
                  history: controller.history,
                  repaint: controller,
                ),
          ),*/
          child: CustomPaint(
            painter:StarView(context,Colors.yellow),
          ),
          boundaryRect: Rect.fromLTWH(
            -visibleSize.width / 2,
            -visibleSize.height / 2,
            visibleSize.width,
            visibleSize.height,
          ),
          // Center the board in the middle of the screen. It's drawn centered
          // at the origin, which is the top left corner of the
          // GestureTransformable.
          initialTranslation: Offset(0, 0),
          //onTapUp: _onTapUp,
          onScaleStart: (start) {
            print("onPanStart=${start.toString()}");
            if (expandableController.expanded) expandableController.toggle();
            controller.startSketch(getPoint(context, start.focalPoint));
          },
          onScaleUpdate: (update){
            print("onPanUpdate=${update.toString()}");
            controller.updateSketchPath(getPoint(context, update.focalPoint));
          } ,
          onScaleEnd: (end){
            print("onPanEnd=${end.toString()}");
            controller.endSketch();
          },
          size: size,
        );
      },
    );
  }

  Offset getPoint(BuildContext context, Offset position) {
    return (context.findRenderObject() as RenderBox).globalToLocal(position);
  }
}


