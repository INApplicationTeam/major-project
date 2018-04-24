<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui.css">


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/png" href="../MDB Free/img/img1.png" />
        
         <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/kext/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/kext/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="${pageContext.request.contextPath}/kext/css/mdb.min.css" rel="stylesheet">
    <!-- Your custom styles (optional) -->
    <link href="${pageContext.request.contextPath}/kext/css/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/kext/css/sidebar.css">

	
	
	<script type="text/javascript">

$(document).ready(function() {
	$(function() {
		$("#idsearch").autocomplete({

			source : function(request, response) {
				$.ajax({
					url : "searchName",
					type : "get",
					data : {
						term : request.term
					},
					dataType : "json",
					success : function(data) {
						console.log(data);
						response(data);
					}
				});
			}
                         
		});
	});
        
        
});

</script>


<title>ADD CR</title>
</head>
<body class="blue-grey lighten-5">

  

<!--Main Navigation-->
<header>
<%@page import="model.UserModel"%>
	<%
	String utype=session.getAttribute("utype").toString();
	Object obj =session.getAttribute("userModel");
	UserModel um=new UserModel();
	String uname=um.getUserName(obj);
	String uid=um.getUserId(obj);
%>

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
						href="aboutClass">About this class</a></li>
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

</header>
<!--Main Navigation-->
	
	<main class="pt-4 mx-lg-5" id="blur">
	<div class="conatiner-fluid">
    <div class="row mt-5">
        <div class="col-md-4"></div>
        <div class="col-md-4">
	
	<div class="card">

    <!-- Card body -->
    <div class="card-body ml-3">

        <!-- Material form register -->
        <form:form action="addCR" modelAttribute="CR" method="POST">
            <p class="h4 text-center py-4">Add class Representative</p>

            <!-- Material input text -->
            <div class="md-form">
             <div class="input-group-text blue lighten-4 mr-3 ml-2" style="display:inline-block">@</div>
			<form:input id="idsearch" path="userModel.uid" name="search" class="search"/>      
             <label for="materialFormCardNameEx" class="font-weight-light"></label>
            </div>
            <!-- Material form grid -->

    <!-- Grid row -->
    <div class="form-group row mt-4">
        <!-- Default input -->
        <label for="inputEmail3" class="col-sm-4 col-form-label">Branch</label>
        <div class="col-sm-8">
               <form:input path="branch" disabled="true" id="branch" placeholder="branch"/>
        </div>
    </div>
    <!-- Grid row -->
    <div class="form-group row">
        <!-- Default input -->
        <label for="inputEmail3" class="col-sm-4 col-form-label">Semester</label>
        <div class="col-sm-8">
              <form:input path="sem" disabled="true" placeholder="semester"/>
        </div>
    </div>
    <!-- Grid row -->
    <div class="form-group row">
        <!-- Default input -->
        <label for="inputEmail3" class="col-sm-4 col-form-label">Section</label>
        <div class="col-sm-8">
                                <form:input path="sec" disabled="true"/>
        </div>
    </div>
   <!-- Grid row -->
    <div class="form-group row">
        <!-- Default input -->
        <label for="inputEmail3" class="col-sm-4 col-form-label">Batch</label>
        <div class="col-sm-8">
                
                <form:input path="batch" disabled="true"/>
        </div>
    </div>


            <div class="text-center py-4 mt-3">
                <input class="btn btn-cyan" type="submit" value="Register">
            </div>
        </form:form>
        <!-- Material form register -->

    </div>
    <!-- Card body -->

</div>
<!-- Card -->
	</div>
	</div>
	</div>
	</main>
		
		

</body>
</html>