import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/passcode/passcode_bloc.dart';
import 'package:my_app/setting/views/setting_views.dart';

class CodeField extends StatefulWidget {
  const CodeField({Key? key}) : super(key: key);

  @override
  CodeFieldState createState() => CodeFieldState();
}

class CodeFieldState extends State<CodeField> {
  late List<String> code;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  late String ddmmyyyyfinal;
  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final num day = now.day, month = now.month, year = now.year;

    ddmmyyyyfinal = ('${day * month * year}'.length < 6
            ? '${day < 9 ? ('0$day') : '$day'}${month < 9 ? ('0$month') : '$month'}$year'
            : '${day * month * year}')
        .trim();
    if (kDebugMode) {
      print(
        'current code field $ddmmyyyyfinal init state with lenght ${ddmmyyyyfinal.length}',
      );
    }
    code = List.generate(ddmmyyyyfinal.length, (index) => '', growable: false);
    focusNodes = List.generate(ddmmyyyyfinal.length, (index) => FocusNode());
    controllers = List.generate(ddmmyyyyfinal.length, (index) {
      final ctrl = TextEditingController();
      ctrl.value = zwspEditingValue;
      return ctrl;
    });

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // give the focus to the first node.
      focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    super.dispose();
    for (final focusNode in focusNodes) {
      focusNode.dispose();
    }
    for (final controller in controllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasscodeBloc, PasscodeState>(
      listener: (context, state) {
        if (state is PasscodeSuccessState) {
          if (kDebugMode) {
            print(
                'current code field $ddmmyyyyfinal success state with lenght ${ddmmyyyyfinal.length}');
          }
          Timer.periodic(const Duration(milliseconds: 500), (timer) {
            Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => const SettingMainView(),
              ),
            );
            timer.cancel();
          });
        }
      },
      builder: (BuildContext context, state) {
        if (state is PasscodeInitialState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            ),
          );
        }

        if (state is PasscodeCheckState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              ddmmyyyyfinal.length,
              (index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.width * 0.05,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      counterText: '',
                    ),
                    onChanged: (value) {
                      if (value.length > 1) {
                        // this is a new character event
                        if (index + 1 == ddmmyyyyfinal.length) {
                          // do something after the last character was inserted
                          // BlocProvider.of<PasscodeBloc>(context).add(
                          //   CheckingPassCodeEvent(
                          //     passcode: code.join(),
                          //   ),
                          // );
                          if (kDebugMode) {
                            print(
                              ' current code = checking passcode $code',
                            );
                          }
                          FocusScope.of(context).unfocus();
                        } else {
                          // move to the next field
                          focusNodes[index + 1].requestFocus();
                        }
                      } else {
                        // this is backspace event

                        // reset the controller
                        controllers[index].value = zwspEditingValue;
                        if (index == 0) {
                          // do something if backspace was pressed at the first field

                        } else {
                          // go back to previous field
                          controllers[index - 1].value = zwspEditingValue;
                          focusNodes[index - 1].requestFocus();
                        }
                      }
                      // make sure to remove the zwsp character
                      code[index] = value.replaceAll(zwsp, '');
                      if (index + 1 == code.length) {
                        if (kDebugMode) {
                          BlocProvider.of<PasscodeBloc>(context).add(
                            CheckingPassCodeEvent(
                              passcode: code.join(),
                            ),
                          );
                          print(
                            ' current code = checking passcode new $index ${code.length} $code ${code.join()}',
                          );
                        }
                      }

                      if (kDebugMode) {
                        print('current code = $code');
                      }
                    },
                  ),
                );
              },
            ),
          );
        }
        if (state is PasscodeSuccessState) {
          return const Center(
            child: Text('Success'),
          );
        }
        if (state is PasscodeErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Wrong passcode'),
              ElevatedButton(
                child: const Text('Try again'),
                onPressed: () {
                  BlocProvider.of<PasscodeBloc>(context).add(
                    RetryPasscodeEvent(passcode: code.join()),
                  );
                },
              ),
            ],
          );
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}

const zwsp = '\u200b';

// the selection is at offset 1 so any character is inserted after it.
const zwspEditingValue = TextEditingValue(
    text: zwsp, selection: TextSelection(baseOffset: 1, extentOffset: 1));
