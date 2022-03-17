// ignore_for_file: avoid_print, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

int hobbyPiece = 0;

class ProfileInterestEditPage extends StatefulWidget {
  const ProfileInterestEditPage({Key? key, required this.userAll})
      : super(key: key);
  final IsolaUserAll userAll;
  @override
  _InterestAddPageState createState() => _InterestAddPageState();
}

class _InterestAddPageState extends State<ProfileInterestEditPage> {
  late var iconButtonList = <HobbyIconButton>[];

  void addValueHobby() {}

  @override
  void initState() {
    super.initState();
    context.read<HobbyEditStatusCubit>().hobbyStatusReset();
    context
        .read<HobbyEditStatusCubit>()
        .hobbyStatusActive(widget.userAll.isolaUserDisplay.userInterest[0]);
    context
        .read<HobbyEditStatusCubit>()
        .hobbyStatusActive(widget.userAll.isolaUserDisplay.userInterest[1]);
    context
        .read<HobbyEditStatusCubit>()
        .hobbyStatusActive(widget.userAll.isolaUserDisplay.userInterest[2]);
    context
        .read<HobbyEditStatusCubit>()
        .hobbyStatusActive(widget.userAll.isolaUserDisplay.userInterest[3]);
    context
        .read<HobbyEditStatusCubit>()
        .hobbyStatusActive(widget.userAll.isolaUserDisplay.userInterest[4]);
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
          trailing: Consumer<HobbyEditStatusCubit>(
              builder: (context, iconStatus, child) {
            return Visibility(
              visible: iconStatus.state.hobbyValue == 5 ? true : false,
              child: CupertinoButton(
                  child: const Icon(
                    CupertinoIcons.check_mark,
                    color: CupertinoColors.systemGreen,
                  ),
                  onPressed: () {
                    CollectionReference userDisplayRef =
                        FirebaseFirestore.instance.collection("users_display");

                    userDisplayRef
                        .doc(widget.userAll.isolaUserMeta.userUid)
                        .update({
                      'uInterest': context
                          .read<HobbyEditStatusCubit>()
                          .state
                          .addingHobby,
                    }).whenComplete(() {
                      Navigator.pop(context);
                    });

                    print(
                        context.read<HobbyEditStatusCubit>().state.addingHobby);
                    print("geç devammkeeeee");
                  }),
            );
          }),
          automaticallyImplyLeading: false,
          middle: Consumer<HobbyEditStatusCubit>(
              builder: (context, iconStatus, child) {
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
    return BlocBuilder<HobbyEditStatusCubit, HobbyButtonModel>(
        builder: (context, hobbyType) {
      return Consumer<HobbyEditStatusCubit>(
          builder: (context, iconStatus, child) {
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
              print("ag");
              if (iconStatus.hobbyStatusReader(iconName) == true) {
                iconStatus.hobbyStatusGrey(iconName);
                print("ag2");
                //burada emit yapılacak
                hobbyPiece = hobbyPiece - 1;

                print(iconStatus.state.addingHobby);
                print(iconStatus.state.hobbyValue);
              } else {
                if (iconStatus.state.hobbyValue < 5) {
                  print("ag3");
                  iconStatus.hobbyStatusActive(iconName);

                  hobbyPiece = hobbyPiece + 1;
                  print(iconStatus.state.addingHobby);
                  print(iconStatus.state.hobbyValue);
                }
                print("coook bastın");
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

class HobbyEditStatusCubit extends Cubit<HobbyButtonModel> {
  HobbyEditStatusCubit() : super(HobbyButtonModel([], 0));

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
    print("girdiimactive1");
    print("iconname $iconName");

    var hobbyItem = HobbyButtonModel(updateList, newValue);
    emit(hobbyItem);
  }

  void hobbyStatusGrey(String iconName) {
    int newValue = state.hobbyValue - 1;
    print("girdiimgrey1");
    var updateList = <String>[];

    updateList.addAll(state.addingHobby);
    if (updateList.contains(iconName) == true) {
      updateList.remove(iconName);
    }
    print("girdiimgrey2");

    var hobbyItem = HobbyButtonModel(updateList, newValue);
    emit(hobbyItem);
  }

  void hobbyStatusReset() {
    int newValue = 0;
    print("girdiimgrey1");
    var updateList = <String>[];

    var hobbyItem = HobbyButtonModel(updateList, newValue);
    emit(hobbyItem);
  }
}

class HobbyButtonModel {
  late List<String> addingHobby;
  late int hobbyValue;

  HobbyButtonModel(this.addingHobby, this.hobbyValue);
}
