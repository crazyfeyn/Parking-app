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
import 'package:shimmer/shimmer.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch vehicle list once after widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchVehicleList();
    });
  }

  void _fetchVehicleList() {
    if (!mounted) return;
    context.read<HomeBloc>().add(const HomeEvent.getVehicleList());
  }

  Widget _buildEmptyState() {
    return Center(
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
    );
  }

  Widget _buildVehicleList(List<VehicleModel> vehicles) {
    return ListView.builder(
      itemCount: vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = vehicles[index];
        return VehicleCardWidget(
          vehicle: vehicle,
          onEditPressed: () => _navigateToEditScreen(context, vehicle),
        );
      },
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount:
          3, // Reduced number of shimmer placeholders for better performance
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 150,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 16,
                        width: 80,
                        color: Colors.white,
                      ),
                      Container(
                        height: 16,
                        width: 80,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 16,
                        width: 80,
                        color: Colors.white,
                      ),
                      Container(
                        height: 16,
                        width: 80,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 16,
                    width: 120,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _navigateToEditScreen(
    BuildContext context,
    VehicleModel vehicle,
  ) async {
    final result = await Navigator.push<VehicleModel>(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewVehicleScreenAssistScreenAssist(
          provider: context.read<VehicleProvider>(),
          vehicle: vehicle,
          isEditing: true,
        ),
      ),
    );

    if (result != null && mounted) {
      context.read<HomeBloc>().add(HomeEvent.updateVehicle(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomProfileAppBarWidget(
        title: 'Your vehicles information',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: BlocConsumer<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              current.status == Status.errorNetwork ||
              (previous.status != Status.error &&
                  current.status == Status.error),
          listener: (context, state) {
            if (state.status == Status.errorNetwork) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('No Internet, check your connection.'),
                  duration: const Duration(seconds: 10),
                  action: SnackBarAction(
                    label: 'Retry',
                    onPressed: _fetchVehicleList,
                  ),
                ),
              );
            }
          },
          buildWhen: (previous, current) =>
              previous.status != current.status ||
              previous.vehicleList != current.vehicleList,
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: state.status == Status.loading
                      ? _buildShimmer()
                      : state.vehicleList?.isEmpty ?? true
                          ? _buildEmptyState()
                          : _buildVehicleList(state.vehicleList!),
                ),
                ButtonWidget(
                  text: 'Add new vehicle',
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddNewVehicleScreenAssistScreenAssist(
                          provider: context.watch<VehicleProvider>(),
                        ),
                      ),
                    );
                    if (mounted) {
                      _fetchVehicleList();
                    }
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
}
