import"package:flutter/material.dart";
class LevelCompletedPage extends StatelessWidget {
  const LevelCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: 353,
          width: 373,
          child: Column(
            children: [
              SizedBox(
                height: 28.5,
                width: 28.5,
                child: Image.asset(
                            'assets/images/close.png',
                           
                          ),
              )
            ],
          ),
          )
        ],
      ),
    );
  }
}