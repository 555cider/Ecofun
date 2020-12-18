<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contentPage = request.getParameter("contentPage");
if (contentPage == null)
	contentPage = "ecofunMain.jsp";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>친환경 프로젝트 에코펀!</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="/img/ecofun.ico" />
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/css/ecofun.css">
<script src="/js/jquery-3.5.1.js"></script>
<script src="/js/bootstrap.bundle.min.js"></script>
<script src="/js/custom.js"></script>

<script>
	function changeView(value) {
		if (value == "0") {
			location.href = "/main"; // HOME 버튼 클릭시 첫화면으로 이동
		} else if (value == "1") {
			location.href = "/member/login"; // 로그인 버튼 클릭시 로그인 화면으로 이동
		} else if (value == "2") {
			location.href = "/member/agreeForm"; // 회원가입 버튼 클릭시 약관동의 화면으로 이동
		} else if (value == "3") {
			location.href = "/member/join";// 약관동의 폼의 회원가입 버튼 클릭시 회원가입 처리
		} else if (value == "5") {
			location.href = "/admin/memberList";
		} else if (value == "6") {
			location.href = "logout"; // 로그아웃 버튼 클릭 시, 로그아웃&메인 이동
		}
	}
</script>
</head>

<body style="padding-top: 5%;">
	<header>
		<jsp:include page="ecofunHeader.jsp" />
	</header>

	<section>
		<jsp:include page="<%=contentPage%>" />
	</section>
	<hr>

	<footer>
		<jsp:include page="ecofunFooter.jsp" />
	</footer>
</body>
</html>