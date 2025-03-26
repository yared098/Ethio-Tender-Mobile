class Tender {
  final String id;
  final String title;
  final String description;

  Tender({required this.id, required this.title, required this.description});

  // Convert Map to Tender object
  factory Tender.fromMap(Map<String, dynamic> data) {
    return Tender(
      id: data['id'],
      title: data['title'],
      description: data['description'],
    );
  }

  // Convert Tender object to Map (for adding/updating)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
