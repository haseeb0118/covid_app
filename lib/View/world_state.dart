import 'package:covid_19/Model/WorldStateModel.dart';
import 'package:covid_19/Service/states_services.dart';
import 'package:covid_19/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  
  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3)
  )..repeat();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  final colorList = [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
      StateService stateService = StateService();

    return Scaffold(
      body : SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding : const EdgeInsets.all(15.0),
          child : Column(
            children :[
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                  future: stateService.fetchWorkStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStateModel> snapshot){
                    if(!snapshot.hasData)
                    {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ));
                    }else {
                      return Column(
                        children: [
                          PieChart(dataMap: {
                            'Total' : double.parse(snapshot.data!.cases.toString()),
                            'Recovered' : double.parse(snapshot.data!.recovered.toString()),
                            'Deaths' : double.parse(snapshot.data!.deaths.toString()),
                          },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true
                            ),
                            animationDuration: const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            chartRadius: MediaQuery.of(context).size.width/3.2,
                            legendOptions: const LegendOptions(
                                legendPosition:  LegendPosition.left
                            ),
                            colorList: colorList,
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * .06),
                            child: Column(
                              children: [
                                Card(
                                  child: Column(
                                    children: [

                                      ReUsableRow(title: 'Today cases',
                                          value: snapshot.data!.todayCases.toString()),
                                      ReUsableRow(title: 'Today Death',
                                          value: snapshot.data!.todayDeaths.toString()),
                                      ReUsableRow(title: 'Today Recovered',
                                          value: snapshot.data!.todayRecovered.toString()),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Card(
                                  child: Column(
                                    children: [
                                      ReUsableRow(title: 'Total cases',
                                          value: snapshot.data!.cases.toString()),
                                      ReUsableRow(title: 'Death',
                                          value: snapshot.data!.deaths.toString()),
                                      ReUsableRow(title: 'Recovered',
                                          value: snapshot.data!.recovered.toString()),
                                      ReUsableRow(title: 'Active',
                                          value: snapshot.data!.active.toString()),
                                      ReUsableRow(title: 'Death',
                                          value: snapshot.data!.deaths.toString()),
                                      ReUsableRow(title: 'Critical',
                                          value: snapshot.data!.critical.toString()),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap : (){
                              Navigator.push(context,MaterialPageRoute(
                                  builder: (context) => CountriesListScreen()

                              ));

                                },
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                              child: Center(
                                child: Text('Track Countries'),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  })

            ]
          )
        )
        ),
      )
    );
  }
}
class ReUsableRow extends StatelessWidget {
  String title, value ;
  ReUsableRow({Key? key , required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10 , right: 10 , top: 10 , bottom: 5),
      child: Column  (
        children: [
          Row (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value)
        ],
      ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}

