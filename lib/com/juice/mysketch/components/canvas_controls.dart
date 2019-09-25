import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/sketching_controller.dart';
import 'package:provider/provider.dart';

class CanvasControls extends StatelessWidget {
  const CanvasControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SketchingController>(context);
    var expandableController = ExpandableController.of(context);

    return Column(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.clear),
          title: const Text('Reset canvas'),
          onTap: () {
            controller.clear();
            expandableController.toggle();
          },
        ),
        ListTile(
          leading: const Icon(Icons.save),
          title: const Text('Save drawing'),
          onTap: () async {
            expandableController.toggle();
            await Future.delayed(Duration(milliseconds: 300));
            controller.save();
          },
        ),
      ],
    );
  }
}
