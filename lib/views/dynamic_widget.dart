import 'package:flutter/material.dart';

class DynamicWidget extends StatefulWidget {
  @override
  _DynamicWidgetState createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  TextEditingController  _eCtrl;
  List<String> textList = [];
  bool showDialog = false;

  @override
  void initState() {
    // TODO: implement initState
    _eCtrl = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RaisedButton(
                  onPressed: (){
                    setState(() {
                      showDialog = true;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 1.1,
                  child: Text('Add Color'),
                  color: Colors.blueGrey[300],
                ),
              ),
              showDialog == true ?
              AlertDialog(
                title: Text('Alert'),
                content: TextField(
                  controller: _eCtrl,
                  decoration: InputDecoration.collapsed(hintText: 'Color'),
                  maxLines: 1,
                  onSubmitted: (String text){

                  },
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: (){
                      setState(() {
                        showDialog = false;
                        textList.add(_eCtrl.text);
                        _eCtrl.clear();
                      });
                    },
                    child: Text('OK'),
                  ),
                ],
              ) : Text(''),
              ListView.builder(
                shrinkWrap: true,
                itemCount: textList.length,
                itemBuilder: (BuildContext context, int Index){
                  return Row(
                    children: <Widget>[
                      Checkbox(
                        value: true,
                        onChanged: null,
                      ),
                      Text(textList[Index])
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
