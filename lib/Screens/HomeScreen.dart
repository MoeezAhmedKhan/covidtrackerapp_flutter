import 'package:covidtracker/Modals/world_state_modal.dart';
import 'package:covidtracker/Screens/CountriesScreen.dart';
import 'package:covidtracker/Services/states_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController animController =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    animController.dispose();
  }

  List<Color> colorList = [Colors.blue, Colors.green, Colors.deepOrangeAccent];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              FutureBuilder(
                future: stateServices.getWorldState(),
                builder: (context, AsyncSnapshot<WorldStateModal> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: animController,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total": double.parse(
                              snapshot.data!.cases!.toString(),
                            ),
                            "Recovered": double.parse(
                              snapshot.data!.recovered!.toString(),
                            ),
                            "Death": double.parse(
                              snapshot.data!.deaths!.toString(),
                            ),
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          animationDuration: const Duration(seconds: 3),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width / 2.8,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.036),
                          child: Card(
                            elevation: 2.5,
                            child: Column(
                              children: [
                                ReuableRow(
                                  title: "Today Cases",
                                  value: snapshot.data!.todayCases!.toString(),
                                ),
                                ReuableRow(
                                  title: "Today Deaths",
                                  value: snapshot.data!.todayDeaths!.toString(),
                                ),
                                ReuableRow(
                                  title: "Today Recovered",
                                  value:
                                      snapshot.data!.todayRecovered!.toString(),
                                ),
                                ReuableRow(
                                  title: "Critical",
                                  value: snapshot.data!.critical!.toString(),
                                ),
                                ReuableRow(
                                  title: "Population",
                                  value: snapshot.data!.population!.toString(),
                                ),
                                ReuableRow(
                                  title: "Affected Countries",
                                  value: snapshot.data!.affectedCountries!
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CountriesListScreen(),
                            ),
                          ),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.green,
                            ),
                            child: const Center(child: Text("Track Countries")),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuableRow extends StatelessWidget {
  String title, value;
  ReuableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
