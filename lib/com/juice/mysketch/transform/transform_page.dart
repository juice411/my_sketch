import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_sketch/com/juice/mysketch/components/expandable_controls.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/sketching_controller.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/sketching_painter.dart';
import 'package:my_sketch/com/juice/mysketch/transform/transformations_gesture_transformable.dart';
import 'package:provider/provider.dart';

class TransformPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SketchingController>(context);
    var expandableController = ExpandableController.of(context);

    // TODO: implement build
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Draw the scene as big as is available, but allow the user to
          // translate beyond that to a visibleSize that's a bit bigger.
          //final Size size = Size(constraints.maxWidth, constraints.maxHeight);
          final Size size = Size(constraints.maxWidth, constraints.maxHeight);
          final Size visibleSize = Size(size.width * 3, size.height * 2);

          /*print("${size.toString()}");
            print("${visibleSize.toString()}");*/

          return GestureTransformable(
            reset: controller.transformReset,
            onResetEnd: () {
              controller.transformReset=false;
            },
            //child: CustomPaint(painter:StarView(context,randomRGB())),
            child: CustomPaint(
              painter: SketchingPainter(
                history: controller.history,
                repaint: controller,
              ),
              size:Size.infinite,
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
            initialTranslation: Offset(size.width / 2, size.height / 2),
            //initialTranslation: Offset(0, 0),
            onTapUp: _onTapUp,
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
      ),
      bottomNavigationBar: ExpandableControls(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.transformReset=true,
        tooltip: 'Reset Transform',
        child: const Icon(Icons.home),
      ),
    );

  }

  void _onTapUp(TapUpDetails details) {
    final Offset scenePoint = details.globalPosition;
    /*final BoardPoint boardPoint = _board.pointToBoardPoint(scenePoint);
    setState(() {
      _board = _board.copyWithSelected(boardPoint);
    });*/
  }

  Offset getPoint(BuildContext context, Offset position) {
    return (context.findRenderObject() as RenderBox).globalToLocal(position);
  }

}

