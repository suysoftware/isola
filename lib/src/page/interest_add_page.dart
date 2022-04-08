// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/page/location_add_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
    return BlocBuilder<HobbyStatusCubit, HobbyButtonModel>(
        builder: (context, hobbyType) {
      return Consumer<HobbyStatusCubit>(builder: (context, iconStatus, child) {
        return CupertinoButton(
            child: SizedBox(
                height: 55.sp,
                width: 55.sp,
                child: iconStatus.hobbyStatusReader(iconName) == true
                    ? Image.asset(
                        "asset/img/hobbies_icons_active/${iconName}_active_icon.png",
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        "asset/img/hobbies_icons_grey/${iconName}_grey_icon.png",
                        fit: BoxFit.contain,
                      )),
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
            });
      });
    });
  }
}

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
