import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:galaxy_food_restaurants/galaxy_theme.dart';

enum IconAlignment{
  start,
  end
}

class GalaxyButton extends Button{

  final IconAlignment iconAlignment;
  final Widget? icon;

  GalaxyButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.style,
    super.focusNode,
    super.autofocus = true,
    super.onTapDown,
    super.onTapUp,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    required Widget child
  }) : super(
    child: icon == null
      ? child
      : _GalaxyButtonWithIcon(
      label: child,
      icon: icon,
      buttonStyle: style,
      iconAlignment: iconAlignment
    )
  );


  @override
  ButtonStyle defaultStyleOf(BuildContext context) => _GalaxyButtonDefaultStyle(context, icon != null);

  @override
  ButtonStyle? themeStyleOf(BuildContext context) => ButtonTheme.of(context).defaultButtonStyle;

}

class _GalaxyButtonWithIcon extends StatelessWidget {
  const _GalaxyButtonWithIcon({
    required this.label,
    required this.icon,
    required this.buttonStyle,
    required this.iconAlignment,
  });

  final Widget label;
  final Widget icon;
  final ButtonStyle? buttonStyle;
  final IconAlignment iconAlignment;

  @override
  Widget build(BuildContext context) {
    final double defaultFontSize = buttonStyle?.textStyle?.resolve(const <WidgetState>{})?.fontSize ?? 14.0;
    final double scale = clampDouble(MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0, 1.0, 2.0) - 1.0;

    final double gap = lerpDouble(8, 4, scale)!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: iconAlignment == IconAlignment.start
          ? <Widget>[icon, SizedBox(width: gap), Flexible(child: label)]
          : <Widget>[Flexible(child: label), SizedBox(width: gap), icon],
    );
  }
}

class _GalaxyButtonDefaultStyle extends ButtonStyle {

  final BuildContext context;
  final bool hasIcon;
  final _theme = GalaxyFoodTheme.normal;

  _GalaxyButtonDefaultStyle(this.context, this.hasIcon);

  @override
  WidgetStateProperty<TextStyle?> get textStyle =>
      WidgetStatePropertyAll<TextStyle?>(GalaxyFoodTheme.text.labelLarge);

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected) || states.contains(WidgetState.pressed)){
          return _theme.activeColor;
        }
        if (states.contains(WidgetState.disabled)) {
          return _theme.cardColor.withOpacity(0.12);
        }
        return Colors.transparent;
      });

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return _theme.cardColor.withOpacity(0.38);
        }
        return Colors.white;
      });


  @override
  WidgetStateProperty<Color>? get shadowColor =>
      WidgetStatePropertyAll<Color>(_theme.shadowColor);

  @override
  WidgetStateProperty<double>? get elevation =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return 1.0;
        }
        return 0.0;
      });

  @override
  WidgetStateProperty<EdgeInsetsGeometry>? get padding =>
      WidgetStatePropertyAll<EdgeInsetsGeometry>(_scaledPadding(context, hasIcon));



  @override
  WidgetStateProperty<OutlinedBorder>? get shape =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: states.contains(WidgetState.selected) || states.contains(WidgetState.pressed)
              ? BorderSide.none
              : const BorderSide(
                color: Colors.white,
                width: 1.5,
              )
        );
      });



}

EdgeInsetsGeometry _scaledPadding(BuildContext context, [bool hasIcon = false]) {

  final double defaultFontSize = GalaxyFoodTheme.text.labelLarge?.fontSize ?? 14.0;
  final double effectiveTextScale = MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;
  const padding1x = 24.0;

  var geometry1x = const EdgeInsets.symmetric(horizontal: padding1x, vertical: padding1x * 2 / 3);
  var geometry2x = const EdgeInsets.symmetric(horizontal: padding1x / 2, vertical: padding1x / 3);
  var geometry3x = const EdgeInsets.symmetric(horizontal: padding1x / 2 / 2, vertical: padding1x / 3 / 2);

  if (hasIcon) {

    geometry1x = const EdgeInsets.only(left: padding1x * 2 / 3, right:  padding1x, top: padding1x * 2 / 3, bottom: padding1x * 2 / 3);
    geometry2x = const EdgeInsets.only(left: padding1x / 3, right:  padding1x / 2,  top: padding1x / 3, bottom: padding1x / 3);
    geometry3x = const EdgeInsets.only(left: padding1x / 3 / 2, right:  padding1x / 2 / 2,  top: padding1x / 3 / 2, bottom: padding1x / 3 / 2);

  }

  return switch (effectiveTextScale) {
    <= 1 => geometry1x,
    < 2  => EdgeInsetsGeometry.lerp(geometry1x, geometry2x, effectiveTextScale - 1)!,
    < 3  => EdgeInsetsGeometry.lerp(geometry2x, geometry3x, effectiveTextScale - 2)!,
    _    => geometry3x,
  };






}