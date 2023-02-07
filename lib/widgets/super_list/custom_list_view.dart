import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_responsive_list_demo/utils/datex.dart';
import 'package:flutter_responsive_list_demo/widgets/super_list/super_list_config.dart';

import '../../controllers/data_controller.dart';
import '../../models/transaction.dart';
import '../../utils/sizes.dart';
import 'custom_list_item.dart';

class CustomListView extends ConsumerWidget {
  const CustomListView({super.key, required this.config});

  final SuperListConfig config;

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
          : ListView.separated(
              itemCount: transactions.length,
              separatorBuilder: (context, _) => const Divider(),
              itemBuilder: (context, index) => CustomListTile(
                transaction: transactions[index],
              ),
            ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Corners.radius10),
      ),
      padding: const EdgeInsets.all(Sizes.paddingH12),
      child: Column(
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
