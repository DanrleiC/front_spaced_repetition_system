import 'dart:convert';

class DeckModel {
  final String id;
  final String name;
  final String description;

  DeckModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory DeckModel.empty() {
    return DeckModel(
      id: '',
      name: '',
      description: '',
    );
  }

  DeckModel copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return DeckModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory DeckModel.fromMap(Map<String, dynamic> map) {
    return DeckModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeckModel.fromJson(String source) =>
      DeckModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
