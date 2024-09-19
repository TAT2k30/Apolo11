import 'package:tripbudgeter/features/trips/models/trip_model.dart';

class TripData {
  static final myTrip = TripModel(
      name: "Trip to Da Lat",
      location: "Da Lat, Vietnam",
      url:
          "https://sakos.vn/wp-content/uploads/2023/04/da-lat-noi-cat-giu-nhung-buc-anh-song-ao-dep-nhat-3.jpg",
      description:
          "Paris is the capital and most populous city of France, with an estimated population of 2,148,271 residents as of 2020, in an area of more than 105 square kilometres. Since the 17th century, Paris has been one of Europe's major centres of finance, diplomacy, commerce, fashion, science and arts.",
      totalBudget: 2000,
      startDate: DateTime.parse('2024-08-01'),
      endDate: DateTime.parse('2021-08-10'));
}