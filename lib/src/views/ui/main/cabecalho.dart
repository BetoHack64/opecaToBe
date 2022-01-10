import 'package:SOP/src/views/ui/main/griddashboard.dart';
import 'package:flutter/material.dart';

class Cabecalho extends StatelessWidget {
  final List<Sistema> lista;
  Cabecalho({required this.lista});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Sistemas",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Open Sans"),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Por favor selecione um sistema!",
                      style: TextStyle(
                          color: Color(0xffa29aac),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Open Sans"),
                    ),
                  ],
                ),
              ),
              /*IconButton(
                alignment: Alignment.topCenter,
                icon: Image.asset(
                  "assets/images/notification.png",
                  width: 24,
                ),
                onPressed: () {},
              )*/
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GridDashboard(
          items: this.lista,
        )
      ],
    );
  }
}
