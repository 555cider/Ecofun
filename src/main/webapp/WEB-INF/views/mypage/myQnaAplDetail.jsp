<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String memId = (String) session.getAttribute("memId");
%>

<div class="container">
	<!-- Content-Header (문의 및 신청 > 프로젝트 신청 상세) -->
	<div class="row">
		<%
			if (memId != null && memId.equals("admin")) {
		%>
		<div class="col">
			<h6>
				| <a href="/admin/qnaList">문의 및 신청</a> > 프로그램 신청 상세
			</h6>
		</div>
		<%
			} else {
		%>
		<div class="col">
			<h6>
				| <a href="/mypage/qnaList">문의 및 신청</a> > 프로그램 신청 상세
			</h6>
		</div>
		<%
			}
		%>
	</div>
	<hr>

	<!-- Detail -->
	<div class="row">
		<fmt:parseDate value="${apl.aplDate}" var="dateValue" pattern="yyyy-MM-dd'T'HH:mm" />
		<table class="table" style="width: 100%; text-align: center; padding: 0;">
			<tr class="thead-light">
				<th style="width: 10%;">${apl.aplNo}</th>
				<th style="width: 65%;">${apl.aplTitle}</th>
				<th class="d-none d-md-table-cell" style="width: 10%;">검토중</th>
				<th class="d-none d-md-table-cell" style="width: 15%;">
					<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd'<br>'HH:mm" />
				</th>
			</tr>
			<tr>
				<td colspan="15" style="width: 100%; margin-bottom: 30%;">${apl.aplContent}</td>
			</tr>
		</table>
	</div>
	<br>

	<div class="row" style="text-align: center;">
		<%
			if (memId != null && memId.equals("admin")) {
		%>
		<div class="col">
			<a href="/admin/qnaList"><input type="button" value="목록으로"></a>
		</div>
		<%
			} else {
		%>
		<div class="col">
			<a href="/mypage/qnaList"><input type="button" value="목록으로"></a>
		</div>
		<%
			}
		%>
	</div>
</div>