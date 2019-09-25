import 'package:flutter/material.dart';

import 'colour_picker_row.dart';

class ColourPickerTile extends StatelessWidget {
  const ColourPickerTile({
    Key key,
    @required this.selectedColour,
    @required this.selectColour,
    @required this.icon,
  }) : super(key: key);

  final Color selectedColour;
  final ValueChanged<Color> selectColour;
  final IconData icon;

  @override
  Widget build(BuildContext context) {

    //print("===color_picker_tile===");

    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: SizedBox(
        height: 50,
        child: Row(
          children: <Widget>[
            Icon(icon, color: selectedColour),
            const SizedBox(width: 15),
            Expanded(
              child: ColourPickerRow(
                selectColour: selectColour,
                selectedColour: selectedColour,
              ),
            ),
          ],
        ),
      ),
    );
  }
}