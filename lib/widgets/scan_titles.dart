import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/utils/utils.dart';

import '../providers/scan-list_provider.dart';

class ScansTitles extends StatelessWidget {
  final String tipo;
  const ScansTitles({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
        itemCount:scans.length,
        itemBuilder: (_, i) => Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (DismissDirection direction){
            Provider.of<ScanListProvider>(context,listen: false).borrarScansPorId(scans[i].id);
          },
          child: ListTile(
                leading: Icon(
                  this.tipo == 'http' ? Icons.home_outlined : Icons.map_outlined, 
                  color: Theme.of(context).primaryColor),
                title: Text(scans[i].valor),
                subtitle: Text(scans[i].id.toString()),
                trailing:const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
                onTap: () => launcherURL(context, scans[i]),
              ),
        ));
  }
}
