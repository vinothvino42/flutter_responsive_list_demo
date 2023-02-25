import 'package:flutter/material.dart';
import 'package:flutter_responsive_list_demo/utils/sizes.dart';
import 'package:flutter_responsive_list_demo/widgets/super_list/super_list_config.dart';

import '../utils/alert.dart';
import 'super_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.paddingH12,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FractionallySizedBox(
                widthFactor: 0.7,
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(hintText: 'Enter your URL'),
                ),
              ),
              const SizedBox(height: Sizes.paddingV12),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    final isValid =
        Uri.tryParse(_textController.text.trim())?.hasAbsolutePath ?? false;
    if (isValid) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SuperListPage(
          config: SuperListConfig(
            url: _textController.text.trim(),
          ),
        ),
      ));
    } else {
      Alert.showToast('Please enter a valid URL');
    }
  }
}
