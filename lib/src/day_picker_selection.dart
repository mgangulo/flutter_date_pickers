import 'date_period.dart';
import 'utils.dart';

/// Base class for day based pickers selection.
abstract class DayPickerSelection {
  /// If this is before [dateTime].
  bool isBefore(DateTime dateTime);

  /// If this is after [dateTime].
  bool isAfter(DateTime dateTime);

  /// Returns earliest [DateTime] in this selection.
  DateTime? get earliest;

  /// If this selection is empty.
  bool get isEmpty;

  /// If this selection is not empty.
  bool get isNotEmpty;

  /// Constructor to allow children to have constant constructor.
  const DayPickerSelection();
}

/// Selection with only one selected date.
///
/// See also:
/// * [DayPickerMultiSelection] - selection with one or many single dates.
/// * [DayPickerRangeSelection] - date period selection.
class DayPickerSingleSelection extends DayPickerSelection {
  /// Selected date.
  final DateTime selectedDate;

  /// Creates selection with only one selected date.
  const DayPickerSingleSelection(this.selectedDate);

  @override
  bool isAfter(DateTime dateTime) => selectedDate.isAfter(dateTime);

  @override
  bool isBefore(DateTime dateTime) => selectedDate.isBefore(dateTime);

  @override
  DateTime? get earliest => selectedDate;

  @override
  bool get isEmpty => false;

  @override
  bool get isNotEmpty => true;
}

/// Selection with one or many single dates.
///
/// See also:
/// * [DayPickerSingleSelection] - selection with only one selected date.
/// * [DayPickerRangeSelection] - date period selection.
class DayPickerMultiSelection extends DayPickerSelection {
  /// List of the selected dates.
  final List<DateTime> selectedDates;

  /// Selection with one or many single dates.
  DayPickerMultiSelection(this.selectedDates);

  @override
  bool isAfter(DateTime dateTime) =>
      selectedDates.every((d) => d.isAfter(dateTime));

  @override
  bool isBefore(DateTime dateTime) =>
      selectedDates.every((d) => d.isBefore(dateTime));

  @override
  DateTime? get earliest => DatePickerUtils.getEarliestFromList(selectedDates);

  @override
  bool get isEmpty => selectedDates.isEmpty;

  @override
  bool get isNotEmpty => selectedDates.isNotEmpty;
}

/// Date period selection.
///
/// See also:
/// * [DayPickerSingleSelection] - selection with only one selected date.
/// * [DayPickerMultiSelection] - selection with one or many single dates.
class DayPickerRangeSelection extends DayPickerSelection {
  /// Selected period.
  final DatePeriod? selectedRange;

  /// Date period selection.
  const DayPickerRangeSelection(this.selectedRange);

  @override
  DateTime? get earliest => selectedRange?.start;

  @override
  bool isAfter(DateTime dateTime) =>
      selectedRange?.start.isAfter(dateTime) ?? false;

  @override
  bool isBefore(DateTime dateTime) =>
      selectedRange?.end.isBefore(dateTime) ?? false;

  @override
  bool get isEmpty => (selectedRange == null);

  @override
  bool get isNotEmpty => (selectedRange != null);
}
