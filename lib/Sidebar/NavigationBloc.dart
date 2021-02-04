import 'package:bloc/bloc.dart';
import 'package:redletterday_planner/Screens/EventsPage.dart';
import 'package:redletterday_planner/Screens/Home.dart';
import 'package:redletterday_planner/Screens/WeeklySchedulePage.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  EventsPageClickedEvent,
  WeeklySchedulePageClickedEvent,
}
abstract class NavigationStates{}

class NavigationBloc extends Bloc<NavigationEvents,NavigationStates> {
  NavigationBloc(NavigationStates initialState) : super(initialState);

  @override
  Stream<NavigationStates> mapEventToState(event) async* {
    switch(event){
      case NavigationEvents.HomePageClickedEvent:
        yield Home();
        break;
      case NavigationEvents.EventsPageClickedEvent:
        yield EventsPage();
        break;
      case NavigationEvents.WeeklySchedulePageClickedEvent:
        yield WeeklySchedulePage();
        break;
    }
  }
  
}