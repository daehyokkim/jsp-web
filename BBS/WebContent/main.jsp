<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 스크립트를 사용할 수 있게 설정 -->
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<!-- 부트스트랩을 사용하여 반응형 웹처럼 실행 가능하게 설치  -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<%
		//현재 세션을 가지고 있다면 해당 id값을 사용할 수 있도록 설정
		String userID = null;
		if(session.getAttribute("userID") != null ){
			userID = (String)session.getAttribute("userID");
		}
	 %>
	<!-- 네비게이션 -->
	<!-- 하나의 웹의 전반적 구성 식별 -->
	<nav class="navbar navbar-default">
		<div calss="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse"
				data-target = "#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button> 
			<!-- 로고 -->
			<a class="navbar-brand" href="main.jsp">JSP 게시판웹사이트</a>
		</div>
		<!--  -->
		<div class="collapse navbar-collapse" id="bs-example=navbar-collapse-1">
			<ul class="nav navbar-nav">
				<!-- active: 현제 접속한 페이지이다를 알림-->
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<!-- 로그인이 되어 있지 않다면 설정  -->
			<%
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<!-- span.caret은 일종에 아이콘 같은것 -->
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>	
			</ul> 
			<%
				}
				else{
			%>
			
			<ul class="nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<!-- span.caret은 일종에 아이콘 같은것 -->
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>	
			</ul> 
			<%
				}			
			%>
			
		</div>
	</nav>
	
	<!-- 애니메이션 담당 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>