<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/sidebars/">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="<%=request.getContextPath()%>/css/main2.css?no=67" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/contentStyle.css" rel="stylesheet" type="text/css"/>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">

<title>지도 검색</title>
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
</head>
<body>
<main class="mainDiv">
	<div class="mainDivGr5 center">
		<p class="p c">[ 주소로 위도, 경도 좌표값 얻기 ]</p>
		<input type="text" id="address" value=""
			class="form-control inputbox2">
		<input type="button" value="좌표값 검색" onclick="addressChk()"
			class="btn btn-sm btn-block loginBt mt-1">
		<input type="button" value="닫기" id="close"
			class="btn btn-sm btn-block regist mt-2" style="margin-bottom:10px;">
	
		<script type="text/javascript">
		$(function(){
			$('#close').click(function(){
				if($('#address').val()==""){
					alert('주소를 검색하세요');
					return false;
				}else{
					self.close();
				}
			});	
		});
		</script>
	
		<div id="map" style="width:100%;height:360px;border-radius: 10px;"></div>
		<div id="coordXY"></div>
	</div>
</main>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b09b1236d9b8273da3a250306575a025&libraries=services"></script>

<script type="text/javascript">
var address      = document.getElementById("address");
var mapContainer = document.getElementById("map");
var coordXY   = document.getElementById("coordXY");
var mapOption;
var map;
var x,y          = "";
var marker;
if (address.value=="") {

 mapOption = {
  center: new daum.maps.LatLng(33.450701, 126.570667), // 임의의 지도 중심좌표 , 제주도 다음본사로 잡아봤다.
        level: 4            // 지도의 확대 레벨

 };

}

// 지도 생성
map = new daum.maps.Map(mapContainer, mapOption);


function addressChk() {
	
	var gap = address.value; // 주소검색어
 if (gap=="") {
  alert("주소 검색어를 입력해 주십시오.");
  address.focus();
  return;
 }
 
 
 // 주소-좌표 변환 객체를 생성
 var geocoder = new daum.maps.services.Geocoder();



 // 주소로 좌표를 검색
 geocoder.addressSearch(gap, function(result, status) {
  
  // 정상적으로 검색이 완료됐으면,
  if (status == daum.maps.services.Status.OK) {
   
   var coords = new daum.maps.LatLng(result[0].y, result[0].x);

   y = result[0].x;
   x = result[0].y;



   // 결과값으로 받은 위치를 마커로 표시합니다.
  marker = new daum.maps.Marker({
    map: map,
    position: coords
   });



   // 인포윈도우로 장소에 대한 설명표시
   var infowindow = new daum.maps.InfoWindow({
    content: '<div style="width:150px;text-align:center;padding:5px 0;">좌표위치</div>'
   });

   infowindow.open(map,marker);
   
   // 지도 중심을 이동
   map.setCenter(coords);
   $(opener.document).find('#resAddr').val(gap);
   $(opener.document).find('#hiddenAddr').val(gap);
   $(opener.document).find('#resX').val(x);
	$(opener.document).find('#resY').val(y);
  }
 });
}


</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

</body>
</html>