class Products {
  final String? id;
  final String? name;
  final String? description;
  final String? thumbnailUrl;

  Products({
    this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
  });

  static Products fromJson({required Map<String, dynamic> json}) => Products(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        thumbnailUrl: json['thumbnail']['url'],
      );
}
