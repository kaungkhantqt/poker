class Poker {
  final int cardsName;
  final String imgUrl;

  Poker({required this.cardsName, required this.imgUrl});
}

String imageUrl(String name) => 'images/$name';

final questions = [
  Poker(cardsName: 1, imgUrl: imageUrl('ace.jpg')),
  Poker(cardsName: 2, imgUrl: imageUrl('two.jpg')),
  Poker(cardsName: 3, imgUrl: imageUrl('three.jpg')),
  Poker(cardsName: 4, imgUrl: imageUrl('four.jpg')),
  Poker(cardsName: 5, imgUrl: imageUrl('five.jpg')),
  Poker(cardsName: 6, imgUrl: imageUrl('six.jpg')),
  Poker(cardsName: 7, imgUrl: imageUrl('seven.jpg')),
  Poker(cardsName: 8, imgUrl: imageUrl('eight.jpg')),
  Poker(cardsName: 9, imgUrl: imageUrl('nine.jpg')),
  Poker(cardsName: 10, imgUrl: imageUrl('ten.jpg')),
  Poker(cardsName: 11, imgUrl: imageUrl('jack.jpg')),
  Poker(cardsName: 12, imgUrl: imageUrl('queen.jpg')),
  Poker(cardsName: 13, imgUrl: imageUrl('king.jpg')),
];
