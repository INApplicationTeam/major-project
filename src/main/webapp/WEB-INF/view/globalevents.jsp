<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Class Events</title>
<script src="https://cdn.quilljs.com/1.2.3/quill.js"></script>
        <script src="https://cdn.quilljs.com/1.2.3/quill.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <link href="https://cdn.quilljs.com/1.1.3/quill.snow.css" rel="stylesheet">
        <link href="https://cdn.quilljs.com/1.1.3/quill.bubble.css" rel="stylesheet">
        
        
                <!-- Font Awesome -->
<link href="${pageContext.request.contextPath}/kext/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/kext/css/bootstrap.min.css" rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="${pageContext.request.contextPath}/kext/css/mdb.min.css" rel="stylesheet">
<!-- Your custom styles (optional) -->
<link href="${pageContext.request.contextPath}/kext/css/style.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/kext/css/sidebar.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/kext/css/calendar.css">
	
	 <style>
        
        img.resize {
  				max-width:15%;
  				max-height:15%;
  				float: right;
		}
		
		iframe{
				width:180px;
  				height:90px;
  				float: right;
  				margin:10px;
		}	
		
		b, strong {
    			font-weight: bolder;
		}

		.ans, .discEditor, .eveEditor{
		  		font-family: "Roboto";
		  		font-size: 16px;
		  		font-weight: 400;
		  		word-wrap: break-word;
		}
		
		.notice{
				font-family: "roboto";
		  		font-size: 15px;
		  		font-weight: 300;
		  		word-wrap: break-word;
		}

		pre{
				font-size: 90%;
		}

		.ql-container.ql-snow {
    			border: 0px solid #ccc;
		}

		.ql-snow .ql-editor img {
    			max-width: 35%;
    			max-height: 35%;
		}
        
        </style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
        
        
        <script type="text/javascript">
        var configForShow = 
        {
            "theme": "snow",
            "modules": {
            "toolbar": false
				}  
		};
        
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
    		  
    		  var options = {  
    				    weekday: "long", year: "numeric", month: "short",  
    				    day: "numeric", hour: "2-digit", minute: "2-digit"  
    				};
    		  
    		  return new Date(time).toLocaleTimeString("en-us",options);
    		}

        function instantiateEditor(index,eventText)
        {
        	var quillShow=new Quill('#eventEditor'+index,configForShow);
        	quillShow.setContents(eventText);
        	quillShow.enable(false);
        	
        }
        </script>

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
				href="../../MyFeed"
				> <strong class="blue-text">Korero</strong>
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
						href="../message/inbox">Message</a></li>
					
					<li class="nav-item"><a class="nav-link waves-effect"
						href="../class/showNotices">Notice</a>
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
		</a> 
		
		<a href="../../MyFeed">

			<div class="item">
				<span class="fa fa-pie-chart"></span> My Feed
			</div>
		</a> 
		
		<a href="../../book advisory/bookhome.jsp">
			<div class="item active">
				<span class="fa fa-institution"></span> Book Advice
			</div>
		</a>
		
		 <a href="../../poll/pollhome.jsp">
			<div class="item">
				<span class="fa fa-bar-chart-o"></span> Polling
			</div>
		</a> 
		
		<a href="../class/CDFhome<%=utype%>">
			<div class="item">
				<span class="fa fa-graduation-cap"></span> Class Discussion
			</div>
		</a>
		
		<a href="../../LoadBlogFeed">
			<div class="item">
				<span class="fa fa-pencil"></span> Blogs
			</div>
		</a>
		
		<a onclick="destroyHandler()">
		<div class="item">
                <span class="fa fa-sign-out"></span>
                LogOut
            </div>
           </a> 
	</div>
	<!-- Sidebar -->

</header>
<main class="pt-4 mx-lg-5" id="blur">
        <div class="container-fluid mt-5 pt-3 ml-3 pr-0">
        
        
        <!-- Heading -->
            <div class="card">

                <!--Card content-->
                <div class="card-body d-sm-flex justify-content-between py-3">

                    <h4 class="mb-2 mb-sm-0">
                        <a href="" target="_blank">GLOBAL EVENT</a>
                        <span>
                        <!-- Split button -->
                        
                        </span>
                    </h4>
                    
