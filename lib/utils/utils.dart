import 'package:flutter/material.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launcherURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor;

  if (scan.tipo == 'http') {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Error al abrir la url';
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
