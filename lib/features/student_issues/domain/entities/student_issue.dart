import 'package:equatable/equatable.dart';

class StudentIssue extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isResolved;
  final DateTime datePosted;

  const StudentIssue({
    required this.id,
    required this.title,
    required this.description,
    required this.isResolved,
    required this.datePosted,
  });

  @override
  List<Object?> get props => [id, title, description, isResolved, datePosted];
}
