/**
 * 아이디 중복확인, 폰번호 검사, 아이디 검사, 주민번호 검사
 */

 $(function(){
    $('#btnChkId').click(function(){
    	var id=$('#mem_id').val();
    	open('checkUserid.jsp?mem_id='+id,'chk',
    		'width=500,height=300,left=0,top=0,location=yes,resizable=yes');	
    });
    
});


function validate_phone(hp){
	 var pattern=new RegExp(/^[0-9]*$/g);
	 return pattern.test(hp);//정규식과 일치하면 true
	 /* 0 에서 9사이의 숫자로 시작하거나 끝나야 한다는 의미 (^는 시작, $는 끝을 의미)
	 닫기 대괄호(]) 뒤의 * 기호는 0번 이상 반복 */
 }
 
 function validate_userid(id){
	 var pattern = new RegExp(/^[a-zA-Z0-9_]+$/g);
	 return pattern.test(id);
	 
	 /* a에서 z 사이의 문자, A~Z사이의 문자, 0 에서 9사이의 숫자나 _로 
	 시작하거나 끝나야 한다는 의미
	 닫기 대괄호(]) 뒤의 + 기호는 이 패턴이 한 번 또는 그 이상 반복된다는 의미 */
 }
 
 function validate_ssn(ssn){
	var pattern=new RegExp(/^[0-9]*$/g);
	return pattern.test(ssn);
	
	/* 주민번호는 숫자로만 시작하거나 끝나야한다 */
}