

import 'package:flutter/material.dart';
import 'package:flutter_application/provider/level_services.dart';
import 'package:flutter_application/widgets/gride_view_level.dart';
import 'package:provider/provider.dart';


class UpcomingLe extends StatelessWidget {
  const UpcomingLe({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LevelsProvider>(
      builder: (context, levelsProvider, child) {
        if (levelsProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return LevelsGridView(
          levelDocs: levelsProvider.levelDocs,
          currentIndex: levelsProvider.currentIndex,
          itemsPerPage: levelsProvider.itemsPerPage,
          showNextLevels: levelsProvider.showNextLevels,
          showPreviousLevels: levelsProvider.showPreviousLevels,
        );
      },
    );
  }
}
