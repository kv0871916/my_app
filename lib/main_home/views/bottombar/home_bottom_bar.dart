import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColor.primary),
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
    );
  }
}
