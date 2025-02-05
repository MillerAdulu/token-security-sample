class RefresherValues {
  RefresherValues({
    required this.urlScheme,
    required this.baseDomain,
    required this.opsBox,
  });

  final String urlScheme;
  final String baseDomain;
  final String opsBox;

  String get baseUrl => '$urlScheme://$baseDomain';
  String get globalHiveAuthBox => 'refresher-auth';
}

class RefresherConfig {
  factory RefresherConfig({required RefresherValues values}) {
    return _instance ??= RefresherConfig._internal(values);
  }

  RefresherConfig._internal(this.values);

  final RefresherValues values;
  static RefresherConfig? _instance;

  static RefresherConfig? get instance => _instance;
}
