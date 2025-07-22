import 'dart:io';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PDFScreen extends StatefulWidget {
  static const routeName = '/pdfScreen';

  final String pdfPath;

  const PDFScreen({Key? key, required this.pdfPath}) : super(key: key);

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

_launchLink(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

class _PDFScreenState extends State<PDFScreen> {
  late File Pfile;
  bool isLoading = false;

  Future<void> loadNetwork() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(widget.pdfPath));
    final bytes = response.bodyBytes;
    final filename = basename(widget.pdfPath);
    final dir = await getApplicationDocumentsDirectory();

    var file = File(dir.path + "/" + filename);

    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      Pfile = file;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadNetwork();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: NavBarTop(title: "Visualizador de PDF"),
      ),
      body:
          isLoading
              ? Center(
                child: CircularProgressIndicator(color: AppColors.colorDark),
              )
              : Container(
                child: Center(
                  child: PDFView(
                    filePath: Pfile.path,
                    swipeHorizontal: true,
                    onViewCreated: (viewController) {},
                    onLinkHandler: (String? url) {
                      _launchLink(url!);
                    },
                  ),
                ),
              ),
    );
  }
}
