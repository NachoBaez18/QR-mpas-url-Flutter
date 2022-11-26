import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/providers/scan-list_provider.dart';
import 'package:qr_app/widgets/scan_titles.dart';

class DireccionesPage extends StatelessWidget {
  const DireccionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScansTitles(
      tipo: 'http',
    );
  }
}
