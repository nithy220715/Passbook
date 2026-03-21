
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/storage_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState()=>_DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>{
  List<TransactionModel> txs=[];

  load() async{
    txs=await StorageService.load();
    setState((){});
  }

  @override
  void initState(){ super.initState(); load(); }

  double get income=>txs.where((e)=>e.amount>0).fold(0,(a,b)=>a+b.amount);
  double get expense=>txs.where((e)=>e.amount<0).fold(0,(a,b)=>a+b.amount.abs());

  editTx(int i){
    var t=txs[i];
    TextEditingController a=TextEditingController(text:t.amount.abs().toString());
    TextEditingController n=TextEditingController(text:t.note);

    showDialog(context: context, builder:(_)=>AlertDialog(
      title: const Text("Edit"),
      content: Column(mainAxisSize: MainAxisSize.min, children:[
        TextField(controller:a),
        TextField(controller:n),
      ]),
      actions:[
        ElevatedButton(onPressed:() async{
          double amt=double.parse(a.text);
          if(t.amount<0) amt=-amt;
          txs[i]=TransactionModel(date:t.date, amount:amt, note:n.text);
          await StorageService.save(txs);
          load();
          Navigator.pop(context);
        }, child: const Text("Save"))
      ],
    ));
  }

  Map<String,double> monthly(){
    Map<String,double> m={};
    for(var t in txs){
      var k=t.date.substring(0,7);
      m[k]=(m[k]??0)+t.amount;
    }
    return m;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Passbook Premium")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children:[

          // Premium cards
          Row(children:[
            Expanded(child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors:[Colors.green,Colors.teal]),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Text("Income ₹$income")
            )),
            const SizedBox(width:10),
            Expanded(child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors:[Colors.red,Colors.orange]),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Text("Expense ₹$expense")
            )),
          ]),

          const SizedBox(height:20),

          // list
          Expanded(child: ListView.builder(
            itemCount: txs.length,
            itemBuilder:(_,i){
              var t=txs[i];
              return Card(
                child: ListTile(
                  title: Text(t.note),
                  subtitle: Text(t.date),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      Text("₹${t.amount}"),
                      IconButton(icon:const Icon(Icons.edit),onPressed:()=>editTx(i)),
                    ],
                  ),
                ),
              );
            }
          )),

          const SizedBox(height:10),

          // monthly summary
          Expanded(child: ListView(
            children: monthly().entries.map((e)=>ListTile(
              title: Text(e.key),
              trailing: Text("₹${e.value}")
            )).toList(),
          ))

        ]),
      ),
    );
  }
}
