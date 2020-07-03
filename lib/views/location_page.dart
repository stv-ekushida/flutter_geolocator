import 'package:flutter/material.dart';
import 'package:fluttergeolocator/viewmodel/location_viewmodel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget{
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  @override
  void initState() {
    super.initState();
    LocationViewModel viewModel = Provider.of<LocationViewModel>(context, listen: false);
    viewModel.getLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GeolocationStatus>(
        future: Geolocator().checkGeolocationPermissionStatus(),
        builder:
            (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(body: const Center(child: CircularProgressIndicator()));
          }

          if (snapshot.data == GeolocationStatus.denied) {
            return Text(
              'Access to location denied',
              textAlign: TextAlign.center,
            );
          }

          return Consumer<LocationViewModel>(
            builder: (context, viewModel, child) {
              return _buildBody(viewModel);
            },
          );
        }
    );
  }

  Widget _buildBody(LocationViewModel viewModel) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Location Information",
              style: TextStyle(
                  fontSize: 20.0
              ),
            ),
            Text("${viewModel.position}")
          ],
        ),
      ),
    );
  }
}