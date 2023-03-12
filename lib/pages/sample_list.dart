import 'package:flutter/foundation.dart';

import 'calendar/calendar_view.dart';

/// Contains the output widget of sample
/// appropriate key and output widget mapped
Map<String, Function> getSampleWidget() {
  return <String, Function>{
    // cartesian charts

    //Radialbar

    //Funnel

    // Calendar Samples

    'shift_scheduler': () => ShiftScheduler(),

    // Date picker Samples
  };
}
