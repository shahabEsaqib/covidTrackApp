

import 'package:covid_app_api/Model/world_states_model.dart';
import 'package:covid_app_api/Services/StatesServices.dart';
import 'package:covid_app_api/views/Countrieslist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({ Key? key }) : super(key: key);

  @override
  _WorldStatesState createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin{
  late final AnimationController _animationController = new AnimationController(
    duration: Duration(seconds: 3),
    vsync: this)..repeat();
    @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
    Color(0xfff23434),


  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = new StatesServices();
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Covid Data"),
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
        // foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Expanded(
          
          child: Column(
              
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.01,),
              FutureBuilder(
                future:statesServices.fetchWorldStetes(),
                builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      controller: _animationController,
                      color: Colors.black,
                      duration: Duration(microseconds: 1500),
                      size: 60,
                  
                    ),
                  );
                }else{
                  return Expanded(
                    child: Column(
                      children: [
                        PieChart(dataMap: {
                          
                          "Totle Cases": double.parse(snapshot.data!.cases.toString()) ,
                          
                          "Deaths": double.parse(snapshot.data!.deaths.toString()) ,
                          
                          "Recovered": double.parse(snapshot.data!.recovered.toString()) ,
                       
                              },
                              chartType: ChartType.ring,
                              animationDuration: Duration(milliseconds: 1000),
                              colorList: colorList,
                              chartRadius: MediaQuery.of(context).size.width /3,
                              centerText: "covid",
                              legendOptions: LegendOptions(
                                legendPosition: LegendPosition.right,
                                showLegendsInRow:false
                              ),
                              chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
                              
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                                child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ReusableRow(title: "Population", value: snapshot.data!.population.toString()),
                        ),
                        ReusableRow(title: "Totle Cases", value: snapshot.data!.cases.toString()),
                        ReusableRow(title: "Today Cases", value: snapshot.data!.todayCases.toString()),
                        ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                        ReusableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                        ReusableRow(title: "Recoverd", value: snapshot.data!.recovered.toString()),
                        ReusableRow(title: "Today Recoverd", value: snapshot.data!.todayRecovered.toString()),
                        ReusableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                      ],
                    ),
                                ),
                              ),
                              GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Countrieslist()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        child: Center(child: Text('Track Countries')),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff1aa260),
                        ),
                      ),
                    ),
                              )
                               
                      ],
                    ),
                  );
                }
              }),
              
            ],
          ),
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title , value;
  ReusableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 2,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
