import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/di/service_locator.dart';
import '../cubits/nearby_devs/nearby_devs_cubit.dart';
import '../cubits/nearby_devs/nearby_devs_state.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../viewmodels/navigation_viewmodel.dart';
import '../widgets/bottom_nav_bar.dart';
import 'public_profile_screen.dart';

/// Tela "Devs por perto": mapa com marcadores dos devs próximos ao
/// usuário logado, com base na localização atual do dispositivo.
class DevsNearYouScreen extends StatefulWidget {
  const DevsNearYouScreen({super.key});

  @override
  State<DevsNearYouScreen> createState() => _DevsNearYouScreenState();
}

class _DevsNearYouScreenState extends State<DevsNearYouScreen> {
  late final NearbyDevsCubit _nearbyDevsCubit = NearbyDevsCubit(
    ServiceLocator.instance.userRepository,
  );
  late final NavigationViewModel _navigationViewModel = NavigationViewModel(
    ServiceLocator.instance.authCubit,
  );

  @override
  void initState() {
    super.initState();
    _nearbyDevsCubit.loadNearbyDevs();
  }

  @override
  void dispose() {
    _nearbyDevsCubit.close();
    super.dispose();
  }

  void _openProfile(String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PublicProfileScreen(userId: userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.devsNearYouTitle),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textColor,
        elevation: 0,
      ),
      body: BlocBuilder<NearbyDevsCubit, NearbyDevsState>(
        bloc: _nearbyDevsCubit,
        builder: (context, state) {
          if (state is NearbyDevsLoading || state is NearbyDevsInitial) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.primaryColor,
                ),
              ),
            );
          }

          if (state is NearbyDevsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_off,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppTheme.textColor),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => _nearbyDevsCubit.loadNearbyDevs(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                      ),
                      child: Text(l10n.btnRetry),
                    ),
                  ],
                ),
              ),
            );
          }

          final loaded = state as NearbyDevsLoaded;
          final markers = <Marker>{
            for (final dev in loaded.devs)
              Marker(
                markerId: MarkerId(dev.id),
                position: LatLng(dev.latitude, dev.longitude),
                infoWindow: InfoWindow(
                  title: dev.name,
                  snippet: l10n.kmAway(dev.distanceKm.toStringAsFixed(1)),
                ),
                onTap: () => _openProfile(dev.id),
              ),
          };

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(loaded.latitude, loaded.longitude),
                  zoom: 12,
                ),
                markers: markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
              if (loaded.devs.isEmpty)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Card(
                    color: AppTheme.cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        l10n.noDevsNearby,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppTheme.textColor),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        viewModel: _navigationViewModel,
        currentIndex: 2,
      ),
    );
  }
}
