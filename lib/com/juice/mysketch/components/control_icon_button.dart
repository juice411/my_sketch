import 'package:flutter/material.dart';

class ControlIconButton extends StatelessWidget {
  const ControlIconButton({
    Key key,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Icon(icon),
      ),
      onTap: onTap,
    );
  }
}

