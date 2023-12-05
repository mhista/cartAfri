import 'package:cartafri/core/constants/constants.dart';
import 'package:flutter/material.dart';

// Bottom Navigation Icons
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

// the star review icons
class StarIcon extends StatelessWidget {
  StarIcon({required this.starType});
  final IconData starType;
  @override
  Widget build(BuildContext context) {
    return Icon(starType, size: 20, color: kYellow);
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

// Icon button for the categories
class CategoryIconButton extends StatelessWidget {
  const CategoryIconButton(
      {required this.iconData,
      required this.onPressed,
      this.color,
      this.bgColor,
      this.elevation});
  final IconData? iconData;
  final Function()? onPressed;
  final Color? color;
  final Color? bgColor;
  final double? elevation;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: bgColor,
          elevation: elevation,
          padding: EdgeInsets.all(14.0)),
      child: Icon(iconData, size: 25, color: color),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton(
      {required this.iconChild, required this.onPressed, this.fillColor});

  final IconData iconChild;
  final Function() onPressed;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      fillColor: fillColor,
      constraints: BoxConstraints.tightFor(width: 30.0, height: 30.0),
      onPressed: onPressed,
      child: Icon(iconChild, color: Colors.white70),
    );
  }
}

// the promo button
class FilledTextButton extends StatelessWidget {
  const FilledTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: () {}, child: Text('promo'));
  }
}

//custom filled button for checkout, cart etc
class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    required this.text,
    required this.onPress,
  });
  final String text;
  final Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPress,
        style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
        child: Text(text));
  }
}

//custom appbar for the project
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        surfaceTintColor: null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        title: AppBarTitle(
          title: title,
        ));
  }
}

// the appbar text widget
class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}

//star review class with text
class RowTextReview extends StatelessWidget {
  const RowTextReview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StarIcon(starType: Icons.star),
        StarIcon(starType: Icons.star),
        StarIcon(starType: Icons.star),
        StarIcon(starType: Icons.star),
        StarIcon(starType: Icons.star_border),
        Text(' 4.5', style: kProductStyle),
      ],
    );
  }
}

//Star review without text
class ColumnTextReview extends StatelessWidget {
  const ColumnTextReview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StarIcon(starType: Icons.star),
        StarIcon(starType: Icons.star),
        StarIcon(starType: Icons.star),
        StarIcon(starType: Icons.star),
        StarIcon(starType: Icons.star_border),
      ],
    );
  }
}

// Icons used in the project
class AuthIcons extends StatelessWidget {
  const AuthIcons({super.key, required this.authIcon});
  final IconData authIcon;
  @override
  Widget build(BuildContext context) {
    return Icon(authIcon, size: 30);
  }
}

// Expanded Flat Button
class ExpandedButton extends StatelessWidget {
  final Function()? onpress;
  final String title;

  const ExpandedButton({super.key, required this.onpress, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
          onPressed: onpress,
          style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0))),
          child: Text(title)),
    );
  }
}
