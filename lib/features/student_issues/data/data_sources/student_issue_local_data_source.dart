import 'dart:convert';

import 'package:campus_saga/core/error/exception.dart';
import 'package:campus_saga/core/secrets/app_key.dart';
import 'package:campus_saga/features/student_issues/data/model/student_issue_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StudentIssueLocalDataSource {
  /// Gets the cached [StudentIssueModel] which was retrieved the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<StudentIssueModel> getLastNumberTrivia();

  /// Caches the [StudentIssueModel] to local storage.
  Future<void> cacheNumberTrivia(StudentIssueModel triviaToCache);
}

class StudentIssueLocalDataSourceImpl implements StudentIssueLocalDataSource {
  final SharedPreferences sharedPreferences;

  StudentIssueLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(StudentIssueModel triviaToCache) {
    return sharedPreferences.setString(
      CACHED_STUDENT_ISSUE,
      json.encode((triviaToCache).toJson()),
    );
  }

  @override
  Future<StudentIssueModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_STUDENT_ISSUE);
    try {
      if (jsonString != null) {
        return Future.value(
            StudentIssueModel.fromJson(json.decode(jsonString)));
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
