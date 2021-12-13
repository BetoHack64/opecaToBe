import 'dart:math';

import 'package:flutter/material.dart';

bool estaVisivel = false;
class CaixaPesquisaAnimacao extends StatefulWidget {
  CaixaPesquisaAnimacao(bool isVisible){
    estaVisivel = isVisible;
  }
  @override
  _CaixaPesquisaAnimacaoState createState() => _CaixaPesquisaAnimacaoState();
}

int toggle = 1;

class _CaixaPesquisaAnimacaoState extends State<CaixaPesquisaAnimacao>
    with SingleTickerProviderStateMixin {
  late AnimationController _con;
  @override
  void initState() {
    super.initState();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 375),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: Center(
        child: Container(
          height: 90.0,
          width: 250.0,
          alignment: Alignment(-1.0, 0.0),
          child: estaVisivel? AnimatedContainer(
            duration: Duration(milliseconds: 375),
            height: 48.0,
            width: (toggle == 0) ? 48.0 : 250.0,
            curve: Curves.easeOut,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: -10.0,
                    blurRadius: 10.0,
                    offset: Offset(-4.0, 10.0),
                    
                  ),
                ]),
            child: Stack(
              children: [
                
                AnimatedPositioned(
                  duration: Duration(milliseconds: 375),
                  left: (toggle == 0) ? 20.0 : 40.0,
                  top: 13.0,
                  curve: Curves.easeOut,
                  child: AnimatedOpacity(
                    opacity: (toggle == 0) ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 200),
                    child: Container(
                      height: 23.0,
                      width: 180.0,
                      child: TextField(
                        cursorRadius: Radius.circular(10.0),
                        cursorWidth: 2.0,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Procurar...',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        /*if (toggle == 0) {
                          toggle = 1;
                          _con.forward();
                        } else {
                          toggle = 0;
                          _con.reverse();
                        }*/
                      });
                    },
                    icon: Image.asset(
                      'assets/images/search.png',
                      height: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ): Center(
            child: 
              Text("LISTA DE OPERAÇÕES",
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Colors.grey
                ),
          
              )
          ),
        ),
      ),
    );
  }
}
