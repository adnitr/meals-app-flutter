import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> filterValues;

  const FiltersScreen(this.filterValues, this.saveFilters, {super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.filterValues['gluten'] as bool;
    _lactoseFree = widget.filterValues['lactose'] as bool;
    _vegan = widget.filterValues['vegan'] as bool;
    _vegetarian = widget.filterValues['vegetarian'] as bool;
    super.initState();
  }

  Widget _buildSwitchListTile(String mainText, String subText,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(mainText),
        subtitle: Text(subText),
        value: currentValue,
        onChanged: (newVal) => updateValue(newVal));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your filters"),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilter = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian
                };
                widget.saveFilters(selectedFilter);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "Adjust your meal selection",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  "Gluten-free", "Only include Gluten free meals", _glutenFree,
                  (newVal) {
                setState(() {
                  _glutenFree = newVal;
                });
              }),
              _buildSwitchListTile("Lactose-free",
                  "Only include Lactose free meals", _lactoseFree, (newVal) {
                setState(() {
                  _lactoseFree = newVal;
                });
              }),
              _buildSwitchListTile(
                  "Vegetarian", "Only include vegetarian meals", _vegetarian,
                  (newVal) {
                setState(() {
                  _vegetarian = newVal;
                });
              }),
              _buildSwitchListTile("Vegan", "Only include vegan meals", _vegan,
                  (newVal) {
                setState(() {
                  _vegan = newVal;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
