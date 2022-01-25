import 'dart:convert';

import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/views/ui/Detalhes/hom_modal.dart';
import 'package:SOP/src/views/ui/main/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'dart:io';
import 'package:path_provider/path_provider.dart';

//import 'package:SOP/src/views/ui/main/convertPdf.dart';

//void main() => runApp(PdfVer());

String titulo = '';
String nomes = '';
String contID = '';
String id = '';
String base = '';
bool red = false;

class PdfVer extends StatefulWidget {
  PdfVer(String titu, String opID, String contentID, String fic64,
      [bool redireciona = false]) {
    titulo = titu;
    print(titu);
    contID = contentID;
    id = opID;
    base = fic64;
    print(id);
    print(contID);
    print('PDF');
    print(base.toString());
    red = redireciona;
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PdfVer> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    //print(titulo);

    print('Base');
    print(base.toString());
    createFileOfPdfUrl(titulo, base).then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),
      );
    });
  }

  Future<File> createFileOfPdfUrl(String nome, String ficb64) async {
    late File filePdf;
    //formato = formato.toLowerCase();
    final decodedBytes = base64Decode(ficb64);
    final directory = await getApplicationDocumentsDirectory();
    filePdf = File('${directory.path}/$nome');
    print(filePdf.path);
    filePdf.writeAsBytesSync(List.from(decodedBytes));
    return filePdf;
  }

  @override
  void dispose() {
    print("dis 1");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Exemplo ')),
      body: Center(
        child: Text('ola'),
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  @override
  void dispose() {
    print("dis");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Documento"),
          leading: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Home()),
                );
              }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: widget.pathPDF);
  }
}
