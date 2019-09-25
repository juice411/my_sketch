import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:my_sketch/com/juice/mysketch/components/sketch_controls.dart';
import 'package:provider/provider.dart';

import '../controls.dart';
import 'canvas_controls.dart';
import 'control_bar.dart';

class ExpandableControls extends StatelessWidget {
  const ExpandableControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Consumer<ControlsNotifier>(
          builder: (context, controls, child) {
            //print("===expandable_controls_Consumer===");
            return Expandable(
                expanded: controls.value == Controls.sketch
                    ? const SketchControls()
                    : const CanvasControls(),
            );
          },
        ),
        FractionallySizedBox(
          widthFactor: 1,
          child: const ControlBar(),
        ),
      ],
    );
  }
}