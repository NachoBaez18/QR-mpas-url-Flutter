import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/pages/home_page.dart';
import 'package:qr_app/pages/mapa_page.dart';
import 'package:qr_app/providers/scan-list_provider.dart';
import 'package:qr_app/providers/ui_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider(create: (_) => new ScanListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home':(_) => HomePage(),
          'mapa':(_) => MapaPage()
        },
        theme:ThemeData(
          primaryColor:Colors.deepPurple,
          floatingActionButtonTheme:FloatingActionButtonThemeData(
            backgroundColor:Colors.deepPurple, 
          ),
          appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple),
    
        ),
      ),
    );
  }
}