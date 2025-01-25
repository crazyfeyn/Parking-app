import 'package:flutter/material.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/profile/presentation/pages/add_new_vehicle_assist_screen.dart';
import 'package:flutter_application/features/profile/presentation/provider/vehicle_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/info_text_widget.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const HomeEvent.getVehicleList());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VehicleProvider>();

    return Scaffold(
      appBar:
          const CustomProfileAppBarWidget(title: 'Your vehicles information'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      const Text('Failed to load vehicles. Please try again.'),
                  action: SnackBarAction(
                    label: 'Retry',
                    onPressed: () {
                      context
                          .read<HomeBloc>()
                          .add(const HomeEvent.getVehicleList());
                    },
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                  strokeWidth: 3,
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: state.vehicleList == null || state.vehicleList!.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions_car_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No vehicles have been added yet',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.vehicleList!.length,
                          itemBuilder: (context, index) {
                            final vehicle = state.vehicleList![index];
                            return _buildVehicleCard(vehicle);
                          },
                        ),
                ),
                ButtonWidget(
                  text: 'Add new vehicle',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddNewVehicleScreenAssistScreenAssist(
                          provider: provider,
                        ),
                      ),
                    );
                  },
                ),
                5.hs(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildVehicleCard(VehicleModel vehicle) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Vehicle type',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.shadeColor,
                ),
              ),
              Text(
                vehicle.type,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoTextWidget(
                title: vehicle.make,
                subTitle: 'Make',
              ),
              InfoTextWidget(
                title: vehicle.model,
                subTitle: 'Model',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoTextWidget(
                title: vehicle.year.toString(),
                subTitle: 'Year',
              ),
              InfoTextWidget(
                title: vehicle.plateNumber,
                subTitle: 'Plate Number',
              ),
            ],
          ),
          const SizedBox(height: 12),
          InfoTextWidget(
            title: vehicle.unitNumber,
            subTitle: 'Unit Number',
          ),
        ],
      ),
    );
  }
}
