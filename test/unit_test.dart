import 'package:test/test.dart';
import 'package:movieclient/livelist.dart';
import 'package:movieclient/dividendcode.dart';
import 'package:movieclient/newversion.dart';
import 'package:movieclient/liveitem.dart';
void main() {


/**
  test('live list unit test', ()async{
	print("live list unit start test for papa");
	List<LiveItem> livelist=await new PaPaList().getLiveList();
	
	for (var i = 1; i < livelist.length; i++) {
		print(livelist[i].toString());
	}
       
	print("live list test for papa end");
  	
  });
**/
test('hongbao code unit test', ()async{
        print("code unit start test");
        var redcode=await new NewVersion().getversionCode();
        print(redcode);
     
  });

}
