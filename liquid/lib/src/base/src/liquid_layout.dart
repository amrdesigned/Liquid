import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class LRowRaw extends Flex {
  final Axis direction;

  LRowRaw({
    Key key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline textBaseline,
    List<Widget> children = const <Widget>[],
    this.direction = Axis.horizontal,
  }) : super(
          children: children,
          key: key,
          direction: direction,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
        );
}

class LColumnRaw extends Flex {
  LColumnRaw({
    Key key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline textBaseline,
    List<Widget> children = const <Widget>[],
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  }) : super(
          children: children,
          key: key,
          direction: Axis.vertical,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
        );

  final int xs, sm, md, lg, xl;
}

class LResponsiveBuilder extends StatelessWidget {
  final bool useMediaQuery;
  final Widget Function(BuildContext context) onXS;
  final Widget Function(BuildContext context) onSM;
  final Widget Function(BuildContext context) onMD;
  final Widget Function(BuildContext context) onLG;
  final Widget Function(BuildContext context) onXL;

  const LResponsiveBuilder({
    Key key,
    @required this.onXS,
    this.onSM,
    this.onMD,
    this.onLG,
    this.onXL,
    this.useMediaQuery = false,
  })  : assert(onXS != null),
        assert(useMediaQuery != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (useMediaQuery) {
      final width = MediaQuery.of(context).size.width;
      return _build(context, width);
    } else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            _build(context, constraints.maxWidth),
      );
    }
  }

  Widget _build(BuildContext context, double width) {
    if (onXL != null && width >= 1200) return onXL(context);
    if (onLG != null && width >= 992) return onLG(context);
    if (onMD != null && width >= 768) return onMD(context);
    if (onSM != null && width >= 576) return onSM(context);
    return onXS(context);
  }
}

class LBoxDimension {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  const LBoxDimension({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });
}

class LBoxVisibility {
  final bool xs;
  final bool sm;
  final bool md;
  final bool lg;
  final bool xl;

  const LBoxVisibility({
    this.xs = true,
    this.sm = true,
    this.md = true,
    this.lg = true,
    this.xl = true,
  });
}

class LBox extends StatelessWidget {
  final LBoxDimension height;
  final LBoxDimension width;
  final LBoxVisibility visibility;

  final Widget child;

  const LBox({
    Key key,
    this.height = const LBoxDimension(),
    this.width = const LBoxDimension(),
    this.visibility = const LBoxVisibility(),
    @required this.child,
  })  : assert(child != null),
        assert(height != null),
        assert(width != null),
        assert(visibility != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LResponsiveBuilder(
      useMediaQuery: true,
      onXS: (_) => visibility.xs ? _buildBox(height.xs, width.xs) : Container(),
      onSM: (_) => visibility.sm ? _buildBox(height.sm, width.sm) : Container(),
      onMD: (_) => visibility.md ? _buildBox(height.md, width.md) : Container(),
      onLG: (_) => visibility.lg ? _buildBox(height.lg, width.lg) : Container(),
      onXL: (_) => visibility.xl ? _buildBox(height.xl, width.xl) : Container(),
    );
  }

  Widget _buildBox(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: child,
    );
  }
}

enum BreakPoint { xs, sm, md, lg, xl }

class LColumn extends StatelessWidget {
  final LBoxVisibility visibility;
  final int xs, sm, md, lg, xl;
  final List<Widget> children;
  final bool flexible;
  final bool expanded;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection = VerticalDirection.down;
  final TextBaseline textBaseline;

  const LColumn({
    Key key,
    this.visibility = const LBoxVisibility(),
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.children = const [],
    this.flexible = true,
    this.expanded = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.textBaseline,
  })  : assert(children != null),
        assert(xs == null || (xs <= 12 && xs >= 1)),
        assert(sm == null || sm <= 12 && sm >= 1),
        assert(md == null || md <= 12 && md >= 1),
        assert(lg == null || lg <= 12 && lg >= 1),
        assert(xl == null || xl <= 12 && xl >= 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LColumnRaw(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        textBaseline: textBaseline,
        children: _buildChildren());
  }

  List<Widget> _buildChildren() {
    if (flexible) {
      return children
          .map((e) => Flexible(
                fit: expanded ? FlexFit.tight : FlexFit.loose,
                child: e,
              ))
          .toList();
    }
    return children;
  }
}

enum LGridMode { ratio, fixedSize }

class LRow extends StatelessWidget {
  final int columnCount = 12;
  final List<LColumn> columns;
  final double gutter;

  // TODO: work on this
  final int cols;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline textBaseline;
  final LGridMode mode;

