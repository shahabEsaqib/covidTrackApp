import 'package:covid_app_api/Services/StatesServices.dart';
import 'package:covid_app_api/views/countryDetail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countrieslist extends StatefulWidget {
  const Countrieslist({Key? key}) : super(key: key);

  @override
  State<Countrieslist> createState() => _CountrieslistState();
}

class _CountrieslistState extends State<Countrieslist> {
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = new StatesServices();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        // foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: 'Search with country name',
                suffixIcon: searchController.text.isEmpty
                    ? const Icon(Icons.search)
                    : GestureDetector(
                        onTap: () {
                          searchController.text = "";
                          setState(() {});
                        },
                        child: Icon(Icons.clear)),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
                future: statesServices.fetchCountriesStetes(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade100,
                        child: ListView.builder(
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              );
                            }));
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [details(context, snapshot, index)],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [details(context, snapshot, index)],
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                }),
          )
        ],
      ),
    );
  }

  InkWell details(
      BuildContext context, AsyncSnapshot<List<dynamic>> snapshot, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CountryDetailScreen(
                      name: snapshot.data![index]['country'],
                      image: snapshot.data![index]['countryInfo']['flag'],
                      critical: snapshot.data![index]['critical'],
                      active: snapshot.data![index]['active'],
                      test: snapshot.data![index]['tests'],
                      todayRecovered: snapshot.data![index]['todayRecovered'],
                      totalCases: snapshot.data![index]['cases'],
                      totalDeaths: snapshot.data![index]['deaths'],
                      totalRecovered: snapshot.data![index]['recovered'],
                    )));
      },
      child: ListTile(
        title: Text(snapshot.data![index]['country']),
        subtitle: Text(snapshot.data![index]['cases'].toString()),
        leading: Image(
            height: 50,
            width: 50,
            image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
      ),
    );
  }
}
