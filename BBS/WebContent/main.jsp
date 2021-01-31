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
<!-- <link rel="stylesheet" href="css/custom.css"> -->
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
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
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
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
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
	<!-- 일반적인 웹사이트 소개 bootstrap lib 기능 jumbotron  -->
	<div class="container">
		<div class="jumbotron">
			<h1>♥♡♥♡♥♡♥♡♥♡</h1>
			<h1>나만의 추억 사이트</h1>
			<h1>♥♡♥♡♥♡♥♡♥♡</h1>
			<p>잘만들어 봅시다!!</p>
			<p><a class ="btn btn-primary btn-pull" href="#" role="button">우리 똥강아지가 항상 옆에있어서 좋앙</a></p>
		</div>
	</div>
	<!-- 케러셀을 통해 사진을 추가하기 -->
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-rid="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1" ></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="img/1.jpg">
				</div>
			<div class="item ">
					<img src="img/2.jpg">
				</div>
			</div>
			<!-- 좌우로 이동할 수 있도록 만들기 -->
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<!-- 이모티콘 추가 -->
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<!-- 이모티콘 추가 -->
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<!-- 애니메이션 담당 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>