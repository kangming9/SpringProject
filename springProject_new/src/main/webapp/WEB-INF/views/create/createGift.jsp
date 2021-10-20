<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		var gifts = 0; //등록된 선물의 개수, gift의 크기
		var details = 0; //등록된 구성품의 개수, detail의 크기
		
		var gift = new Array(); //선물 객체를 저장할 배열
		
		var detail = new Array(); //구성품 객체를 저장할 배열
		
		//관련된 이벤트가 있으면 경고 메시지 리셋
		$("#giftname").on("propertychange change keyup paste input", function(){ 
			$("#message_name").text("");
		});
		$("#giftprice").on("propertychange change keyup paste input", function(){
			$("#message_price").text("");
		});
		$("#giftcount").on("propertychange change keyup paste input", function(){
			$("#message_count").text("");
		});
		
		$("#detailname").on("propertychange change keyup paste input", function(){
			$("#message_dname").text("");
		});
		$("#detailcount").on("propertychange change keyup paste input", function(){
			$("#message_dcount").text("");
		});
		
		$("#gift").change(function(){ //선택한 선물이 변경될 때 select(detail)의 구성품 목록을 변경
			
			$('#detail').children('option').remove(); //현재 보여지고 있는 구성품 목록 삭제
			
			$("#gname").text("현재 선택된 선물 : " + $("#gift option:selected").text());
			
			for(var i = 0; i < details; i++){
				if(detail[i].gname == $("#gift option:selected").text()){
					var op = document.createElement("option");
					op.value = i;
					op.text = detail[i].name;
					document.getElementById("detail").add(op);
				}
			}
		});
		
		$("#add_gift").click(function(){ //선물 추가 버튼을 클릭할 때
			
			var gobj = new Object(); //선물 내용을 저장할 객체
			
			if($("#giftname").val().trim() == ""){ //선물 이름이 입력되지 않으면
				$("#message_name").css("color", "red").text("선물 이름 입력 필수"); //경고 메시지 출력
				$("#name").val("").focus();
			}else if($("#giftprice").val() == ""){ //선물 가격이 입력되지 않으면
				$("#message_price").css("color", "red").text("선물 가격 입력 필수"); //경고 메시지 출력
				$("#giftprice").val("").focus();
			}else if($('#checklimit').text() == "limited" && $("#giftcount").val() == ""){ //선물이 한정 상품일 때 한정 수량이 입력되지 않으면
				$("#message_count").css("color", "red").text("선물 수량 입력 필수"); //경고 메시지 출력
				$("#giftcount").val("").focus();
			}else{ //모든 값이 입력되어 있으면
				
				var dup = false;
				$("#gift option").each(function(){ //현재 있는 선물 목록에서
					console.log(this.value  + " == " + $("#giftname").val());
					if(this.text == $("#giftname").val()) { //중복을 확인하고
						dup = true;
						return;
					}
				});
				
				if(dup){
					alert("선물의 이름이 중복됩니다.\n각 선물의 이름은 중복되지 않게 입력해주세요.");
					$("#name").val("").focus();
				}else{ //중복되지 않았으면
					//배열에 상품 내용을 배열로 저장
					
					gobj.name = $("#giftname").val();
					gobj.price = $("#giftprice").val();
					gobj.ship = $('#checkship').text();
					
					if($('#checklimit').text() == "limited"){
						gobj.count = $("#giftcount").val();
						
					}else{
						gobj.count = -1; //한정이 아닐 경우, 수량을 -1로 저장
					}
				
					gifts = gift.push(gobj);
				
					var op = document.createElement("option");
					op.value = gifts - 1; //현재 선물의 인덱스를 value로
					op.text = gift[gifts - 1].name; //텍스트에 현재 선물의 이름을 보여줄 수 있게 첫번째 값을 저장
					document.getElementById("gift").add(op);
					
					alert("선물 [" + gift[gifts - 1].name + "] 추가 완료.");
				}
			}
		});
		
		$("#delete_gift").click(function(){ //선물 삭제 버튼을 클릭할 때
			
			if($("#gift option:selected").text() == ""){ //선물이 선택되지 않았으면
				alert("삭제할 선물을 선택해주세요."); //경고 메시지
			}else{ //선물이 선택되었으면
				var index = $("#gift option:selected").val();
				var name = $("#gift option:selected").text();
				
				for(var i = 0; i < details; i++){ //해당하는 구성품들을 지우고
					if(detail[i].gname == name){
						detail[i] = null;
						$('#detail').children('option').remove();
					}
				}
				
				gift[index] = null;
				
				$("#gift option:selected").remove(); //선택된 선물을 삭제
				
				$("#gname").text("현재 선택된 선물 : 없음");
				
				alert("선물 [" + name + "] 및 구성품 삭제 완료.");
			}
		});
		
		$("#add_detail").click(function(){ //구성품 추가 버튼을 클릭할 때
			
			var dobj = new Object(); //구성품 내용을 저장할 객체
			
			if($("#gift option:selected").text() == ""){ //선물 이름이 입력되지 않으면
				alert("구성품을 추가할 선물을 선택해주세요.");
			}else{
			
				if($("#detailname").val().trim() == ""){ //구성품 이름이 입력되지 않으면
					$("#message_dname").css("color", "red").text("구성품 이름 입력 필수"); //경고 메시지 출력
					$("#detailname").val("").focus();
				}else if($("#detailcount").val() == ""){ //구성품 수량이 입력되지 않으면
					$("#message_dcount").css("color", "red").text("구성품 수량 입력 필수"); //경고 메시지 출력
					$("#detailcount").val("").focus();
				}else{ //모든 값이 입력되어 있으면
					
					dobj.gname = $("#gift option:selected").text();
					dobj.name = $("#detailname").val();
					dobj.count = $("#detailcount").val();
					
					details = detail.push(dobj);
					
					var op = document.createElement("option");
					op.value = details - 1; //현재 선물이 저장된 인덱스를 value로
					op.text = detail[details - 1].name; //텍스트에 현재 선물의 이름을 보여줄 수 있게 첫번째 값을 저장
					document.getElementById("detail").add(op);
					
					alert("구성품 [" + detail[details - 1].name + "] 추가 완료.");
				}
				
			}
		});
		
		$("#delete_detail").click(function(){ //구성품 삭제 버튼을 클릭할 때
			
			if($("#detail option:selected").text() == ""){ //구성품이 선택되지 않았으면
				alert("삭제할 구성품을 선택해주세요.");
			}else{
				var index = $("#detail option:selected").val();
				var name = $("#detail option:selected").text();
				
				detail[index] = null;
				
				$("#detail option:selected").remove();
				
				alert("구성품 [" + name + "] 삭제 완료.");
			}
		});
		
		$("#create_gift_form").submit(function(){
			var giftsize = 0;
			var detailsize = 0;
			
			var answer = true;
			
			//선물과 구성품의 실제 개수를 구함
			for(var i = 0; i < gifts; i++){ 
				if(gift[i]){
					giftsize++;
				}
			}
			
			for(var i = 0; i < details; i++){ 
				if(detail[i]){
					detailsize++;
				}
			}
			
			if(giftsize == 0){
				answer = confirm("작성된 선물이 없습니다.\n작성된 선물이 없으면 후원받을 수 없습니다.\n그래도 다음 페이지로 이동하시겠습니까?");
			}else if(detailsize == 0){
				answer = confirm("작성된 구성품이 없습니다.\n구성품이 없는 선물로만 이루어진 게 맞습니까?");
			}
			
			if(answer){
				$.ajax({
					url:"addGift.do",
					type:"post",
					data:{gift: JSON.stringify(gift), detail: JSON.stringify(detail), p_num: $('#p_num').val()}, //선물과 구성품의 배열을 JSON문자열로 바꾸고, 프로젝트 번호와 함께 data로 전달
					dataType:"json",
					cache:false,
					timeout:30000,
					success:function(param){
						if(param.result == 'logout'){
							alert('로그인 후 사용하세요');
						}else if(param.result == "success"){
							return answer;
						}else if(param.result == "fail"){
							return false;
						}else{
							alert("선물 데이터 전달 오류");
						}
					},
					error:function(){
						checkName = 0;
						alert("네트워크 오류 발생");
					}
				});
			}else{
				return answer;
			}
		});
		
		$("#home").click(function(){
			var answer;
			answer = confirm("지금까지 작성한 내용이 저장되지 않습니다.\n그래도 나가시겠습니까?");
			if(answer) document.location.href='${pageContext.request.contextPath}/main/main.do';
		});
	});
	
	function getLimit(event){ //한정 여부 체크가 변경될 때마다 limitcount의 display와 숨겨진 태그의 값을 변경

		if(event.target.id == "limited"){
			$('#checklimit').text("limited");
			$('#limitcount').show();
		}else{
			$('#checklimit').text("unlimited");
			$('#limitcount').hide();
		}

	}
	
	function getShip(event){ //배송 여부 체크가 변경될 때마다 숨겨진 태그의 값을 변경
		if(event.target.id == "shipped") {
			$('#checkship').text("shipped");
		}else{
			$('#checkship').text("unshipped");
		}
	}
