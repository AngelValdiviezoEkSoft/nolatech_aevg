import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
//import 'package:date_ranger/date_ranger.dart';
import 'package:nolatech_aevg_app/domain/domain.dart';
import 'package:nolatech_aevg_app/ui/ui.dart';
import 'package:table_calendar/table_calendar.dart';

List<ItemBoton> lstCanchasReserv = [];
bool likeIt = false;

class FrmReservationScreen extends StatefulWidget {
  
  const FrmReservationScreen({super.key});

  @override
  FrmReservationScreenState createState() => FrmReservationScreenState();

}

class FrmReservationScreenState extends State<FrmReservationScreen> {
  
  DateTime? _selectedDate;
  //var initialDateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now());

  //DateTime? _selectedDate;
  DateTime _focusedDay = DateTime.now();

  void _openCalendarDialog() async {
    DateTime? tempSelectedDate = _selectedDate ?? DateTime.now();

    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Calendario
                  TableCalendar(
                    firstDay: DateTime.utc(2000, 1, 1),
                    lastDay: DateTime.utc(2100, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(tempSelectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setStateDialog(() {
                        tempSelectedDate = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Divider(),
                  // Botones
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedDate = tempSelectedDate;
                            });
                            Navigator.pop(context);
                          },
                          child: Text('Aplicar', style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    likeIt = false;
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<GenericBloc, GenericState>(
          builder: (context,state) {
            return FutureBuilder(
              future: state.readCanchas(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

                if(!snapshot.hasData) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Image.asset(
                      "assets/gifs/gif_carga.gif",
                      height: size.width * 0.85,
                      width: size.width * 0.85,
                    ),
                  ),
                );
              }
              else{
                if(snapshot.data != null && snapshot.data!.isNotEmpty) {

                  String rspTmp = snapshot.data as String;

                  lstCanchasReserv = state.deserializeItemBotonMenuList(rspTmp);

                  return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [

                     Stack(
                      children: [
                        Container(
                      width: size.width * 0.98,
                      height: size.height * 0.42,
                      color: Colors.transparent,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return _courtCard(size, index, context);                            
                        },
                        itemCount: lstCanchasReserv.length,
                        autoplayDisableOnInteraction: true,
                        autoplay: true,             
                        pagination: const SwiperPagination(),
                        //control: SwiperControl(),             
                      ),
                    ),
                        // Botón de regreso (círculo verde)
                        Positioned(
                          top: 12,
                          left: 12,
                          child: CircleAvatar(
                            backgroundColor: Colors.lightGreen,
                            child: GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: const Icon(Icons.arrow_back, color: Colors.white)),
                          ),
                        ),
                        // Corazón (favoritos)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                likeIt = !likeIt;
                              });
                            },
                            child: Icon(Icons.favorite, color: likeIt ? Colors.red : Colors.white)
                          ),
                        ),
                      ],
                    ),
                    
                    
                
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Epic Box', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('Cancha tipo A', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        Text('\$25',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(Icons.access_time, color: Colors.green, size: 18),
                        SizedBox(width: 5),
                        Text('Disponible 7:00 am a 4:00 pm'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.grey, size: 18),
                        SizedBox(width: 5),
                        Text('Vía Av. Caracas y Av. P° Caroní'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Agregar instructor'),
                    ),
                    const SizedBox(height: 16),
                    
                    const Text('Establecer fecha y hora',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    /*
                    Row(
                      children: [
                        Expanded(
                          child: InputDecorator(
                            decoration: const InputDecoration(labelText: 'Fecha', border: OutlineInputBorder()),
                            child: Text('09/07/2024'), // Placeholder
                          ),
                        ),
                      ],
                    ),
                    */
/*
                    Container(
                      color: Colors.transparent,
                      width: size.width * 0.85,
                      child: TextButton(
                        style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: const BorderSide(color: Colors.black)))),
                        onPressed: () async {
                          initializeDateFormatting('es');
                          //DateTime fechaActual = DateTime.now();
                          //int anioActual = fechaActual.year;
                          //int anioValido = anioActual - 18;
                          DateTime? varSelectedDate = await showDatePicker(
                            cancelText: 'Cancelar',
                            confirmText: 'Ok',
                            fieldLabelText: 'Mes/Día/Año',
                            helpText: '',
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            errorFormatText: 'Formato inválido',
                            context: context,
                            initialDate: DateTime(DateTime.now().year - 10),
                            firstDate: DateTime(DateTime.now().year - 10),
                            lastDate: DateTime(DateTime.now().year),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: objColorsApp.naranjaIntenso, onPrimary: Colors.white), textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(backgroundColor: Colors.white))),
                                child: child!,
                              );
                            },
                          );
                                        
                          if (varSelectedDate != null) {
                            /*
                            varObjetoProspectoFunc!.fechaNacDate = varSelectedDate;
                            
                            */
                            setState(() {
                              fechaVencimiento = DateFormat('dd-MM-yyyy', 'es').format(varSelectedDate);
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '',
                              style: TextStyle(color: Colors.transparent),
                            ),
                            Text(
                              fechaVencimiento,
                              style: const TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    */

                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.1,
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: _openCalendarDialog,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Fecha',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                          child: Text(
                            _selectedDate != null
                                ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
                                : 'Seleccionar fecha',
                          ),
                        ),
                      )
                    ),

/*
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.1,
                      color: Colors.transparent,
                      child: DateRanger(
                        initialRange: initialDateRange,
                        onRangeChanged: (range) {
                          setState(() {
                            initialDateRange = range;
                          });
                        },
                      ),
                    ),
                    */
                    
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: InputDecorator(
                            decoration: const InputDecoration(labelText: 'Hora de inicio', border: OutlineInputBorder()),
                            child: Text('00:00'), // Placeholder
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InputDecorator(
                            decoration: const InputDecoration(labelText: 'Hora de fin', border: OutlineInputBorder()),
                            child: Text('00:00'), // Placeholder
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Agregar un comentario',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    const TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Agregar un comentario...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFBFF17D)),
                        onPressed: () {},
                        child: const Text('Reservar', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                );
              
                }
              }

                
                return Container();
              }
            );
          }
        ),
      ),
    );
  }

    Widget _courtCard(Size size, int index, BuildContext context) {
    return Container(
      width: size.width * 0.75,
      height: size.height * 0.55,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.9,
            height: size.height * 0.41,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(lstCanchasReserv[index].tipoNotificacion,//'assets/images/court_epicbox.png',
                  height: 120, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }


}