import 'package:flutter/material.dart';
import 'package:project_ktp/data/model/provinces_model.dart';
import 'package:project_ktp/data/model/regencies_model.dart';
import 'package:project_ktp/domain/usecases/get_provinces_usecase.dart';
import 'package:project_ktp/domain/usecases/get_regencies_usecase.dart';



class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ttlController = TextEditingController();
  TextEditingController _pekerjaanController = TextEditingController();
  TextEditingController _pendidikanController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GetProvincesUseCase getProvincesUseCase = GetProvincesUseCase();
  GetRegenciesUseCase getRegenciesUseCase = GetRegenciesUseCase();
  List<ProvincesModel> provinsiItems = []; // Initialize as an empty list
  List<RegenciesModel> regencyItems = [];
  // String _selectedProvince = '';
  // String _selectedRegency = '';
  String? _selectedProvinceId;
  RegenciesModel? _selectedRegency;


  @override
  void initState() {
    super.initState();
    _fetchProvinces();
  }

  Future<void> _fetchProvinces() async {
    try {
      List<ProvincesModel> provinces = await getProvincesUseCase.execute();
      setState(() {
        provinsiItems = provinces;
      });
    } catch (e) {
      print("Error fetching provinces: $e");
    }
  }

  Future<void> _fetchRegencies(String id) async{
    try{
      List<RegenciesModel> regencies = await getRegenciesUseCase.execute(id);
      setState(() {
        regencyItems = regencies;
        _selectedProvinceId = id;
      });
    }catch(e){
      print("Error fetching regencies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data KTP'),

      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Masukkan nama lengkap anda',
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Nama wajib diisi';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _ttlController,
              decoration: InputDecoration(
                hintText: 'Masukkan Tempat Tanggal Lahir',
                labelText: 'Tempat Tanggal Lahir',
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'TTL wajib diisi';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<ProvincesModel>(
              items: provinsiItems
                  .map(
                    (provinsi) => DropdownMenuItem<ProvincesModel>(
                  value: provinsi,
                  child: Text(provinsi.name ?? ''),
                ),
              )
                  .toList(),
              onChanged: (ProvincesModel? newValue) {
                setState(() {
                  _selectedProvinceId = newValue!.id;
                  _selectedRegency = null; // Reset kabupaten saat provinsi berubah
                  regencyItems.clear(); // Kosongkan list kabupaten saat provinsi berubah
                  _fetchRegencies(_selectedProvinceId!);
                  print(newValue!.name);
                  print(newValue!.id);
                });
              },
              decoration: InputDecoration(
                hintText: 'Pilih Provinsi',
                labelText: 'Provinsi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<RegenciesModel>(
              value: _selectedRegency,
              items: regencyItems
                  .map(
                    (regency) => DropdownMenuItem<RegenciesModel>(
                  value: regency,
                  child: Text(regency.name ?? ''),
                ),
              )
                  .toList(),
              onChanged: (RegenciesModel? newValue) {
                setState(() {
                  _selectedRegency = newValue;
                  print(newValue!.name);
                  print(newValue!.id);
                });
              },
              decoration: InputDecoration(
                hintText: 'Pilih Kabupaten',
                labelText: 'Kabupaten',
                border: OutlineInputBorder(),
              ),
            ),

            // DropdownButtonFormField<RegenciesModel>(
            //   items: regencyItems.isNotEmpty ? regencyItems
            //   .map((regency) => DropdownMenuItem<RegenciesModel>(
            //     value: regency,
            //     child: Text(regency.name ?? ''),
            //     ),
            //   )
            //   .toList() : [],
            //   onChanged: (RegenciesModel? newValue) {
            //     setState(() {
            //       print(newValue!.name);
            //       print(newValue!.id);
            //       _selectedProvinceId = '';
            //     });
            //   },
            //   decoration: InputDecoration(
            //     hintText: 'Pilih Kabupaten',
            //     labelText: 'Kabupaten',
            //     border: OutlineInputBorder(),
            //   ),),
            SizedBox(height: 20),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _pekerjaanController,
              decoration: InputDecoration(
                hintText: 'Masukkan Pekerjaan',
                labelText: 'Pekerjaan',
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Pekerjaan wajib diisi';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _pendidikanController,
              decoration: InputDecoration(
                hintText: 'Masukkan pendidikan terakhir',
                labelText: 'Pendidikan',
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Pendidikan terakhir wajib diisi';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await GetProvincesUseCase().execute();
                print(getProvincesUseCase.execute().toString());
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}


