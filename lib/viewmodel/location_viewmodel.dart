
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationViewModel extends ChangeNotifier {

  Position _position = Position(latitude: 0, longitude: 0);
  Position get position => _position;

  /// 現在地を取得する
  Future<void> getLocation(context) async {
    Position _currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _position = _currentPosition;
    notifyListeners();
  }
}