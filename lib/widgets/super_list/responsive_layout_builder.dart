import 'package:flutter/widgets.dart';

class DeviceBreakpoints {
  DeviceBreakpoints._();

  /// Max width for a small layout.
  static const double small = 550;

  /// Max width for a medium layout.
  static const double medium = 720;

  /// Max width for a large layout.
  static const double large = 1020;
}

typedef ResponsiveLayoutWidgetBuilder = Widget Function(
    BuildContext, BoxConstraints, Widget?);

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    Key? key,
    required this.small,
    required this.medium,
    this.large,
    this.child,
  }) : super(key: key);

  /// [ResponsiveLayoutWidgetBuilder] for small layout.
  final ResponsiveLayoutWidgetBuilder small;

  /// [ResponsiveLayoutWidgetBuilder] for medium layout.
  final ResponsiveLayoutWidgetBuilder medium;

  /// [ResponsiveLayoutWidgetBuilder] for large layout.
  final ResponsiveLayoutWidgetBuilder? large;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print('Data: ${constraints.maxWidth}');
        if (constraints.maxWidth <= DeviceBreakpoints.small) {
          return small(context, constraints, child);
        }
        if (constraints.maxWidth <= DeviceBreakpoints.medium) {
          return (medium).call(context, constraints, child);
        }

        return (large ?? medium)(context, constraints, child);
      },
    );
  }
}