<!--                   <form class="d-flex justify-content-center">
                        <input type="search" placeholder="Type your query" aria-label="Search" class="form-control">
                        <button class="btn btn-primary btn-sm my-0 p" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                 </form>
-->
                    
                </div>
            </div>
            <!-- Heading -->
        
        

        <div class="row wow fadeIn">
        
        
        <!-- Show events code -->
        <div class="col-md-9">
        	<c:forEach var="events" items="${eventlist}" begin="0" varStatus="loop"> 
 <div class="card mb-3 mt-4">
                        <div class="card-body pb-2">
                            <small>
                                <a href="">${events.userModel.uname }</a> created event <span id="createddate${loop.index}"></span>
                                
                            </small>
                            <h4 style="font-size: 24px;" class="mt-2"><a>${events.title}</a></h4>
                            <small>
                                <strong>Description: </strong>	
                            </small>
                            <div id="eventEditor${loop.index}" class="eveEditor"></div>
                            <div class="text-center" style='overflow:hidden; white-space:nowrap;'>
                                <strong class="pr-1 wow bounceInLeft" data-wow-delay="0.4s" >From <span id="startdate${loop.index}"></span></strong>
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <hr style='display:inline-block; width:30%;vertical-align: middle;' />
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <strong class="pr-1 wow bounceInRight" data-wow-delay="0.4s">To <span id="lastdate${loop.index}"></strong>
                            </div>
	<script>
		var endDate=${events.enddate};
		var startDate=${events.startdate};
		var createdDate=${events.timestamp};
		
		document.getElementById('createddate${loop.index}').innerHTML=time_ago(createdDate);
		document.getElementById('lastdate${loop.index}').innerHTML=time_ago(endDate);
		document.getElementById('startdate${loop.index}').innerHTML=time_ago(startDate);
		
		var eventText=${events.description};
		instantiateEditor('${loop.index}',eventText);
		
		if("${events.pending}"== "false")
		{
			document.getElementById('pending${loop.index}').innerHTML="YES";
		}
		else
			document.getElementById('pending${loop.index}').innerHTML="NO";
	</script>
                        </div>
                        </div>
                    </c:forEach>
                        </div>
                        
                        
                        
                        
                   <div class="col-md-3 mx-0 my-0 px-0 py-0">

                
                <div id="my-calendar" style="margin-left: 10px; margin-top:20px"></div>
                </div>
                </div>
                
                <!--Grid row-->

            <!--Grid row-->
            <div class="row wow fadeIn"></div>
            <!--Grid row-->

            <!--Grid row-->
            <div class="row wow fadeIn"></div>
            <!--Grid row-->
                
                </div>
                        </main>
                         <!-- SCRIPTS -->
    <!-- JQuery -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/kext/js/jquery-2.2.3.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/kext/js/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/kext/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/kext/js/mdb.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/kext/js/calendar1.js"></script>
    <!-- Initializations -->
<!-- 
	<hr>
	<c:forEach var="events" items="${eventlist}" begin="0" varStatus="loop"> 
	<center>
	<h3>Event ${loop.index+1}</h3>
	<h4>Title : <i>${events.title} </i>   By: <i> ${events.userModel.uname }</i></h4> 
	<p> 
		<b>Description:</b> <br>
		<div id="eventEditor${loop.index}"></div>
	</p>
	<b>Start Date:</b> <span id="startdate${loop.index}"></span><br><br> 
	<b>Last Date:</b> <span id="lastdate${loop.index}"></span><br><br>
	<b> Pending : </b> <span id="pending${loop.index}"></span>
	<hr>
	

</center>
	</c:forEach>
	 -->
	 
	 <script type="text/javascript">
function destroyHandler()
{
	     	window.location="../../LogOut";
}
</script>
	 
</body>
</html>