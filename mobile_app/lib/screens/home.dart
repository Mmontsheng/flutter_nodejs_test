import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/weight/weight.dart';
import 'package:mobile_app/services/bearer_token.dart';
import 'package:mobile_app/state/weight.dart';
import 'package:mobile_app/theme/colors.dart';
import 'package:mobile_app/widgets/logout.dart';
import 'package:mobile_app/widgets/no_glow_behaviour.dart';
import 'package:mobile_app/widgets/weight_card.dart';
import 'package:mobile_app/widgets/weight_dialog.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<WeightProvider>(context, listen: false);
    provider.loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final bearerTokenService = Provider.of<BearerTokenService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            LogoutButton(
              onYes: () {
                bearerTokenService.remove();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (Route<dynamic> route) => false);
              },
            )
          ],
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
                      fontSize: 25),
                ),
              ),
            ],
          ),
        ),
        body: ScrollConfiguration(
          behavior: NoGlowBehaviour(),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Consumer<WeightProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (provider.weights.isEmpty && !provider.isLoading) {
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
                  itemCount: provider.weights.length,
                  itemBuilder: (context, index) {
                    Weight weight = provider.weights[index];
                    return WeightCard(
                      weight: weight,
                      onDeleted: (weight) async {
                        await provider.remove(weight);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Weight ${weight.value} deleted",
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
                return const WeightDialog();
              },
            );
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
