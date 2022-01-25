import 'package:SOP/src/business_logic/models/cardDetail.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/listaAprovacoes.dart';
import 'package:SOP/src/views/ui/main/drawer.dart';
import 'package:SOP/src/views/ui/main/homeIconButton.dart';
import 'package:SOP/src/views/ui/main/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'hom_modal.dart';


int _currentIndex = 0;
final List _children = [];
// ignore: unused_element
OperationData _detalhes = OperationData(
  applicationId: '',
  operationCodId: '',
  operationId: '',
  header: Header(campo: '', valor: ''),
  dados: [],
  grelha: Grelha(
      header: Header_grelha(coluna1: '', coluna2: '', coluna3: ''), data: []),
  anexo: [],
);

bool botaoHomeAparece = true;

bool botao = false;

void main() {
  runApp(AprovarRejeitar(_detalhes));
}

class AprovarRejeitar extends StatelessWidget {
  AprovarRejeitar(OperationData detalhes) {
    _detalhes = detalhes;

    print(_detalhes.grelha.header.coluna1);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var currentPage = null;
  bool menu = false;
  int seleteposition = 2;

  //get getLinhas => null;

  @override
  Widget build(BuildContext context) {
    final larg = MediaQuery.of(context).size.width;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    //print(valor);
    void _selecionaSistema(BuildContext context) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
      );
    }

    //Gera o conteudo das celulas
    List<DataCell> getCelulas(List<dynamic> cells) =>
        cells.map((data) => DataCell(Text('$data'))).toList();

    //Desenha o cabeçalho das Colunas
    List<DataColumn> getColunas(List<String> columns) => columns
        .map((String columns) => DataColumn(
              label: Text(columns),
            ))
        .toList();
    //Desenha as linhas
    List<DataRow> getLinhas(List<String> columns, List<dynamic> cell) => columns
        .map((String columns) => DataRow(
              cells: getCelulas(cell),
            ))
        .toList();
    //Construção do cabeçalho da tabela
    final columns = [
      _detalhes.grelha.header.coluna1,
      _detalhes.grelha.header.coluna2,
      _detalhes.grelha.header.coluna3
    ];

    List<DataRow> _tabela() {
      var celulas = [];
      List<DataRow> lista = [];
      for (int i = 0; i < _detalhes.grelha.data.length; i++) {
        celulas = [
          _detalhes.grelha.data[i].valor1,
          _detalhes.grelha.data[i].valor2,
          _detalhes.grelha.data[i].valor3
        ];
        DataRow rows = DataRow(cells: getCelulas(celulas));

        lista.add(rows);
      }

      return lista;
    }

    //Construção da Tabela
    Widget _tabelaDados() {
      return Container(
        //margin: EdgeInsets.only(right: 10, top: 10), poderia usar o FitdBox para rem o pading
        child: DataTable(
          horizontalMargin: 1,
          columnSpacing: 19,
          columns: getColunas(columns),
          rows: _tabela(),
        ),
      );
    }

    //Construção dos campos
    Widget _camposPovoar(int i) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Text(
              (_detalhes.dados[i].campo == 'ok')
                  ? ''
                  : _detalhes.dados[i].campo,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 13,
                  //fontWeight: FontWeight.bold,
                  fontFamily: "Open Sans"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              (_detalhes.dados[i].campo.contains('Data'))
                  ? _detalhes.dados[i].valor.split('-').reversed.join('-')
                  : _detalhes.dados[i].valor,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 17,
                  //fontWeight: FontWeight.bold,   DateFormat("'Data numérica:' dd/MM/yyyy").format(data)
                  fontFamily: "Open Sans"),
            ),
          ),
        ],
      );
    }

    //Retornar a Detalhes de Operaçõesvoid
    void _retornaPaginaDetalhe(BuildContext context, String sistema) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            // applicationDetailItems = [];
            return ListaAprovacoes(
              nomeSistema: sistema,
            );
          },
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: RetrocederButton(telaRetroceder: 'aprovarReprovar'),
        elevation: 4.0,
        backgroundColor: Colors.red[900],
        title: Text(
          _detalhes.dados[0].valor +
              '                ' +
              _detalhes.operationId, // ${id}
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        centerTitle: true,
      ),

      //Botões inferiores

      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSpacing: MainAxisSpacing.right,
        children: [
          Container(
            //color: Colors.amber,
            margin: const EdgeInsets.only(
                // top: 1,
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50, //altura do button
                    width: 100, //Largura button
                    child: ElevatedButton(
                      child: Text('Aprovar'.toUpperCase()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          //side: BorderSide(color: Colors.red)
                        ),
                        primary: Colors.green,
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        print('Aprovar'.toUpperCase());
                      },
                    ),
                  ),
                ),
                //Fim botão aprovar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50, //altura do button
                    width: 100, //Largura button
                    child: ElevatedButton(
                      child: Text('Rejeitar'.toUpperCase()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          //side: BorderSide(color: Colors.red)
                        ),
                        primary: Colors.red[900],
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        print('Rejeitar'.toUpperCase());
                      },
                    ),
                  ),
                ),
                //Fim btn rejeitar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50, //altura do button
                    width: 100, //Largura button
                    child: ElevatedButton(
                      child: Text('Anexos'.toUpperCase()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          //side: BorderSide(color: Colors.red)
                        ),
                        primary: Color(0xFF263238),
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => HomeModal(
                              _detalhes.dados[0].valor, _detalhes.anexo),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //

      body:
          //Design do Conteúdo toda descrição da operaçã à aprovar ou rejeitar
          Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            //Informação de cabeçalho
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 18,
                  // bottom: 12,
                  //left: 10,
                ),
                child: Text(
                  _detalhes.header.valor.isEmpty
                      ? 'vazio'
                      : _detalhes.header.valor,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Open Sans"),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            //Fim divisão Operação
            Card(
              // Inicia Aqui o 1º card com a  informação referente ao numero da conta
              elevation: 5.0,
              margin: new EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(0, 0, 0, 0),
                ),

                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 0.0,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //aqui irei colocar todos os widgets q farão parte dos detalhes
                      Container(
                        margin: EdgeInsets.only(right: 0, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0,
                                bottom: 2,
                                //left: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Intrução for
                                  for (int i = 2;
                                      i < _detalhes.dados.length;
                                      i++)
                                    (_detalhes.dados[i].valor == 'ok')
                                        ? _camposPovoar(++i)
                                        : _camposPovoar(i),

                                  // _camposPovoar(i),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: Colors.black,
                      ),
                      _tabelaDados(),
                    ],
                  ),
                ), //makeListTile,
              ), // termina Aqui o 1º card com a  informação referente ao numero da conta
            ),

            //Card com informações dos produtos
            //botões estavam aqui  *btns*

            //Fim dos botões
          ],
        ),
      ),
      //Fim do Conteúdo

      floatingActionButton:
          botaoHomeAparece ? null : null, //Desenha o Dash lateral esquerdo
      drawer: DrawerMenu(),
    );
  }
}
