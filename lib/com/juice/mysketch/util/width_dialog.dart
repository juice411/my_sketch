import 'package:flutter/material.dart';
import 'package:my_sketch/com/juice/mysketch/sketching/sketching_controller.dart';
import 'package:provider/provider.dart';

class WidthDialog extends StatefulWidget {
  /*final double strokeWidth;

  WidthDialog({@required this.strokeWidth});*/

  @override
  State<StatefulWidget> createState() => WidthDialogState();
}

class WidthDialogState extends State<WidthDialog> {
  //double strokeWidth;

  @override
  /*void initState() {
    super.initState();
    strokeWidth = widget.strokeWidth;
  }*/

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SketchingController>(context);
    return SimpleDialog(
        //title: Text('${controller.brushThickness.toStringAsPrecision(2)}'),
        contentPadding: const EdgeInsets.all(12.0),
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    '${controller.brushThickness.toStringAsPrecision(2)}',
                    style: TextStyle(color: controller.brushColour),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  width: controller.brushThickness,
                  height: controller.brushThickness,
                  decoration:
                  BoxDecoration(color: controller.brushColour, shape: BoxShape.circle),
                  padding: EdgeInsets.all(5.0),
                ),
                flex:5,
              ),
            ],
          ),

          Slider(
            value: controller.brushThickness,
            min: 1.0,
            max: 20.0,
            onChanged: (d) {
              setState(() {
                controller.brushThickness=d;
              });
            },
            activeColor: Colors.grey,
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: ThemeData().accentColor),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  }),
              FlatButton(
                  child: Text(
                    'ACCEPT',
                    style: TextStyle(color: ThemeData().accentColor),
                  ),
                  onPressed: () async {
                    Navigator.pop(context, strokeWidth);
                  }),
            ],
          ),*/
        ]);
  }
}
