import 'package:flutter/material.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/sketching_controller.dart';
import 'package:provider/provider.dart';

import 'colour_picker_tile.dart';

class SketchControls extends StatelessWidget {
  const SketchControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SketchingController>(context);
    //print("===sketch_controls===");
    return Column(
      children: <Widget>[
        ColourPickerTile(
          selectedColour: controller.brushColour,
          selectColour: (colour) => controller.brushColour = colour,
          icon: Icons.color_lens,
        ),
        ColourPickerTile(
          selectedColour: controller.backgroundColour,
          selectColour: (colour) => controller.backgroundColour = colour,
          icon: Icons.format_color_fill,
        ),
        ListTile(
          leading: Text(controller.brushThickness.toStringAsPrecision(2)),
          title: Slider(
            value: controller.brushThickness,
            min: 0,
            max: 20,
            onChanged: (data) => controller.brushThickness = data,
            activeColor: Colors.white,
          ),
        ),
      ],
    );
  }
}