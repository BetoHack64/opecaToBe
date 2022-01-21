import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/models/sistema.dart';
import 'package:SOP/src/views/ui/main/iconSistema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<Sistema> applicationDetailItems = [];

class GridDashboard extends StatefulWidget {
  GridDashboard({required List<Sistema> items}) {
    applicationDetailItems = items;
  }

  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Sistema> myList = applicationDetailItems;
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map(
          (data) {
            return InkWell(
              onTap: () => BlocProvider.of<MainBloc>(context).selecionaSistema(
                  context, data.applicationCod, data.applicationID),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 0.2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      child: Center(
                        child: Text(
                          data.numOperations,
                          style: TextStyle(
                              color: data.numOperations == "0"
                                  ? Colors.black
                                  : Colors.red[900],
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Open Sans"),
                        ),
                      ),
                      margin: EdgeInsets.only(left: 120, bottom: 0),
                    ),
                    Container(
                      child: IconSistema(
                          imageAnalysed: data.iconBase64,
                          nome: data.applicationCod),
                      margin: EdgeInsets.only(bottom: 16),
                    ),
                    Container(
                      child: Text(
                        data.applicationCod,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Open Sans"),
                      ),
                      margin: EdgeInsets.only(bottom: 5),
                    ),
                    Text(
                      data.applicationNameShort,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Open Sans"),
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
