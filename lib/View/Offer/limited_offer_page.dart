import 'package:flutter/material.dart';
import 'package:nodelabscase/Components/CustomButtons/primary_large_button.dart';
import 'package:nodelabscase/Components/CustomButtons/x_mark_button.dart';
import 'package:nodelabscase/Components/CustomViews/bonus_view.dart';
import 'package:nodelabscase/Components/CustomViews/custom_background_view.dart';

import '../../Components/CustomViews/offer_card_view.dart';
import '../../Core/Theme/app_colors.dart';
import '../../Core/Theme/app_typography.dart';

class LimitedOfferPage extends StatefulWidget {
  const LimitedOfferPage({super.key});

  @override
  State<LimitedOfferPage> createState() => _LimitedOfferPageState();
}

class _LimitedOfferPageState extends State<LimitedOfferPage> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.80;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: Container(
        height: height,
        color: AppColors.black, // veya arkaplan gradientin
        child: CustomBackgroundView(
          child: Stack(
            children: [
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   const SizedBox(height: 30),
                   const Text("Limited Offer", style: AppTypography.h4),
                   const SizedBox(height: 10),
                   const Text(
                      "Select your token package to earn bonuses and unlock new sections!",
                      style: AppTypography.bodyMediumRegular,
                      textAlign: TextAlign.center,
                    ),
                   const SizedBox(height: 20),
                    const BonusView(),
                   const SizedBox(height: 20),
                   const Text("Choose a coin pack to unlock", style: AppTypography.h5),
                    const SizedBox(height: 30),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OfferCard(
                          bonusText: "+10%",
                          oldValue: "200",
                          newValue: "300",
                          price: "TL99,99",
                          subtitle: "Weekly",
                          color: Colors.red,
                        ),
                        OfferCard(
                          bonusText: "+70%",
                          oldValue: "2000",
                          newValue: "3375",
                          price: "TL799,99",
                          subtitle: "Weekly",
                          color: Colors.purple,
                        ),
                        OfferCard(
                          bonusText: "+35%",
                          oldValue: "1000",
                          newValue: "1350",
                          price: "TL399,99",
                          subtitle: "Weekly",
                          color: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    PrimaryLargeButton(
                        buttonText: "Show All Coins",
                        onPressed: () {
                          debugPrint("DEBUG -> Show All Coins Tapped!");
                        },
                        isActive: true
                    )
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: XMarkButton(onPressed: () => Navigator.pop(context)),
              ),
            ],
          ),
        ),
      ),
    );

  }

}
