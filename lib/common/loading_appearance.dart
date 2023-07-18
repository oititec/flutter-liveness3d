import 'package:oiti_liveness3d/common/enumerations.dart';
import 'package:oiti_liveness3d/common/enum_case_name.dart';

class LoadingAppearence {
  LoadingType type;
  int size = 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10;
  String? backgroundColor;
  String? loadingColor;

  LoadingAppearence(
      {required this.type,
      required this.size,
      this.backgroundColor,
      this.loadingColor}) {
    backgroundColor = backgroundColor ?? '#FFFFFF';
    loadingColor = loadingColor ?? '#05D758';
  }

  factory LoadingAppearence.config(Map json) {
    return LoadingAppearence(
        type: json['type'],
        size: json['size'],
        backgroundColor: json['backgroundColor'],
        loadingColor: json['loadingColor']);
  }

  Map toJson() {
    return {
      'type': type.caseName(),
      'size': size,
      'background': backgroundColor,
      'foreground': loadingColor,
    };
  }
}
