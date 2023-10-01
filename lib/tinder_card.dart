import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinder/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TinderCard extends StatefulWidget {
  const TinderCard({super.key, required this.user});

  final User user;

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  Widget buildName() {
    return Row(children: [
      Text(widget.user.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          )),
      Text(" ${widget.user.age}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
          ))
    ]);
  }

  Widget buildStatus() {
    return Row(children: [
      Container(
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        width: 12,
        height: 12,
      ),
      const SizedBox(width: 8),
      const Text("Online",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AppinioSwiper(
      swipeOptions: const AppinioSwipeOptions.only(
        left: true,
        right: true,
        top: true,
      ),
      cardsCount: 20,
      onSwiping: (AppinioSwiperDirection direction) {
        print(direction.toString());

        switch (direction) {
          case AppinioSwiperDirection.left:
            Fluttertoast.showToast(msg: "left", fontSize: 36);
            break;
          case AppinioSwiperDirection.right:
            Fluttertoast.showToast(msg: "right", fontSize: 36);
            break;
          case AppinioSwiperDirection.top:
            break;

          case AppinioSwiperDirection.none:
          case AppinioSwiperDirection.bottom:
            break;
        }
      },
      cardsBuilder: (BuildContext context, int index) {
        print(index);
        return buildCard(index);
      },
    ));
  }

  Widget buildCard(int cardNumber) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
            widget.user.urlImage + cardNumber.toString(),
          ),
          fit: BoxFit.cover,
        )),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.7, 1])),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Spacer(),
              buildName(),
              const SizedBox(
                height: 8,
              ),
              buildStatus()
            ]),
          ),
        ),
      ),
    );
  }
}
