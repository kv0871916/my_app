import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/main_home/constants/main_home_const.dart';
import 'package:my_app/passcode/passcode_bloc.dart';
import 'package:my_app/passcode/views/custom_passcode_view.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainHomeView();
  }
}

class MainHomeView extends StatefulWidget {
  const MainHomeView({Key? key}) : super(key: key);

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabsHeader.length,
      child: Scaffold(
        bottomNavigationBar: myTabsBottomNavigationBar.first,
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          centerTitle: true,
          leading: IconButton(
            onPressed: () async {
              await showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Developer Passcode'),
                    content: BlocProvider(
                      create: (_) => PasscodeBloc()
                        ..add(const CheckingPassCodeEvent(passcode: '')),
                      child: const CodeField(),
                    ),
                    // actions: <Widget>[
                    //   ElevatedButton(
                    //     child: const Text('OK'),
                    //     onPressed: () {},
                    //   ),
                    // ],
                  );
                },
              );
            },
            icon: const Icon(Icons.settings),
          ),
          title: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColor.accent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ButtonsTabBar(
              height: MediaQuery.of(context).size.height * 0.1,
              buttonMargin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              labelStyle: const TextStyle().copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.w400,
                color: AppColor.primary,
              ),
              backgroundColor: AppColor.white,
              unselectedBackgroundColor: AppColor.accent,
              unselectedLabelStyle: const TextStyle().copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.w400,
                color: AppColor.white,
              ),
              tabs: [...myTabsHeader],
            ),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [...myTabsBody],
        ),
      ),
    );
  }
}
