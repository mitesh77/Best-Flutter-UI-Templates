class PopularFilterListData {
  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<PopularFilterListData> popularFList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: 'Free Breakfast',
    ),
    PopularFilterListData(
      titleTxt: 'Free Parking',
    ),
    PopularFilterListData(
      titleTxt: 'Pool',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Pet Friendly',
    ),
    PopularFilterListData(
      titleTxt: 'Free wifi',
    ),
  ];

  static List<PopularFilterListData> accomodationList = [
    PopularFilterListData(
      titleTxt: 'All',
    ),
    PopularFilterListData(
      titleTxt: 'Apartment',
    ),
    PopularFilterListData(
      titleTxt: 'Home',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Villa',
    ),
    PopularFilterListData(
      titleTxt: 'Hotel',
    ),
    PopularFilterListData(
      titleTxt: 'Resort',
    ),
  ];
}
