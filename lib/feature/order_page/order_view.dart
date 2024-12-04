import 'package:brasil_fields/brasil_fields.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food_restaurants/core/domain/order_status.dart';
import 'package:galaxy_food_restaurants/feature/order_page/orderview_viewmodel.dart';
import 'package:galaxy_food_restaurants/galaxy_theme.dart';
import 'package:resizable_widget/resizable_widget.dart';
import 'package:lottie/lottie.dart';

import '../../core/domain/buy.dart';
import '../../core/widgets/galaxy_button.dart';

class OrderView extends StatefulWidget{

  final List<Buy> finishedList;
  final List<Buy> waitingList;
  final Function() update;

  const OrderView({super.key, required this.finishedList, required this.waitingList, required this.update});

  @override
  State<StatefulWidget> createState() => _OrderViewState();

}

class _OrderViewState extends State<OrderView>{

  final viewModel = OrderViewViewModel();

  @override
  void initState() {
    super.initState();
    widget.update();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
      child: ResizableWidget(
        percentages: const [0.4, 0.6],
        separatorColor: GalaxyFoodTheme.normal.micaBackgroundColor,
        children: [

          SingleChildScrollView(
            child: Observer(
                builder: (context) {
                  return Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: GalaxyFoodTheme.normal.activeColor,
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.elliptical(1300, 100)
                              ),
                              border: const Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Colors.white
                                  )
                              )
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 25),
                          width: double.maxFinite,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text("PEDIDOS", style: GalaxyFoodTheme.text.titleLarge,),
                          )
                      ),


                      if (widget.waitingList.isEmpty && widget.finishedList.isEmpty)
                        SizedBox(
                          height: 500,
                          width: 350,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Lottie.asset(
                                    "lib/animations/OrderAnimationLottie.json",
                                    fit: BoxFit.fill,
                                    alignment: Alignment.topCenter
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 15, left: 15),
                                child: Text("ESPERANDO POR MAIS PEDIDOS!",
                                  style: GalaxyFoodTheme.text.headlineSmall!.merge(
                                      const TextStyle(
                                        color: Color(0xfffafafa),
                                      )
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (widget.waitingList.isNotEmpty)
                        ..._getWaiting(),
                      if (widget.finishedList.isNotEmpty)
                        ..._getFinished(),

                    ],
                  );
                }
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Observer(
                  builder: (context) {

                    final subtotal = _getTotalValue(viewModel.selectedBuy);

                    final int differenceDate =
                        (viewModel.selectedBuy?.date??DateTime(0))
                            .difference(DateTime.now()).inHours;
                    final dynamic date = differenceDate > -24
                        ? "Hoje"
                        : differenceDate > -48
                        ? "Ontem"
                        : differenceDate > -168
                        ? _getWeekDay(viewModel.selectedBuy?.date?? DateTime(0))
                        : UtilData.obterDataDDMMAAAA(viewModel.selectedBuy?.date?? DateTime(0));

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            SizedBox(
                              width: 350,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("CLIENTE:", style: GalaxyFoodTheme.text.titleMedium,),
                                  Text(
                                    viewModel.selectedBuy?.client.name??"",
                                    style: GalaxyFoodTheme.text.bodyLarge,
                                  ),
                                  Text(
                                    viewModel.selectedBuy?.client.cpf??"",
                                    style: GalaxyFoodTheme.text.bodyLarge,
                                  )

                                ],
                              ),
                            ),

