import 'package:flutter/material.dart';
import 'package:flutter_responsive_list_demo/widgets/super_list/super_list_config.dart';
import 'package:flutter_responsive_list_demo/widgets/super_list/super_list_view.dart';

import '../constants/app_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appBar),
      ),
      body: SuperListView(
        config: SuperListConfig(url: AppConstants.apiUrl),
      ),
    );
  }
}
