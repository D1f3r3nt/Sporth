import 'package:flutter/material.dart';
import 'package:sporth/models/dto/deportes_dto.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _nombreController = TextEditingController();
  final DatabaseEvento databaseEvento = DatabaseEvento();

  @override
  Widget build(BuildContext context) {
    final EventosProvider eventosProvider = Provider.of<EventosProvider>(context);
    final DeportesProvider deportesProvider = Provider.of<DeportesProvider>(context);
    final SearchProvider searchProvider = Provider.of<SearchProvider>(context);
    final Size size = MediaQuery.of(context).size;

    final List<DeportesDto> deportes = deportesProvider.deportesFilter;

    deportes.sort((a, b) {
      if (a.selected) return -1;
      if (b.selected) return 1;
      return 0;
    });

    eventosProvider.getFilteredEventos(searchProvider.search);

    final eventos = eventosProvider.filteredEventos;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FormInput(
                    icon: const Icon(
                      Icons.search,
                      color: ColorsUtils.grey,
                    ),
                    placeholder: 'Buscar',
                    controller: _nombreController,
                    fillColor: ColorsUtils.white,
                    styleText: TextUtils.kanit_18_grey,
                    onChanged: (value) => setState(() {
                      searchProvider.nombre = value;
                    }),
                    validator: (p0) => null,
                  ),
                ),
                IconButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    isScrollControlled: true,
                    builder: (context) {
                      return const BottomDesplegate();
                    },
                  ),
                  icon: const Icon(
                    Icons.filter_alt,
                    color: ColorsUtils.grey,
                  ),
                  iconSize: 40.0,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 90.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: deportes
                    .map(
                      (e) => SearchDeporte(
                        active: e.selected,
                        image: e.imagen,
                        onTap: () => setState(() {
                          e.selected = !e.selected;
                          searchProvider.deporte = deportes.where((element) => element.selected).map((e) => e.id).toList();
                        }),
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: (eventos.length == 0)
                  ? Image.asset(
                      'image/no_hay_eventos.png',
                      height: size.height * 0.4,
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
                      itemCount: eventos.length,
                      itemBuilder: (context, index) {
                        return CardPublicacion(eventoDto: eventos[index]);
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
