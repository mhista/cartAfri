import 'package:cartafri/app_config/constants.dart';
import 'package:flutter/material.dart';

class BottomBarIcons extends StatelessWidget {
  const BottomBarIcons(
      {required this.iconData, required this.label, this.selectedIcon});
  final IconData iconData;
  final String label;
  final IconData? selectedIcon;
  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Icon(iconData),
      label: label,
      selectedIcon: Icon(selectedIcon, color: kButtonColor),
    );
  }
}

class StarIcon extends StatelessWidget {
  StarIcon({required this.starType});
  final IconData starType;
  @override
  Widget build(BuildContext context) {
    return Icon(starType, size: 20, color: Color(0xffe3ca00));
  }
}

class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton({required this.iconData, required this.onPressed});
  final IconData iconData;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      color: kButtonColor,
      onPressed: onPressed,
    );
  }
}

class ElevatedIconButton extends StatelessWidget {
  const ElevatedIconButton(
      {required this.iconData,
      required this.onPressed,
      this.color,
      this.bgColor});
  final IconData? iconData;
  final Function()? onPressed;
  final Color? color;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Icon(iconData, size: 25, color: color),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: bgColor,
          padding: EdgeInsets.all(14.0)),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.IconChild, required this.onPressed});

  final IconData IconChild;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(IconChild),
      shape: RoundedRectangleBorder(),
      fillColor: Color(0xFF4C4F5E),
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      onPressed: onPressed,
    );
  }
}

class FilledTextButton extends StatelessWidget {
  const FilledTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: (){}, child: Text('promo'));
  }
}
