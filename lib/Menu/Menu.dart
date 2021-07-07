
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Menu extends StatefulWidget {

  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
    final _data = List<String>.generate(8, (index) {
      if(index == 0)
      {
        return 'assets/logoblc.png';
      }
      return 'assets/ico_$index.png';
    });

    int _selectedIndex = 1;

    Widget _getWidget()
    {
      String value;
      if(_selectedIndex.isOdd)
      {
        value='assets/logoneg.png';
      }
      else
      {
        value='assets/logoblc.png';
      }
      return DecoratedBox(
        child: Container(),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(value)
          )
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      onItemSelected: (index)
      {
        if(index!=0)
        {
          setState(() {
            _selectedIndex = index;
          });
        }
      },
      selecterColor: Color.fromRGBO(250, 145, 155, 100),
      unselectedColor: Colors.black,
      menuWidth: 90,
      builder:(showMenu)
      {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: showMenu,
            ),
            centerTitle: true,
            title: Text(
              'Agenda',
              style: GoogleFonts.oswald(),
            ),
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          body: _getWidget(),
        );
      },
      items: _data.map((e) => 
      Padding(padding: const EdgeInsets.all(20.0),
      child: Image.asset(e),
      )
      ).toList(),
    );
  }
}

typedef SideMenuBuilder = Widget Function(VoidCallback showMenu);

class SideMenu extends StatefulWidget {
  
  const SideMenu({Key key, 
  this.builder, 
  this.items, 
  this.onItemSelected, 
  this.selecterColor = Colors.black, 
  this.unselectedColor = Colors.green,
  this.menuWidth = 100.0,
  this.duration = const Duration(milliseconds: 800)
  }): super(key: key);

  final SideMenuBuilder builder;
  final List<Widget> items;
  final ValueChanged<int> onItemSelected;
  final Color selecterColor;
  final Color unselectedColor;
  final double menuWidth;
  final Duration duration;


  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with SingleTickerProviderStateMixin {


  AnimationController _animationController;
  List <Animation<double>> _animation;
  int selectedIndex = 1;


  @override
  void initState() { 
    _animationController = AnimationController(vsync:  this, duration: widget.duration);
    final _intervalGap = 1/widget.items.length;

    _animation = List.generate(widget.items.length, (index) =>  Tween(
      begin: 0.0, end: 1.6
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(index* _intervalGap, index*_intervalGap+_intervalGap)
    ))).toList();
    _animationController.forward(from: 1.0);
    super.initState();


    
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(
        
          builder: (context, constraints)
            {
              final itemSize = constraints.maxHeight / widget.items.length;
             return AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child)
                  {
                    return Stack(
                      children: [
                         widget.builder(
                           (){
                             _animationController.reverse();
                           }
                         ),
                  for(int i=0; i<widget.items.length;i++)
                  
                    Positioned(
                      left: 0,
                      top: itemSize*i,
                      width: widget.menuWidth,
                      height: itemSize,
                      child: 
                      Transform(
                        transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(
                          _animationController.status == AnimationStatus.reverse?
                          _animation[widget.items.length-1-i].value : _animation[i].value
                          
                          ),
                        alignment: Alignment.bottomLeft,

                        child: Material(
                        color: i== selectedIndex ? widget.selecterColor : widget.unselectedColor,
                        child: InkWell(
                          onTap: (){
                            _animationController.forward(from: 0.0);
                            if(i!=0)
                            {
                              setState(() {
                              selectedIndex = i;
                            });
                            }
                            widget.onItemSelected(i);
                            
                          },
                          child: widget.items[i],
                        )

                      ),
                      )
                      
                    )
                      ],
                    );
                  }
              );
            }
            
        
      ),
    );
  }
}