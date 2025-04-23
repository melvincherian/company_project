import 'package:company_project/features/presentation/pages/home/business/payment_screen.dart';
import 'package:flutter/material.dart';

class AddBusiness extends StatelessWidget {
  const AddBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        title: Text('Add Business Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
        
        ),
        leading:IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios))
       ),
       body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           buildTextfield('Business Name/Person Name', 'Manoj'),
            buildTextfield("Tagline / Owner Name", ""),
            buildTextfield("Contact Number", "+919999999999"),
            buildTextfield("Whatsapp Number", "+919999999999"),
            buildTextfield("Address", "Enter your address"),
            buildTextfield("Email", "", borderColor: Colors.blue),
            buildTextfield("Website", ""),
            SizedBox(height: 20,),
            DottedBorderWidget(),
            SizedBox(height: 8,),
            Row(
              children: [
                Icon(Icons.info_outline,color: Colors.grey,),
                SizedBox(height: 8,),
                Expanded(
                  child: Text("Don't have brand logo choose from library.",
                  style: TextStyle(color: Colors.black54)
                  )
                  )
              ],
            ),
            SizedBox(height: 20,),
            SizedBox(width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 74, 71, 248),
                ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PaymentScreen()));
              }, child: Text('Save and Next',style: TextStyle(color: Colors.white),)),
            )

          ],
        ),
       ),
    );
  }

  Widget buildTextfield(String label,String hint,{Color?borderColor}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
             borderSide: BorderSide(
              color: borderColor ?? Colors.grey.shade300,
              width: 1.5,
            ),
          )
        ),
      ),
      );
  }
}

class DottedBorderWidget extends StatelessWidget {
  const DottedBorderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage:NetworkImage('https://s3-alpha-sig.figma.com/img/4e71/f25b/9da2a00e2c56e397c0aab306442e3108?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=bXabt491VjIxVWXU4BwFOpRQ0~dptbneilGiT0gLdaKzX1SjMqGtvvfCpkQG~RWVPnkq11fJt8JmQJ5af5eZY3ng~K-gfxAjE117qFSPH-Hms5MkgfGBrDbcWrI3yZCNDM2G4gje4blA-m3jaRn9ZqRM8qobMkHHK5huEGvljuXC5aFsKaZq3VXT82fLc-em0wuVfGsEy~5TtzK5i7AqD7N~jD2ZT3C4xzKbSBXi0OFqwQUIs03A3I0wv7BxDbBq3g50CQs9rVXd77dNpPoAq4KYz2ZzsmyXgUlJhXAmugo4uIOssMg-uxiTATfvprOVsXRMhAfcrcT9XKu9lFpYkA__') // replace with actual image
          ),
          const SizedBox(height: 8),
          const Text(
            "Logo Name",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}