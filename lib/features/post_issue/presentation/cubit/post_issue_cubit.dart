import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:campus_saga/core/common/entities/my_user.dart';
import 'package:campus_saga/core/utils/random_picture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/issue.dart';

part 'post_issue_state.dart';

class PostIssueCubit extends Cubit<PostIssueState> {
  PostIssueCubit() : super(PostIssueInitial());
  void postIssue(String title, String description, MyUser user) async {
    emit(PostIssueLoading());
    // Post Issue
    final issue = Issue(
      id: const Uuid().v1(),
      title: title,
      description: description,
      status: "pending",
      userId: user.id,
      universityId: user.universityId,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      imageUrl: randomPicture(),
      votes: const [],
      comments: const [],
    );
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      await firebaseFirestore.collection('issues').doc(issue.id).set(
            issue.toMap(),
          );
      
      emit(PostIssueSuccess(issue));
    } catch (e) {
      emit(PostIssueFailed(e.toString()));
    }
  }

  void getIssue() async {
    emit(PostIssueLoading());
    //get issue from firestore
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      final snapShot = await firebaseFirestore
          .collection('issues')
          .where('universityId', isEqualTo: 'Daffodil International University')
          .get();
      final issue = Issue.fromMap(snapShot.docs.first.data());
      print(issue.toString());

      final List<Issue> issues =
          snapShot.docs.map((e) => Issue.fromMap(e.data())).toList();

      emit(PostIssueLoadSuccess(issues));
    } catch (e) {
      emit(PostIssueFailed(e.toString()));
      rethrow; // Add a throw statement here
    }
  }
}
