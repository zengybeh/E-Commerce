
import 'package:flutter/material.dart';
import '../../../widgets/extensions.dart';
import '../../../widgets/titletext.dart';
import '../../../model/product.dart';


class ProductDetailPage extends StatefulWidget {

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = true;
  Widget _appBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          _icon(isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Color(0xffF72804) : Color(0xffE1E2E4),
              size: 15,
              padding: 12,
              isOutLine: false, onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              }),
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {
        Color color = const Color(0xffa8a09b),
        double size = 20,
        double padding = 10,
        bool isOutLine = false,
        required Function onPressed,}) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: Color(0xffa8a09b),
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
        isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Container(
        alignment: Alignment.topCenter,
        child: Image.network('https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/skwgyqrbfzhu6uyeh0gg/air-max-270-mens-shoes-KkLcGR.png',
        width: 1000,
        height: 220,)
      ),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10).copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Color(0xffa8a09b),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TitleText(text: "NIKE AIR MAX 200", fontSize: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: "\$ ",
                                fontSize: 18,
                                color: Color(0xffF72804),
                              ),
                              TitleText(
                                text: "240",
                                fontSize: 25,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.star,
                                  color: Color(0xfffbba01), size: 17),
                              Icon(Icons.star,
                                  color: Color(0xfffbba01), size: 17),
                              Icon(Icons.star,
                                  color: Color(0xfffbba01), size: 17),
                              Icon(Icons.star,
                                  color: Color(0xfffbba01), size: 17),
                              Icon(Icons.star_border, size: 17),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _availableSize(),
                SizedBox(
                  height: 20,
                ),
                _availableColor(),
                SizedBox(
                  height: 20,
                ),
                _description(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _availableSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Available Size",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _sizeWidget("US 6"),
            _sizeWidget("US 7", isSelected: true),
            _sizeWidget("US 8"),
            _sizeWidget("US 9"),
          ],
        )
      ],
    );
  }

  Widget _sizeWidget(String text, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: Color(0xffa8a09b),
            style: !isSelected ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
        isSelected ? Color(0xffE65829) : Theme.of(context).backgroundColor,
      ),
      child: TitleText(
        text: text,
        fontSize: 16,
        color: isSelected ? Color(0XFFFFFFFF) : const Color(0xff1d2635),
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _availableColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Available Color",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _colorWidget(Color(0xfffbba01), isSelected: true),
            SizedBox(
              width: 30,
            ),
            _colorWidget(Color(0xff5F5F60)),
            SizedBox(
              width: 30,
            ),
            _colorWidget(Color(0xff20262C)),
            SizedBox(
              width: 30,
            ),
            _colorWidget(Color(0xffF72804)),
            SizedBox(
              width: 30,
            ),
            _colorWidget(Color(0xff2890c8)),
          ],
        )
      ],
    );
  }

  Widget _colorWidget(Color color, {bool isSelected = false}) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: color.withAlpha(150),
      child: isSelected
          ? Icon(
        Icons.check_circle,
        color: color,
        size: 18,
      )
          : CircleAvatar(radius: 7, backgroundColor: color),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Description",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Text(AppData.description),
      ],
    );
  }

  FloatingActionButton _flotingButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Color(0xff0088ff),
      child: Icon(Icons.shopping_basket,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _flotingButton(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }
}