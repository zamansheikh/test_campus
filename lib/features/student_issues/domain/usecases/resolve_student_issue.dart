import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/features/student_issues/domain/repositories/student_issue_repository.dart';
import 'package:dartz/dartz.dart';
class ResolveStudentIssue {
  final StudentIssueRepository repository;

  ResolveStudentIssue(this.repository);

  Future<Either<Failure, void>> call(String issueId) async {
    return await repository.resolveStudentIssue(issueId);
  }
}
