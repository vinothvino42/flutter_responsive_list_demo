class SuperListConfig {
  final String url;

  SuperListConfig({
    required this.url,
  }) : assert(
          Uri.parse(url).host.isNotEmpty,
          'Reason - Please enter a Valid URL',
        );
}
