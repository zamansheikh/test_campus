import 'package:campus_saga/core/utils/random_picture.dart';
import 'package:campus_saga/features/post_issue/presentation/cubit/post_issue_cubit.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentIssuesPage extends StatefulWidget {
  const StudentIssuesPage({super.key});

  @override
  State<StudentIssuesPage> createState() => _StudentIssuesPageState();
}

class _StudentIssuesPageState extends State<StudentIssuesPage> {
  @override
  void initState() {
    BlocProvider.of<PostIssueCubit>(context).getIssue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      onRefresh: () {
        BlocProvider.of<PostIssueCubit>(context).getIssue();
      },
      child: Center(child: BlocBuilder<PostIssueCubit, PostIssueState>(
        builder: (context, state) {
          if (state is PostIssueLoading) {
            return const CircularProgressIndicator();
          } else if (state is PostIssueFailed) {
            return Text(state.message);
          } else if (state is PostIssueLoadSuccess) {
            return ListView.builder(
              itemCount: state.issue.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(state.issue[index].title),
                      subtitle: Text(state.issue[index].description),
                    ),
                    Image.network(state.issue[index].imageUrl.isEmpty
                        ? randomPicture()
                        : state.issue[index].imageUrl),
                  ],
                );
              },
            );
          }
          return const Text("No Data");
        },
      )),
    );
  }
}
