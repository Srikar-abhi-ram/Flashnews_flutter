import 'package:flashnews/helper/data.dart';
import 'package:flashnews/models/ArticleModel.dart';
import 'package:flashnews/models/categorymodel.dart';
import 'package:flashnews/use/article.dart';
import 'package:flashnews/helper/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'category_news.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories =new List<CategoryModel>();
  List<ArticleModel> articles =new List<ArticleModel>();
  bool _loading =true;
  @override
  void initState() {
    super.initState();
    categories =getCategories();
    getNews();
  }
getNews() async{
    News newsClass =News();
    await newsClass.getNews();
    articles=newsClass.news;
    setState(() {
      _loading =false;
    });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flash",style: TextStyle(color:Colors.red[900]),),
            Text("News",style: TextStyle(color:Colors.black87),),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading ?Center(
        child: Container(
          child:CircularProgressIndicator(),
        ),
      ):SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:Column(
            children: <Widget>[
              ///Categories
              Container(
                height: 70,
                child:ListView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context , index){
                return CategoryTIle(
                  imageUrl: categories[index].imageUrl,
                  categoryName: categories[index].categoryName,

                );
              }),
              ),
              /// blogs\
               Container(
                 padding: EdgeInsets.only(top:16),
                 margin: EdgeInsets.only(top: 16),
                   child: ListView.builder(
                     itemCount: articles.length,
                       shrinkWrap: true,
                       physics: ClampingScrollPhysics(),
                       scrollDirection: Axis.vertical,
                       itemBuilder: (context , index){
                       return BlogTile(
                         imageUrl: articles[index].urlToImage,
                         title: articles[index].title,
                         desc: articles[index].description,
                       );
                       }),
                 ),
            ],
          )
        ),
      ),
    );
  }
}

class CategoryTIle extends StatelessWidget {
  final String imageUrl,categoryName;
  CategoryTIle({this.imageUrl,this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder:(context) => CategoryNews(
              newsCategory: categoryName.toLowerCase(),
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius:BorderRadius.circular(20),
                child: CachedNetworkImage(
                   imageUrl: imageUrl,width: 120,height: 500,fit:BoxFit.cover)),
            Container(
              alignment: Alignment.center,
                color: Colors.black26,
                width: 120,height: 500,
              child: Text(categoryName,style: TextStyle(
                color:Colors.white,
                fontWeight: FontWeight.bold,
              ),),
            )
          ],
        ) ,
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl ,title ,desc;
  BlogTile({@required this.imageUrl,this.title,this.desc});
  @override
  Widget build(BuildContext context) {
    return  Container(
        margin:EdgeInsets.only(bottom:18),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
                child: Image.network((imageUrl))),
            SizedBox(height: 8),
            Text(title , style:TextStyle(
              fontSize: 20,
              color:Colors.black87,
              fontWeight:FontWeight.bold,
            )),
            SizedBox(height: 8),
            Text(desc,style:TextStyle(
              color:Colors.black54,
            )),
          ],
        ),
      );
  }
}
