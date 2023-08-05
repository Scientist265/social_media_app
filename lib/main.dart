import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/config/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  {
    option:
    DefaultFirebaseOptions.currentPlatform;
  }
  runApp(const DevWorld());
}

class DevWorld extends StatelessWidget {
  const DevWorld({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: FlexThemeData.light(
            scheme: FlexScheme.rosewood,
            fontFamily: GoogleFonts.dmSans().fontFamily),
        darkTheme: FlexThemeData.dark(
            scheme: FlexScheme.rosewood,
            fontFamily: GoogleFonts.dmSans().fontFamily),
        initialRoute: authPagesTabRoute,
        routes: routes,
        // onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      ),
    );
  }
}
