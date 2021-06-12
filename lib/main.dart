import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "SI Calculator",
    home: SIForm(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      brightness: Brightness.dark,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  var _currencies = ['Rupees', 'Dollar', 'Pound'];
  var _minimumPadding = 5.0;
  var _currentSelectedItem;
  // ignore: must_call_super
  void initState() {
    _currentSelectedItem = _currencies[0];
  }

  var _displayResult = "";

  TextEditingController principleControler = TextEditingController();
  TextEditingController roiControler = TextEditingController();
  TextEditingController termControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
        appBar: AppBar(
          title: Text("SI Calculator"),
        ),
        body: Form(
          child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: [
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principleControler,
                      decoration: InputDecoration(
                        labelText: "Principal",
                        hintText: "Enter the Principal Amount",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent, fontSize: 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.5)),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      controller: roiControler,
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: "Rate of Interest",
                        hintText: "Enter the Rate of Interest",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.5)),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termControler,
                          decoration: InputDecoration(
                            labelText: "Term",
                            hintText: "Time in years",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5)),
                          ),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((var value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          value: _currentSelectedItem,
                          onChanged: (var newValueSelected) =>
                              _onDropDownItem(newValueSelected.toString()),
                        ))
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: [
                      Expanded(
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.2,
                        ),
                        onPressed: () {
                          setState(() {
                            this._displayResult = calc();
                          });
                        },
                      )),
                      Expanded(
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.2,
                        ),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Text(
                    this._displayResult,
                    style: textStyle,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget getImageAsset() {
    AssetImage img = AssetImage('images/image1.png');
    Image image = Image(
      image: img,
      width: 175.0,
      height: 175.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItem(String newSelectedItem) {
    setState(() {
      this._currentSelectedItem = newSelectedItem;
    });
  }

  String calc() {
    double principle = double.parse(principleControler.text);
    double roi = double.parse(roiControler.text);
    double term = double.parse(termControler.text);
    double tot = principle + (roi * principle * term) / 100;
    return "After $term years , Your invitement will be worth of $tot $_currentSelectedItem";
  }

  void _reset() {
    principleControler.text = '';
    roiControler.text = '';
    termControler.text = '';
    _displayResult = '';
    _currentSelectedItem = _currencies[0];
  }
}
