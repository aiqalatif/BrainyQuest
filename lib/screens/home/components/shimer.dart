import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1C1B54), // Background color
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: 5, // Number of shimmer items you want to show
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Shimmer.fromColors(
                baseColor: Color.fromARGB(255, 139, 174, 226)!,
                highlightColor: Color.fromARGB(255, 75, 21, 201),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 50.0, // Adjust height as per your design
                    color:  Color(0xFF1C1B54),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
