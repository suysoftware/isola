// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/page/location_add_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../extensions/locale_keys.dart';

int hobbyPiece = 0;

class InterestAddPage extends StatefulWidget {
  const InterestAddPage({Key? key, required this.userUid}) : super(key: key);
  final userUid;
  @override
  _InterestAddPageState createState() => _InterestAddPageState();
}

class _InterestAddPageState extends State<InterestAddPage> {
  late var iconButtonList = <HobbyIconButton>[];

  void addValueHobby() {}

  @override
  void initState() {
    super.initState();
    for (var item in iconNameList) {
      var hobbyItem = HobbyIconButton(
        iconName: item,
      );
      iconButtonList.add(hobbyItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          trailing:
              Consumer<HobbyStatusCubit>(builder: (context, iconStatus, child) {
            return Visibility(
              visible: iconStatus.state.hobbyValue == 5 ? true : false,
              child: CupertinoButton(
                  child: const Icon(
                    CupertinoIcons.arrow_right,
                    color: CupertinoColors.systemGreen,
                  ),
                  onPressed: () {
                    FirebaseAuth _auth = FirebaseAuth.instance;

                    CollectionReference usersDisplay =
                        FirebaseFirestore.instance.collection('users_display');

                    usersDisplay.doc(_auth.currentUser!.uid).update({
                      'uInterest':
                          context.read<HobbyStatusCubit>().state.addingHobby,
                    }).whenComplete(() => {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => LocationAddPage(
                                        userUid: widget.userUid,
                                      )))
                        });
                  }),
            );
          }),
          automaticallyImplyLeading: false,
          middle:
              Consumer<HobbyStatusCubit>(builder: (context, iconStatus, child) {
            return Text(
              "${iconStatus.state.hobbyValue} / 5",
              style: iconStatus.state.hobbyValue >= 5
                  ? const TextStyle(color: CupertinoColors.systemGreen)
                  : const TextStyle(color: ColorConstant.softBlack),
            );
          }),
        ),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            itemCount: 35,
            itemBuilder: (context, index) {
              return iconButtonList[index];
            }));
  }
}

class HobbyIconButton extends StatelessWidget {
  HobbyIconButton({
    Key? key,
    required this.iconName,
  }) : super(key: key);

  String iconName;

  @override
  Widget build(BuildContext context) {
     int nameLine= iconNameList.indexOf(iconName);
    return BlocBuilder<HobbyStatusCubit, HobbyButtonModel>(
        builder: (context, hobbyType) {
      return Consumer<HobbyStatusCubit>(builder: (context, iconStatus, child) {
        return Column(
          children: [
            CupertinoButton(
                child: iconStatus.hobbyStatusReader(iconName) == true
                    ? Image.asset(
                                "asset/img/hobbies_icons/active_$iconName.png",
                                filterQuality: FilterQuality.high,
                                height: 100.h > 1200 ? 35.sp : 35.sp,
                                width: 100.h > 1200 ? 55.sp : 55.sp,
                              )
                            : Image.asset(
                                "asset/img/hobbies_icons_grey/${iconName}_grey_icon.png",
                                filterQuality: FilterQuality.high,
                                height: 100.h > 1200 ? 35.sp : 35.sp,
                                width: 100.h > 1200 ? 55.sp : 55.sp,
                              ),
                onPressed: () {
                  if (iconStatus.hobbyStatusReader(iconName) == true) {
                    iconStatus.hobbyStatusGrey(iconName);

                    hobbyPiece = hobbyPiece - 1;
                  } else {
                    if (iconStatus.state.hobbyValue < 5) {
                      iconStatus.hobbyStatusActive(iconName);

                      hobbyPiece = hobbyPiece + 1;
                    }
                  }
                }),   Text(
              iconNameListForName[nameLine],
              style: TextStyle(fontSize: 9.sp, color: CupertinoColors.black),
            )
          ],
        );
      });
    });
  }
}
var iconNameListForName = [
  LocaleKeys.interest_hiking.tr(),
  LocaleKeys.interest_reading.tr(),
  LocaleKeys.interest_art.tr(),
  LocaleKeys.interest_cooking.tr(),
  LocaleKeys.interest_theater.tr(),
  LocaleKeys.interest_traveling.tr(),
  LocaleKeys.interest_swimming.tr(),
  LocaleKeys.interest_basketball.tr(),
  LocaleKeys.interest_football.tr(),
  LocaleKeys.interest_volleyball.tr(),
  LocaleKeys.interest_tennis.tr(),
  LocaleKeys.interest_skiing.tr(),
  LocaleKeys.interest_cycling.tr(),
  LocaleKeys.interest_baseball.tr(),
  LocaleKeys.interest_climbing.tr(),
  LocaleKeys.interest_blogging.tr(),
  LocaleKeys.interest_astrology.tr(),
  LocaleKeys.interest_movies.tr(),
  LocaleKeys.interest_music.tr(),
  LocaleKeys.interest_gardening.tr(),
  LocaleKeys.interest_calligraphy.tr(),
  LocaleKeys.interest_yoga.tr(),
  LocaleKeys.interest_language.tr(),
  LocaleKeys.interest_camping.tr(),
  LocaleKeys.interest_dance.tr(),
  LocaleKeys.interest_games.tr(),
  LocaleKeys.interest_design.tr(),
  LocaleKeys.interest_photography.tr(),
  LocaleKeys.interest_chess.tr(),
  LocaleKeys.interest_running.tr(),
  LocaleKeys.interest_bowling.tr(),
  LocaleKeys.interest_skate.tr(),
  LocaleKeys.interest_martial.tr(),
  LocaleKeys.interest_fashion.tr(),
  LocaleKeys.interest_pet.tr()
];
var iconNameList = [
  "hiking",
  "reading",
  "art",
  "cooking",
  "theater",
  "travelling",
  "swimming",
  "basketball",
  "football",
  "volleyball",
  "tennis",
  "skiing",
  "cycling",
  "baseball",
  "climbing",
  "blogging",
  "astrology",
  "movies",
  "music",
  "gardening",
  "calligraphy",
  "yoga",
  "language",
  "camping",
  "dance",
  "games",
  "design",
  "photography",
  "chess",
  "running",
  "bowling",
  "skate",
  "martial",
  "fashion",
  "pet"
];

class HobbyStatusCubit extends Cubit<HobbyButtonModel> {
  HobbyStatusCubit() : super(HobbyButtonModel([], 0));

  List<String> hobbyButtonListReader() {
    return state.addingHobby;
  }

  bool hobbyStatusReader(String iconName) {
    if (state.addingHobby.contains(iconName)) {
      return true;
    } else {
      return false;
    }
  }

  void hobbyStatusActive(String iconName) {
    int newValue = state.hobbyValue + 1;

    var updateList = <String>[];

    updateList.addAll(state.addingHobby);

    updateList.add(iconName);

    var hobbyItem = HobbyButtonModel(updateList, newValue);
    emit(hobbyItem);
  }

  void hobbyStatusGrey(String iconName) {
    int newValue = state.hobbyValue - 1;

    var updateList = <String>[];

    updateList.addAll(state.addingHobby);
    if (updateList.contains(iconName) == true) {
      updateList.remove(iconName);
    }

    var hobbyItem = HobbyButtonModel(updateList, newValue);
    emit(hobbyItem);
  }
}

class HobbyButtonModel {
  late List<String> addingHobby;
  late int hobbyValue;

  HobbyButtonModel(this.addingHobby, this.hobbyValue);
}
