import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_strava_ble_app/common/instances.dart';
import 'package:my_strava_ble_app/modules/strava/bloc/strava_bloc.dart';
import 'package:my_strava_ble_app/modules/strava/models/strava_activity_model.dart';
import 'package:intl/intl.dart';

class StravaListView extends StatelessWidget {
  const StravaListView({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StravaBloc, StravaState>(
      buildWhen: (previous, current) {
        return switch (current) {
          AuthenticatingStrava() => true,
          StravaAuthenticated() => true,
          AuthenticationFailed() => true,
          StravaDataFetched() => true,
          StravaDataFetchError() => true,
          FetchingStravaData() => true,
          _ => false,
        };
      },
      builder: (context, state) {
        final isAuthenticating = switch (state) {
          AuthenticatingStrava() => true,
          _ => false,
        };
        final notAuthenticated = switch (state) {
          AuthenticationFailed() => true,
          _ => false,
        };

        if (state is FetchingStravaData) {
          return Center(child: CircularProgressIndicator());
        }
        if (notAuthenticated) {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                Text("Error authenticating with Strava"),
                ElevatedButton(
                    onPressed: () {
                      context.read<StravaBloc>().add(AuthenticateStravaEvent());
                    },
                    child: Text("Retry"))
              ]));
        }

        if (isAuthenticating) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Checking authentication status..."),
              CircularProgressIndicator(),
            ],
          ));
        }
        final isError = switch (state) {
          StravaDataFetchError() => true,
          _ => false,
        };
        if (isError) {
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Error fetching data"),
                  ElevatedButton(
                      onPressed: () {
                        context.read<StravaBloc>().add(GetStravaDataEvent());
                      },
                      child: Text("Retry"))
                ]),
          );
        }

        final data = switch (state) {
          StravaDataFetched() => state.activity,
          _ => Instance.stravaRepo.activity ?? <StravaActivityModel>[],
        };
        if (data.isNotEmpty) {
          return ListView.builder(
            itemCount: data.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemBuilder: (context, index) {
              final activity = data[index];
              final distanceKm = (activity.distance ?? 0) / 1000;
              final distanceMiles = distanceKm * 0.621371;
              final duration = Duration(seconds: activity.movingTime ?? 0);
              final formattedDuration = [
                duration.inHours.toString().padLeft(2, '0'),
                (duration.inMinutes % 60).toString().padLeft(2, '0'),
                (duration.inSeconds % 60).toString().padLeft(2, '0'),
              ].join(':');
              final formattedDate = activity.startDateLocal != null
                  ? DateFormat('dd MMM yyyy – HH:mm')
                      .format(activity.startDateLocal!)
                  : "N/A";

              return Card(
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade50, Colors.blue.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.name ?? "Unnamed Activity",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 18),
                            const SizedBox(width: 8),
                            Text(formattedDate),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.map_outlined, size: 18),
                            const SizedBox(width: 8),
                            Text(
                                "${distanceKm.toStringAsFixed(2)} km (${distanceMiles.toStringAsFixed(2)} mi)"),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined, size: 18),
                            const SizedBox(width: 8),
                            Text("Duration: $formattedDuration"),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.directions_bike, size: 18),
                            const SizedBox(width: 8),
                            Text("Type: ${activity.type ?? "Unknown"}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        if (data.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("No Strava Data Found"),
                ElevatedButton(
                    onPressed: () {
                      context.read<StravaBloc>().add(GetStravaDataEvent());
                    },
                    child: Text("Retry"))
              ],
            ),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Fetching Strava Data...'),
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
