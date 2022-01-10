import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//void main() => runApp(PdfVer());

String titulo = '';
String nomes = '';

class PdfVer extends StatefulWidget {
  PdfVer(String titu, String nome) {
    titulo = titu;
    nomes = nome;
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PdfVer> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/PDFs/exemplo.pdf');

    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/sample2.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
        "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf",
        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
      );
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /* drawer: Drawer(
          child: Column(
            children: <Widget>[
              SizedBox(height: 36),
              /*ListTile(
                title: Text('Abrindo Documento'),
                onTap: () {
                  changePDF(1);
                },
              ),*/
              /* ListTile(
                title: Text('Carregando'),
                onTap: () {
                  changePDF(2);
                },
              ),*/
              /* ListTile(
                title: Text('Restore default'),
                onTap: () {
                  changePDF(3);
                },
              ),*/
            ],
          ),
        ),*/
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () =>
                //Navigator.of(context, rootNavigator: true).pop()
                //Voltar a página que chamou a modal
                Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.red[900],
          title: Text("${nomes}- ${titulo}"),
          centerTitle: true,
        ),
        body: Center(
          child: _isLoading
              ? Center(
                  /*child:CircularProgressIndicator(color: Colors.red[900])*/)
              : PDFViewer(
                  document: document,
                ),
        ),
      ),
    );
  }
}
