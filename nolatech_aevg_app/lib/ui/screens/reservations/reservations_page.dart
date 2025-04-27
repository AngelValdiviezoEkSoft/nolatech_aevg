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
  
  String? horaInicio;
  String? horaFin;
  String instructorSeleccionado = 'Agregar instructor';

  final List<String> instructoresDisponibles = [
    'Agregar instructor',
    'Angel Valdiviezo',
    'Marck González',
    'Fulanito',
    'Sultanito'
  ];

  final List<String> horasDisponibles = [
    '8:00',
    '9:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00'
  ];

  final List<String> horasDeshabilitadas = [
    '10:00',
    '13:00',
    '14:00',
  ];

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

                  return Container(
                    width: size.width * 0.99,
                    height: size.height * 0.99,
                    color: Colors.transparent,
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                      //padding: const EdgeInsets.all(16),
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
                      
                        Container(
                          width: size.width * 0.95,
                          height: size.height * 0.06,
                          color: Colors.transparent,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                        ),
                        //const SizedBox(height: 2),
                        Container(
                          width: size.width * 0.95,
                          height: size.height * 0.04,
                          color: Colors.transparent,
                          child: const Row(
                            children: [
                              Text('Disponible '),
                              Icon(Icons.access_time, color: Colors.green, size: 18),
                              SizedBox(width: 5),
                              Text('7:00 am a 4:00 pm'),
                            ],
                          ),
                        ),
                        //const SizedBox(height: 4),
                        Container(
                          width: size.width * 0.95,
                          height: size.height * 0.04,
                          color: Colors.transparent,
                          child: const Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.grey, size: 18),
                              SizedBox(width: 5),
                              Text('Vía Av. Caracas y Av. P° Caroní'),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: size.height * 0.01),
                        
                        Container(
                          width: size.width * 0.95,
                          height: size.height * 0.07,
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: size.width * 0.65,
                          height: size.height * 0.07,
                          color: Colors.transparent,
                            child: InputDecorator(
                              decoration: InputDecoration(                              
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))                              
                              ),
                              child: Container(
                                width: size.width * 0.65,
                                height: size.height * 0.03,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: DropdownButton<String>(
                                  value: instructorSeleccionado,
                                  hint: Text(instructorSeleccionado),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  items: instructoresDisponibles.map((hora) {
                                    //bool deshabilitada = horasDeshabilitadas.contains(hora);
                                    return DropdownMenuItem<String>(
                                      value: hora,
                                      //enabled: !deshabilitada,
                                      child: Text(
                                        hora,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        instructorSeleccionado = value;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      
                        const SizedBox(height: 16),
                        
                        Container(
                          width: size.width * 0.95,
                          height: size.height * 0.04,
                          color: Colors.transparent,
                          child: const Text('Establecer fecha y hora',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
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
                          width: size.width * 0.95,
                          height: size.height * 0.085,
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: _openCalendarDialog,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Fecha',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                              ),
                              child: Text(
                                _selectedDate != null
                                    ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
                                    : 'Seleccionar fecha',
                              ),
                            ),
                          )
                        ),
                      
                        SizedBox(height: size.height * 0.0004),
                      
                        Container(
                          width: size.width * 0.95,
                          height: size.height * 0.11,
                          color: Colors.transparent,
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 0.42,
                                height: size.height * 0.35,
                                color: Colors.transparent,
                                child: buildDropdown('Hora de inicio', horaInicio, (value) {
                                setState(() {
                                  horaInicio = value;
                                });
                              }, size)),
                              
                              Container(
                                width: size.width * 0.42,
                                height: size.height * 0.35,
                                color: Colors.transparent,
                                child: buildDropdown('Hora de fin', horaFin, (value) {
                                setState(() {
                                  horaFin = value;
                                });
                              }, size)),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: size.height * 0.015),
                      
                        Container(
                          width: size.width * 0.95,
                          height: size.height * 0.04,
                          color: Colors.transparent,
                          child: const Text('Agregar un comentario',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: size.width * 0.95,
                          height: size.height * 0.1,
                          color: Colors.transparent,
                          child: const TextField(
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Agregar un comentario...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: size.width * 0.95,
                          height: size.height * 0.05,
                          color: Colors.transparent,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFBFF17D)),
                              onPressed: () {},
                              child: const Text('Reservar', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                      ],
                                      ),
                    ),
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

    Widget buildDropdown(String label, String? selectedValue, ValueChanged<String?> onChanged, Size size) {
    return Container(
      color: Colors.transparent,
      width: size.width * 0.9,
      height: size.height * 0.04,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            height: size.height * 0.03,
            child: Text(label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              )
            ),
          ),
          SizedBox(height: size.height * 0.002),
          
          InputDecorator(
            decoration: InputDecoration(
              //labelText: 'Fecha',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              //suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
            child: Container(
              height: size.height * 0.03,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: selectedValue,
                hint: const Text('00:00'),
                isExpanded: true,
                underline: const SizedBox(),
                items: horasDisponibles.map((hora) {
                  bool deshabilitada = horasDeshabilitadas.contains(hora);
                  return DropdownMenuItem<String>(
                    value: deshabilitada ? null : hora,
                    enabled: !deshabilitada,
                    child: Text(
                      hora,
                      style: TextStyle(
                        color: deshabilitada ? Colors.grey : Colors.black,
                        fontWeight: deshabilitada ? FontWeight.normal : FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}