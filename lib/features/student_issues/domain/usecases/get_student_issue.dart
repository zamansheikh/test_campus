import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/features/student_issues/domain/entities/student_issue.dart';
import 'package:campus_saga/features/student_issues/domain/repositories/student_issue_repository.dart';
import 'package:dartz/dartz.dart';

class GetStudentIssues {
  final StudentIssueRepository repository;

  GetStudentIssues(this.repository);

  Future<Either<Failure, List<StudentIssue>>> call() async {
    return await repository.getStudentIssues();
  }
}
