import 'package:covidtracker/Screens/DetailScreen.dart';
import 'package:covidtracker/Services/Utitlities/app_url.dart';
import 'package:covidtracker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  labelText: "Search Country Name",
                  labelStyle: TextStyle(color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder(
                  future: stateServices.getCountriesList(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white),
                                  title: Container(
                                      height: 10,
                                      width: 90,
                                      color: Colors.white),
                                  subtitle: Container(
                                      height: 10,
                                      width: 90,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String countryname = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          country_name: snapshot.data![index]
                                              ['country'],
                                          cases: snapshot.data![index]['cases'],
                                          continent: snapshot.data![index]
                                              ['continent'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                          deaths: snapshot.data![index]
                                              ['deaths'],
                                          recovered: snapshot.data![index]
                                              ['recovered'],
                                          todayCases: snapshot.data![index]
                                              ['todayCases'],
                                          todayDeaths: snapshot.data![index]
                                              ['todayDeaths'],
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    leading: Image(
                                        height: 100,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(
                                      snapshot.data![index]['cases'].toString(),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else if (countryname
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          country_name: snapshot.data![index]
                                              ['country'],
                                          cases: snapshot.data![index]['cases'],
                                          continent: snapshot.data![index]
                                              ['continent'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                          deaths: snapshot.data![index]
                                              ['deaths'],
                                          recovered: snapshot.data![index]
                                              ['recovered'],
                                          todayCases: snapshot.data![index]
                                              ['todayCases'],
                                          todayDeaths: snapshot.data![index]
                                              ['todayDeaths'],
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    leading: Image(
                                        height: 100,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(
                                      snapshot.data![index]['cases'].toString(),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
