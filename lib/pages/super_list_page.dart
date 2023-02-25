import 'package:flutter/material.dart';
import 'package:flutter_responsive_list_demo/widgets/super_list/responsive_layout_builder.dart';
import '../widgets/super_list/super_list.dart';
import '../widgets/super_list/super_list_config.dart';

class SuperListPage extends StatelessWidget {
  const SuperListPage({
    super.key,
    required this.config,
  });

  final SuperListConfig config;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, _, __) => CustomListView(config: config),
      medium: (context, constraints, _) => CustomGridView(
        config: config,
        crossAxisType: crossAxisType(constraints),
      ),
      large: (context, constraints, _) => CustomGridView(
        config: config,
        crossAxisType: crossAxisType(constraints),
      ),
    );
  }

  GridCrossAxisType crossAxisType(BoxConstraints constraints) {
    if (constraints.maxWidth > 550 && constraints.maxWidth < 651) {
      return GridCrossAxisType.xxs;
    } else if (constraints.maxWidth > 650 && constraints.maxWidth < 851) {
      return GridCrossAxisType.xs;
    } else if (constraints.maxWidth > 850 && constraints.maxWidth < 1051) {
      return GridCrossAxisType.sm;
    } else if (constraints.maxWidth > 1050 && constraints.maxWidth < 1251) {
      return GridCrossAxisType.md;
    } else if (constraints.maxWidth > 1250 && constraints.maxWidth < 1451) {
      return GridCrossAxisType.lg;
    } else if (constraints.maxWidth > 1450 && constraints.maxWidth < 1651) {
      return GridCrossAxisType.xl;
    } else if (constraints.maxWidth > 1650 && constraints.maxWidth < 1851) {
      return GridCrossAxisType.xxl;
    }
    return GridCrossAxisType.xxl;
  }
}
