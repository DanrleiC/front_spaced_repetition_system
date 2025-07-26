import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_spaced_repetition_system/app/features/deck/screen/deck_creation.screen.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/provider/bottombar.provider.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/screen/homepage.screen.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/widgets/fab.widget.dart';
import 'package:front_spaced_repetition_system/app/features/menu/screen/menu.screen.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    final List<Widget> screens = [
      const HomePageScreen(),
      const MenuScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsApp.cardBackgound,
        currentIndex: selectedIndex,
        onTap: (index) => ref.read(selectedIndexProvider.notifier).state = index,
        selectedItemColor: ColorsApp.mainPurple,
        unselectedItemColor: ColorsApp.fieldBackground,
        type: BottomNavigationBarType.fixed,
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
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const DeckCreateDialog(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
