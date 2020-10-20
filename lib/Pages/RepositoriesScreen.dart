import 'package:flutter/material.dart';
import 'package:git_repo/Pages/InfoScreen.dart';
import 'package:git_repo/Providers/repoprovider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RepositoriesScreen extends StatefulWidget {
  final String username;
  RepositoriesScreen(this.username);
  @override
  _RepositoriesScreenState createState() => _RepositoriesScreenState();
}

class _RepositoriesScreenState extends State<RepositoriesScreen> {
  var _init = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<RepoProvider>(context)
          .getRepositoriesList(widget.username)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    final repoData = Provider.of<RepoProvider>(context);
    final dateF = new DateFormat.yMMMMd("en_US");
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(widget.username),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: repoData.repoList.length,
              itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => InfoScreen(
                          repoData.repoList[index].repo_name,
                          repoData.repoList[index].url)));
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffd9d9d9), width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: 40,
                          width: double.infinity,
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  repoData.repoList[index].repo_name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Created :',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              dateF.format(DateTime.parse(
                                  repoData.repoList[index].created_date)),
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      repoData.repoList[index].description == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Description :',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Container(
                                      width: 150,
                                      child: Text(
                                        repoData.repoList[index].description,
                                        style: TextStyle(color: Colors.black),
                                      ))
                                ],
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Last Pushed : ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              dateF.format(DateTime.parse(
                                  repoData.repoList[index].last_pushed)),
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Branch : ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              repoData.repoList[index].branch,
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                          height: 40,
                          width: double.infinity,
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Stars: ${repoData.repoList[index].stars.toString()}',
                                  style: TextStyle(
                                      color: Colors.yellow[900],
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  repoData.repoList[index].language == ""
                                      ? "Unknown"
                                      : repoData.repoList[index].language,
                                  style: TextStyle(
                                      color: Colors.yellow[900],
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                      //  Text('${url}')
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