                            SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ENDEREÇO:", style: GalaxyFoodTheme.text.titleMedium,),
                                  Text(
                                    viewModel.selectedBuy?.sentAddress.toString()??"",
                                    style: GalaxyFoodTheme.text.bodyLarge,

                                  ),
                                ],
                              ),
                            )

                          ],
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Divider(),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text("PEDIDO:", style: GalaxyFoodTheme.text.titleMedium,),
                        ),

                        Text("ID PEDIDO: ${viewModel.selectedBuy?.id??""}",style: GalaxyFoodTheme.text.bodyLarge,),
                        Text(
                          "$date, às ${UtilData.obterHoraHHMM(
                              viewModel.selectedBuy?.date??DateTime(0)
                          )}",
                          style: GalaxyFoodTheme.text.bodyLarge,
                        ),

                        Container(
                          decoration: BoxDecoration(
                              color: GalaxyFoodTheme.normal.cardColor,
                              borderRadius: const BorderRadius.all(Radius.circular(10))
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.all(20),
                          width: double.maxFinite,
                          height: 300,
                          child: ListView.builder(
                            itemCount: viewModel.selectedBuy?.items.length??0,
                            itemBuilder: (context, index){
                              final item = viewModel.selectedBuy?.items[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 2.5),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(5),
                                  tileColor: WidgetStatePropertyAll(
                                      GalaxyFoodTheme.normal.micaBackgroundColor
                                  ),
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text("${item!.quantity}x", style: GalaxyFoodTheme.text.titleLarge,),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.item.name,
                                              style: GalaxyFoodTheme.text.bodyLarge,
                                            ),

                                            Text(
                                              item.item.id!,
                                              style: GalaxyFoodTheme.text.bodySmall,
                                            ),
                                          ],
                                        ),

                                        Text(
                                          UtilBrasilFields.obterReal(item.item.price*item.quantity),
                                          style: GalaxyFoodTheme.text.bodyLarge,
                                        )
                                      ],
                                    ),
                                  ),

                                ),
                              );
                            },
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  "Forma de Pagamento: ${viewModel.selectedBuy?.paymentForm.toString()??""}",
                                  style: GalaxyFoodTheme.text.bodyLarge,
                                ),

                                if (
                                viewModel.selectedBuy != null && viewModel.selectedStatus != null &&
                                    viewModel.selectedBuy?.orderStatus != OrderStatus.delivered &&
                                    viewModel.selectedBuy?.orderStatus != OrderStatus.canceled
                                )
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ComboBox(
                                      value: viewModel.selectedStatus,
                                      items: List.generate(
                                        OrderStatus.values.length - viewModel.selectedStatus!.code,
                                            (index) {
                                          final status = OrderStatus.values[viewModel.selectedStatus!.code + index];
                                          return ComboBoxItem(
                                            value: status,
                                            child: Text(status.toString()),
                                          );
                                        },
                                      ),
                                      onChanged: (status) {
                                        viewModel.onChangeStatus(context, status!, widget.update);
                                      },
                                    ),
                                  )
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Subtotal: ${
                                      UtilBrasilFields.obterReal(
                                          subtotal
                                      )
                                  }",
                                  style: GalaxyFoodTheme.text.bodyLarge,
                                ),
                                Text(
                                  "Taxa de Entrega: ${
                                      UtilBrasilFields.obterReal(
                                          viewModel.selectedBuy?.deliveryFee??0.0
                                      )
                                  }",
                                  style: GalaxyFoodTheme.text.bodyLarge,
                                ),
                                Text(
                                  "Desconto: ${
                                      UtilBrasilFields.obterReal(
                                          viewModel.selectedBuy?.discount??0.0
                                      )
                                  }",
                                  style: GalaxyFoodTheme.text.bodyLarge,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    "Total: ${
                                        UtilBrasilFields.obterReal(
                                            subtotal
                                                + (viewModel.selectedBuy?.deliveryFee??0.0)
                                                - (viewModel.selectedBuy?.discount??0.0)
                                        )
                                    }",
                                    style: GalaxyFoodTheme.text.titleMedium,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: GalaxyButton(
                                    onPressed: () => viewModel.printing(),
                                    child: const Text("IMPRIMIR")
                                ),
                              ),
                              GalaxyButton(
                                  onPressed: () => viewModel.onChangeStatus(context, OrderStatus.canceled, widget.update),
                                  child: const Text("CANCELAR")
                              ),
                            ],
                          ),
                        )

                      ],
                    );
                  }
              ),
            ),
          )
        ],
      ),
    );
  }

  double _getTotalValue(Buy? buy){
    var value = 0.0;
    if (buy == null) return 0;
    for (final item in buy.items){
      value += item.quantity*item.item.price;
    }
    return value;
  }

  List<Widget> _getWaiting(){
    if (widget.waitingList.isNotEmpty){
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("EM ESPERA (${widget.waitingList.length})", style: GalaxyFoodTheme.text.titleMedium,),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 5),
          child: Divider(),
        ),

        ...List.generate(
          widget.waitingList.length,
              (index) => Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: OrderItem(
              widget.waitingList[index],
              onClick: () {
                viewModel.onSelectOrder(widget.waitingList[index]);
              },
            ),
          ),
        )
      ];
    }
    return [];
  }

  List<Widget> _getFinished(){
    if (widget.finishedList.isNotEmpty){
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("FINALIZADOS (${widget.finishedList.length})", style: GalaxyFoodTheme.text.titleMedium,),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 5),
          child: Divider(),
        ),

        ...List.generate(
          widget.finishedList.length,
              (index) => Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: OrderItem(
              widget.finishedList[index],
              onClick: (){
                viewModel.onSelectOrder(widget.finishedList[index]);
                setState(() {});
              },
            ),
          ),
        )
      ];
    }
    return [];
  }
}


