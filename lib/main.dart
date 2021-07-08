import 'package:flutter/material.dart';


void main() => runApp(SiCalculator());

class SiCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SiCalcApp();
  }
}

class _SiCalcApp extends State<SiCalculator> {
  var _currencies = ['Rupees', 'Dollars', 'Pounds', 'Others'];
  var _currentItemValue = '';
  var _minMargin = 5.0;
  var _formKey = GlobalKey<FormState>();
  // Text Controller to get values
  var _princeTextController = TextEditingController();
  var _rateTextController = TextEditingController();
  var _termTextController = TextEditingController();

  var _displayResult = "";
   @override
  void initState() {
    super.initState();
     _currentItemValue = _currencies[0];
  }
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    TextStyle textStyle = Theme.of(context).textTheme.title;

    var container = Container(
                      padding: EdgeInsets.all(_minMargin),
                    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calc",
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.lightGreen,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showDialog(
                 context: context,
                 builder: (_) => MyAlertBox(),
                );
              },
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(_minMargin * 5),
                  child: Icon(
                    Icons.account_balance,
                    color: Colors.green,
                    size: 140,
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.only(top: _minMargin, bottom: _minMargin),
                  child: TextFormField(
                    validator: (String inputVal){
                      if(inputVal.isEmpty){
                        return "Please Enter the Principal";
                      }
                    },
                    controller: _princeTextController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Principal",
                      labelStyle: textStyle,
                      hintText: "Enter Principal (e.g : 1200)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: _minMargin, bottom: _minMargin),
                  child: TextFormField(
                    validator: (String inputVal){
                      if(inputVal.isEmpty){
                        return "Please Enter the Rate";
                      }
                    },
                    controller: _rateTextController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Rate of Interest",
                      labelStyle: textStyle,
                      hintText: "Enter In Percentage",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: _minMargin, bottom: _minMargin),
                        child: TextFormField(
                          validator: (String inputVal){
                      if(inputVal.isEmpty){
                        return "Please Enter the Term";
                      }
                    },
                          keyboardType: TextInputType.number,
                          controller: _termTextController,
                          style: textStyle,
                          decoration: InputDecoration(
                            labelText: "Terms",
                            labelStyle: textStyle,
                            hintText: "Select The Terms",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_minMargin * 5),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        elevation: 10,
                        items: _currencies.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: textStyle,
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          _dropDownSelectedItems(_currentItemValue);
                        },
                        value: _currentItemValue,
                      ),
                    )
                  ],
                ),
                Container(padding: EdgeInsets.all(_minMargin)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            if(_formKey.currentState.validate()){
                            this._displayResult = _onCalculateClick();
                          }});
                        },
                        child: Container(
                          padding: EdgeInsets.all(_minMargin + 6),
                          child: Text(
                            "Calculate",
                            style: TextStyle(
                              letterSpacing: 2,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    container,
                    Expanded(
                      child: RaisedButton(
                        color: Colors.orange,
                        onPressed: () {
                          _onResetButton();
                        },
                        child: Container(
                          padding: EdgeInsets.all(_minMargin + 6),
                          child: Text(
                            "Reset",
                            style: TextStyle(
                              letterSpacing: 2,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(_minMargin * 5),
                  child: Text(
                    _displayResult,
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
//Build Method ends
  }

  /* Defining Image Assets */
  Widget getAssetImage() {
    AssetImage imageAsset = AssetImage('images/bank.png');
    Image image = Image(
      image: imageAsset,
      height: 200,
      width: 200,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minMargin * 10),
    );
  }

/* METHODS */
  void _dropDownSelectedItems(String newValue) {
    setState(() {
      this._currentItemValue = newValue;
    });
  }
/* Calculating the Total Payable Amount */

  String _onCalculateClick() {
    double prince = double.parse(_princeTextController.text);
    double rate = double.parse(_rateTextController.text);
    double term = double.parse(_termTextController.text);

    double totalPayableAmount = prince + (prince * rate * term) / 100;
    String resultMessage =
        "After $term years Your Investement will worth $totalPayableAmount,  $_currentItemValue";
    return resultMessage;
  }
  // Reset Button

  void _onResetButton() {
    _princeTextController.text = '';
    _rateTextController.text = '';
    _termTextController.text = '';
    _currentItemValue = _currencies[0];
  }

//AlerDialog Box for Result message



// SiCalculator Main Class Ended
}

class MyAlertBox extends StatelessWidget{
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: Colors.green,
      title: Text("Welcome to my AlertDialog"),
      content: Text("Hope you like this one"),
        );
  }
}