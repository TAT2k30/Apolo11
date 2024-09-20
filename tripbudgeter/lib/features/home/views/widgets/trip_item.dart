import 'package:flutter/material.dart';
import 'package:tripbudgeter/features/home/views/pages/gallerypage.dart';
import 'package:tripbudgeter/features/home/views/pages/homepage.dart';

var viewallstyle =
    TextStyle(fontSize: 14, color: appTheme.primaryColor //Colors.teal
        );
Widget homeDown2(BuildContext context, String as) {
  final filteredCities = cities.where((city) => city.status == as).toList();

  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              as == "fails"
                  ? "The trips have not yet been made"
                  : "Trips have been made",
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GalleryPage(
                      status: as,
                    ), // Điều hướng đến trang HomeScreen
                  ),
                );
              },
              child: Text("VIEW ALL", style: viewallstyle),
            ),
          ],
        ),
      ),
      SizedBox(
        height: height! * .25 < 170 ? height! * .25 : 170,
        child: ListView.builder(
          itemBuilder: (context, index) => filteredCities[index],
          shrinkWrap: true,
          padding: const EdgeInsets.all(0.0),
          itemCount: filteredCities.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    ],
  );
}

Widget galleryPage(String as) {
  final filteredCities = galleries.where((city) => city.status == as).toList();

  return Column(
    children: <Widget>[
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
      SizedBox(
        height: 800.0, // Chiều cao cố định cho GridView
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 0.0,
          ),
          itemCount: filteredCities.length,
          itemBuilder: (context, index) {
            final galleryItem = filteredCities[index];
            return Gallery(
              image: galleryItem.image,
              name: galleryItem.name,
              monthyear: galleryItem.monthyear,
              oldprice: galleryItem.oldprice,
              newprice: galleryItem.newprice,
              status: galleryItem.status,
            );
          },
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.vertical,
        ),
      ),
    ],
  );
}

List<City> cities = [
  const City(
    image: "assets/images/Kerman.png",
    name: "Da Lat",
    monthyear: "17/11/2003",
    oldprice: "5000", //dự tính
    newprice: "6000", //phát sinh
    status: "success",
  ),
  const City(
    image: "assets/images/Mashhad.png",
    name: "Mashhad",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    status: "fails",
  ),
  const City(
    image: "assets/images/Tehran.png",
    name: "Tehran",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    status: "fails",
  ),
  const City(
    image: "assets/images/Tehran.png",
    name: "Hamadan",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    status: "fails",
  ),
  const City(
    image: "assets/images/Tehran.png",
    name: "Rasht",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    status: "fails",
  ),
  const City(
    image: "assets/images/Tehran.png",
    name: "Bandar Abbas",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    status: "success",
  ),
];

class City extends StatelessWidget {
  final String? image, monthyear, oldprice;
  final String? name, status, newprice;

  const City(
      {super.key,
      this.image,
      this.monthyear,
      this.oldprice,
      this.name,
      this.status,
      this.newprice});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: height! * .137 < 160 ? height! * .137 : 160,
                    width: width! * .5 < 250 ? width! * .5 : 250,
                    //   child: Image.asset(image,fit: BoxFit.cover,)
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(image!), fit: BoxFit.fill)),
                  ),
                ),
                Positioned(
                  height: 60,
                  width: width! * .5 < 250 ? width! * .5 : 250,
                  left: 5,
                  //right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.black12],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  right: 15,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        //decoration: BoxDecoration(
                        //   shape: BoxShape.rectangle,
                        //   color: Colors.black.withOpacity(.4),
                        //  borderRadius: BorderRadius.all(Radius.circular(10))
                        // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 100.0,
                              child: Text(
                                name!,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              monthyear!,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HomeScreen()), // Điều hướng đến trang mới
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Text(
                            "Details",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "\$ $newprice",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              width: width! * 0.08,
            ),
            Text(
              "\$ $oldprice",
              style: TextStyle(
                color: int.parse(oldprice!) > int.parse(newprice!)
                    ? Colors.red
                    : Colors.blue, // Thay đổi màu sắc dựa trên điều kiện
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        )
      ],
    );
  }
}

List<Gallery> galleries = [
  const Gallery(
    image: "assets/images/Kerman.png",
    name: "Da Lat",
    monthyear: "17/11/2003",
    oldprice: "5000", //dự tính
    newprice: "6000", //phát sinh
    status: "success",
  ),
  const Gallery(
    image: "assets/images/Mashhad.png",
    name: "Mashhad",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    status: "fails",
  ),
  const Gallery(
    image: "assets/images/Tehran.png",
    name: "Tehran",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    status: "fails",
  ),
  const Gallery(
    image: "assets/images/Tehran.png",
    name: "Hamadan",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    status: "fails",
  ),
  const Gallery(
    image: "assets/images/Tehran.png",
    name: "Rasht",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    status: "fails",
  ),
  const Gallery(
    image: "assets/images/Tehran.png",
    name: "Bandar Abbas",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    status: "success",
  ),
];

Color _getPriceColor(String? oldprice, String? newprice) {
  try {
    final oldPriceValue = int.parse(oldprice ?? '0');
    final newPriceValue = int.parse(newprice ?? '0');
    return oldPriceValue > newPriceValue ? Colors.red : Colors.blue;
  } catch (e) {
    return Colors.black; // Trả về màu mặc định nếu có lỗi khi chuyển đổi
  }
}

class Gallery extends StatelessWidget {
  final String? image, monthyear, oldprice;
  final String? name, status, newprice;

  const Gallery(
      {super.key,
      this.image,
      this.monthyear,
      this.oldprice,
      this.name,
      this.status,
      this.newprice});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  height: 185,
                  width: width! * .5 < 250 ? width! * .5 : 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                height: 60,
                width: width! * .5 < 250 ? width! * .5 : 250,
                left: 5,
                //right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.black12],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                right: 15,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 90.0,
                            child: Text(
                              name!,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          Text(
                            monthyear!,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          SizedBox(
                            child: Text(
                              "\$ $oldprice",
                              style: TextStyle(
                                color: _getPriceColor(oldprice, newprice),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
