import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final dummyItems = [
  'http://61.82.70.6/images2022/2022082504OLC-KD220870-F.JPG',
  'http://61.82.70.6/images2022/2022082505OLC-KD220335-F.JPG',
  'http://61.82.70.6/images2022/2022082502OLC-KD220675-F.JPG',
  'http://61.82.70.6/images2022/2022082504OLC-KD220629-F.JPG',
  'http://61.82.70.6/images2022/2022082506SEGA-KD220658-F.jpg',
];

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // !!중요!! Column 을 ListView로 변경하면 상하 스크롤이 생김.(화면이 초과되어도 픽셀오류(공사중)가 발생하지 않고 스크롤로 화면을 이동할 수 있음)
      children: [
        _buildTop(),
        _buildMiddle(),
        _buildBottom(),
      ],
    );
  }

  _buildTop() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  print('클릭');
                },
                child: Column(
                  children: const [
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                    Text('택시'),
                  ],
                ),
              ),
              Column(
                children: const [
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                  Text('블랙'),
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                  Text('바이크'),
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                  Text('대리'),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                  Text('택시'),
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                  Text('블랙'),
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                  Text('바이크'),
                ],
              ),
              Opacity(
                opacity: 0.0,
                child: Column(
                  children: const [
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                    Text('대리'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //-- 중간 슬라이드 구성.
  _buildMiddle() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250.0, // 높이 400
        autoPlay: true, //이미지 자동 전환.
      ),
      // items: [1, 2, 3, 4, 5].map((i) {
      items: dummyItems.map((url) {
        return Builder(
          builder: (BuildContext context) {
            //context 를 사용하고자 할때
            return Container(
              width: MediaQuery.of(context).size.width, //기기의 가로 길이
              margin: const EdgeInsets.symmetric(horizontal: 5.0), //좌우 여백5
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  _buildBottom() {
    return const Text('Bottom');
  }
}
