import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/features/student_issues/domain/entities/student_issue.dart';
import 'package:campus_saga/features/student_issues/domain/repositories/student_issue_repository.dart';
import 'package:dartz/dartz.dart';

class PostStudentIssue {
  final StudentIssueRepository repository;

  PostStudentIssue(this.repository);

  Future<Either<Failure, void>> call(StudentIssue issue) async {
    return await repository.postStudentIssue(issue);
  }
}
