import 'dart:convert';

import 'package:campus_saga/core/error/exception.dart';
import 'package:campus_saga/core/secrets/app_key.dart';
import 'package:campus_saga/features/student_issues/data/model/student_issue_model.dart';
import 'package:http/http.dart' as http;

abstract class StudentIssueRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<StudentIssueModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<StudentIssueModel> getRandomNumberTrivia();
}

class StudentIssueRemoteDataSourceImpl implements StudentIssueRemoteDataSource {
  final http.Client client;
  StudentIssueRemoteDataSourceImpl({required this.client});
  @override
  Future<StudentIssueModel> getConcreteNumberTrivia(int number) async {
    final response = await client.get(Uri.parse('number'), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return Future.value(
          StudentIssueModel.fromJson(jsonDecode(response.body)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<StudentIssueModel> getRandomNumberTrivia() async {
    final response = await client.get(
        Uri.parse('${CACHED_STUDENT_ISSUE}random'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return StudentIssueModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
