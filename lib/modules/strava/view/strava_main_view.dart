import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_strava_ble_app/modules/bluetooth/widgets/scan_screen.dart';
import 'package:my_strava_ble_app/modules/strava/bloc/strava_bloc.dart';
import 'package:my_strava_ble_app/modules/strava/widgets/strava_list_view.dart';

class StravaMainView extends StatefulWidget {
  const StravaMainView({super.key});

  @override
  State<StravaMainView> createState() => _StravaMainViewState();
}

class _StravaMainViewState extends State<StravaMainView> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StravaBloc, StravaState>(
      listener: _listener,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text('Strava Activities'),
                pinned: true,
                actions: [
                  TextButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScanScreen()));
                      },
                      child: Text('Connect to a device')),
                ],
              )
            ];
          },
          body: RefreshIndicator(
              onRefresh: () async {
                context.read<StravaBloc>().add(GetStravaDataEvent());
              },
              child: StravaListView(scrollController: ScrollController())),
        ),
      ),
    );
  }

  void _listener(BuildContext context, StravaState state) {
    switch (state) {
      case StravaDataFetched():
        break;
      case StravaDataFetchError():
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.errorMsg ?? 'Error fetching data'),
        ));
        break;
      case FetchingStravaData():
        break;
      case AuthenticationFailed():
      case StravaStateInitial():
        break;
      case AuthenticatingStrava():
        break;
      case StravaAuthenticated():
        context.read<StravaBloc>().add(GetStravaDataEvent());
    }
  }
}
