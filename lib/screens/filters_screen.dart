import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;
  bool _isLactoseFree = false;

  @override
  initState() {
    _isGlutenFree = widget.currentFilters['gluten'];
    _isVegetarian = widget.currentFilters['vegetarian'];
    _isVegan = widget.currentFilters['vegan'];
    _isLactoseFree = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      activeColor: Theme.of(context).primaryColor,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Your filters'),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final selectedFilters = {
                    'gluten': _isGlutenFree,
                    'lactose': _isLactoseFree,
                    'vegan': _isVegan,
                    'vegetarian': _isVegetarian,
                  };
                  widget.saveFilters(selectedFilters);
                })
          ],
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile('Gluten-free',
                  'Only include gluten-free meals', _isGlutenFree, (newValue) {
                setState(() {
                  _isGlutenFree = newValue;
                });
              }),
              _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals',
                  _isLactoseFree, (newValue) {
                setState(() {
                  _isLactoseFree = newValue;
                });
              }),
              _buildSwitchListTile(
                  'Vegetarian', 'Only include vegetarian meals', _isVegetarian,
                  (newValue) {
                setState(() {
                  _isVegetarian = newValue;
                });
              }),
              _buildSwitchListTile('Vegan', 'Only includevegan meals', _isVegan,
                  (newValue) {
                setState(() {
                  _isVegan = newValue;
                });
              })
            ],
          ))
        ]));
  }
}
