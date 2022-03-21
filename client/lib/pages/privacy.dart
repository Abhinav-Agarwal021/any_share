import 'package:flutter/material.dart';

class PrivacyRoute extends StatelessWidget {
  const PrivacyRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Privacy"),
        ),
        body: const Privacy(),
      ),
    );
  }
}

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);
  @override
  PrivacyState createState() {
    return PrivacyState();
  }
}

class PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text(
          "Privacy Policy",
          style: TextStyle(fontSize: 25, color: Colors.cyan),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(bottom: 20, top: 5),
          child: const Text(
            "Rakshit, Abhinav built the Any Share app as an Ad Supported app. This SERVICE is provided by Rakshit, Abhinav at no cost and is intended for use as is.This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the saus meanings as in our Terms and Conditions, which are accessible at Any Share unless otherwise defined in this Privacy Policy.",
            style: TextStyle(color: Colors.yellow, fontSize: 17),
          ),
        ),
        const Text(
          "Information Collection and use",
          style: TextStyle(fontSize: 25, color: Colors.cyan),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(bottom: 20, top: 5),
          child: const Text(
            "For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information. The information that we request will be retained on your device and is not collected by us in any way. The app does use third-party services that may collect information used to identify you.",
            style: TextStyle(fontSize: 17, color: Colors.yellow),
          ),
        ),
        const Text(
          "Log Data",
          style: TextStyle(color: Colors.cyan, fontSize: 25),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(bottom: 20, top: 5),
          child: const Text(
              "we want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the tius and date of your use of the Service, and other statistics.",
              style: TextStyle(fontSize: 17, color: Colors.yellow)),
        ),
        const Text(
          "Cookies",
          style: TextStyle(color: Colors.cyan, fontSize: 25),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(top: 5, bottom: 20),
          child: const Text(
            "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use sous portions of this Service.",
            style: TextStyle(fontSize: 17, color: Colors.yellow),
          ),
        ),
        const Text(
          "Service Providers",
          style: TextStyle(color: Colors.cyan, fontSize: 25),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(bottom: 20, top: 5),
          child: const Text(
            "we may employ third-party companies and individuals to facilitate our service, to provide the service on our behalf, to assist us in analyzing how our service is used",
            style: TextStyle(color: Colors.yellow, fontSize: 17),
          ),
        ),
        const Text(
          "Security",
          style: TextStyle(color: Colors.cyan, fontSize: 25),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(top: 5, bottom: 20),
          child: const Text(
            "we value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.",
            style: TextStyle(color: Colors.yellow, fontSize: 17),
          ),
        )
      ],
    );
  }
}
