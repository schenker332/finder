class Foodcard{
  final String title;
  final String imageURL;
  final String price;
  final String foodart;
  final String description;
  final String time;
  final String waterneed;


  const Foodcard({required this.time, required this.waterneed, required  this.title,required this.imageURL, required this.price, required this.foodart, required this.description});

}

  List<Foodcard> allcards = [
    Foodcard(
      title: "Nudeln mit Walnüssen",
      imageURL: "https://media.istockphoto.com/id/1680097339/de/foto/rigatoni-nudeln-in-basilikum-pesto-w%C3%BCrzige-italienische-pasta.jpg?s=1024x1024&w=is&k=20&c=4h6c_m9Tv54mMwExNJ4XhzQUBnzglXhIUUnLa8BH8Og=",
      price: "€€",
      foodart: "Vegan",
      description: "Der frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum",
      time: "",
      waterneed: ""

    ),
    Foodcard(
        title: "Reis mit Hähnchen",
        imageURL: "https://images.unsplash.com/photo-1610057098265-05f2bcbedd55?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        price: "€€",
        foodart: "fleich",
        description: "Der frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum",
        time: "",
        waterneed: ""
    ),
    Foodcard(
        title: "Pizza mit hackfleisch",
        imageURL: "https://images.unsplash.com/photo-1620374230612-265d5045c85b?q=80&w=1771&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        price: "€€",
        foodart: "fleich",
        description: "Der frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum",
        time: "",
        waterneed: ""
    ),
    Foodcard(
        title: "Lammburger",
        imageURL: "https://media.istockphoto.com/id/1500141300/de/foto/bbq-classic-burger-gegen-feurige-flammen-lebendiges-essen-schwarzer-hintergrund.jpg?s=1024x1024&w=is&k=20&c=j3dsTSu_A8thbND_DdEdPFlPzrxrpngR7itW2xqN2JM=",
        price: "7 Euro",
        foodart: "fleich",
        description: "Der frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum",
        time: "40 min",
        waterneed: "1 l"
    ),
    Foodcard(
        title: "Pancakes",
        imageURL: "https://media.istockphoto.com/id/1161996776/de/foto/stapel-pfannkuchen-mit-ahornsirup-und-frischen-heidelbeeren.jpg?s=1024x1024&w=is&k=20&c=H2TGi_4OrxR-xBX4Ny8vxN-e7onr8Ccf3Wq5CjzJlpY=",
        price: "€",
        foodart: "Vegan",
        description: "Der frische und gesunde Klassiker für den schnellen Genuss lorem impsum lorem ipsum",
        time: "",
        waterneed: ""
    ),



  ];