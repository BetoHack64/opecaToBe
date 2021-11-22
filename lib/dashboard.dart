import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opeca_app/griddashboard.dart';

class Dashboard extends StatelessWidget {
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
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Por favor selecione um sistema!",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xffa29aac),
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              IconButton(
                alignment: Alignment.topCenter,
                icon: Image.asset(
                  "assets/images/notification.png",
                  width: 24,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        SizedBox(
          height: 35,
        ),
        GridDashboard()
      ],
    );
  }
}
