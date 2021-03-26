import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter';

  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _lactoseFree = false;
  var _vegan = false;

  @override
  initState() {
    super.initState();
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
  }

  Widget _buildSwitchListTile(
      bool value, String title, String subTitle, Function updateValue) {
    return SwitchListTile(
      value: value,
      title: Text(title),
      subtitle: Text(subTitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Filters'),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                _glutenFree,
                'Gluten-free',
                'Only include gluten-free meals',
                (val) {
                  setState(() {
                    _glutenFree = val;
                  });
                },
              ),
              _buildSwitchListTile(
                _lactoseFree,
                'Lactose-free',
                'Only include lactose-free meals',
                (val) {
                  setState(() {
                    _lactoseFree = val;
                  });
                },
              ),
              _buildSwitchListTile(
                _vegetarian,
                'Vegetarian',
                'Only include vegetarian meals',
                (val) {
                  setState(() {
                    _vegetarian = val;
                  });
                },
              ),
              _buildSwitchListTile(
                _vegan,
                'Vegan',
                'Only include vegan meals',
                (val) {
                  setState(() {
                    _vegan = val;
                  });
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
