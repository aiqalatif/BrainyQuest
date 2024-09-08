import 'package:brain_master/screens/authentication_screens/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EnterCode extends StatefulWidget {
  const EnterCode({super.key});

  @override
  _EnterCodeState createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {
  List<String> circleValues = ["", "", "", ""];
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  void _focusTextField(int index) {
    setState(() {
      circleValues[index] = "";
      FocusScope.of(context).requestFocus(focusNodes[index]);
    });
  }

  @override
  void dispose() {
    // Dispose focus nodes to avoid memory leaks
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF131B63),
              Color(0xFF481162),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.keyboard_arrow_left_outlined, size: 35, color: Color(0xffCE1313)),
                    ),
                    const Text(
                      'Enter Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(),
                    const SizedBox(),
                  ],
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: 'Please enter code sent to your mail,\nCode will expire in ',
                      ),
                      TextSpan(
                        text: '29s',
                        style: TextStyle(
                          color: Color(0xffCE1313),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return GestureDetector(
                        onTap: () => _focusTextField(index),
                        child: Container(
                          width: circleValues[index].isEmpty ? 20 : 50,
                          height: circleValues[index].isEmpty ? 20 : 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: circleValues[index].isEmpty ? const Color(0xFF666666) : Colors.transparent, width: 3)),
                          child: circleValues[index].isEmpty
                              ? TextField(
                                  cursorColor: Colors.transparent,
                                  // Set your desired color here

                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  autofocus: true,
                                  focusNode: focusNodes[index],
                                  style: const TextStyle(fontSize: 24, color: Color(0xffCE1313)),
                                  decoration: const InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      if (RegExp(r'^\d$').hasMatch(value)) {
                                        circleValues[index] = value;
                                        // Move to next field if available
                                        if (index < focusNodes.length - 1) {
                                          FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                                        }
                                      }
                                    });
                                  },
                                )
                              : Text(
                                  circleValues[index],
                                  style: const TextStyle(fontSize: 35, color: Color(0xffCE1313)),
                                ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't received yet?",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResetPassword()),
                        );
                      },
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                          color: Color(0xffCE1313),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      // bottomSheet: Container(
      //   padding: const EdgeInsets.all(16.0),
      //   color: Colors.grey[850],
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: List.generate(3, (index) {
      //           return GestureDetector(
      //             onTap: () => _handleInput('${index + 1}'),
      //             child: Container(
      //               width: 50,
      //               height: 50,
      //               alignment: Alignment.center,
      //               decoration: BoxDecoration(
      //                 color: Colors.grey[900],
      //                 borderRadius: BorderRadius.circular(8),
      //               ),
      //               child: Text(
      //                 '${index + 1}',
      //                 style: const TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 24,
      //                 ),
      //               ),
      //             ),
      //           );
      //         }),
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: List.generate(3, (index) {
      //           return GestureDetector(
      //             onTap: () => _handleInput('${index + 4}'),
      //             child: Container(
      //               width: 50,
      //               height: 50,
      //               alignment: Alignment.center,
      //               decoration: BoxDecoration(
      //                 color: Colors.grey[900],
      //                 borderRadius: BorderRadius.circular(8),
      //               ),
      //               child: Text(
      //                 '${index + 4}',
      //                 style: const TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 24,
      //                 ),
      //               ),
      //             ),
      //           );
      //         }),
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           GestureDetector(
      //             onTap: () => _handleInput('0'),
      //             child: Container(
      //               width: 50,
      //               height: 50,
      //               alignment: Alignment.center,
      //               decoration: BoxDecoration(
      //                 color: Colors.grey[900],
      //                 borderRadius: BorderRadius.circular(8),
      //               ),
      //               child: const Text(
      //                 '0',
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 24,
      //                 ),
      //               ),
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: _handleBackspace,
      //             child: Container(
      //               width: 50,
      //               height: 50,
      //               alignment: Alignment.center,
      //               decoration: BoxDecoration(
      //                 color: Colors.grey[900],
      //                 borderRadius: BorderRadius.circular(8),
      //               ),
      //               child: const Icon(Icons.backspace_outlined,
      //                   color: Colors.white),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
