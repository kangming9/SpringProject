<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css">
</head>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-client_id" content="84497321586-98m97vpame2mb38rtfr3hntdovs1erqk.apps.googleusercontent.com">
 
 <body>
<script>
//구글 로그인
/* $(function(){
    function onSuccess(googleUser) {
        var profile = googleUser.getBasicProfile();
        console.log(profile);
    }
        
    $(".g-signin2").on("click", function(){
        gapi.client.load('plus', 'v1', function () {
            gapi.client.plus.people.get({
                'userId': 'me'
            }).execute(function (res) {
                console.log(JSON.stringify(res));
                
                res.id += "@g";
                      
                $.ajax({
                    url : "/user/json/checkDuplication/"+res.id,
                    headers : {
                          "Accept" : "application/json",
                          "Content-Type" : "application/json"
                      },
                      success : function(idChk){
                            if(idChk==true){ //DB에 아이디가 없을 경우 => 회원가입
                                console.log("회원가입중...");
                                $.ajax({
                                    url : "/user/json/addUser",
                                    method : "POST",
                                    headers : {
                                      "Accept" : "application/json",
                                      "Content-Type" : "application/json"
                                    },
                                    data : JSON.stringify({
                                      userId : res.id,
                                      userName : res.displayName,
                                      password : "google123",
                                    }),
                                    success : function(JSONData){
                                       alert("회원가입이 정상적으로 되었습니다.");
                                       $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
                                    }
                                })
                            }
                            if(idChk==false){ //DB에 아이디가 존재할 경우 => 로그인
                                console.log("로그인중...");
                                $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
                            }
                        }
                  })
                })
           })
    })//e.o.google.loginLogic
    
    function onFailure(error) {
        console("error : "+error);
    }
    
    function signOut() {
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            self.location="/user/logout";
        });
    }
    
})//e.o.google

 */

</script>

<!-- 로그인 시작 -->


<div class="container">
<c:if test="${user_id eq null}">
		<div class="align-center">
	<div class="box">
		<h2>로그인</h2>
		
		<div class="sns">
			<!-- 구글 로그인 추가 -->
<div id="googleLogin" align="center">                                                    
    <div class="g-signin2" data-onsuccess="onSuccess" data-theme="dark"></div>
</div>
			<div class="item">
				<div class="form-group socialimage" id="kakaoBtn">
					<a href="https://kauth.kakao.com/oauth/authorize?client_id=4234090cf188276e03ecdbf634a9c0b9&redirect_uri=http://localhost:8081/FundingAdventure2/member/login.do&response_type=code">
						<img id="socialimage" src="${pageContext.request.contextPath}/resources/images/kakao_login.png" width="320px" height="100%" class="loginImage"/>
					</a>
				</div>
			</div>
			<div id="userinfo"></div>
			<div class="item">
				네이버
			</div>
		</div>
		<hr size="1" style="margin:10px 20px;width:90%;" >
		<form:form id="login_form" action="login.do" modelAttribute="memberVO">
		<form:errors element="div" cssClass="error-color"/>
			<ul style="list-style:none;">
				<li class="form-li">
					<form:input path="id" placeholder="	아이디를 입력해주세요"/>
					<form:errors path="id" cssClass="error-color"/>
				</li>
				<li class="form-li">
					<form:password path="pass" placeholder="	비밀번호를 입력해주세요"/>
					<form:errors path="pass" cssClass="error-color"/>
				</li>
			</ul>
			<div class="align-center">
				<form:button class="submit-btn">로그인</form:button>
			</div>
		</form:form>
		<div class="sub-function">
			<p>
				<span>아직 계정이 없으신가요?	</span>
				<a href="${pageContext.request.contextPath}/member/selectRegister.do">회원가입</a>
			</p>
			<p class="search-btn">
				<input type="button" value="아이디 찾기" onclick="location.href='${pageContext.request.contextPath}/member/searchID.do'">
				<span>	|	</span>
				<input type="button" value="비밀번호 재설정" onclick="location.href='${pageContext.request.contextPath}/member/searchPass.do'">
			</p>
		</div>
	</div>
</div>

<!-- 로그인 끝 -->
</c:if>
<c:if test="${user_id ne null}">
	<h1>로그인 성공!</h1>
</c:if>

</div>
</body>
</html>