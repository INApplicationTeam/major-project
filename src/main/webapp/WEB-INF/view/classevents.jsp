<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Class Events</title>
</head>
<body>

	<hr>
	<c:forEach var="events" items="${eventlist}" begin="0" varStatus="loop"> 
	<center>
	<h3>Event ${loop.index+1}</h3>
	<h4>Title : <i>${events.title} </i>   By: <i> ${events.userModel.uname }</i></h4> 
	<p> <b>Description:</b>  ${events.description} </p> 
	<b>Last Date:</b> <span id="lastdate${loop.index}"></span><br><br>
	<b> Pending : </b> <span id="pending${loop.index}"></span>
	<hr>
	
	
	<script>
		var endDate=${events.enddate};
		document.getElementById('lastdate${loop.index}').innerHTML=new Date(endDate);
		if("${events.pending}"== "false")
		{
			document.getElementById('pending${loop.index}').innerHTML="YES";
		}
		else
			document.getElementById('pending${loop.index}').innerHTML="NO";
	</script>
</center>
	</c:forEach>
</body>
</html>