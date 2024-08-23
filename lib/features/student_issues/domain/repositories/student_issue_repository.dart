import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/features/student_issues/domain/entities/student_issue.dart';
import 'package:dartz/dartz.dart';

abstract class StudentIssueRepository {
  Future<Either<Failure, List<StudentIssue>>> getStudentIssues();
  Future<Either<Failure, void>> postStudentIssue(StudentIssue issue);
  Future<Either<Failure, void>> resolveStudentIssue(String issueId);
}
