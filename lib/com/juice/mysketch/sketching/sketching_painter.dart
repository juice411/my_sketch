import 'package:flutter/material.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/path_history.dart';
import 'package:my_sketch/com/juice/mysketch/util/my_util.dart';

class SketchingPainter extends CustomPainter {
  final PathHistory history;

  const SketchingPainter({
    this.history,
    Listenable repaint,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) => history.draw(canvas, size);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class StarView extends CustomPainter {

  Paint mHelpPaint;
  BuildContext context;
  Color color;

  Paint mPaint;

  StarView(this.context,this.color){
    mHelpPaint = new Paint();
    mHelpPaint.style=PaintingStyle.stroke;
    mHelpPaint.color=Color(0xffBBC3C5);
    mHelpPaint.isAntiAlias=true;

    mPaint = new Paint();
    mPaint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var winSize = MediaQuery.of(context).size;
    //网格
    //canvas.drawPath(gridPath(20, winSize), mHelpPaint);

    //坐标轴
    //drawCoo(canvas, Size(winSize.width/2-1, winSize.height/2-1), winSize);


    //canvas.translate(winSize.width/2-1, winSize.height/2-1);//移动到坐标系原点
    canvas.drawPath(nStarPath(5,80,40), mPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}
