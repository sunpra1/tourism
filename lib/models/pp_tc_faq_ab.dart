

class PpTcFaqAb {
  static const String _key_pp_tc_faq_ab = "pptcfaqList";
  List<PpTcFaqAbDetails> ppTcFaqAbDetailsList;

  PpTcFaqAb({required this.ppTcFaqAbDetailsList});

  factory PpTcFaqAb.fromMap(Map<String, dynamic> map) {
    return PpTcFaqAb(
      ppTcFaqAbDetailsList:
          PpTcFaqAbDetails.fromListMap(map[_key_pp_tc_faq_ab]),
    );
  }
}

class PpTcFaqAbDetails {
  static const String _key_content = "content";

  String content;

  PpTcFaqAbDetails({required this.content});

  factory PpTcFaqAbDetails.fromMap(Map<String, dynamic> map) {
    return PpTcFaqAbDetails(
      content: map[_key_content],
    );
  }

  static List<PpTcFaqAbDetails> fromListMap(List<dynamic> listMap) {
    List<PpTcFaqAbDetails> items = [];
    listMap.forEach((element) {
      items.add(PpTcFaqAbDetails.fromMap(element));
    });
    return items;
  }
}
