import 'package:campus_saga/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:campus_saga/features/profile/presentation/pages/profile_page.dart';
import 'package:campus_saga/features/promotions/presentation/pages/promotions_page.dart';
import 'package:campus_saga/features/student_issues/presentation/pages/student_issue_page.dart';
import 'package:campus_saga/features/university_ranking/presentation/pages/university_ranking_page.dart';
import 'package:campus_saga/navigation/cubit/bottom_nav_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  /// Top Level Pages
  final List<Widget> topLevelPages = const [
    StudentIssuesPage(),
    PromotionsPage(),
    UniversityRankingPage(),
    ProfilePage(),
  ];

  /// on Page Changed
  void onPageChanged(int page) {
    BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 2, 2),
      appBar: _mainScreenAppBar(),
      body: _mainScreenBody(),
      bottomNavigationBar: _mainScreenBottomNavBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _mainScreebFActionButton(),
    );
  }

  // Bottom Navigation Bar - MainWrapper Widget
  BottomAppBar _mainScreenBottomNavBar(BuildContext context) {
    return BottomAppBar(
      // color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.report_outlined,
                  page: 0,
                  label: "Issues",
                  filledIcon: Icons.report,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.campaign_outlined,
                  page: 1,
                  label: "Campaigns",
                  filledIcon: Icons.campaign,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.leaderboard_outlined,
                  page: 2,
                  label: "Ranking",
                  filledIcon: Icons.leaderboard,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: Icons.person_outline,
                  page: 3,
                  label: "Profile",
                  filledIcon: Icons.person,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 80,
            height: 20,
          ),
        ],
      ),
    );
  }

  // Floating Action Button - MainWrapper Widget
  FloatingActionButton _mainScreebFActionButton() {
    return FloatingActionButton(
      onPressed: () {
        //route to PostIssuePage
        Navigator.pushNamed(context, "/post_issue");
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      backgroundColor: Colors.amber,
      child: const Icon(Icons.add),
    );
  }

  // App Bar - MainWrapper Widget
  AppBar _mainScreenAppBar() {
    return AppBar(
      // backgroundColor: Colors.black,
      title: const Text("Campus Saga"),
      centerTitle: true,
      //logout action
      actions: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is AuthInitial) {
              Navigator.of(context).pushNamed('/login');
            }
          },
          child: IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
            },
            icon: const Icon(Icons.logout),
          ),
        ),
      ],
    );
  }

  // Body - MainWrapper Widget
  PageView _mainScreenBody() {
    return PageView(
      onPageChanged: (int page) => onPageChanged(page),
      controller: pageController,
      children: topLevelPages,
    );
  }

  // Bottom Navigation Bar Single item - MainWrapper Widget
  Widget _bottomAppBarItem(
    BuildContext context, {
    required defaultIcon,
    required page,
    required label,
    required filledIcon,
  }) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);

        pageController.animateToPage(page,
            duration: const Duration(milliseconds: 10),
            curve: Curves.fastLinearToSlowEaseIn);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Icon(
              context.watch<BottomNavCubit>().state == page
                  ? filledIcon
                  : defaultIcon,
              color: context.watch<BottomNavCubit>().state == page
                  ? Colors.amber
                  : Colors.grey,
              size: 26,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              label,
              style: GoogleFonts.aBeeZee(
                color: context.watch<BottomNavCubit>().state == page
                    ? Colors.amber
                    : Colors.grey,
                fontSize: 13,
                fontWeight: context.watch<BottomNavCubit>().state == page
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
