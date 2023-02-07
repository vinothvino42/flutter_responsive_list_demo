import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_responsive_list_demo/models/transaction.dart';
import 'package:flutter_responsive_list_demo/utils/datex.dart';
import 'package:flutter_responsive_list_demo/widgets/super_list/super_list_config.dart';

import '../../controllers/data_controller.dart';
import '../../utils/sizes.dart';
import 'custom_list_item.dart';

enum GridCrossAxisType {
  xxs,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  xxxl,
}

extension GridCrossAxisX on GridCrossAxisType {
  int get getCrossAxis {
    switch (this) {
      case GridCrossAxisType.xxs:
        return 2;
      case GridCrossAxisType.xs:
        return 3;
      case GridCrossAxisType.sm:
        return 4;
      case GridCrossAxisType.md:
        return 5;
      case GridCrossAxisType.lg:
        return 6;
      case GridCrossAxisType.xl:
        return 7;
      case GridCrossAxisType.xxl:
        return 8;
      case GridCrossAxisType.xxxl:
        return 9;
      default:
        return 10;
    }
  }
}

class CustomGridView extends ConsumerWidget {
  const CustomGridView({
    super.key,
    required this.config,
    required this.crossAxisType,
  });

  final SuperListConfig config;
  final GridCrossAxisType crossAxisType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataState = ref.watch(dataController(config.url));

    return dataState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err) => Center(
        child: Text('Error: $err'),
      ),
      success: (transactions) => transactions.isEmpty
          ? const Center(
              child: Text('No data found'),
            )
          : GridView.count(
              mainAxisSpacing: Sizes.screenMarginH16,
              crossAxisSpacing: Sizes.screenMarginH16,
              crossAxisCount: crossAxisType.getCrossAxis,
              children: List.generate(
                transactions.length,
                (index) => CustomGridItem(
                  config: config,
                  transaction: transactions[index],
                ),
              ),
            ),
    );
  }
}

class CustomGridItem extends StatelessWidget {
  const CustomGridItem({
    super.key,
    required this.config,
    required this.transaction,
  });

  final SuperListConfig config;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Corners.radius10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(Sizes.paddingH12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomListItem(title: 'Name: ', value: transaction.name),
          CustomListItem(title: 'Date: ', value: transaction.date.formatDate),
          CustomListItem(title: 'Category: ', value: transaction.category),
          CustomListItem(title: 'Amount: ', value: '${transaction.amount}'),
          CustomListItem(
            title: 'Created At: ',
            value: transaction.createdAt.formatDate,
          ),
        ],
      ),
    );
  }
}
