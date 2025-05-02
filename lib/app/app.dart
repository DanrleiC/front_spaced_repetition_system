import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spaced Repetition System',
      theme: ThemeData(
        textTheme: GoogleFonts.comicNeueTextTheme().apply(
          bodyColor: ColorsApp.labelField,
        )
      ),
      initialRoute: AppRoutes.initial,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}