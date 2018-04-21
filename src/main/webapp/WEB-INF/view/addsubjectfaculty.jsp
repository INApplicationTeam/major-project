<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add faculty</title>
</head>
<body>
			<h2>Add Faculty</h2>
			<form:form action="addFaculty" modelAttribute="faculty" method="POST">
			<table>
				<tr>
					<td><label>ID</label></td>
					 <td><form:input id="name"  path="userModel.uid" onkeyup="searchName()" />
					 	</td>
				</tr>
				
				<tr>
					<td><label>Branch</label></td>
					 <td><form:input path="branch"/></td>
				</tr>
				
				<tr>
					<td><label>Semester</label></td>
					 <td><form:input path="sem"/></td>
				</tr>
				
				<tr>
					<td><label>Section</label></td>
					 <td><form:input path="sec"/></td>
				</tr>
				
				<tr>
					<td><label>Batch</label></td>
					 <td><form:input path="batch"/></td>
				</tr>
				<tr>
					<td><label>Subject</label></td>
					 <td>
					 <form:select path="subject.subcode" >
					 <form:option value="000" label="--- Select ---"/>
					 	<c:set var="i" value="0" scope="page" />

					   <c:forEach var="code" items="${subjectname}">
					   		<form:option value="${subjectCode.get(i)}" label="${code}"/>
					   		<c:set var="i" value="${i + 1}" scope="page"/>
					   		
					   </c:forEach>
					 </form:select>
					 </td>
				</tr>
				<tr>
					<td><label></label></td>
					<td><input type="submit" value="ADD" /></td>	
				</tr>
			</table>
			
						<p id="test"></p>
				
			</form:form>
					 

<script>

function getXmlHttpRequestObject()
{
var xmlHttpReq;

if(window.XMLHttpRequest){
    request=new window.XMLHttpRequest();
}
else if(window.ActiveXObject){
    request=new window.ActiveXObject();
}
else{
    request=null;
}
return request;
}



function searchName()
{
	var name=document.getElementById("name").value;
	console.log(name);
	request=getXmlHttpRequestObject();
	request.onreadystatechange=threadNames;
    request.open("post","searchName",true);
    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");    
    var data="searchedname="+name;
    request.send(data);
}


function threadNames()
{
	if(request.readyState===4 && request.status===200)
    {
		
		document.getElementById("test").innerHTML=request.responseText;
           }
	
}


</script>
	
</body>
</html>