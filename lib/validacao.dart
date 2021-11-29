import 'package:flutter/material.dart';

class Validacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      "Validacao",
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.attach_file),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Anexos"),
                    SizedBox(height: 5.0),
                    Text("2021001263"),
                  ],
                ),
              ),
              Divider(
                endIndent: 50,
                color: Colors.grey[500],
                indent: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ID OPERACAO"),
                    SizedBox(height: 5.0),
                    Text("2021001263"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
