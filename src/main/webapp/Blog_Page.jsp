<%@page import="model.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
BlogModel bm=(BlogModel)session.getAttribute("blogmodel");
ArrayList<BlogCommentModel> arbcm=bm.getArbcm();
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h3><strong><%=bm.getTitle() %></strong></h3><h2>in <%=bm.getDname() %></h2>
<h2>-by <strong><%=bm.getUname() %></strong></h2>
<p><%=bm.getBlogContent() %></p>
Comments - <%if(arbcm!=null){
			for(BlogCommentModel bcm :arbcm)
			{
				%>
				Comment - <%=bcm.getComment() %> from <%=bcm.getUname() %><br>
				<% 
			}}
else{
	%>
	Hello
	<% }
	%>


</body>
</html>