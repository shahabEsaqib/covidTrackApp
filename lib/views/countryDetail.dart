import 'package:covid_app_api/views/worldstates.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatefulWidget {
 String image ;
  String  name ;
  int totalCases , totalDeaths, totalRecovered , active , critical, todayRecovered , test;

  CountryDetailScreen({
    required this.image ,
    required this.name ,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,

  }) ;

  @override
  _CountryDetailScreenState createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          Stack(
            fit: StackFit.loose,
            alignment: Alignment.topCenter,
            children: [
              
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.057),
                child: Card(
                  child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.078,),
                    ReusableRow(title: "Cases", value: widget.totalCases.toString()),
                     ReusableRow(title: 'Test', value: widget.test.toString(),),
                        ReusableRow(title: 'Recovered', value:  widget.totalRecovered.toString(),),
                        ReusableRow(title: 'Death', value:  widget.totalDeaths.toString(),),
                        ReusableRow(title: 'Critical', value: widget.critical.toString(),),
                        ReusableRow(title: 'Today Recovered', value:widget.todayRecovered.toString(),),
                        ReusableRow(title: 'Active', value: widget.active.toString(),),
                  ],
                )),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
                ),
                
            ],
            
          )
        ],
      ),
      
    );
  }
}