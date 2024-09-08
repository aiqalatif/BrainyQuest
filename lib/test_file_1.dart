import 'package:brain_master/provider/level_services.dart';
import 'package:brain_master/widgets/gride_view_level.dart';

import 'package:flutter/material.dart';
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
