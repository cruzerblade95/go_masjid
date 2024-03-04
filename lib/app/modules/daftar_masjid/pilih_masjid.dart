import 'dart:convert';
import 'package:go_masjid/app/modules/daftar_app/components/my_button.dart';
import 'package:go_masjid/app/modules/home_dashboard/dashboard_page.dart';
// import 'package:go_masjid/app/modules/home/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:go_masjid/app/modules/daftar_app/register_app/register_page.dart';
import 'package:get_storage/get_storage.dart';

class DaftarMasjidPage extends StatefulWidget {
  const DaftarMasjidPage({super.key});

  @override
  State<DaftarMasjidPage> createState() => _DaftarMasjidPageState();
}

class _DaftarMasjidPageState extends State<DaftarMasjidPage> {

  final box = GetStorage();

  void _homepage() {
    box.write('negeri', _myNegeri);
    box.write('daerah', _myDaerah);
    box.write('poskod', _myZip);
    box.write('kodMasjid', _myMasjid);

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  //CALLING STATE API HERE
  // Get Negeri information by API
  List? negeriList;
  String? _myNegeri;

  String stateInfoUrl = 'https://api.gomasjid.my/api/utama?cara=getNegeri';
  Future<String?> _getStateList() async {
    await http.post(Uri.parse(stateInfoUrl), headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
    }).then((response) {
      var data = json.decode(response.body);

      setState(() {
        negeriList = data['negeri'];
      });
    });
    return null;
  }

  // Get Daerah information by API
  List? daerahList;
  String? _myDaerah;

  Future<String?> _getDaerahList(String? myNegeri) async {
  String zipInfoUrl = 'https://api.gomasjid.my/api/utama?cara=getDaerah&idNegeri=${myNegeri}';
  print(zipInfoUrl);
    await http.post(Uri.parse(zipInfoUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          // "api_key": '25d55ad283aa400af464c76d713c07ad',
          // "state_id": _myDaerah,
        }).then((response) {
      var data = json.decode(response.body);

      setState(() {
        daerahList = data['daerah'];
      });
    });
    return null;
  }

  // Get Daerah information by API
  List? poskodList;
  String? _myZip;

  Future<String?> _getPoskodList(String? myDaerah) async {
    String zipInfoUrl = 'https://api.gomasjid.my/api/utama?cara=getPoskod&idDaerah=${myDaerah}';
    await http.post(Uri.parse(zipInfoUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          // "api_key": '25d55ad283aa400af464c76d713c07ad',
          // "state_id": _myZip,
        }).then((response) {
      var data = json.decode(response.body);

      setState(() {
        poskodList = data['poskod'];
      });
    });
    return null;
  }

  @override
  void initState() {
    _getStateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25),

                const Text(
                  'Select',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),

                const Text(
                  'Mosque',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontSize: 40,
                  ),
                ),

                Text(
                  'Please choose your information',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: _myNegeri,
                              iconSize: 30,
                              icon: (null),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              hint: Text('Select Negeri'),
                              onChanged: (newValue) {
                                setState(() {
                                  _myNegeri = newValue!;
                                  _myDaerah = null;
                                  _myZip = null;
                                  _myMasjid = null;
                                  _getDaerahList(_myNegeri);
                                  print(_myNegeri);
                                });
                              },
                              items: negeriList?.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item['name']),
                                  value: item['id_negeri'].toString(),
                                );
                              }).toList() ??
                                  [],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: _myDaerah,
                              iconSize: 30,
                              icon: (null),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              hint: Text('Select Daerah'),
                              onChanged: (newValue) {
                                setState(() {
                                  _myDaerah = newValue!;
                                  _myZip = null;
                                  _myMasjid = null;
                                  _getPoskodList(_myDaerah);
                                  print(_myDaerah);
                                });
                              },
                              items: daerahList?.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item['nama_daerah']),
                                  value: item['id_daerah'].toString(),
                                );
                              }).toList() ??
                                  [],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: _myZip,
                              iconSize: 30,
                              icon: (null),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              hint: Text('Select Poskod'),
                              onChanged: (newValue) {
                                setState(() {
                                  _myZip = newValue!;
                                  _myMasjid = null;
                                  _getMasjidList(_myZip);
                                  print(_myZip);
                                });
                              },
                              items: poskodList?.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item['poskod']),
                                  value: item['poskod'].toString(),
                                );
                              }).toList() ??
                                  [],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: _myMasjid,
                              iconSize: 30,
                              icon: (null),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              hint: Text('Select Masjid'),
                              onChanged: (newValue) {
                                setState(() {
                                  _myMasjid = newValue!;
                                  // _getMasjidList();
                                  print(_myMasjid);
                                });
                              },
                              items: masjidList?.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item['nama_masjid']),
                                  value: item['kod_masjid'].toString(),
                                );
                              }).toList() ??
                                  [],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //sign in button
                MyButton(
                  text: "Select Now",
                  // onTap: signUserIn,
                  onTap: _homepage,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }




  // Get Masjid information by API
  List? masjidList;
  String? _myMasjid;

  Future<String?> _getMasjidList(String? myZip) async {
  String masjidInfoUrl = 'https://api.gomasjid.my/api/utama?cara=getMasjid&idPoskod=${myZip}';
    await http.post(Uri.parse(masjidInfoUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          // "api_key": '25d55ad283aa400af464c76d713c07ad',
          // "state_id": _myMasjid,
        }).then((response) {
      var data = json.decode(response.body);

      setState(() {
        masjidList = data['masjid'];
      });
    });
    return null;
  }
}

