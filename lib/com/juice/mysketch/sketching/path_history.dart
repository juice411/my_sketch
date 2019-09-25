import 'package:flutter/material.dart';

class PathHistory {
  List<MapEntry<Path, Paint>> _paths = [];
  List<MapEntry<Path, Paint>> _undos = [];
  Paint currentPaint;
  Paint _backgroundPaint = Paint();
  bool _inDrag = false;

  void undo() {
    if (!_inDrag && _paths.isNotEmpty) {
      _undos.add(_paths.removeLast());
    }
  }

  void redo() {
    if (!_inDrag && _undos.isNotEmpty) {
      _paths.add(_undos.removeLast());
    }
  }

  void clear() {
    if (!_inDrag) {
      _undos.addAll(_paths);
      _paths.clear();
    }
  }

  void add(Offset startPoint) {
    if (!_inDrag) {
      _inDrag = true;
      Path path = Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      _paths.add(MapEntry<Path, Paint>(path, currentPaint));
      //print("_paths.size=${_paths.length}");
    }
  }

  void updateCurrent(Offset nextPoint) {
    if (_inDrag) {
      Path path = _paths.last.key;
      path.lineTo(nextPoint.dx, nextPoint.dy);
    }
  }

  //void endCurrent() => _inDrag = false;
  void endCurrent(){
    _inDrag = false;
    //print("_inDrag=${_inDrag}");
  }

  void draw(Canvas canvas, Size size) {
    //canvas.drawRect(Rect.fromLTWH(-size.width / 2, -size.height / 2, size.width, size.height), _backgroundPaint);
    for (MapEntry<Path, Paint> path in _paths) {
      if (path != null) canvas.drawPath(path.key, path.value);
    }
  }

  set backgroundPaint(Color value) => _backgroundPaint.color = value;

  bool get inDrag => _inDrag;
}
