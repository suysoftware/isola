// ignore_for_file: unused_local_variable
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/page/searchpage.dart';

class SearchCubit extends Cubit<List<GridTile>> {
  SearchCubit() : super(feedValue);
  static var feedValue = <GridTile>[
    const GridTile(2, 1),
    const GridTile(1, 2),
    const GridTile(2, 2),
    const GridTile(1, 1),
    const GridTile(2, 1),
    const GridTile(1, 2),
    const GridTile(2, 2),
    const GridTile(1, 1),
  ];
  void feedValueLoader(List<GridTile> gTilebaba) {
    const tiles2 = [
      GridTile(2, 1),
      GridTile(1, 2),
      GridTile(2, 2),
      GridTile(1, 1),
      GridTile(2, 1),
      GridTile(1, 2),
      GridTile(2, 2),
      GridTile(1, 1),
    ];
    const tiles3 = GridTile(2, 1);
    const tiles4 = GridTile(1, 2);
    const tiles5 = GridTile(2, 2);
    const tiles6 = GridTile(1, 1);
    const tiles7 = GridTile(2, 1);
    const tiles8 = GridTile(1, 2);
    const tiles9 = GridTile(2, 2);
    const tiles10 = GridTile(1, 1);

    List<GridTile> gList = gTilebaba;

    gList.add(tiles3);
    gList.add(tiles4);
    gList.add(tiles5);
    gList.add(tiles6);
    gList.add(tiles7);
    gList.add(tiles8);
    gList.add(tiles9);
    gList.add(tiles10);
    var search = gList;
    emit(search);
  }
}
