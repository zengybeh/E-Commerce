import 'package:flutter/material.dart';
import 'package:e_commerce1/models/cart.dart';
import 'package:e_commerce1/size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: dummyCarts.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(dummyCarts[index].product.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                dummyCarts.removeAt(index);
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                ],
              ),
            ),
            child: CartCard(cart: dummyCarts[index]),
          ),
        ),
      ),
    );
  }
}
