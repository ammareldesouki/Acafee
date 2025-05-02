class Item {
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final bool isOffer;
  final String offerDescription;

  Item({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    this.isOffer = false,
    this.offerDescription = '',
  });
}
