import 'package:flashnews/helper/news.dart';
import 'package:flashnews/models/ArticleModel.dart';
import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {

  final String newsCategory;

  CategoryNews({this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();


}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  @override
  void initState() {
    getNews();
    // TODO: implement initState
    super.initState();
  }

  void getNews() async {
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(widget.newsCategory);
    articles = news.news;
    setState(() {
      _loading = false;
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
      ): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:Column(
            children: <Widget>[
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
          ),
        ),
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