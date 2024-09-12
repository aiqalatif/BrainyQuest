import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brain_master/screens/home/levels_screen.dart';
import 'package:brain_master/themes/custom_color.dart';

class LevelsGridView extends StatelessWidget {
  final List levelDocs;
  final int currentIndex;
  final int itemsPerPage;
  final Function showNextLevels;
  final Function showPreviousLevels;

  const LevelsGridView({
    Key? key,
    required this.levelDocs,
    required this.currentIndex,
    required this.itemsPerPage,
    required this.showNextLevels,
    required this.showPreviousLevels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalLevels = levelDocs.length;
    int endIndex = (currentIndex + itemsPerPage).clamp(0, totalLevels); 
    int displayCount = endIndex - currentIndex;

    return Column(
      children: [
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Upcoming Levels",
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => showPreviousLevels(), 
                  icon: const Icon(Icons.keyboard_arrow_left_outlined, color: Colors.white),
                ),
                IconButton(
                  onPressed: () => showNextLevels(), // Show next set of levels
                  icon: const Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: displayCount,
          itemBuilder: (context, index) {
            var levelData = levelDocs[currentIndex + index];
            String docId = levelData.id;
            
            // bool isActive = levelData["status"] == "unlock";
            int levelNum = levelData["number"];
            int gems = levelData["gems"];
            String title = levelData["title"];
         
          
            return 
            // isActive
            //     ? InkWell(
            //         onTap: () {
            //           Get.to(LevelScreen(
            //             docId: docId,
            //             level: levelNum,
            //           ));
            //         },
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: const Color(0xFF270B52),
            //             border: Border.all(
            //               color: const Color(0xff979191).withOpacity(0.7),
            //             ),
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(
            //                     horizontal: 8.0, vertical: 5),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Container(
            //                       decoration: BoxDecoration(
            //                           color: CustomColors.darkBlue,
            //                           borderRadius: BorderRadius.circular(30)),
            //                       child: Padding(
            //                         padding: const EdgeInsets.symmetric(
            //                             vertical: 3.0, horizontal: 3),
            //                         child: Text(
            //                           "Level $levelNum",
            //                           style: const TextStyle(
            //                             fontSize: 5,
            //                             color: Colors.white70,
            //                             fontWeight: FontWeight.w600,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                       decoration: BoxDecoration(
            //                           color: CustomColors.darkBlue,
            //                           borderRadius: BorderRadius.circular(30)),
            //                       child: Padding(
            //                         padding: const EdgeInsets.symmetric(
            //                             vertical: 3.0, horizontal: 3),
            //                         child: Row(
            //                           children: [
            //                             Image.asset(
            //                               "assets/images/diamond.png",
            //                               width: 10,
            //                               height: 10,
            //                             ),
            //                             const SizedBox(width: 4),
            //                             Text(
            //                               gems.toString(),
            //                               style: const TextStyle(
            //                                 fontSize: 5,
            //                                 color: Colors.white70,
            //                                 fontWeight: FontWeight.w600,
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Image.asset(
            //                 "assets/images/level_1_icon.png",
            //                 width: 45,
            //                 height: 45,
            //               ),
            //               const SizedBox(
            //                 height: 5,
            //               ),
            //               Text(
            //                 title,
            //                 style: const TextStyle(
            //                     color: Colors.white, fontSize: 8),
            //               )
            //             ],
            //           ),
            //         ),
            //       )
            //                     :
                                 InkWell(
                                   onTap: () {
                      Get.to(LevelScreen(
                        docId: docId,
                        level: levelNum,
                      ));
                    },
                                   child: Container(
                                                       decoration: BoxDecoration(
                                                         border: Border.all(
                                                           color: const Color(0xff979191).withOpacity(0.5),
                                                         ),
                                                         borderRadius: BorderRadius.circular(10),
                                                         gradient: const LinearGradient(
                                                           colors: [
                                                             Color(0xFF24155F),
                                                             Color(0xFF37115F),
                                                           ], // Gradient colors
                                                           begin: Alignment.topCenter,
                                                           end: Alignment.bottomCenter,
                                                         ),
                                                       ),
                                                       child: Column(
                                                         children: [
                                                           Padding(
                                                             padding: const EdgeInsets.all(8.0),
                                                             child: Row(
                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                               children: [
                                                                 Text(
                                                                   "Level $levelNum",
                                                                   style: const TextStyle(
                                    fontSize: 6,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600,
                                                                   ),
                                                                 ),
                                                                 Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF1F1E61),
                                        borderRadius: BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0, horizontal: 3),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/diamond.png",
                                            width: 10,
                                            height: 10,
                                            opacity:
                                                const AlwaysStoppedAnimation(0.1),
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            "13",
                                            style: TextStyle(
                                              fontSize: 5,
                                              color: Colors.white12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                                               ],
                                                             ),
                                                           ),
                                                           Stack(
                                                             children: [
                                                               Image.asset(
                                                                 "assets/images/level_1_icon.png",
                                                                 width: 45,
                                                                 height: 45,
                                                                 opacity: const AlwaysStoppedAnimation(0.3),
                                                               ),
                                                               Positioned(
                                                                 right: 0,
                                                                 left: 0,
                                                                 child: Image.asset(
                                                                   "assets/images/lock.png",
                                                                   width: 33,
                                                                   height: 33,
                                                                   opacity: const AlwaysStoppedAnimation(0.9),
                                                                 ),
                                                               ),
                                                             ],
                                                           ),
                                                           const Text(
                                                             "Your weapons",
                                                             style: TextStyle(color: Colors.white, fontSize: 8),
                                                           )
                                                         ],
                                                       ),
                                                     ),
                                 );
         
          },
        ),
      ],
    );
  }
}
