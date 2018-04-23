<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
	
		<%@page import="model.UserModel"%>
	<%
	String utype=session.getAttribute("utype").toString();
	Object obj =session.getAttribute("userModel");
	UserModel um=new UserModel();
	String uname=um.getUserName(obj);
	String uid=um.getUserId(obj);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" href="../MDB Free/img/img1.png" />

<!-- Font Awesome -->
<link
	href="${pageContext.request.contextPath}/kext/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/kext/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="${pageContext.request.contextPath}/kext/css/mdb.min.css"
	rel="stylesheet">
<!-- Your custom styles (optional) -->
<link href="${pageContext.request.contextPath}/kext/css/style.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/kext/css/sidebar.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>



<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inbox</title>

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

</head>
<body>

	<!-- Navbar -->
	<nav
		class="navbar fixed-top navbar-expand-lg navbar-light white scrolling-navbar"
		style="margin-left: 30px; box-shadow: none;">
		<div class="container-fluid">

			<!-- Brand -->
			<a class="navbar-brand waves-effect"
				href="https://mdbootstrap.com/material-design-for-bootstrap/"
				target="_blank"> <strong class="blue-text">Korero</strong>
			</a>

			<!-- Collapse -->
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!-- Links -->
			<div class="collapse navbar-collapse" id="navbarSupportedContent">

				<!-- Left -->
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link waves-effect"
						href="../../MyFeed">Home <span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link waves-effect"
						href="https://mdbootstrap.com/material-design-for-bootstrap/"
						target="_blank">About this class</a></li>
					<li class="nav-item"><a class="nav-link waves-effect"
						href="https://mdbootstrap.com/getting-started/">Blogs</a>
					</li>
					<li class="nav-item"><a class="nav-link waves-effect"
						href="showNotices">Notice</a>
					</li>
				</ul>

				<!-- Right -->
				<ul class="navbar-nav nav-flex-icons">
					<li class="nav-item mr-4">
						<form class="form-inline ml-auto">
							<div class="md-form mt-0">
								<input class="form-control" type="text" placeholder="Search"
									aria-label="Search">
							</div>
						</form>
					</li>
					<li class="nav-item mr-2">
						<!-- Basic dropdown -->
						<div class="btn-group">
							<a class="dropdown-toggle nav-link" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"> <i
								class="fa fa-bell"></i>
							</a>

							<div class="dropdown-menu dropdown-pull-right">
								<a class="dropdown-item" href="#">Action</a> <a
									class="dropdown-item" href="#">Another action Another
									action Another action Another action</a> <a class="dropdown-item"
									href="#">Something else here</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#">Separated link</a>
							</div>
						</div> </a>
					</li>
				</ul>

			</div>

		</div>
	</nav>
	<!-- Navbar -->

	<!-- Sidebar -->
	<div class="leftside pt-2"
		onmouseover="javascript:document.getElementById('blur').style.filter='blur(3px)';"
		onmouseout="javascript:document.getElementById('blur').style.filter='blur(0)';">
		<div class="text-center" style="padding: 10px;">
			<img src="../../ImageLoader?uid=<%=uid%>"
				class="img-fluid z-depth-1 rounded-circle"
				style="max-height: 150px;" alt="Responsive image">
		</div>
		<div class="item">
			<span class="fa fa-bel"></span><%=uname%>
		</div>
		<a href="../../MyProfile">
			<div class="item">
				<span class="fa fa-user"></span> Profile
			</div>
		</a> <a href="../../MyFeed">

			<div class="item">
				<span class="fa fa-pie-chart"></span> My Feed
			</div>
		</a> <a href="../../book advisory/bookhome.jsp">
			<div class="item active">
				<span class="fa fa-institution"></span> Book Advice
			</div>
		</a> <a href="../../poll/pollhome.jsp">
			<div class="item">
				<span class="fa fa-bar-chart-o"></span> Polling
			</div>
		</a> <a href="../class/CDFhome<%=utype%>">
			<div class="item">
				<span class="fa fa-graduation-cap"></span> Class Discussion
			</div>
		</a>
	</div>
	<!-- Sidebar -->
	
	
	
	
	
	<main class="pt-4 mx-lg-5" id="blur">
	<div class="container-fluid mt-5 pt-3 ml-3 pr-0">

		<div class="row mx-2">
			<!-- First column -->
			<div class="col-4">

				<div class="list-group" id="list-tab" role="tablist"
					style="max-height: 83vh; overflow-y: scroll;">
					<a class="list-group-item disabled"><h3 class="h3-responsive">Messages</h3></a>
					<div class="list-group-item px-0 py-0" style="border-top: none;">
						<label class="sr-only" for="searchname">Username</label>
						<div class="input-group">
							<div class="input-group-prepend">
								<div class="input-group-text blue lighten-4">@</div>
							</div>
							<input type="text" class="form-control" id="searchname"
								onkeyup="searchName()" placeholder="Username">
						</div>
					</div>


					<div id="threadname">


						<c:forEach var="temp" items="${threads}" begin="0"
							varStatus="loop">


							<a class="list-group-item list-group-item-action"
								id="list-home-list" data-toggle="list"
								href="<c:url value="inbox?id=${temp.key}&name=${temp.value}" />" role="tab"
								aria-controls="home" style="border-top: none;"> 
								<img src="../../ImageLoader?uid=${temp.key}"
								class="img-fluid z-depth-1 rounded-circle avatar mr-2"
								alt="Responsive image">${temp.value} 
								
								<c:if test="${onlineUsers.get(loop.index)==true}">
								<i class = "fa fa-circle pull-right mt-2 green-text"></i>
								</c:if>
								</a>





						</c:forEach>

					</div>

				</div>

			</div>


			<!-- Second column -->
			<div class="col-8">

				<!-- Content -->
				<div class="tab-content" id="nav-tabContent">
					<div class="tab-pane fade show active" id="list-home"
						role="tabpanel" aria-labelledby="list-home-list">
						<!--Panel-->
													<c:if test="${fn:length(conversation) gt 0}">
						<div class="card" id="messageScroll"
							style="max-height: 70vh; overflow-y: scroll; border-bottom-left-radius: 0px;">
							<div class="card-header" style="position:fixed;background-color:white;z-index:1000;width:770px">
								<h4 class="pb-0 mb-0">
									<a class="blue-text" id="list-home">${threadName}</a>
								</h4>
							</div>
							<div class="card-body" style="margin-top: 70px">
							

							<c:forEach var="temp" items="${conversation}" begin="0" varStatus="loop">
							<!-- Other Person -->
							<c:if test="${temp.sender.uid!= userID }">
								<div class="row mt-3">
									<div class="col-md-1">
										<img
											src="../../ImageLoader?uid=${temp.sender.uid}"
											class="img-fluid z-depth-1 rounded-circle avatar"
											alt="Responsive image">
									</div>
									<div class="col-md-9 pl-0">
										<div class="card card-body py-2 px-3">
											<p class="card-text black-text">
												${temp.message}<small
													class="grey-text inline pl-2"><span id="time${loop.index}"></span></small>
											</p>
										</div>
									</div>
								</div>
								
								</c:if>																
								<c:if test="${temp.sender.uid == userID }">
								<!-- Person who is logged in -->
								<div class="row mt-3">
									<div class="col-md-2"></div>
									<div class="col-md-9 pr-0">
										<div class="card card-body py-2 px-3">
											<p class="card-text black-text">${temp.message}<small
													class="grey-text inline pl-2"><span id="time${loop.index}"></span></small>
											</p>
										</div>
									</div>
									<div class="col-md-1">
										<img
											src="../../ImageLoader?uid=${userID}"
											class="img-fluid z-depth-1 rounded-circle avatar"
											alt="Responsive image">
									</div>
								</div>
							</c:if>
							
							<script>
				document.getElementById("time${loop.index}").innerHTML=time_ago(new Date (${temp.timestamp}) ) ;
				</script>
				
							</c:forEach>
							
							</div>
						</div>
						
						</c:if>
						
						<c:if test="${fn:length(conversation) gt 0}">
						<!--/.Panel-->
						<div class="card"
							style="border-top-left-radius: 0px; border-top-right-radius: 0px; border-top: 1px solid rgba(0, 0, 255, .45);">
							<!-- Auto-resizing textarea -->
							<div class="form mx-3 mb-3">
								<div class="form-row">
									<div class="col-11 mr-0 pr-0">
									<form:form action="sendDM?id=${message.receiver.uid}&name=${message.receiver.uname}" modelAttribute="message" method="POST">
										<label for="exampleFormControlTextarea1"><small>Send
												a message</small></label>
									<form:hidden path="receiver.uid" id="receiverId"/>
									<div style="display:none">
									<input type="submit" value="SEND" id="submitMsg"/>
									</div>
										<form:textarea cssClass="form-control"
											id="exampleFormControlTextarea1" rows="1" path="message"/>
										</form:form>	
									</div>
									<div class="col-1">
										<br>
										<br> <a class="ml-4 pt-3"><i
											class="fa fa-send blue-text" onclick="submitMessage()"></i></a>
									</div>
								</div>
							</div>
						</div>
						
					</c:if>
					</div>
					<c:if test="${fn:length(conversation)==0}">
					<h1> Welcome to Messaging</h1>
					</c:if>
				</div>
			</div>
		</div>



		<<%-- center>
			<c:if test="${fn:length(conversation) gt 0}">

				<table>
					<tr>
						<th>Messages</th>
						<th>By</th>
						<th>At</th>
					</tr>
					<c:forEach var="temp" items="${conversation}" begin="0"
						varStatus="loop">


						<tr>
							<td>${temp.message}</td>
							<td>${temp.sender.uname}</td>
							<td id="time${loop.index}"></td>

						</tr>


						</div>
						<script>
				document.getElementById("time${loop.index}").innerHTML=time_ago(new Date (${temp.timestamp}) ;
				console.log(time_ago(new Date (${temp.timestamp})));
				</script>
					</c:forEach>
				</table>

			</c:if>

 --%>



	<!--  		<c:if test="${flag==true}">

				<form:form action="sendDM?id=${message.receiver.uid}"
					modelAttribute="message" method="POST">
					<br>
					<form:hidden path="receiver.uid" />
					<label>Message</label>
					<br>
					<form:textarea path="message" />
					<br>

					<input type="submit" value="SEND" />


				</form:form>
			</c:if>


			<c:if test="${flag==false}">
				<h2>Welcome to messaging</h2>
			</c:if>
-->

		</center>

	</div>
	</main>
	<script src="${pageContext.request.contextPath}/js/Notifications.js"></script>
	<script>
	$('#messageScroll').scrollTop($('#messageScroll')[0].scrollHeight);

	function submitMessage()
	{
		$('#submitMsg').click();
	}
	
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
	var name=document.getElementById("searchname").value;
	console.log(name);
	request=getXmlHttpRequestObject();
	request.onreadystatechange=threadNames;
    request.open("post","searchThreadName",true);
    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");    
    var data="searchedname="+name;
    request.send(data);
}


function threadNames()
{
	if(request.readyState===4 && request.status===200)
    {
		
		document.getElementById("threadname").innerHTML=request.responseText;
    }
	
}

</script>

</body>
</html>