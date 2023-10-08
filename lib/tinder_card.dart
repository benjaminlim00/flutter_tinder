import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinder/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Status { like, dislike, superLike }

class TinderCard extends StatefulWidget {
  const TinderCard({super.key, required this.user});

  final User user;

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  like() {
    Fluttertoast.showToast(msg: "like", fontSize: 36);
  }

  dislike() {
    Fluttertoast.showToast(msg: "dislike", fontSize: 36);
  }

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

// the opacity of the stamp is affected by the swipe distance from center
// we use a max function of dx and dy
  double getStatusOpacity(double dx, double dy) {
    return 1 - (dx.abs() + dy.abs()).clamp(0.0, 1.0);
  }

// TODO:
// we need to use this when card is halfway through the swipe
// add Positioned parent widget
// add Opacity parent widget
  Widget stampBuilder(Status status) {
    switch (status) {
      case Status.like:
        return statusStamp(angle: -0.5, text: "LIKE", color: Colors.green);
      case Status.dislike:
        return statusStamp(angle: -0.5, text: "DISLIKE", color: Colors.red);
      default:
        return Container();
    }
  }

  Widget statusStamp(
      {required String text, required Color color, required double angle}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 4),
      ),
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          )),
    );
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
            dislike();
            break;
          case AppinioSwiperDirection.right:
            like();
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
