import 'package:campus_saga/features/student_issues/domain/entities/student_issue.dart';

class StudentIssueModel extends StudentIssue {
  const StudentIssueModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isResolved,
    required super.datePosted,
  });

  factory StudentIssueModel.fromJson(Map<String, dynamic> json) {
    return StudentIssueModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isResolved: json['isResolved'],
      datePosted: DateTime.parse(json['datePosted']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isResolved': isResolved,
      'datePosted': datePosted.toIso8601String(),
    };
  }
}
