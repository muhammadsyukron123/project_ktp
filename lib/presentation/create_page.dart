import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_ktp/data/core/navigation/router_provider.dart';
import 'package:project_ktp/data/datasource/hive_data_source.dart';
import 'package:project_ktp/data/model/provinces_model.dart';
import 'package:project_ktp/data/model/regencies_model.dart';
import 'package:project_ktp/data/repositories/person_repository.dart';
import 'package:project_ktp/domain/usecases/get_provinces_usecase.dart';
import 'package:project_ktp/domain/usecases/get_regencies_usecase.dart';
import 'package:project_ktp/presentation/list_person_page.dart';
import 'package:provider/provider.dart';

import '../data/model/person_hive_model.dart';
import '../data/person_repositories_impl.dart';
import '../domain/entities/person_entity.dart';
import '../domain/model/person_model.dart';
import '../domain/usecases/add_person_usecase.dart';
import '../domain/usecases/get_person_usecase.dart';



class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late AddPersonUseCase addPersonUseCase;
  late GetPersonUseCase getPersonUseCase;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ttlController = TextEditingController();
  TextEditingController _pekerjaanController = TextEditingController();
  TextEditingController _pendidikanController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GetProvincesUseCase getProvincesUseCase = GetProvincesUseCase();
  GetRegenciesUseCase getRegenciesUseCase = GetRegenciesUseCase();
  List<ProvincesModel> provinsiItems = []; // Initialize as an empty list
  List<RegenciesModel> regencyItems = [];
  String? _selectedProvinceId;
  String? selectedProvince;
  String? selectedRegency;
  RegenciesModel? _selectedRegency;
  late final PersonRepository _personRepository = PersonRepositoryImpl(hiveDataSource: HiveDataSource());

  void _printDataFromHive() async {
    // Ambil kotak Hive yang berisi data PersonHiveModel
    var box = await Hive.openBox<PersonHiveModel>(HiveDataSource.boxName);
    for (var i = 0; i < box.length; i++) {
      print('Data ke-$i: ${box.getAt(i)}');
    }

    // Periksa apakah kotak Hive tidak kosong
    if (box.isNotEmpty) {
      // Iterasi melalui setiap item dalam kotak Hive dan cetak ke terminal

    } else {
      print('Kotak Hive kosong.');
    }
  }



  @override
  void initState() {
    super.initState();
    addPersonUseCase = AddPersonUseCase(repository: _personRepository);
    getPersonUseCase = GetPersonUseCase(repository: _personRepository);
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
                  selectedProvince = newValue.name;
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
                  selectedRegency = newValue!.id;
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
            // ini adalah tombol untuk menambahkan data baru
            ElevatedButton(
              onPressed: () async {
                _printDataFromHive();

              },
              child: Text('Cek data'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  // Validasi form berhasil, lanjutkan dengan menyimpan data
                  // Dapatkan nilai dari form
                  String name = _nameController.text;
                  String ttl = _ttlController.text;
                  String pekerjaan = _pekerjaanController.text;
                  String pendidikan = _pendidikanController.text;

                  // Buat objek PersonEntity
                  PersonEntity person = PersonEntity(
                    name: name,
                    birthDate: ttl,
                    province: _selectedProvinceId ?? '', // Pastikan nilai sudah terisi
                    regency: _selectedRegency?.id ?? '', // Pastikan nilai sudah terisi
                    occupation: pekerjaan,
                    education: pendidikan,
                  );

                  // Simpan data ke dalam database Hive
                  try {
                    await addPersonUseCase.execute(person);
                    await getPersonUseCase.execute();
                    // RouterProvider.of(context)?.appRouter.goToListPage();
                    // Data berhasil disimpan, tambahkan log atau notifikasi
                    Provider.of<PersonModel>(context, listen: false).addPerson(person);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ListPersonPage()
                    ));
                    print('Data berhasil disimpan ke dalam database Hive: $person');
                  } catch (e) {
                    // Terjadi kesalahan saat menyimpan data, tampilkan pesan error
                    print('Error saat menyimpan data: $e');
                  }
                }
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ListPersonPage()
                      ));
                },
                child: Text('go to list'))
          ],
        ),
      ),
    );
  }
}


