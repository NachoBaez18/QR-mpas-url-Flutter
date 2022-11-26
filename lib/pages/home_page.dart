import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/pages/direcciones_page.dart';
import 'package:qr_app/pages/mapa_page.dart';
import 'package:qr_app/pages/mapas_page.dart';
import 'package:qr_app/providers/db_provider.dart';
import 'package:qr_app/providers/scan-list_provider.dart';
import 'package:qr_app/providers/ui_provider.dart';
import 'package:qr_app/widgets/custom_navigatorbar.dart';
import 'package:qr_app/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Historial')),
        actions: const[
          _deleteAllData()
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _deleteAllData extends StatelessWidget {
  const _deleteAllData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {
      final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.borrarTodos();
    }, icon: const Icon(Icons.delete_forever));
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    //leer la bd datos
    // final tempScan = ScanModel(valor:'http:/kola');
    //  DBProvider.db.deleteAllScans().then(print);

    //usar el scan List provider

    final scanListsProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListsProvider.cargarScanPorTipo('geo');
        return MapasPage();
      case 1:
        scanListsProvider.cargarScanPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
