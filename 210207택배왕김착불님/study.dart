// 질문에 관련 된 기반 내용입니다,
// 반드시 흐름 및 사용 방법에 대한 암기가 필요합니다 :)
// * DartPad(https://dartpad.deev) 에서 연습하시면 편합니다 ~

void main(){
  
  // 문자열 안에 변수 및 식 넣기
  
  String ex1 = "안녕하세요 000 님";
  print( ex1 );
  
  
  String name = '택배왕';
  String ex2 = "안녕하세요 $name 님";
  print(ex2);
  
  int number1 = 123;
  String ex3 = "안녕하세요 $number1 님";
  print(ex3);
  
  int number2 = 123;
  String ex4 = "안녕하세요 ${number2+321} 님";
  print(ex4);
  
  List<String> phoneNumberList 
    = ['010-1111-1111', '010-2222-2222', '010-3333-3333'];
  String ex5 
    = "안녕하세요 $name 님, 제 연락처는 ${phoneNumberList[2].toString()} 입니다";
  print(ex5);
  
  print("---------------------------");
  
  // 변수와 함수, 그리고 중괄호 {} 코드의 범위
  // - 전역 변수
  String myName = '제임쓰';
  {
    print(myName);
    String uName = '택배왕';
    print(uName);
  }
  /// 오류 : 중괄호가 닫히며 } 코드의 범위가 종료 되었으므로 변수 uName은 찾을 수 없음.
  // myName 의 경우 전체 범위가 종료되지 않았으며 중괄호가 열리기 { 시작한 코드의 범위는 
  // 전체 main(){}의 중괄호에 {} 포함되어있으므로 찾을 수 있음
  // print(uName);
  
  // 함수 
  String func1(){
    return '왕';
  }
  
  print( func1() );
  
  // - 택배왕 소방왕 정비왕 처럼 표현하고 싶을 때
  //   과정이 같다면 변하는 값을 인자로 사용
  String func11(){
    return "택배 왕";
  }
  String func22(){
    return "소방 왕";
  }
  String func33(){
    return "정비 왕";
  }
  print(func11());
  print(func22());
  print(func33());
  
  // -> 중복되는 내용을 인자로 사용
  String func2(String data){
    return "$data 왕";
  }
  
  print( func2("택배") );
  print( func2("소방") );
  print( func2("정비") );
  
  print("---------------------------");
  // 전역 & 지역 변수와 함수의 조화
  
  void myPressed(){
    print("Example2");
    return;
  }
  
  void myPressed2(String data){
    print("Example3 : $data");
    return;
  }
  // 줄여서 표현할 수 있음
  void myPressed3({String data}) => print("Example4 : $data");
  
  ListView.builder(
    builder: (String context, int index){
      return TextButton(
        child: Text("안녕하세요"),
        onPressed: (){
          print("Example1");
        },
        onPressed2: myPressed,
        onPressed3: (){
          myPressed2("예제3");
          return;
        },
        onPressed4: () => myPressed3(data: "예제4")
      );
    }
  );
  
}

class ListView{
  int index = 1;
  String context = "2";
  dynamic Function(String context, int index) builder;
  ListView.builder({this.builder}){
    this.builder(this.context, this.index);
  }
}

// Flutter와 동일하게 표현해보기 위한 예제 Class 입니다 

class TextButton{
  Text child;
  Function onPressed;
  Function onPressed2;
  Function onPressed3;
  Function onPressed4;
  TextButton({this.child, this.onPressed, this.onPressed2, 
              this.onPressed3, this.onPressed4}){
    this.onPressed();
    this.onPressed2();
    this.onPressed3();
    this.onPressed4();
  }
}

class Text{
  String data;
  Text(data);
}
