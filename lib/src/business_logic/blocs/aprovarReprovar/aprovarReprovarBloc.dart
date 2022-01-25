import 'package:SOP/src/business_logic/blocs/aprovarReprovar/events/aprovarReprovarEvent.dart';
import 'package:SOP/src/business_logic/blocs/aprovarReprovar/states/aprovarReprovarState.dart';
import 'package:bloc/bloc.dart';

class AprovarReprovarBloc
    extends Bloc<AprovarReprovarEvent, AprovarReprovarState> {
  AprovarReprovarBloc(AprovarReprovarState initialState) : super(LoadingAprovarReprovarState()) {
    on<AprovarReprovarEvent>((event, emit) {
      
    
    });
  }
}
