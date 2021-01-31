<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 스크립트를 사용할 수 있게 설정 -->
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.bbs" %>
<%@ page import="bbs.bbsDAO" %>
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
		
		if(userID == null){

			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('로그인을 하시오.')");
			script.println("location.href='login.jsp'"); //main.jsp요청
			script.println("</script>");
		}
		//spring MVC패턴으로 치면  ,@RequestParam("bbsNum")int bbsNum 이랑 같은 것 URL에 추가적인 데이터 전송
		int bbsNum = 0;
		if(request.getParameter("bbsNum") != null){
			bbsNum = Integer.parseInt(request.getParameter("bbsNum"));
		}
		if(bbsNum == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'"); //main.jsp요청
			script.println("</script>");
		}
		//반드시 존재 시 가능 , 받아온 글 담기
		bbs bbs = new bbsDAO().getbbs(bbsNum);
		if(!userID.equals(bbs.getBbsUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>"); //유동적으로 실행
			script.println("alert('권한이 없습니다..')");
			script.println("location.href='bbs.jsp'"); //main.jsp요청
			script.println("</script>");
			
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
		</div>
	</nav>
	
	<!-- 게시판 화면 설정 table구조-->
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsNum=<%=bbs.getBbsNum()%>">
				<!-- table-striped: 홀칸,짝칸 별로 색 차이주기 -->
				<table class="table table-striped"
				   style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name ="bbsTitle" maxLength="50" value ="<%=bbs.getBbsTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name ="bbsContent" maxLength="200" style="height:350px;"><%=bbs.getBbsContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
			
			</form>
		</div>
	</div>
	<!-- 애니메이션 담당 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>