



List<Res> resList = [
  new Res(
      img: 'assets/images/br.jpg',
      name: 'Resto Cafe',
      rating: 4,
      pri: '400 FOR TWO'
      ),
  new Res(
    img: 'assets/images/ce.jpg',
    name: 'WN Restaurant',
    rating: 5,
      pri: '500 FOR TWO'
  ),

  new Res(
    img: 'assets/images/ab.jpg',
    name: 'Ali Baba',
    rating: 5,
    pri: '450 FOR TWO'
  ),
];

class Res {
  String img;
  String name;
  int rating;
  String pri;
  Res({this.img, this.name,  this.rating, this.pri});
}



