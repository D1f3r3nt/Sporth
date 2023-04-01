import 'package:flutter/material.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deportesProvider = Provider.of<DeportesProvider>(context);
    final deportes = deportesProvider.deportesSelect;

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
                    controller: TextEditingController(),
                    fillColor: ColorsUtils.white,
                    styleText: TextUtils.kanit_18_grey,
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
                        }),
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const CardPublicacion();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
