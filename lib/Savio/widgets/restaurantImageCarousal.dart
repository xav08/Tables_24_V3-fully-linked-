import 'package:flutter/material.dart';

class RestaurantImageCarousal extends StatelessWidget {
  List images;
  RestaurantImageCarousal(List this.images);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                      images[index],
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
          );
        }

    );
  }
}