class OrderItem extends StatefulWidget{
  final Buy buy;
  final Function() onClick;

  const OrderItem(this.buy, {super.key, required this.onClick});

  @override
  State<StatefulWidget> createState() => _OrderItemState();

}

class _OrderItemState extends State<OrderItem>{

  @override
  Widget build(BuildContext context) {
    final int differenceDate = widget.buy.date.difference(DateTime.now()).inHours;
    final dynamic date = differenceDate > -24
        ? "Hoje"
        : differenceDate > -48
        ? "Ontem"
        : differenceDate > -168
        ? _getWeekDay(widget.buy.date)
        : UtilData.obterDataDDMMAAAA(widget.buy.date);

    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 500,
          minWidth: 375,
        ),
        height: 175,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: GalaxyFoodTheme.normal.cardColor,
            borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(7.5),
                left: Radius.circular(17.5)
            ),
            border: Border(left: BorderSide(
                color: widget.buy.orderStatus.color,
                width: 10
            )),
            boxShadow: const [
              BoxShadow(
                  color: Color(0xaa000000),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 16
              ),
            ]
        ),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 280,
                        child: Text(widget.buy.client.name, style: GalaxyFoodTheme.text.titleLarge,)
                    ),
                    Text(UtilBrasilFields.obterReal(totalValue), style: GalaxyFoodTheme.text.titleMedium,),
                  ],
                ),

                Column(
                  children: [

                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: widget.buy.orderStatus.color
                      ),
                      child:  Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 16),
                          child: Text(widget.buy.orderStatus.toString())
                      ),
                    ),


                  ],
                )
              ],
            ),

            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "$date, às ${UtilData.obterHoraHHMM(widget.buy.date)}",
                          style: GalaxyFoodTheme.text.titleMedium,
                        ),
                      ),

                      Text("Forma de Pagamento: ${widget.buy.paymentForm.toString()}", style: GalaxyFoodTheme.text.bodyMedium,),
                      Text("Quantidade de Produtos: $quantity", style: GalaxyFoodTheme.text.bodyMedium,)
                    ],
                  ),
                )
            ),

          ],
        ),
      ),
    );

  }

  double get totalValue{
    var value = 0.0;
    for (final item in widget.buy.items){
      value += item.quantity*item.item.price;
    }
    return value;
  }

  int get quantity{
    var value = 0;
    for (final item in widget.buy.items){
      value += item.quantity;
    }
    return value;
  }

}

String _getWeekDay(DateTime date){
  switch(date.weekday){
    case(DateTime.sunday):
      return "Domingo";
    case(DateTime.monday):
      return "Segunda-Feira";
    case(DateTime.tuesday):
      return "Terça-Feira";
    case(DateTime.wednesday):
      return "Quarta-Feira";
    case(DateTime.thursday):
      return "Quinta-Feira";
    case(DateTime.friday):
      return "Sexta-Feira";
    case(DateTime.saturday):
      return "Sabádo";
    default:
      return "";
  }
}