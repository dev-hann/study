# 리스트에서 객체를 제거할때,

시발점.

어디서부터 시작된진 모르겠다, 리스트에서 객체를 제거할경우가 굉장히 많다. 

어느세부턴가 이상한 습관이 생겨버렸다. 아마 코딩테스트 연습 기점으로 생긴 습관같다. 

아래 코드를 봐보자.

```dart
// create target list
final List<SomeCallback> listenerList=[];

// addListener
void addListener(SomeCallback listener){
	if(listListener.contain(listener))return;
	listenerList.add(listener);
}

// removeListener
void removeListener(SomeCallback listener){
	// ! Problem Here !
	if(!listenerList.contain(listener))return;
	listenerList.remove(listener);
}
```

본 코드는 평소 구체화 시키던 리스너 코드였다. 

문제는 removeListener()함수에서 listenerList 에 객체가 있는지 한번 확인하고 작업을 실행하는것이다.  

과연 이게 합리적인가? 퍼포먼스상 문제가 있는가?

결과부터 보면 위 상황에선 **합리적이진 않다**, **퍼포먼스에도 문제**가 있다. 

실험 코드부터 봐보자

```dart
	 void main(List<String> arguments) {                                                                                                                                                                             
     final List<int> targetList = List.generate(100000, (index) => index);                                                                                                                                         
     final List<Duration> resultList = [];                                                                                                                                                                         
                                                                                                                                                                                                                   
     final Stopwatch watch = Stopwatch();                                                                                                                                                                          
                                                                                                                                                                                                                   
     for (int index = 0; index < 100; index++) {                                                                                                                                                                   
       watch.start();       
			// HERE!!                                                                                                                                                                                       
       targetList.remove(-1);                                                                                                                                                                                      
      // if (targetList.contains(-1)) {                                                                                                                                                                           
        // targetList.remove(-1);                                                                                                                                                                                 
      // }                                                                                                                                                                                                        
      watch.stop();                                                                                                                                                                                               
      resultList.add(watch.elapsed);                                                                                                                                                                              
      watch.reset();                                                                                                                                                                                              
    }                                                                                                                                                                                                             
                                                                                                                                                                                                                  
    resultList.sort();                                                                                                                                                                                            
    print("min: ${resultList.first}");                                                                                                                                                                            
    print("max: ${resultList.last}");                                                                                                                                                                             
    final sum =                                                                                                                                                                                                   
        resultList.map((e) => e.inMicroseconds).fold<int>(0, (a, b) => a + b);                                                                                                                                    
    print("sum in micSec : $sum");                                                                                                                                                                                
  }                                                                                                                                                                                                               
```

위 코드를 돌려보면 유의미하다면 유의미한,

무의미하다면 무의미한 차이가 보일것이다.

그러면 언제 if문을 통해 필터를 해주어야하는가..는 

근본적인 if의 사용법으로 가보자..

…

…

결론적으론 뒤에 간단한 작업이 아닌, 좀더 복잡하거나 긴 코드가 있을경우

if문으로 걸러주면 좋겠다. 

간단하게 리스트에서 삭제해주는 작업은 걸러줄 필요없다.

! 실험중 발견한 사실?

min 값이 if 문을 사용한것과 사용하지않은것 둘다 같은 값이나왔다?

왜그런 걸까? 다시 조사해보자..