</script>

<!-- 중앙 내용 시작 -->
<div class="container">
	<h2>프로젝트 창작 - 선물</h2>
	<h3 id="projectname">${name}</h3>
	<div class="box">
	
		<div>
			<label for="gift">선물 목록</label><br>
			<select id="gift" size="10">
			
			</select><br>
			
			<label for="giftname">선물 이름</label><br>
			<input type="text" name="giftname" id="giftname">
			<span id="message_name"></span>
			<br>
			<label for="giftprice">선물 가격</label><br>
			<input type="number" min="100" max="2000000000" name="giftprice" id="giftprice">
			<span id="message_price"></span>
			<br>
			<label for="giftship">배송 여부</label><br>
			<p id="checkship" style="display:none">unshipped</p>
			<input type="radio" name="giftship" id="unshipped" value="0" checked="checked" onclick='getShip(event);'/>배송 없음
			<input type="radio" name="giftship" id="shipped" value="1" onclick='getShip(event);'/>배송 있음
			<br>
			<label for="giftlimit">한정 여부</label><br>
			<p id="checklimit" style="display:none">unlimited</p>
			<input type="radio" name="giftlimit" id="unlimited" value="0" checked="checked" onclick='getLimit(event);'/>제한 없음
			<input type="radio" name="giftlimit" id="limited" value="1" onclick='getLimit(event);'/>한정 상품
			<br>
			<div id="limitcount" style="display:none">
				<label for="giftcount">후원 가능 수량</label><br>
				<input type="number" min="1" max="1000" name="giftcount" id="giftcount">
				<span id="message_count"></span>
			</div>
			<br>
			<input type="button" value="선물 추가" id="add_gift">
			<input type="button" value="선물 삭제" id="delete_gift">
		</div>
		<div>
			<label for="gift_detail">구성품 목록</label><br>
			<span id="gname">현재 선택된 선물 : 없음</span>
			<p>
			선물 목록에서 선물을 선택하지 않으면 구성품을 추가할 수 없습니다.<br>
			선물을 선택하면 해당 선물의 구성품 목록을 불러올 수 있습니다.<br>
			구성품 추가를 누르면 해당 선물에 구성품이 추가됩니다.
			</p>
			<select id="detail" size="10">
			
			</select>
			<br>
			<label for="detailname">구성품 이름</label><br>
			<input type="text" name="detailname" id="detailname">
			<span id="message_dname"></span>
			<br>
			<label for="detailcount">구성품 수량</label><br>
			<input type="number" min="1" max="1000" name="detailcount" id="detailcount">
			<span id="message_dcount"></span>
			<br>
			<input type="button" value="구성품 추가" id="add_detail">
			<input type="button" value="구성품 삭제" id="delete_detail">
		</div>
		
		<form:form id="create_gift_form" action="createGift.do" modelAttribute="giftVO">
		<input type="hidden" value="${num}" id="p_num">
		<input type="hidden" value="${name}" id="p_name">
			
		<div class="align-center">
			<form:button>다음</form:button>
			<input type="button" id="home" value="홈으로" >
		</div>
		</form:form>
	</div>
</div>
<!-- 중앙 내용 끝 -->



