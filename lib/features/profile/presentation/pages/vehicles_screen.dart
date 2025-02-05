import 'package:flutter/material.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/profile/presentation/pages/add_new_vehicle_assist_screen.dart';
import 'package:flutter_application/features/profile/presentation/provider/vehicle_provider.dart';
import 'package:flutter_application/features/profile/presentation/widgets/vehicle_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/info_text_widget.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

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
            if (state.status == Status.errorNetwork) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('No Internet, check your connection.'),
                  duration: const Duration(seconds: 10),
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
            } else if (state.status == Status.error) {
              context.read<HomeBloc>().add(const HomeEvent.getVehicleList());
            }
          },
          builder: (context, state) {
            if (state.status == Status.loading) {
              return _buildShimmer();
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
                            return VehicleCardWidget(
                              vehicle: vehicle,
                              onEditPressed: () {
                                _navigateToEditScreen(context, vehicle);
                              },
                            );
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

  // Shimmer placeholder widget
  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 5, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Placeholder for vehicle type row
                Container(
                  height: 20,
                  width: 150,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                // Placeholder row for make & model
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 16,
                      width: 80,
                      color: Colors.grey[400],
                    ),
                    Container(
                      height: 16,
                      width: 80,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Placeholder row for year & plate number
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 16,
                      width: 80,
                      color: Colors.grey[400],
                    ),
                    Container(
                      height: 16,
                      width: 80,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Placeholder for unit number
                Container(
                  height: 16,
                  width: 120,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToEditScreen(BuildContext context, VehicleModel vehicle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewVehicleScreenAssistScreenAssist(
          provider: context.read<VehicleProvider>(),
          vehicle: vehicle,
          isEditing: true,
        ),
      ),
    ).then((updatedVehicle) {
      if (updatedVehicle != null) {
        context.read<HomeBloc>().add(HomeEvent.updateVehicle(updatedVehicle));
      }
    });
  }
}
