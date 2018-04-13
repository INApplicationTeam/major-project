<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Direct Message</title>


<script>
function time_ago(time) {

    		  switch (typeof time) {
    		    case 'number':
    		      break;
    		    case 'string':
    		      time = +new Date(time);
    		      break;
    		    case 'object':
    		      if (time.constructor === Date) time = time.getTime();
    		      break;
    		    default:
    		      time = +new Date();
    		  }
    		  var time_formats = [
    		    [60, 'seconds', 1], // 60
    		    [120, '1 minute ago', '1 minute from now'], // 60*2
    		    [3600, 'minutes', 60], // 60*60, 60
    		    [7200, '1 hour ago', '1 hour from now'], // 60*60*2
    		    [86400, 'hours', 3600], // 60*60*24, 60*60
    		    [172800, 'Yesterday', 'Tomorrow'], // 60*60*24*2
    		    [604800, 'days', 86400], // 60*60*24*7, 60*60*24
    		  ];
    		  var seconds = (+new Date() - time) / 1000,
    		    token = 'ago',
    		    list_choice = 1;

    		  if (seconds == 0) {
    		    return 'Just now'
    		  }
    		  if (seconds < 0) {
    		    seconds = Math.abs(seconds);
    		    token = 'from now';
    		    list_choice = 2;
    		  }
    		  var i = 0,
    		    format;
    		  while (format = time_formats[i++])
    		    if (seconds < format[0]) {
    		      if (typeof format[2] == 'string')
    		        return format[list_choice];
    		      else
    		        return Math.floor(seconds / format[2]) + ' ' + format[1] + ' ' + token;
    		    }
    		  return new Date(time).toDateString();
    		}

        </script>


<style>
table {
    font-family: arial, sans-serif;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>



</head>
<body>
<h2> Message </h2>

			
		<table>
		<th>Messages</th>
		<th>By</th>
		<th>At</th>
		<c:forEach var="temp" items="${conversation}" begin="0" varStatus="loop"> 
				
				
			<tr>
				<td> ${temp.message}</td>
				<td> ${temp.sender.uname} </td>
				<td id="time${loop.index}" ></td>
				
			</tr>
			
			
			
			<script>
				document.getElementById("time${loop.index}").innerHTML=time_ago(new Date (${temp.timestamp}) ) +" " +new Date(${temp.timestamp});
				console.log(time_ago(new Date (${temp.timestamp})));
				</script>
			</c:forEach>
			</table>
			
			<form:form action="sendDM" modelAttribute="message" method="POST">
				<label>To: </label> <br>
				<form:input path="receiver.uname"/>
				<br>
				<label>Message</label><br>
				<form:textarea path="message"/>
				<br>
						
					<input type="submit" value="SEND" />
					
			
		</form:form>	

</body>
</html>