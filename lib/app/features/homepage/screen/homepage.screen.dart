import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/provider/bottombar.provider.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/widgets/deck_card.widget.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

import '../widgets/fab.widget.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      body: content(),
      backgroundColor: ColorsApp.background,
      bottomNavigationBar: bottombar(ref: ref, selectedIndex: selectedIndex),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          DeckCard(
            title: 'Tittle',
            description: 'desc',
          )
        ],
      ),
    );
  }

  Widget bottombar({required int selectedIndex, required WidgetRef ref}) {
    return BottomNavigationBar(
      backgroundColor: ColorsApp.cardBackgound,
      currentIndex: selectedIndex,
      onTap: (index) => ref.read(selectedIndexProvider.notifier).state = index,
      selectedItemColor: ColorsApp.mainPurple,
      unselectedItemColor: ColorsApp.fieldBackground,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.bars),
          label: 'Menu',
        ),
      ],
    );
  }
}