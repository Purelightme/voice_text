class Speech {
  String corpusNo;
  String errMsg;
  int errNo;
  List<String> result;
  String sn;

  Speech({this.corpusNo, this.errMsg, this.errNo, this.result, this.sn});

  Speech.fromJson(Map<String, dynamic> json) {
    corpusNo = json['corpus_no'];
    errMsg = json['err_msg'];
    errNo = json['err_no'];
    result = json['result'].cast<String>();
    sn = json['sn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['corpus_no'] = this.corpusNo;
    data['err_msg'] = this.errMsg;
    data['err_no'] = this.errNo;
    data['result'] = this.result;
    data['sn'] = this.sn;
    return data;
  }
}
