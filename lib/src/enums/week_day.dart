enum WeekDay {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
}

Map<WeekDay, String> weekDaysNames = <WeekDay, String>{
  WeekDay.monday: 'Segunda-feira',
  WeekDay.tuesday: 'Terça-feira',
  WeekDay.wednesday: 'Quarta-feira',
  WeekDay.thursday: 'Quinta-feira',
  WeekDay.friday: 'Sexta-feira',
  WeekDay.saturday: 'Sábado',
  WeekDay.sunday: 'Domingo',
};

Map<int, WeekDay> weekDaysNumbers = <int, WeekDay>{
  0: WeekDay.sunday,
  1: WeekDay.monday,
  2: WeekDay.tuesday,
  3: WeekDay.wednesday,
  4: WeekDay.thursday,
  5: WeekDay.friday,
  6: WeekDay.saturday,
};

Map<String, String> weekDaysInitialsPT = <String, String>{
  'MONDAY': 'Seg',
  'TUESDAY': 'Ter',
  'WEDNESDAY': 'Qua',
  'THURSDAY': 'Qui',
  'FRIDAY': 'Sex',
  'SATURDAY': 'Sáb',
  'SUNDAY': 'Dom',
};
