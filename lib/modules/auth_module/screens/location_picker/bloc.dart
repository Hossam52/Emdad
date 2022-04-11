import 'package:bloc/bloc.dart';
import 'package:open_location_picker/open_location_picker.dart';

class CustomBloc extends Cubit<OpenMapState> implements OpenMapBloc {
  CustomBloc(OpenMapState initialState) : super(initialState);
  FormattedLocation? formattedLocation;
}