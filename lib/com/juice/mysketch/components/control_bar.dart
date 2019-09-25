import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/sketching_controller.dart';
import 'package:provider/provider.dart';
import 'package:my_sketch/com/juice/mysketch/components/control_icon_button.dart';

import '../controls.dart';
class ControlBar extends StatelessWidget {
  const ControlBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SketchingController>(context);
    var controls = Provider.of<ControlsNotifier>(context);
    var expandableController = ExpandableController.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ControlIconButton(
              icon: Icons.format_paint,
              onTap: () {
                if (expandableController.expanded &&
                    controls.value == Controls.canvas) {
                  controls.value = Controls.sketch;
                  return;
                }
                expandableController.toggle();
                controls.value = Controls.sketch;
              }),
          Row(
            children: <Widget>[
              ControlIconButton(
                icon: Icons.undo,
                onTap: controller.undo,
              ),
              const SizedBox(width: 20),
              ControlIconButton(
                icon: Icons.redo,
                onTap: controller.redo,
              ),
            ],
          ),
          ControlIconButton(
            icon: Icons.more_vert,
            onTap: () {
              if (expandableController.expanded &&
                  controls.value == Controls.sketch) {
                controls.value = Controls.canvas;
                return;
              }
              expandableController.toggle();
              controls.value = Controls.canvas;
            },
          ),
        ],
      ),
    );
  }
}
