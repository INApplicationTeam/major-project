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
    		  return "on "+new Date(time).toDateString();
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
<%@include file="navBarAndSideBar.jsp"%>

<main class="pt-4 mx-lg-5" id="blur">
        <div class="container-fluid mt-5 pt-3 ml-3 pr-0">
        
        
        <!-- Heading -->
            <div class="card">

                <!--Card content-->
                <div class="card-body d-sm-flex justify-content-between py-3">

                    <h4 class="mb-2 mb-sm-0">
                        <a href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">CS-B/</a>
                        <span>
                        <!-- Split button -->
                        <div class="btn-group">
                            <a class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                8th sem
                                <span class="sr-only">Toggle Dropdown</span>
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="#">Action</a>
                                <a class="dropdown-item" href="#">Another action</a>
                                <a class="dropdown-item" href="#">Something else here</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">Separated link</a>
                            </div>
                        </div>
                        </span>
                    </h4>
                    <button type="button" class="btn btn-outline-primary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Create poll</button>
                    <button type="button" class="btn btn-outline-default waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Start Discussion</button>
                    <button type="button" class="btn btn-outline-secondary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Add event</button>
                    <button type="button" class="btn btn-outline-success waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Ask Question</button>
<!--                   <form class="d-flex justify-content-center">
                        <input type="search" placeholder="Type your query" aria-label="Search" class="form-control">
                        <button class="btn btn-primary btn-sm my-0 p" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                 </form>
-->
                    <div>
                    <a href=""><i class="fa fa-thumb-tack" aria-hidden="true"></i> My Saved Posts&nbsp;&nbsp;</a>
                    <a href=""><i class="fa fa-circle" aria-hidden="true"></i> My Posts</a>
                    </div>
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
                                <i class="fa fa-eye float-right mr-2 ml-1" aria-hidden="true"> 18</i>
                                <a class="blue-text"><i class="fa fa-thumb-tack float-right blue-text mr-2" aria-hidden="true"></i></a>
                                <a class="blue-text"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
                            </small>
                            <h4 style="font-size: 24px;" class="mt-2"><a>${events.title}</a></h4>
                            <small>
                                <strong>Description: </strong><div id="eventEditor${loop.index}"></div>	
                            </small>
                            <div class="text-center" style='overflow:hidden; white-space:nowrap;'>
                                <strong class="pr-1 wow bounceInLeft" data-wow-delay="0.4s" ><span id="startdate${loop.index}"></span></strong>
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <hr style='display:inline-block; width:60%;vertical-align: middle;' />
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <strong class="pr-1 wow bounceInRight" data-wow-delay="0.4s"><span id="lastdate${loop.index}"></strong>
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

                <ul class="list-group mt-4 ml-2 mb-4">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <h4 class="mb-0 pb-0"><strong>Pinned Posts</strong></h4>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Cras justo odio
                        <span class="badge badge-primary badge-pill">event</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Dapibus ac facilisis in
                        <span class="badge badge-primary badge-pill">poll</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Morbi leo risus
                        <span class="badge badge-primary badge-pill">discussion</span>
                    </li>
                </ul>
                <div id="my-calendar" style="margin-left: 10px;"></div>
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/kext/js/calendar.js"></script>
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
</body>
</html>