  const LRow({
    Key key,
    this.columns = const <LColumn>[],
    this.cols,
    this.gutter,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize,
    this.crossAxisAlignment,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.mode = LGridMode.fixedSize,
  })  : assert(mode != null),
        assert(columns != null),
        assert(columns.length > 0,
            "You need to add atleast one column to the LRow"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: gutter ?? 5.0),
      child: LResponsiveBuilder(
        onXS: (context) => _buildChildrens(context, BreakPoint.xs),
        onSM: (context) => _buildChildrens(context, BreakPoint.sm),
        onMD: (context) => _buildChildrens(context, BreakPoint.md),
        onLG: (context) => _buildChildrens(context, BreakPoint.lg),
        onXL: (context) => _buildChildrens(context, BreakPoint.xl),
      ),
    );
  }

  int _getFlex(LColumn child, BreakPoint breakPoint) {
    switch (breakPoint) {
      case BreakPoint.xs:
        return child.xs ?? -1;
        break;

      case BreakPoint.sm:
        return child.sm ?? -1;
        break;

      case BreakPoint.md:
        return child.md ?? -1;
        break;

      case BreakPoint.lg:
        return child.lg ?? -1;
        break;

      case BreakPoint.xl:
        return child.xl ?? -1;
        break;

      default:
        return child.xs ?? -1;
        break;
    }
  }

  List<dynamic> _preProcess(BreakPoint breakPoint) {
    final List<int> bp = [];
    bool _ = false;
    columns.forEach((element) {
      bp.add(_getFlex(element, breakPoint));
      if (!_) _ = element.xs != null;
    });

    return [bp, _];
  }

  List<int> _fillEmpty(List<int> bps) {
    final List<int> _calBps = [];
    int totalCol = 0;
    int nullCols = 0;

    for (final val in bps) {
      totalCol += (val > 0 ? val : 0);
      if (val == -1) nullCols++;
    }

    final remaining = columnCount - totalCol;

    final colFlex = remaining / (nullCols > 0 ? nullCols : 1);

    for (final val in bps) {
      if (val != -1)
        _calBps.add(val);
      else
        _calBps.add(colFlex.round());
    }

    int _colSum = _calBps.reduce((value, element) => value + element).round();

    if (mode == LGridMode.fixedSize && _colSum < columnCount) {
      _fillRemaining(_colSum);
      final diff = columnCount - _colSum;
      _calBps.add(diff);
      _colSum += diff;
    }

    if (kDebugMode) {
      if (bps.length > columnCount) {
        print("Warning: More than 12 colums not suitable for row");
      }

      if (_colSum > columnCount) {
        print("Warning: Colums flexs are greater than 12!");
      }
      if (_colSum < columnCount) {
        print("Warning: Colums flexs are less than 12!");
      }
    }

    return _calBps;
  }

  void _fillRemaining(int totalFlex) {
    if (totalFlex < columnCount) {
      columns.add(LColumn());
    }
  }

  bool _isVisible(LColumn column, BreakPoint breakPoint) {
    switch (breakPoint) {
      case BreakPoint.xs:
        return column.visibility.xs;
        break;

      case BreakPoint.sm:
        return column.visibility.sm;
        break;

      case BreakPoint.md:
        return column.visibility.md;
        break;

      case BreakPoint.lg:
        return column.visibility.lg;
        break;

      case BreakPoint.xl:
        return column.visibility.xl;
        break;

      default:
        return column.visibility.xs;
        break;
    }
  }

  Widget _buildChildrens(BuildContext context, BreakPoint breakPoint) {
    int currentIndex = 0;
    final _processed = _preProcess(breakPoint);
    final _flexes = _fillEmpty(_processed[0] as List<int>);

    final vertical =
        _processed[1] ? false : (breakPoint == BreakPoint.xs ? true : false);
    final lastchild = columns.last.hashCode;
    return LRowRaw(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize:
          mainAxisSize ?? (vertical ? MainAxisSize.min : MainAxisSize.max),
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      direction: vertical ? Axis.vertical : Axis.horizontal,
      children: columns.map(
        (child) {
          final flex = _flexes[currentIndex];
          currentIndex++;

          if (_isVisible(child, breakPoint)) {
            return Flexible(
              fit: vertical ? FlexFit.loose : FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: (child.hashCode == lastchild || vertical)
                      ? 0.0
                      : (gutter ?? 5.0),
                  bottom: !vertical ? 0.0 : (gutter ?? 5.0),
                ),
                child: child,
              ),
              flex: flex,
            );
          }
          return Container();
        },
      ).toList(),
    );
  }
}