enum PriorityEnum {
  high(3, 'Priority 3'),
  medium(2, 'Priority 2'),
  low(1, 'Priority 1'),
  none(0, 'No priority');

  final int key;
  final String label;

  const PriorityEnum(this.key, this.label);

  static String getLabel(int key) {
    return PriorityEnum.values
        .firstWhere((val) => val.key == key, orElse: () => PriorityEnum.none)
        .label;
  }
}
