import 'dart:ui' as ui;
import 'dart:html' as html;
import 'package:flutter/material.dart';

class PDFScreen extends StatelessWidget {
  static const routeName = '/pdfScreen';
  final String pdfPath;

  const PDFScreen({Key? key, required this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewId = 'pdf-viewer-${pdfPath.hashCode}';

    // ignore: deprecated_member_use
    ui.platformViewRegistry.registerViewFactory(viewId, (int _) {
      return html.IFrameElement()
        ..src = pdfPath
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Visualizador de PDF')),
      body: HtmlElementView(viewType: viewId),
    );
  }
}
