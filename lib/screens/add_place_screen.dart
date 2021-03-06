import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/place.dart';
import 'package:flutter_complete_guide/providers/great_places.dart';
import 'package:flutter_complete_guide/widgets/image_input.dart';
import 'package:flutter_complete_guide/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  AddPlaceScreen({Key key}) : super(key: key);

  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File _pickedImage;
  PlaceLocation _pickedLocation;
  final _titleController = TextEditingController();

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add a New Place'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ImageInput(
                        onSelectImage: _selectImage,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LocationInput(
                        onSelectPlace: _selectPlace,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            RaisedButton.icon(
              onPressed: () {
                _savePlace();
              },
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.add),
              label: Text('Add Place'),
            )
          ],
        ));
  }
}
