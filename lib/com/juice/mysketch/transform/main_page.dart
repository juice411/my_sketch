import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_sketch/com/juice/mysketch/components/expandable_controls.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/sketching_controller.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/sketching_painter.dart';
import 'package:my_sketch/com/juice/mysketch/transform/transformations_gesture_transformable.dart';
import 'package:my_sketch/com/juice/mysketch/util/color_dialog.dart';
import 'package:my_sketch/com/juice/mysketch/util/storage.dart';
import 'package:my_sketch/com/juice/mysketch/util/width_dialog.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State <MainPage> with TickerProviderStateMixin {
  //用以控制菜单的动画
  AnimationController _controller;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // The widgets returned by build(...) change when animationStatus changes
    _controller.addStatusListener((newAnimationStatus) {
      if (newAnimationStatus != _animationStatus) {
        setState(() {
          _animationStatus = newAnimationStatus;
        });
      }
    });
  }

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
            onTapUp: (details){
              print("onTapUp=${details.toString()}");
              if (expandableController.expanded) expandableController.toggle();
            },
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
            //storage: Storage(),
          );
        },
      ),
      //bottomNavigationBar: ExpandableControls(),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () => controller.transformReset=true,
        tooltip: 'Reset Transform',
        child: const Icon(Icons.home),
      ),*/
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !_controller.isDismissed
              ? Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0 - 0 / 3 / 2.0,
                    curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                mini: true,
                child: Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                },
              ),
            ),
          )
              : null,
          !_controller.isDismissed
              ? Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0 - 1 / 3 / 2.0,
                    curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                mini: true,
                child: Icon(Icons.lens),
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) =>
                          WidthDialog());

                },
              ),
            ),
          )
              : null,
          !_controller.isDismissed
              ? Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0 - 2 / 3 / 2.0,
                    curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                mini: true,
                child: Icon(Icons.color_lens),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => ColorDialog(),
                  ) as Color;
                },
              ),
            ),
          )
              : null,
          !_controller.isDismissed
              ? Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0 - 0 / 3 / 2.0,
                    curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                mini: true,
                child: Icon(Icons.undo),
                onPressed: () {
                  controller.undo();
                },
              ),
            ),
          )
              : null,
          !_controller.isDismissed
              ? Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0 - 0 / 3 / 2.0,
                    curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                mini: true,
                child: Icon(Icons.redo),
                onPressed: () {
                  controller.redo();
                },
              ),
            ),
          )
              : null,
          !_controller.isDismissed
              ? Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0 - 0 / 3 / 2.0,
                    curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                mini: true,
                child: Icon(Icons.autorenew),
                onPressed: () {
                  controller.transformReset=true;
                },
              ),
            ),
          )
              : null,
          FloatingActionButton(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Transform(
                  transform:
                  Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: Icon(Icons.brush),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ].where((widget) => widget != null).toList(),
      ),

    );

  }

  Offset getPoint(BuildContext context, Offset position) {
    return (context.findRenderObject() as RenderBox).globalToLocal(position);
  }

}

