<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<!-- span.caret은 일종에 아이콘 같은것 -->
					<ul class="dropdown-menu">
						<!-- active: 현제 선택이 되었다 -->
						<li class="active"><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>	
			</ul> 
		</div>
	</nav>
	
	<!-- 로그인 양식  -->
	<div class = "container">
		<div class="col-lg-4"></div>
		<!-- 로그인 양식이 들어감 -->
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top:20px;">
				<form action="loginAction.jsp" method ="post">
					<h3 style="text-align: center;">로그인 화면</h3> 
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="user_Password" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인">
				</form>
			</div>
		</div>		
		<div class="col-lg-4"></div>
	</div>
	<!-- 애니메이션 담당 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>