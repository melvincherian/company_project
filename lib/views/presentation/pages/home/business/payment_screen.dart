import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<TextEditingController> _controller =
      List.generate(7, (_) => TextEditingController());
  String? _paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Business Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSocialMediaTextField(
                'Facebook',
                'https://upload.wikimedia.org/wikipedia/commons/1/1b/Facebook_icon.svg',
                _controller[0]),
            _buildSocialMediaTextField(
                'Instagram',
                'https://upload.wikimedia.org/wikipedia/commons/e/e7/Instagram_logo_2016.svg',
                _controller[1]),
            _buildSocialMediaTextField(
                'Twitter',
                'https://upload.wikimedia.org/wikipedia/commons/6/6f/Logo_of_Twitter.svg',
                _controller[2]),
            _buildSocialMediaTextField(
                'Telegram',
                'https://upload.wikimedia.org/wikipedia/commons/8/82/Telegram_logo.svg',
                _controller[3]),
            _buildSocialMediaTextField(
                'Youtube',
                'https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg',
                _controller[4]),
            _buildSocialMediaTextField(
                'LinkedIn',
                'https://upload.wikimedia.org/wikipedia/commons/0/01/LinkedIn_Logo.svg',
                _controller[5]),
            _buildSocialMediaTextField(
                'Google Business URL',
                'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                _controller[6]),
            const SizedBox(height: 24.0),
            const Text(
              'Payment method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            _buildPaymentMethodRadioButton(
                'Credit/Debit card',
                'https://cdn-icons-png.flaticon.com/512/633/633611.png',
                'card'),
            _buildPaymentMethodRadioButton(
                'Phonepe',
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/6d/3a/bf/6d3abfde-5db0-2319-012a-b6fde0710c67/AppIcon-0-0-1x_U007emarketing-0-6-0-85-220.png/1200x630wa.png,',
                'phonepe'),
            _buildPaymentMethodRadioButton(
                'Google pay',
                'https://play-lh.googleusercontent.com/HArtbyi53u0jnqhnnxkQnMx9dHOERNcprZyKnInd2nrfM7Wd9ivMNTiz7IJP6-mSpwk',
                'googlepay'),
            _buildPaymentMethodRadioButton(
                'Paytm',
                'https://yt3.googleusercontent.com/nfovxGynnTWHMBFQfUjZzbFrViXNa9MYLZXuRFXhWGAfwWwIBsqV_4B5A_LGu0sZlMenuimmsQ=s900-c-k-c0x00ffffff-no-rj',
                'paytm'),
            _buildPaymentMethodRadioButton(
                'Cash on Delivery',
                'https://cdn-icons-png.flaticon.com/512/891/891419.png',
                'cash'),
                  _buildPaymentMethodRadioButton(
                'Razor Pay',
                'https://media.tradly.app/images/marketplace/34521/razor_pay_icon-ICtywSbN.png',
                'Razorpay'),
            const SizedBox(height: 32.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 28, 50, 139),
                ),
                onPressed: () {
                  //  ScaffoldMessenger.of(context);

                  print('Facebook: ${_controller[0].text}');
                  print('Instagram: ${_controller[1].text}');
                  print('Twitter: ${_controller[2].text}');
                  print('Telegram: ${_controller[3].text}');
                  print('Youtube: ${_controller[4].text}');
                  print('LinkedIn: ${_controller[5].text}');
                  print('Google Business URL: ${_controller[6].text}');
                  print('Payment Method: $_paymentMethod');
                },
                child: const Text(
                  'Save and Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaTextField(
      String label, String imageUrl, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10),
            // child: Image.network(
            //   imageUrl,
            //   width: 24,
            //   height: 24,
            //   // errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
            // ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodRadioButton(
      String label, String iconUrl, String value) {
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: _paymentMethod,
      onChanged: (String? newValue) {
        setState(() {
          _paymentMethod = newValue;
        });
      },
      secondary: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Image.network(
          iconUrl,
          width: 32,
          height: 32,
          errorBuilder: (_, __, ___) => const Icon(Icons.payment),
        ),
      ),
    );
  }
}
