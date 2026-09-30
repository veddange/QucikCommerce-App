class QuickSelectionTabModel {
  final String title;
  final String image;

  const QuickSelectionTabModel({required this.title, required this.image});

  factory QuickSelectionTabModel.toJson(Map<String, dynamic> json) {
    return QuickSelectionTabModel(title: json['title'], image: json['image']);
  }
}
