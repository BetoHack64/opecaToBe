import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opeca_app/aprovacoes.dart';

class GridDashboard extends StatelessWidget {
  void _selecionaSistema(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Aprovacoes();
        },
      ),
    );
  }

  Items item1 = new Items(
      title: "SOP SAL",
      subtitle: "Salário Cobrança",
      event: "1",
      img: "assets/images/money-transfer-100.png");

  Items item2 = new Items(
    title: "SGCD",
    subtitle: "Gestão Créditos",
    event: "7",
    img: "assets/images/donate-50.png",
  );
  Items item3 = new Items(
    title: "SGC",
    subtitle: "Compras Crédito",
    event: "1",
    img: "assets/images/icons8-basket-50.png",
  );
  Items item4 = new Items(
    title: "MD",
    subtitle: "Mediation",
    event: "8",
    img: "assets/images/synchronize.png",
  );
  Items item5 = new Items(
    title: "ACR",
    subtitle: "Accrual",
    event: "4",
    img: "assets/images/calculator-50.png",
  );
  Items item6 = new Items(
    title: "SGFM",
    subtitle: "Compra Dinheiro",
    event: "4",
    img: "assets/images/money-bag-50.png",
  );
  Items item7 = new Items(
    title: "ADM",
    subtitle: "Administração",
    event: "4",
    img: "assets/images/group-64.png",
  );
  Items item8 = new Items(
    title: "SGP",
    subtitle: "Gestão Património",
    event: "4",
    img: "assets/images/swatchbook.png",
  );
  Items item9 = new Items(
    title: "SOPMN",
    subtitle: "Operações MN",
    event: "4",
    img: "assets/images/money-transfer.png",
  );
  Items item10 = new Items(
    title: "MMF",
    subtitle: "Meios Físicos",
    event: "4",
    img: "assets/images/money-transfer.png",
  );
  Items item11 = new Items(
    title: "SGL",
    subtitle: "Gestão Liquidez",
    event: "4",
    img: "assets/images/money-transfer.png",
  );
  Items item12 = new Items(
    title: "SCT",
    subtitle: "Contabilidade",
    event: "4",
    img: "assets/images/money-transfer.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item8,
      item9,
      item10,
      item11,
      item12
    ];
    var color = 0xffEf5350;
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map(
          (data) {
            return InkWell(
              onTap: () => _selecionaSistema(context),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(color),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      color: Colors.white,
                      width: 55,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.event,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img});
}
