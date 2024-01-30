import 'package:flutter/material.dart';
import 'package:project_ktp/data/model/provinces_model.dart';
import 'package:project_ktp/domain/usecases/get_provinces_usecase.dart';



class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController _nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GetProvincesUseCase getProvincesUseCase = GetProvincesUseCase();
  List<ProvincesModel> provinsiItems = []; // Initialize as an empty list
  String _selectedProvince = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Masukkan nama lengkap anda',
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
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
                  print(newValue!.name);
                });
              },
              decoration: InputDecoration(
                hintText: 'Pilih Provinsi',
                labelText: 'Provinsi',
                border: OutlineInputBorder(),
              ),
            ),
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


