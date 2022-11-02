import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'package:sizer/sizer.dart';

class AnimatedLiquidCircularProgressIndicator extends StatefulWidget {
  const AnimatedLiquidCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      AnimatedLiquidCircularProgressIndicatorState();
}

class AnimatedLiquidCircularProgressIndicatorState
    extends State<AnimatedLiquidCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ColorConstant.themeColor,
      child: Center(
        child: LiquidCustomProgressIndicator(
          value: 0.5, // Defaults to 0.5.
          valueColor: const AlwaysStoppedAnimation(ColorConstant
              .iGradientMaterial3), // Defaults to the current Theme's accentColor.
          backgroundColor: ColorConstant
              .milkColor, // Defaults to the current Theme's backgroundColor.

          direction: Axis
              .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
          shapePath: _buildIsolaLogoPath(),
        ),
      ),
    );
  }

  Path _buildIsolaLogoPath() {
    int sizeValueWidth = 27;
    int sizeValueHeight = 10;
    return Path()
      ..moveTo(sizeValueWidth.w * 0.1659266, sizeValueHeight.h * 0.4081632)
      ..cubicTo(
          sizeValueWidth.w * 0.1521498,
          sizeValueHeight.h * 0.4776005,
          sizeValueWidth.w * 0.1502773,
          sizeValueHeight.h * 0.5506724,
          sizeValueWidth.w * 0.1607198,
          sizeValueHeight.h * 0.6217211)
      ..cubicTo(
          sizeValueWidth.w * 0.1741188,
          sizeValueHeight.h * 0.7128855,
          sizeValueWidth.w * 0.2071923,
          sizeValueHeight.h * 0.7966248,
          sizeValueWidth.w * 0.2557565,
          sizeValueHeight.h * 0.8623508)
      ..cubicTo(
          sizeValueWidth.w * 0.3043217,
          sizeValueHeight.h * 0.9280755,
          sizeValueWidth.w * 0.3661971,
          sizeValueHeight.h * 0.9728356,
          sizeValueWidth.w * 0.4335585,
          sizeValueHeight.h * 0.9909695)
      ..cubicTo(
          sizeValueWidth.w * 0.5009208,
          sizeValueHeight.h * 1.009104,
          sizeValueWidth.w * 0.5707420,
          sizeValueHeight.h * 0.9997966,
          sizeValueWidth.w * 0.6341961,
          sizeValueHeight.h * 0.9642253)
      ..cubicTo(
          sizeValueWidth.w * 0.6644850,
          sizeValueHeight.h * 0.9472460,
          sizeValueWidth.w * 0.8232222,
          sizeValueHeight.h * 1.018362,
          sizeValueWidth.w * 0.8485643,
          sizeValueHeight.h * 0.9909695)
      ..cubicTo(
          sizeValueWidth.w * 0.8028725,
          sizeValueHeight.h * 0.9469963,
          sizeValueWidth.w * 0.7700976,
          sizeValueHeight.h * 0.8315274,
          sizeValueWidth.w * 0.7900406,
          sizeValueHeight.h * 0.7911340)
      ..cubicTo(
          sizeValueWidth.w * 0.8281981,
          sizeValueHeight.h * 0.7138477,
          sizeValueWidth.w * 0.8485643,
          sizeValueHeight.h * 0.6229854,
          sizeValueWidth.w * 0.8485643,
          sizeValueHeight.h * 0.5300353)
      ..cubicTo(
          sizeValueWidth.w * 0.8485285,
          sizeValueHeight.h * 0.4880268,
          sizeValueWidth.w * 0.8443430,
          sizeValueHeight.h * 0.4466041,
          sizeValueWidth.w * 0.8363140,
          sizeValueHeight.h * 0.4067698)
      ..cubicTo(
          sizeValueWidth.w * 0.8204705,
          sizeValueHeight.h * 0.4150451,
          sizeValueWidth.w * 0.7993382,
          sizeValueHeight.h * 0.4260767,
          sizeValueWidth.w * 0.7777527,
          sizeValueHeight.h * 0.4373398)
      ..cubicTo(
          sizeValueWidth.w * 0.7383063,
          sizeValueHeight.h * 0.4579257,
          sizeValueWidth.w * 0.7037034,
          sizeValueHeight.h * 0.4760317,
          sizeValueWidth.w * 0.7008560,
          sizeValueHeight.h * 0.4775786)
      ..cubicTo(
          sizeValueWidth.w * 0.6944899,
          sizeValueHeight.h * 0.4810365,
          sizeValueWidth.w * 0.6812667,
          sizeValueHeight.h * 0.4879805,
          sizeValueWidth.w * 0.6312309,
          sizeValueHeight.h * 0.5141108)
      ..lineTo(sizeValueWidth.w * 0.6282290, sizeValueHeight.h * 0.5392326)
      ..cubicTo(
          sizeValueWidth.w * 0.6273797,
          sizeValueHeight.h * 0.5462972,
          sizeValueWidth.w * 0.6282213,
          sizeValueHeight.h * 0.5535445,
          sizeValueWidth.w * 0.6306309,
          sizeValueHeight.h * 0.5599160)
      ..cubicTo(
          sizeValueWidth.w * 0.6330406,
          sizeValueHeight.h * 0.5662862,
          sizeValueWidth.w * 0.6368918,
          sizeValueHeight.h * 0.5714482,
          sizeValueWidth.w * 0.6416232,
          sizeValueHeight.h * 0.5746480)
      ..lineTo(sizeValueWidth.w * 0.7245430, sizeValueHeight.h * 0.6307418)
      ..lineTo(sizeValueWidth.w * 0.7415343, sizeValueHeight.h * 0.7668977)
      ..cubicTo(
          sizeValueWidth.w * 0.7140029,
          sizeValueHeight.h * 0.8182436,
          sizeValueWidth.w * 0.6778860,
          sizeValueHeight.h * 0.8600475,
          sizeValueWidth.w * 0.6361353,
          sizeValueHeight.h * 0.8888916)
      ..cubicTo(
          sizeValueWidth.w * 0.5943836,
          sizeValueHeight.h * 0.9177357,
          sizeValueWidth.w * 0.5481826,
          sizeValueHeight.h * 0.9328027,
          sizeValueWidth.w * 0.5013053,
          sizeValueHeight.h * 0.9328624)
      ..cubicTo(
          sizeValueWidth.w * 0.4798473,
          sizeValueHeight.h * 0.9328027,
          sizeValueWidth.w * 0.4584570,
          sizeValueHeight.h * 0.9295956,
          sizeValueWidth.w * 0.4375092,
          sizeValueHeight.h * 0.9232948)
      ..lineTo(sizeValueWidth.w * 0.4516976, sizeValueHeight.h * 0.8657247)
      ..lineTo(sizeValueWidth.w * 0.4964686, sizeValueHeight.h * 0.7142619)
      ..cubicTo(
          sizeValueWidth.w * 0.4979604,
          sizeValueHeight.h * 0.7092046,
          sizeValueWidth.w * 0.4985208,
          sizeValueHeight.h * 0.7037320,
          sizeValueWidth.w * 0.4981024,
          sizeValueHeight.h * 0.6983167)
      ..cubicTo(
          sizeValueWidth.w * 0.4976831,
          sizeValueHeight.h * 0.6929013,
          sizeValueWidth.w * 0.4962966,
          sizeValueHeight.h * 0.6877052,
          sizeValueWidth.w * 0.4940628,
          sizeValueHeight.h * 0.6831766)
      ..lineTo(sizeValueWidth.w * 0.4590638, sizeValueHeight.h * 0.6121108)
      ..cubicTo(
          sizeValueWidth.w * 0.4567981,
          sizeValueHeight.h * 0.6075152,
          sizeValueWidth.w * 0.4537295,
          sizeValueHeight.h * 0.6037467,
          sizeValueWidth.w * 0.4501295,
          sizeValueHeight.h * 0.6011413)
      ..cubicTo(
          sizeValueWidth.w * 0.4465295,
          sizeValueHeight.h * 0.5985347,
          sizeValueWidth.w * 0.4425092,
          sizeValueHeight.h * 0.5971717,
          sizeValueWidth.w * 0.4384271,
          sizeValueHeight.h * 0.5971730)
      ..lineTo(sizeValueWidth.w * 0.3161420, sizeValueHeight.h * 0.5971730)
      ..lineTo(sizeValueWidth.w * 0.2851865, sizeValueHeight.h * 0.5342984)
      ..lineTo(sizeValueWidth.w * 0.3192676, sizeValueHeight.h * 0.4881742)
      ..cubicTo(
          sizeValueWidth.w * 0.2872966,
          sizeValueHeight.h * 0.4714750,
          sizeValueWidth.w * 0.2613556,
          sizeValueHeight.h * 0.4579537,
          sizeValueWidth.w * 0.2527874,
          sizeValueHeight.h * 0.4535323)
      ..cubicTo(
          sizeValueWidth.w * 0.2406908,
          sizeValueHeight.h * 0.4472887,
          sizeValueWidth.w * 0.2032705,
          sizeValueHeight.h * 0.4277418,
          sizeValueWidth.w * 0.1659266,
          sizeValueHeight.h * 0.4081632)
      ..close()
      ..moveTo(sizeValueWidth.w * 0.2373391, sizeValueHeight.h * 0.5582326)
      ..lineTo(sizeValueWidth.w * 0.2041517, sizeValueHeight.h * 0.5432619)
      ..cubicTo(
          sizeValueWidth.w * 0.2058280,
          sizeValueHeight.h * 0.6115664,
          sizeValueWidth.w * 0.2203237,
          sizeValueHeight.h * 0.6781693,
          sizeValueWidth.w * 0.2462734,
          sizeValueHeight.h * 0.7367966)
      ..cubicTo(
          sizeValueWidth.w * 0.2722232,
          sizeValueHeight.h * 0.7954251,
          sizeValueWidth.w * 0.3087729,
          sizeValueHeight.h * 0.8441498,
          sizeValueWidth.w * 0.3524802,
          sizeValueHeight.h * 0.8783800)
      ..lineTo(sizeValueWidth.w * 0.3524802, sizeValueHeight.h * 0.7985859)
      ..lineTo(sizeValueWidth.w * 0.2853353, sizeValueHeight.h * 0.7077150)
      ..cubicTo(
          sizeValueWidth.w * 0.2806841,
          sizeValueHeight.h * 0.7014214,
          sizeValueWidth.w * 0.2780696,
          sizeValueHeight.h * 0.6928843,
          sizeValueWidth.w * 0.2780676,
          sizeValueHeight.h * 0.6839817)
      ..lineTo(sizeValueWidth.w * 0.2780676, sizeValueHeight.h * 0.6409135)
      ..lineTo(sizeValueWidth.w * 0.2373391, sizeValueHeight.h * 0.5582326)
      ..close()
      ..moveTo(sizeValueWidth.w * 0.4886522, sizeValueHeight.h * 0.0005150426)
      ..cubicTo(
          sizeValueWidth.w * 0.4822725,
          sizeValueHeight.h * 0.002646163,
          sizeValueWidth.w * 0.4836135,
          sizeValueHeight.h * 0.001957868,
          sizeValueWidth.w * 0.3755256,
          sizeValueHeight.h * 0.05847467)
      ..cubicTo(
          sizeValueWidth.w * 0.2815749,
          sizeValueHeight.h * 0.1076007,
          sizeValueWidth.w * 0.2780792,
          sizeValueHeight.h * 0.1094329,
          sizeValueWidth.w * 0.2720116,
          sizeValueHeight.h * 0.1127239)
      ..cubicTo(
          sizeValueWidth.w * 0.2691652,
          sizeValueHeight.h * 0.1142670,
          sizeValueWidth.w * 0.2432126,
          sizeValueHeight.h * 0.1278246,
          sizeValueWidth.w * 0.2143391,
          sizeValueHeight.h * 0.1428526)
      ..cubicTo(
          sizeValueWidth.w * 0.1854667,
          sizeValueHeight.h * 0.1578782,
          sizeValueWidth.w * 0.1568522,
          sizeValueHeight.h * 0.1728027,
          sizeValueWidth.w * 0.1507517,
          sizeValueHeight.h * 0.1760171)
      ..cubicTo(
          sizeValueWidth.w * 0.1446522,
          sizeValueHeight.h * 0.1792326,
          sizeValueWidth.w * 0.1097159,
          sizeValueHeight.h * 0.1975286,
          sizeValueWidth.w * 0.07311623,
          sizeValueHeight.h * 0.2166797)
      ..cubicTo(
          sizeValueWidth.w * 0.01176039,
          sizeValueHeight.h * 0.2487808,
          sizeValueWidth.w * 0.006312522,
          sizeValueHeight.h * 0.2520158,
          sizeValueWidth.w * 0.003244068,
          sizeValueHeight.h * 0.2581462)
      ..cubicTo(
          sizeValueWidth.w * -0.001081353,
          sizeValueHeight.h * 0.2667905,
          sizeValueWidth.w * -0.001081353,
          sizeValueHeight.h * 0.2777016,
          sizeValueWidth.w * 0.003244068,
          sizeValueHeight.h * 0.2861937)
      ..cubicTo(
          sizeValueWidth.w * 0.005768338,
          sizeValueHeight.h * 0.2911474,
          sizeValueWidth.w * 0.009781739,
          sizeValueHeight.h * 0.2944933,
          sizeValueWidth.w * 0.01988029,
          sizeValueHeight.h * 0.3000572)
      ..lineTo(sizeValueWidth.w * 0.03318918, sizeValueHeight.h * 0.3073898)
      ..lineTo(sizeValueWidth.w * 0.03395082, sizeValueHeight.h * 0.5650353)
      ..lineTo(sizeValueWidth.w * 0.02877362, sizeValueHeight.h * 0.5837893)
      ..cubicTo(
          sizeValueWidth.w * 0.02101005,
          sizeValueHeight.h * 0.6119111,
          sizeValueWidth.w * 0.01618338,
          sizeValueHeight.h * 0.6351596,
          sizeValueWidth.w * 0.01618338,
          sizeValueHeight.h * 0.6444324)
      ..cubicTo(
          sizeValueWidth.w * 0.01618338,
          sizeValueHeight.h * 0.6559610,
          sizeValueWidth.w * 0.02234986,
          sizeValueHeight.h * 0.6718697,
          sizeValueWidth.w * 0.02938145,
          sizeValueHeight.h * 0.6784823)
      ..cubicTo(
          sizeValueWidth.w * 0.04158280,
          sizeValueHeight.h * 0.6899562,
          sizeValueWidth.w * 0.05976135,
          sizeValueHeight.h * 0.6869160,
          sizeValueWidth.w * 0.06988647,
          sizeValueHeight.h * 0.6717077)
      ..cubicTo(
          sizeValueWidth.w * 0.08086493,
          sizeValueHeight.h * 0.6552156,
          sizeValueWidth.w * 0.08068908,
          sizeValueHeight.h * 0.6438197,
          sizeValueWidth.w * 0.06872280,
          sizeValueHeight.h * 0.5963922)
      ..lineTo(sizeValueWidth.w * 0.06054667, sizeValueHeight.h * 0.5639890)
      ..lineTo(sizeValueWidth.w * 0.06054667, sizeValueHeight.h * 0.4431937)
      ..cubicTo(
          sizeValueWidth.w * 0.06054667,
          sizeValueHeight.h * 0.3767540,
          sizeValueWidth.w * 0.06104638,
          sizeValueHeight.h * 0.3223959,
          sizeValueWidth.w * 0.06165565,
          sizeValueHeight.h * 0.3223983)
      ..cubicTo(
          sizeValueWidth.w * 0.06305903,
          sizeValueHeight.h * 0.3223983,
          sizeValueWidth.w * 0.06410444,
          sizeValueHeight.h * 0.3229379,
          sizeValueWidth.w * 0.1537092,
          sizeValueHeight.h * 0.3699537)
      ..cubicTo(
          sizeValueWidth.w * 0.1947826,
          sizeValueHeight.h * 0.3915055,
          sizeValueWidth.w * 0.2393671,
          sizeValueHeight.h * 0.4148027,
          sizeValueWidth.w * 0.2527874,
          sizeValueHeight.h * 0.4217296)
      ..cubicTo(
          sizeValueWidth.w * 0.2662077,
          sizeValueHeight.h * 0.4286553,
          sizeValueWidth.w * 0.3222512,
          sizeValueHeight.h * 0.4579050,
          sizeValueWidth.w * 0.3773285,
          sizeValueHeight.h * 0.4867296)
      ..cubicTo(
          sizeValueWidth.w * 0.4324068,
          sizeValueHeight.h * 0.5155554,
          sizeValueWidth.w * 0.4812908,
          sizeValueHeight.h * 0.5404884,
          sizeValueWidth.w * 0.4859594,
          sizeValueHeight.h * 0.5421401)
      ..cubicTo(
          sizeValueWidth.w * 0.5013826,
          sizeValueHeight.h * 0.5475907,
          sizeValueWidth.w * 0.5114251,
          sizeValueHeight.h * 0.5452083,
          sizeValueWidth.w * 0.5426271,
          sizeValueHeight.h * 0.5286931)
      ..cubicTo(
          sizeValueWidth.w * 0.5519807,
          sizeValueHeight.h * 0.5237430,
          sizeValueWidth.w * 0.5842551,
          sizeValueHeight.h * 0.5068368,
          sizeValueWidth.w * 0.6143478,
          sizeValueHeight.h * 0.4911242)
      ..cubicTo(
          sizeValueWidth.w * 0.6784357,
          sizeValueHeight.h * 0.4576638,
          sizeValueWidth.w * 0.6938261,
          sizeValueHeight.h * 0.4495956,
          sizeValueWidth.w * 0.7008560,
          sizeValueHeight.h * 0.4457771)
      ..cubicTo(
          sizeValueWidth.w * 0.7037034,
          sizeValueHeight.h * 0.4442290,
          sizeValueWidth.w * 0.7383063,
          sizeValueHeight.h * 0.4261230,
          sizeValueWidth.w * 0.7777527,
          sizeValueHeight.h * 0.4055384)
      ..cubicTo(
          sizeValueWidth.w * 0.8171990,
          sizeValueHeight.h * 0.3849549,
          sizeValueWidth.w * 0.8551295,
          sizeValueHeight.h * 0.3651449,
          sizeValueWidth.w * 0.8620425,
          sizeValueHeight.h * 0.3615164)
      ..cubicTo(
          sizeValueWidth.w * 0.8689565,
          sizeValueHeight.h * 0.3578904,
          sizeValueWidth.w * 0.9008976,
          sizeValueHeight.h * 0.3411949,
          sizeValueWidth.w * 0.9330242,
          sizeValueHeight.h * 0.3244166)
      ..cubicTo(
          sizeValueWidth.w * 0.9651507,
          sizeValueHeight.h * 0.3076395,
          sizeValueWidth.w * 0.9929372,
          sizeValueHeight.h * 0.2920353,
          sizeValueWidth.w * 0.9947633,
          sizeValueHeight.h * 0.2897418)
      ..cubicTo(
          sizeValueWidth.w * 1.001749,
          sizeValueHeight.h * 0.2809939,
          sizeValueWidth.w * 1.001749,
          sizeValueHeight.h * 0.2635396,
          sizeValueWidth.w * 0.9947633,
          sizeValueHeight.h * 0.2546334)
      ..cubicTo(
          sizeValueWidth.w * 0.9929179,
          sizeValueHeight.h * 0.2522935,
          sizeValueWidth.w * 0.9851014,
          sizeValueHeight.h * 0.2471352,
          sizeValueWidth.w * 0.9773816,
          sizeValueHeight.h * 0.2431681)
      ..cubicTo(
          sizeValueWidth.w * 0.9696618,
          sizeValueHeight.h * 0.2392022,
          sizeValueWidth.w * 0.9610097,
          sizeValueHeight.h * 0.2346687,
          sizeValueWidth.w * 0.9581633,
          sizeValueHeight.h * 0.2330974)
      ..cubicTo(
          sizeValueWidth.w * 0.9553169,
          sizeValueHeight.h * 0.2315250,
          sizeValueWidth.w * 0.9193826,
          sizeValueHeight.h * 0.2126797,
          sizeValueWidth.w * 0.8783092,
          sizeValueHeight.h * 0.1912180)
      ..cubicTo(
          sizeValueWidth.w * 0.8372367,
          sizeValueHeight.h * 0.1697564,
          sizeValueWidth.w * 0.7703585,
          sizeValueHeight.h * 0.1347978,
          sizeValueWidth.w * 0.7296928,
          sizeValueHeight.h * 0.1135306)
      ..cubicTo(
          sizeValueWidth.w * 0.6890261,
          sizeValueHeight.h * 0.09226358,
          sizeValueWidth.w * 0.6517614,
          sizeValueHeight.h * 0.07282058,
          sizeValueWidth.w * 0.6468812,
          sizeValueHeight.h * 0.07032424)
      ..cubicTo(
          sizeValueWidth.w * 0.6374010,
          sizeValueHeight.h * 0.06547600,
          sizeValueWidth.w * 0.6290705,
          sizeValueHeight.h * 0.06112558,
          sizeValueWidth.w * 0.5590213,
          sizeValueHeight.h * 0.02444896)
      ..cubicTo(
          sizeValueWidth.w * 0.5181498,
          sizeValueHeight.h * 0.003047503,
          sizeValueWidth.w * 0.5130213,
          sizeValueHeight.h * 0.0008361133,
          sizeValueWidth.w * 0.5028280,
          sizeValueHeight.h * 0.0002140341)
      ..cubicTo(
          sizeValueWidth.w * 0.4966580,
          sizeValueHeight.h * -0.0001632253,
          sizeValueWidth.w * 0.4902792,
          sizeValueHeight.h * -0.00002877345,
          sizeValueWidth.w * 0.4886522,
          sizeValueHeight.h * 0.0005150426)
      ..close();
  }
}
