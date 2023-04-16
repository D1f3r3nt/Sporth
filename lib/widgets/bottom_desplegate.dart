import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class BottomDesplegate extends StatefulWidget {
  const BottomDesplegate({super.key});

  @override
  State<BottomDesplegate> createState() => _BottomDesplegateState();
}

class _BottomDesplegateState extends State<BottomDesplegate> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();

  DateTime? _date;
  TimeOfDay? _time;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      initialDate: _date ?? DateTime.now(),
      lastDate: DateTime(2100),
    );

    _date = picked;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );

    _time = picked;
  }

  @override
  Widget build(BuildContext context) {
    final SearchProvider searchProvider = Provider.of<SearchProvider>(context);
    final Size size = MediaQuery.of(context).size;

    _dateController.text = searchProvider.search.dia == null ? '' : searchProvider.search.dia!;
    _timeController.text = searchProvider.search.hora == null ? '' : searchProvider.search.hora!;

    return SizedBox(
      height: size.height * 0.75,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0)),
          color: ColorsUtils.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filtro',
              style: TextUtils.kanitItalic_24_black,
            ),
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Max personas',
                    style: TextUtils.kanit_18_black,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Slider(
                          value: double.parse(searchProvider.search.maxPersonas.toString()),
                          activeColor: ColorsUtils.creme,
                          inactiveColor: ColorsUtils.grey,
                          min: 2.0,
                          max: 25.0,
                          divisions: 23,
                          onChanged: (value) => setState(() {
                            searchProvider.maxPersonas = value.toInt();
                          }),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (searchProvider.search.maxPersonas == 25) ? '+25' : '${searchProvider.search.maxPersonas}',
                          style: TextUtils.kanitItalic_24_blue,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Precio',
                    style: TextUtils.kanit_18_black,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Slider(
                          value: double.parse(searchProvider.search.precio.toString()),
                          activeColor: ColorsUtils.creme,
                          inactiveColor: ColorsUtils.grey,
                          min: 0.0,
                          max: 50.0,
                          divisions: 25,
                          onChanged: (value) => setState(() {
                            searchProvider.precio = value.toInt();
                          }),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (searchProvider.search.precio == 0)
                              ? 'Gratis'
                              : (searchProvider.search.precio == 50)
                                  ? '+50 €'
                                  : '${searchProvider.search.precio} €',
                          style: TextUtils.kanitItalic_24_blue,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Localización',
                    style: TextUtils.kanit_18_black,
                  ),
                  const SizedBox(height: 5.0),
                  FormInput(
                    icon: const Icon(
                      Icons.search,
                      color: ColorsUtils.grey,
                    ),
                    placeholder: 'Buscar',
                    controller: _ubicacionController,
                    fillColor: ColorsUtils.white,
                    styleText: TextUtils.kanit_18_grey,
                    validator: (p0) => null,
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: ButtonInput(
                      text: 'Mi ubicacion',
                      color: ColorsUtils.lightblue,
                      style: TextUtils.kanit_18_whtie,
                      funcion: () {},
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Dia y hora',
                    style: TextUtils.kanit_18_black,
                  ),
                  FormInput(
                    icon: const Icon(
                      Icons.calendar_month,
                    ),
                    placeholder: 'Buscar',
                    controller: _dateController,
                    fillColor: ColorsUtils.white,
                    styleText: TextUtils.kanit_18_black,
                    onTap: () async {
                      await _selectDate(context);
                      searchProvider.dia = _date == null ? '' : DateFormat.yMd().format(_date!);
                    },
                    textInputType: TextInputType.none,
                    validator: (p0) => null,
                  ),
                  const SizedBox(height: 20.0),
                  FormInput(
                    icon: const Icon(
                      Icons.access_time,
                    ),
                    placeholder: 'Buscar',
                    controller: _timeController,
                    onTap: () async {
                      await _selectTime(context);
                      searchProvider.hora = _time == null ? '' : '${_time!.hour.toString().padLeft(2, '0')}:${_time!.minute.toString().padLeft(2, '0')}';
                    },
                    fillColor: ColorsUtils.white,
                    styleText: TextUtils.kanit_18_black,
                    textInputType: TextInputType.none,
                    validator: (p0) => null,
                  ),
                ],
              ),
            ),
            ButtonInput(
              text: 'Aplicar',
              funcion: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
