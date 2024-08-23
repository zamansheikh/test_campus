import 'package:campus_saga/core/error/failure.dart';
import 'package:campus_saga/features/student_issues/data/data_sources/student_issue_local_data_source.dart';
import 'package:campus_saga/features/student_issues/data/data_sources/student_issue_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/student_issue.dart';
import '../../domain/repositories/student_issue_repository.dart';

class StudentIssueRepositoryImpl implements StudentIssueRepository {
  final StudentIssueRemoteDataSource remoteDataSource;
  final StudentIssueLocalDataSource localDataSource;

  StudentIssueRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<StudentIssue>>> getStudentIssues() async {
    // Implement data fetching logic
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> postStudentIssue(StudentIssue issue) async {
    // Implement posting logic
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> resolveStudentIssue(String issueId) async {
    // Implement resolution logic
    throw UnimplementedError();
  }
}
