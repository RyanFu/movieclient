import 'package:test/test.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
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
test('test html parse', (){
var document = parse(
      '<body>Hello world! <a href="www.html5rocks.com">HTML5 rocks!');
  print(document.outerHtml);
	
     
  });

}
