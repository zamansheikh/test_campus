part of 'post_issue_cubit.dart';

sealed class PostIssueState extends Equatable {
  const PostIssueState();

  @override
  List<Object> get props => [];
}

final class PostIssueInitial extends PostIssueState {}

final class PostIssueLoading extends PostIssueState {}

final class PostIssueSuccess extends PostIssueState {
  final Issue issue;

  const PostIssueSuccess(this.issue);

  @override
  List<Object> get props => [issue];
}

final class PostIssueLoadSuccess extends PostIssueState {
  final List<Issue> issue;

  const PostIssueLoadSuccess(this.issue);

  @override
  List<Object> get props => [issue];
}

final class PostIssueFailed extends PostIssueState {
  final String message;

  const PostIssueFailed(this.message);

  @override
  List<Object> get props => [message];
}
