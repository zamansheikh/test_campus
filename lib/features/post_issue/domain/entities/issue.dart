// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Issue extends Equatable {
  final String id;
  final String title;
  final String description;
  final String status;
  final String userId;
  final String universityId;
  final String createdAt;
  final String updatedAt;
  final String imageUrl;
  final List<String> votes;
  final List<Map<String, String>> comments;
  const Issue({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.userId,
    required this.universityId,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    required this.votes,
    required this.comments,
  });

  Issue copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    String? userId,
    String? universityId,
    String? createdAt,
    String? updatedAt,
    String? imageUrl,
    List<String>? votes,
    List<Map<String, String>>? comments,
  }) {
    return Issue(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      universityId: universityId ?? this.universityId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      votes: votes ?? this.votes,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'userId': userId,
      'universityId': universityId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'imageUrl': imageUrl,
      'votes': votes,
      'comments': comments,
    };
  }

  factory Issue.fromMap(Map<String, dynamic> map) {
    return Issue(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      userId: map['userId'] as String,
      universityId: map['universityId'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      imageUrl: map['imageUrl'] as String,
      votes: List<String>.from(map['votes'].map((x) => x as String)),
      comments: List<Map<String, String>>.from(
          map['comments'].map((x) => Map<String, String>.from(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Issue.fromJson(String source) =>
      Issue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      status,
      userId,
      universityId,
      createdAt,
      updatedAt,
      imageUrl,
      votes,
      comments,
    ];
  }
}
