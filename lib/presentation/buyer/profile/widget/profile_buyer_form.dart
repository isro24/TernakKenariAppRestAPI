import 'package:canary_template/core/core.dart';
import 'package:canary_template/data/models/request/buyer/buyer_profile_request_model.dart';
import 'package:canary_template/presentation/buyer/profile/bloc/profile_buyer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBuyerForm extends StatefulWidget {
  const ProfileBuyerForm({super.key});

  @override
  State<ProfileBuyerForm> createState() => _ProfileBuyerFormState();
}

class _ProfileBuyerFormState extends State<ProfileBuyerForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController addressController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    nameController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final profileRequest = BuyerProfileRequestModel(
        name: nameController.text,
        address: addressController.text,
        phone: phoneController.text,
      );

      context.read<ProfileBuyerBloc>().add(
        AddProfileBuyerEvent(requestModel: profileRequest),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SpaceHeight(80),
            Text(
              'Lengkapi Profil Anda',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SpaceHeight(30),
            CustomTextField(
              controller: nameController,
              label: 'Nama',
              validator: 'Nama tidak boleh kosong',
              prefixIcon: const Icon(Icons.person),
            ),
            const SpaceHeight(20),
            CustomTextField(
              controller: addressController,
              label: 'Alamat',
              validator: 'Alamat tidak boleh kosong',
              prefixIcon: const Icon(Icons.home),
            ),
            const SpaceHeight(20),
            CustomTextField(
              controller: phoneController,
              label: 'No HP',
              validator: 'Nomor HP tidak boleh kosong',
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone),
            ),
            const SpaceHeight(30),
            BlocBuilder<ProfileBuyerBloc, ProfileBuyerState>(
              builder: (context, state) {
                final isLoading = state is ProfileBuyerLoading;

                return Button.filled(
                  label: isLoading ? 'Menyimpan...' : 'Simpan Profil',
                  onPressed: isLoading ? null : _submitForm,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
