abstract class MoveItem {
  final String name;
  final String playpath;
final String director;
final String thumbnail;
  LiveItem(this.name, this.playpath,this.director,this.thumbnail);
  getMovename();
  getUid();
  toString() {
    if (name != null && playpath != null)
      return "name is:" + name + "playpath is:" + playpath;
    else
      return null;
  }
}

class YKOMoveItem implements MoveItem {
  String uid="";
  final String name;
  final String playpath;
  final String director;
	final String thumbnail;
  String type;
  String lan;
  YKOMoveItem(this.name, this.playpath,this.director,this.thumbnail);
  setType(type) {
    this.type = type;
  }

  setLan(lan) {
    this.lan = lan;
  }
  

  getMovename() {
    return this.name;
  }

  setUid(uid) {
    this.uid = uid;
  }

  getUid() {
    return this.uid;
  }
}


