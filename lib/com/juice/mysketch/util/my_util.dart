
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/**
 * 绘制网格路径
 *
 * @param step    小正方形边长
 * @param winSize 屏幕尺寸
 */
Path gridPath(int step, Size winSize) {
  Path path = new Path();

  for (int i = 0; i < winSize.height / step + 1; i++) {
    path.moveTo(0, step * i.toDouble());
    path.lineTo(winSize.width, step * i.toDouble());
  }

  for (int i = 0; i < winSize.width / step + 1; i++) {
    path.moveTo(step * i.toDouble(), 0);
    path.lineTo(step * i.toDouble(), winSize.height);
  }
  return path;
}

/**
 * 坐标系路径
 *
 * @param coo     坐标点
 * @param winSize 屏幕尺寸
 * @return 坐标系路径
 */
Path cooPath(Size coo, Size winSize) {
  Path path = new Path();
  //x正半轴线
  path.moveTo(coo.width, coo.height);
  path.lineTo(winSize.width, coo.height);
  //x负半轴线
  path.moveTo(coo.width, coo.height);
  path.lineTo(coo.width - winSize.width, coo.height);
  //y负半轴线
  path.moveTo(coo.width, coo.height);
  path.lineTo(coo.width, coo.height - winSize.height);
  //y负半轴线
  path.moveTo(coo.width, coo.height);
  path.lineTo(coo.width, winSize.height);
  return path;
}

//绘制坐标系
drawCoo(Canvas canvas, Size coo, Size winSize) {
  //初始化网格画笔
  Paint paint = new Paint();
  paint.strokeWidth = 2;
  paint.style = PaintingStyle.stroke;

  //绘制直线
  canvas.drawPath(cooPath(coo, winSize), paint);
  //左箭头
  canvas.drawLine(new Offset(winSize.width, coo.height),
      new Offset(winSize.width - 10, coo.height - 6), paint);
  canvas.drawLine(new Offset(winSize.width, coo.height),
      new Offset(winSize.width - 10, coo.height + 6), paint);
  //下箭头
  canvas.drawLine(new Offset(coo.width, winSize.height-90),
      new Offset(coo.width - 6, winSize.height - 10-90), paint);
  canvas.drawLine(new Offset(coo.width, winSize.height-90),
      new Offset(coo.width + 6, winSize.height - 10-90), paint);
}

/**
 * n角星路径
 *
 * @param num 几角星
 * @param R   外接圆半径
 * @param r   内接圆半径
 * @return n角星路径
 */
Path nStarPath(int num, double R, double r) {

  double _rad(double deg) {
    return deg * pi / 180;
  }

  Path path = new Path();
  double perDeg = 360 / num; //尖角的度数
  double degA = perDeg / 2 / 2;
  double degB = 360 / (num - 1) / 2 - degA / 2 + degA;

  path.moveTo(cos(_rad(degA)) * R, (-sin(_rad(degA)) * R));
  for (int i = 0; i < num; i++) {
    path.lineTo(
        cos(_rad(degA + perDeg * i)) * R, -sin(_rad(degA + perDeg * i)) * R);
    path.lineTo(
        cos(_rad(degB + perDeg * i)) * r, -sin(_rad(degB + perDeg * i)) * r);
  }
  path.close();
  return path;
}

Color randomRGB(){
  Random random = new Random();
  int r = 30 + random.nextInt(200);
  int g = 30 + random.nextInt(200);
  int b = 30 + random.nextInt(200);
  return Color.fromARGB(255, r, g, b);
}

bool useWhiteForeground(Color color) {
  return 1.05 / (color.computeLuminance() + 0.05) > 4.5;
}

/// reference: https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_HSL
HSLColor hsvToHsl(HSVColor color) {
  double s = 0.0;
  double l = 0.0;
  l = (2 - color.saturation) * color.value / 2;
  if (l != 0) {
    if (l == 1)
      s = 0.0;
    else if (l < 0.5)
      s = color.saturation * color.value / (l * 2);
    else
      s = color.saturation * color.value / (2 - l * 2);
  }
  return HSLColor.fromAHSL(color.alpha, color.hue, s, l);
}

/// reference: https://en.wikipedia.org/wiki/HSL_and_HSV#HSL_to_HSV
HSVColor hslToHsv(HSLColor color) {
  double s = 0.0;
  double v = 0.0;

  v = color.lightness +
      color.saturation *
          (color.lightness < 0.5 ? color.lightness : 1 - color.lightness);
  if (v != 0) {
    s = 2 - 2 * color.lightness / v;
  }

  return HSVColor.fromAHSV(color.alpha, color.hue, s, v);
}