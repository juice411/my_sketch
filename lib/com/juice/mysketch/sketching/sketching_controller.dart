import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/path_history.dart';
import 'package:my_sketch/com/juice/mysketch/util/colors.dart';
import 'package:path_provider/path_provider.dart';

class SketchingController extends ChangeNotifier {
  Color _brushColour = defaultBrush;
  Color _backgroundColour = defaultBackground;
  double _brushThickness = defaultThickness;
  PathHistory _history = PathHistory();
  GlobalKey sketchKey = GlobalKey();
  bool _transformReset=false;
  
  SketchingController() {
    updatePaint();
  }

  get transformReset => _transformReset;

  set transformReset(bool value){
    _transformReset=value;
    notifyListeners();
  }

  void updatePaint() {
    var paint = Paint()
      ..color = brushColour
      ..style = PaintingStyle.stroke
      ..strokeWidth = brushThickness
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    _history
      ..currentPaint = paint
      ..backgroundPaint = backgroundColour;
    notifyListeners();
  }

  void startSketch(Offset startPoint) {
    _history.add(startPoint);
    //print("startPoint-----");
    //notifyListeners();//暂时注释，没发现什么异常情况
  }

  void updateSketchPath(Offset currentPoint) {
    _history.updateCurrent(currentPoint);
    //print("update-----");
    notifyListeners();
  }

  void endSketch() {
    _history.endCurrent();
    //print("endCurrent-----");
    //notifyListeners();//暂时注释，没发现什么异常情况
  }

  void undo() {
    _history.undo();
    notifyListeners();
  }

  void redo() {
    _history.redo();
    notifyListeners();
  }

  void clear() {
    _history.clear();
    /*backgroundColour = defaultBackground;
    brushColour = defaultBrush;
    brushThickness = defaultThickness;*/
    notifyListeners();
  }

  void save() async {
    RenderRepaintBoundary boundary = sketchKey.currentContext.findRenderObject();
    var image = await boundary.toImage(pixelRatio: 3);
    var imageData = await image.toByteData(format: ImageByteFormat.png);
    var directory = (await getExternalStorageDirectory()).path;
    var fileName = DateFormat("y-M-d H:m:s").format(DateTime.now());
    var file = File('$directory/$fileName.png');
    file.writeAsBytes(imageData.buffer.asUint8List());
  }

  Color get brushColour => _brushColour;

  set brushColour(Color value) {
    _brushColour = value;
    updatePaint();
  }

  double get brushThickness => _brushThickness;

  set brushThickness(double value) {
    _brushThickness = value;
    updatePaint();
  }

  Color get backgroundColour => _backgroundColour;

  set backgroundColour(Color value) {
    _backgroundColour = value;
    updatePaint();
  }

  PathHistory get history => _history;
}
