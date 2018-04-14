<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Class Discussion Forum</title>
<style type="text/css">
 a{
     color: #0099cc;
  }
</style>
</head>
<body>
	<a href="#no" onclick="showMyQuestions()">MY QUESTIONS</a> 
	<a href="#no" onclick="showMyEvents()">MY EVENTS</a> 
	<a href="#no" onclick="showMyDiscussions()">MY DISCUSSIONS</a> 
	<a href="#no" onclick="showMyPolls()">MY POLLS</a>
	<br>
	<div id="question">
	<h1>MY-QUESTIONS</h1>
		<c:forEach var="question" items="${myQuestions}" begin="0" varStatus="queLoop">
			<b>
			<a href="">${question.userModel.uname}</a> Posted Question In <a href="">${question.domain.dname}</a> on ${question.timestamp}
			With Tags :
			<c:forEach var="tag" items="${question.tags}">
				<a href="">| ${tag.kname} </a>
			</c:forEach>
			
			<h1><a href="../question/allAnswers?qid=${question.qid}">${question.que}</a></h1>
			</b>
			<hr>
		</c:forEach>
	</div>
	
	<div id="poll">
	
	</div>
	
	<div id="event">
	
	</div>
	
	<div id="discussion">
	
	</div>
</body>
</html>