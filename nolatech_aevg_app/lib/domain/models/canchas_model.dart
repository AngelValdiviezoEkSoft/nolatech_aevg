class CanchasModel {
    CanchasModel({
      required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.value,
      required this.like,
      required this.image,
      required this.range
    });

    int id;
    String title;
    String description;
    String date;
    String value;
    String image;
    String range;
    bool like;

    // Crear Usuario desde un Map
  factory CanchasModel.fromJson(Map<String, dynamic> json) {
    return CanchasModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      value: json['value'] ?? '',
      image: json['image'] ?? '',
      range: json['range'] ?? '',
      like: json['like'] ?? false,
    );
  }

  // Convertir Usuario a Map (para guardar)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'value': value,
      'image': image,
      'range': range,
      'like': like
    };
  }

}