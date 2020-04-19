part of 'components.dart';

enum ButtonType {
  primary,
  secondary,
  success,
  warning,
  danger,
  info,
  light,
  dark
}

enum ButtonShape {
  standard,

  circular
}

class LButton extends StatelessWidget {
  final Color textColor;
  final LiquidColor color;
  final String text;
  final ButtonType type;
  final ButtonShape shape;
  final Widget child;
  final double elevation;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function onPressed;
  final bool autofocus;
  final BorderRadius borderRadius;
  final bool canRequestFocus;
  final ShapeBorder customBorder;
  final bool enableFeedback;
  final bool excludeFromSemantics;
  final Color focusColor;
  final FocusNode focusNode;
  final Color highlightColor;
  final Color hoverColor;
  final Function onFocusChange;
  final Function onHighlightChanged;
  final Function onHover;
  final bool small;
  final double borderThickness;

  const LButton({
    Key key,
    this.child,
    this.color,
    this.text,
    this.textColor,
    this.elevation = 0.0,
    this.small = false,
    this.type = ButtonType.primary,
    this.shape = ButtonShape.standard,
    this.margin,
    this.padding,
    this.onPressed,
    this.autofocus,
    this.borderRadius,
    this.canRequestFocus,
    this.customBorder,
    this.enableFeedback,
    this.excludeFromSemantics,
    this.focusColor,
    this.focusNode,
    this.highlightColor,
    this.hoverColor,
    this.onFocusChange,
    this.onHighlightChanged,
    this.onHover,
    this.borderThickness,
  })  : assert(
            (child != null && text == null) || (child == null && text != null),
            "Use either child or text"),
        super(key: key);

  LiquidColor getColor(LiquidThemeData themeData) {
    final bg = themeData.buttonColors;

    switch (type) {
      case ButtonType.secondary:
        return bg.secondaryColor;
        break;
      case ButtonType.success:
        return bg.success;
        break;
      case ButtonType.danger:
        return bg.danger;
        break;
      case ButtonType.info:
        return bg.info;
        break;
      case ButtonType.warning:
        return bg.warning;
        break;
      case ButtonType.light:
        return bg.light;
        break;
      case ButtonType.dark:
        return bg.dark;
        break;

      case ButtonType.primary:
      default:
        return bg.primaryColor;
        break;
    }
  }

  double _getRadius() {
    switch (shape) {
      case ButtonShape.circular:
        return 1000.0;
        break;
      case ButtonShape.standard:
      default:
        return 2.0;
    }
  }

  ShapeBorder _getShape(LiquidThemeData themeData, Color color) {
    return RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(_getRadius()),
        side: BorderSide(width: borderThickness ?? 1.0, color: color));
  }

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final _color = color ?? getColor(theme);
    final _shape = _getShape(theme, _color);

    return Container(
      margin: margin ?? theme.buttonTheme.margin,
      child: Material(
        color: onPressed == null ? _color.withOpacity(0.6) : _color,
        shape: _shape,
        elevation: elevation,
        child: InkWell(
          autofocus: autofocus,
          borderRadius: borderRadius ?? BorderRadius.circular(_getRadius()),
          canRequestFocus: canRequestFocus,
          customBorder: customBorder,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
          focusColor: focusColor,
          focusNode: focusNode,
          highlightColor: _color.darken(0.05),
          onFocusChange: onFocusChange,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          onTap: onPressed,
          child: Padding(
              padding: padding ??
                  (small
                      ? theme.buttonTheme.smallPadding
                      : theme.buttonTheme.padding),
              child: _buildChild(theme, textColor ?? Colors.white)),
        ),
      ),
    );
  }

  Widget _buildChild(LiquidThemeData theme, Color color) {
    if (text != null) {
      return Text(
        text,
        textAlign: TextAlign.center,
        style: (small
                ? theme.typographyTheme.small.size(10.0)
                : theme.typographyTheme.p)
            .withColor(color)
            .weight(FontWeight.w500),
      );
    }
    return child;
  }
}

class LOutlineButton extends LButton {
  final ShapeBorder border;

  const LOutlineButton({
    Key key,
    this.border,
    Widget child,
    LiquidColor color,
    String text,
    Color textColor,
    double elevation = 0.0,
    bool small = false,
    ButtonType type = ButtonType.primary,
    ButtonShape shape = ButtonShape.standard,
    EdgeInsets margin,
    EdgeInsets padding,
    Function onPressed,
    bool autofocus,
    BorderRadius borderRadius,
    bool canRequestFocus,
    bool enableFeedback,
    bool excludeFromSemantics,
    Color focusColor,
    FocusNode focusNode,
    Color highlightColor,
    Color hoverColor,
    Function onFocusChange,
    Function onHighlightChanged,
    Function onHover,
    double borderThickness,
  })  : assert(
            (child != null && text == null) || (child == null && text != null),
            "Use either child or text"),
        super(
          key: key,
          child: child,
          elevation: elevation,
          small: small,
          text: text,
          textColor: textColor,
          color: color,
          type: type,
          shape: shape,
          margin: margin,
          padding: padding,
          onPressed: onPressed,
          autofocus: autofocus,
          borderRadius: borderRadius,
          canRequestFocus: canRequestFocus,
          customBorder: null,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
          focusColor: focusColor,
          focusNode: focusNode,
          highlightColor: highlightColor,
          hoverColor: hoverColor,
          onFocusChange: onFocusChange,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          borderThickness: borderThickness,
        );

  @override
  ShapeBorder _getShape(LiquidThemeData themeData, Color color) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(_getRadius()),
      side: BorderSide(width: borderThickness ?? 1.0, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final _color =
        (color ?? getColor(theme)).lighten(onPressed != null ? 0.0 : 0.05);
    final _shape = _getShape(theme, _color);

    return Container(
      margin: margin ?? theme.buttonTheme.margin,
      child: Material(
        borderOnForeground: true,
        shape: border ?? _shape,
        elevation: elevation,
        child: InkWell(
          autofocus: autofocus,
          borderRadius: borderRadius == null
              ? BorderRadius.circular(_getRadius())
              : borderRadius,
          canRequestFocus: canRequestFocus,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
          focusColor: focusColor,
          focusNode: focusNode,
          highlightColor: _color.withOpacity(0.1),
          onFocusChange: onFocusChange,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          onTap: onPressed,
          child: Padding(
              padding: padding ??
                  (small
                      ? theme.buttonTheme.smallPadding
                      : theme.buttonTheme.padding),
              child: _buildChild(theme, textColor ?? _color)),
        ),
      ),
    );
  }
}
