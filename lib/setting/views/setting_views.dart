import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/main_home/constants/main_home_const.dart';
import 'package:my_app/main_home/views/mainHomeView.dart';

class SettingMainView extends StatefulWidget {
  const SettingMainView({Key? key}) : super(key: key);

  @override
  State<SettingMainView> createState() => _SettingMainViewState();
}

class _SettingMainViewState extends State<SettingMainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: mysettingtabsHeader.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              TextButton(
                onPressed: () async {
                  await Navigator.of(context).push<void>(
                    MaterialPageRoute(
                      builder: (context) => const MainHomePage(),
                    ),
                  );
                },
                child: Text(
                  'Close',
                  style: const TextStyle()
                      .copyWith(fontSize: 15, color: AppColor.white),
                ),
              ),
              Text(
                'Setting',
                style: const TextStyle()
                    .copyWith(fontSize: 15, color: AppColor.white),
              ),
            ],
          ),
        ),
        body: Row(
          children: [
            Expanded(
              flex: 20,
              child: Column(
                children: [
                  Expanded(
                    flex: 40,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: TabBar(
                        labelColor: AppColor.secondary,
                        unselectedLabelColor: AppColor.primary,
                        indicator: const BoxDecoration(
                          color: AppColor.primary,
                        ),
                        tabs: <Widget>[
                          getItem(
                            text: const Text(
                              'Gallery',
                              style: TextStyle(),
                            ),
                          ),
                          getItem(
                            text: const Text(
                              'Contact us',
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 60,
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 80,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [...mysettingtabsBody],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getItem({required Text text}) {
    return RotatedBox(
      quarterTurns: -1,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[text],
        ),
      ),
    );
  }
}
