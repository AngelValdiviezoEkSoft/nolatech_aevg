part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class GpsAndPermissionEvent extends GpsEvent {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;
  final bool isMuestraMapa;
  final bool tieneUbicacion;

  const GpsAndPermissionEvent({
    required this.isGpsEnabled, 
    required this.isGpsPermissionGranted,
    required this.isMuestraMapa,
    required this.tieneUbicacion
  });
}
