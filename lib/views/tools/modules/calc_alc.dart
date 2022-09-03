import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:legal_info/models/alc_drink_model.dart';
import 'package:legal_info/models/enum_gender.dart';
import 'package:legal_info/models/view_detail_model.dart';

class CalculateAlcPage extends StatefulWidget implements IViewDetailModel {
  @override
  final String title = "Restalkohol berechnen";
  @override
  final IconData icon = Icons.no_drinks;

  const CalculateAlcPage({Key? key}) : super(key: key);

  @override
  State<CalculateAlcPage> createState() => _CalculateAlcPageState();
}

class _CalculateAlcPageState extends State<CalculateAlcPage> {
  final _controllerHeight = TextEditingController();
  final _controllerWheight = TextEditingController();

  final Map<GenderType, double> bodyFluidPercentage = {
    GenderType.male: 0.68,
    GenderType.female: 0.55
  };
  final defaultAlcoholicDrink =
      AlcoholicDrink(percentage: 5.0, volume: 500.0, drinkType: DrinkType.Bier);

  GenderType? _gender = GenderType.male;
  var _weight = 80.0;
  var _height = 180;
  var _drinks = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    _drinks.add(AlcoholicDrink.clone(defaultAlcoholicDrink));

    _controllerHeight.text = _height.toString();
    _controllerHeight.selection =
        TextSelection(baseOffset: 0, extentOffset: _height.toString().length);
    _controllerHeight.value = TextEditingValue(
      text: _controllerHeight.text,
      selection: _controllerHeight.selection,
      composing: TextRange.empty,
    );

    _controllerWheight.text = _weight.toString();
    _controllerWheight.selection =
        TextSelection(baseOffset: 0, extentOffset: _weight.toString().length);
    _controllerWheight.value = TextEditingValue(
      text: _controllerWheight.text,
      selection: _controllerWheight.selection,
      composing: TextRange.empty,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Generate radio buttons for gender
    List<Widget> genders = <Widget>[];
    for (var genderType in GenderType.values) {
      Gender gender = Gender(genderType);

      var box = Row(children: [
        Text(gender.toString()),
        Radio(
          value: genderType,
          groupValue: _gender,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (GenderType? value) {
            setState(() {
              _gender = value;
            });
          },
        ),
      ]);
      genders.add(box);
    }

    var spaceBetweenFields = 10.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(children: [
              Column(
                children: [
                  Text(
                    "Geschlecht",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: genders),
              )
            ]),
            SizedBox(height: spaceBetweenFields),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Gewicht in kg",
              ),
              keyboardType: TextInputType.number,
              controller: _controllerWheight,
              onTap: () {
                _controllerWheight.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: _controllerWheight.text.length);
              },
              onChanged: (String value) {
                setState(() {
                  _weight = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: spaceBetweenFields),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Körpergröße in cm",
              ),
              keyboardType: TextInputType.number,
              controller: _controllerHeight,
              onTap: () {
                _controllerHeight.selection = TextSelection(
                    baseOffset: 0, extentOffset: _controllerHeight.text.length);
              },
              onChanged: (String value) {
                setState(() {
                  _height = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: spaceBetweenFields * 2),
            Expanded(
              child: ListView.separated(
                itemCount: _drinks.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext content, int index) {
                  return ListTile(
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          if (_drinks.length == 1) return;
                          _drinks.removeAt(index);
                        });
                      },
                    ),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          child: DropdownButtonFormField<DrinkType>(
                            decoration: const InputDecoration(
                              labelText: "Getränk",
                            ),
                            value: DrinkType.Bier,
                            items: DrinkType.values.map((DrinkType classType) {
                              return DropdownMenuItem<DrinkType>(
                                  value: classType,
                                  child: Text(classType.name.toString()));
                            }).toList(),
                            onChanged: (DrinkType? newValue) {
                              setState(() {
                                _drinks[index].drinkType =
                                    newValue ?? DrinkType.Bier;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: spaceBetweenFields),
                        SizedBox(
                          width: 80,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Volumen",
                            ),
                            initialValue: _drinks[index].volume.toString(),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.end,
                            onChanged: (String value) {
                              setState(() {
                                _drinks[index].volume =
                                    double.tryParse(value) ?? 0.0;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Einheit",
                            ),
                            value: AlcoholicDrink.volumeTypeFactor.keys.first,
                            items: AlcoholicDrink.volumeTypeFactor.keys
                                .map((String s) {
                              return DropdownMenuItem<String>(
                                  value: s, child: Text(s));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  _drinks[index].volumeFactor = AlcoholicDrink
                                          .volumeTypeFactor[newValue] ??
                                      1;
                                }
                              });
                            },
                          ),
                        ),
                        // todo add alcohol percentage
                      ],
                    ),
                    onTap: () {
                      // todo add drink
                      // _drinks.add(AlcoholicDrink());
                    },
                  );
                },
                separatorBuilder: (context, i) => const Divider(
                  color: Colors.grey,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.add_box_rounded),
                onPressed: () {
                  setState(() {
                    _drinks.add(_drinks.last);
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton(
              onPressed: (() {
                setState(() {
                  _drinks.clear();
                  _drinks.add(AlcoholicDrink.clone(defaultAlcoholicDrink));
                });
              }),
              child: Text("Getränke löschen")),
          ElevatedButton(
              onPressed: (() {
                // todo calculate
                if (kDebugMode) {
                  print("Höhe: $_height");
                  print("Gewicht: $_weight");
                }
              }),
              child: Text("Berechnen")),
        ]),
      ),
    );
  }
}
