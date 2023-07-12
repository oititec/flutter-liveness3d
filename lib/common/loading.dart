class LoadingApparence {
  String? type;
  int? size = 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10;
  String? backgroundColor;
  String? loadingColor;

  LoadingApparence(
      {required this.type,
      required this.size,
      this.backgroundColor,
      this.loadingColor}) {
    assert(type != null, "type param is required.");
    assert(size != null, "size param is required.");
  }

  factory LoadingApparence.config(Map json) {
    return LoadingApparence(
        type: json['type'],
        size: json['size'],
        backgroundColor: json['backgroundColor'],
        loadingColor: json['loadingColor']);
  }

  Map toJson() {
    return {
      'type': type,
      'size': size,
      'backgroundColor': backgroundColor,
      'loadingColor': loadingColor,
    };
  }
}
