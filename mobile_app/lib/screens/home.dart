import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mobile_app/models/weight.dart';
import 'package:mobile_app/services/authentication.dart';
import 'package:mobile_app/services/weights.dart';
import 'package:mobile_app/theme/colors.dart';
import 'package:mobile_app/widgets/loading_Icon.dart';
import 'package:mobile_app/widgets/no_glow_behaviour.dart';
import 'package:mobile_app/widgets/weight_card.dart';
import 'package:mobile_app/widgets/weight_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeightService weightService;
  bool isLoading = false;
  List<Weight> weights = [];

  @override
  void initState() {
    super.initState();
    initServices();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: Row(
            children: const [
              Expanded(
                child: Text(
                  'Weight Tracker',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
              ),
            ],
          ),
        ),
        body: ScrollConfiguration(
          behavior: NoGlowBehaviour(),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (isLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (weights.isEmpty && !isLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'No weights.',
                        style: TextStyle(fontSize: 20, color: AppColors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Use the Create button to add one.',
                        style: TextStyle(fontSize: 20, color: AppColors.grey),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: weights.length,
                  itemBuilder: (context, index) {
                    Weight weight = weights[index];
                    return WeightCard(
                      weight: weight,
                      onDismissed: (direction) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Deleted',
                          ),
                          backgroundColor: AppColors.primary,
                        ));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return WeightDialog(onSave: (value, id) {
                  Navigator.pop(context);
                });
              },
            );
            // Add your onPressed code here!
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void loadWeights() async {
    http.Response response = await weightService.get();
    if (response.statusCode != 200) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    WeightReponse data = parseFromJson(response.body);
    setState(() {
      weights = data.result!;
      weights.sort((a, b) => b.date.compareTo(a.date));
      isLoading = false;
    });
  }

  initServices() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    weightService = WeightService(
        authenticationService:
            AuthenticationService(localStorage: localStorage));
    return loadWeights();
  }
}
