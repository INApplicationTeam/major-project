<!DOCTYPE html>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Class discussion forum</title>
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/kext/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/kext/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="${pageContext.request.contextPath}/kext/css/mdb.min.css" rel="stylesheet">
    <!-- Your custom styles (optional) -->
    <link href="${pageContext.request.contextPath}/kext/css/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/kext/css/sidebar.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/kext/css/calendar.css">
    
    <script src="https://cdn.quilljs.com/1.2.3/quill.js"></script>
    <script src="https://cdn.quilljs.com/1.2.3/quill.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <link href="https://cdn.quilljs.com/1.1.3/quill.snow.css" rel="stylesheet">
    <link href="https://cdn.quilljs.com/1.1.3/quill.bubble.css" rel="stylesheet">
    
    <style>
        
        img.resize {
  				max-width:15%;
  				max-height:15%;
  				float: right;
		}
			
		.card img {
    			width: auto;
    			height: auto;
		}

		b, strong {
    			font-weight: bolder;
		}

		.notice{
		  		font-family: "roboto";
		  		font-size: 16px;
		  		font-weight: 400;
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
    
    	 <script>
        var isviewed=[];
        
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
        
        function setTime(id,time)
        {
        	document.getElementById(id).innerHTML=time_ago(new Date(time));
        }
        
        var configForShow = {
                "theme": "snow",
                "modules": {
                "toolbar": false
    			} 
     	};
     
     	var quillShowNotice;
     
	    function instantiateEditor(id,content)
	    {
	       quillShowNotice=new Quill(id,configForShow);
	       quillShowNotice.setContents(content);
	       quillShowNotice.enable(false);  
	    }
     
    
        </script>
    	
</head>

<body class="blue-grey lighten-5">

    <!--Main Navigation-->
    <header>

        <!-- Navbar -->
        <nav class="navbar fixed-top navbar-expand-lg navbar-light white scrolling-navbar" style="margin-left: 30px;box-shadow: none;">
            <div class="container-fluid">

                <!-- Brand -->
                <a class="navbar-brand waves-effect" href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">
                    <strong class="blue-text">Korero</strong>
                </a>

                <!-- Collapse -->
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Links -->
                <div class="collapse navbar-collapse" id="navbarSupportedContent">

                    <!-- Left -->
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link waves-effect" href="#">Home
    
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link waves-effect" href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">About this class</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link waves-effect" href="https://mdbootstrap.com/getting-started/" target="_blank">Blogs</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link waves-effect" href="https://mdbootstrap.com/bootstrap-tutorial/" target="_blank">Notice
                            <span class="sr-only">(current)</span>
                            </a>
                        </li>
                    </ul>
                    <!-- Right -->
                    <ul class="navbar-nav nav-flex-icons">
                        <li class="nav-item mr-4">
                            <form class="form-inline ml-auto">
                                <div class="md-form mt-0">
                                    <i class="fa fa-search" aria-hidden="true"></i>
                                    <input class="form-control" type="text" placeholder="Search" aria-label="Search">
                                </div>
                            </form>
                        </li>
                        <li class="nav-item mr-2">
                            <!-- Basic dropdown -->
                            <div class="btn-group">
                                <a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-bell"></i>
                                </a>

                                <div class="dropdown-menu dropdown-pull-right">
                                    <a class="dropdown-item" href="#">Action</a>
                                    <a class="dropdown-item" href="#">Another action Another action Another action Another action</a>
                                    <a class="dropdown-item" href="#">Something else here</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#">Separated link</a>
                                </div>
                            </div>
                            </a>
                        </li>
                    </ul>

                </div>

            </div>
        </nav>
        <!-- Navbar -->

                <!-- Sidebar -->
        <div class="leftside pt-2" onmouseover="javascript:document.getElementById('blur').style.filter='blur(3px)';" onmouseout="javascript:document.getElementById('blur').style.filter='blur(0)';">
            <div class="text-center" style="padding: 10px;">
                <img src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg" class="img-fluid z-depth-1 rounded-circle" style="max-height: 150px;"  alt="Responsive image">
            </div>
            <div class="item">
                <span class="fa fa-bel"></span>
                Shreeya Nagar
            </div>
            <div class="item">
                <span class="fa fa-user"></span>
                 Profile
            </div>
            <div class="item">
                <span class="fa fa-pie-chart"></span>
                Dashboard
            </div>
            <div class="item active">
                <span class="fa fa-institution"></span>
                Book Advice
            </div>
            <div class="item">
                <span class="fa fa-bar-chart-o"></span>
                Polling
            </div>
            <div class="item">
                <span class="fa fa-graduation-cap"></span>
                Class Discussion
            </div> 
            <div class="item">
                <span class="fa fa-sign-out"></span>
                LogOut
            </div> 
        </div>

                <!-- Sidebar -->

    </header>
    <!--Main Navigation-->

    <!--Main layout-->
      <main class="pt-5 mx-lg-5" id="blur">
        <div class="container-fluid mt-5 ml-3">

            <!-- Heading -->
            <div class="card wow fadeIn">

                <!--Card content-->
                <div class="card-body d-sm-flex justify-content-between">

                    <h4 class="mb-2 mb-sm-0">
                        <a href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">CS-B/</a>
                        <span>8th sem/</span>
                        <span></span>
                    </h4>

                    <div>
                    <a href="showSavedPosts"><i class="fa fa-thumb-tack" aria-hidden="true"></i> My Saved Posts&nbsp;&nbsp;</a>
                    <a href="showMyPosts"><i class="fa fa-circle" aria-hidden="true"></i> My Posts</a>
                        
                    </div>
                </div>

            </div>
            <!-- Heading -->

            <!--Grid row-->
        <div class="row mx-4">
                <!-- Card -->
            <c:forEach var="notice" items="${classNotices}" begin="0" varStatus="noticeLoop">
            	
            	<span id="noticeId${noticeLoop.index}" style="display:none">${notice.noticeId}</span>
                <div class="card wow fadeIn mt-4" data-wow-delay="0.3s">
	                <!-- Content -->
	                <div class="d-flex align-items-center py-4 px-4">
	                    <div>
	                    	<h5 class="blue-text" style="display: inline-block;"><i class="fa fa-pie-chart"></i></h5>
	                    	<a href="">${notice.creator.uname}</a> issued <span id="noticeTimeStamp${noticeLoop.index}"></span> 
	                        <small class="float-right"><a href="#no" onclick="showViewers(${notice.noticeId})"><i class="fa fa-eye"></i></a>   ${notice.viewers}</small>
	                        <h3 class="card-title pt-2"><strong>${notice.title}</strong></h3>
	                        <p>
	                        <div id="noticeEditor${noticeLoop.index}" class="notice" style="width:1127px"></div>
	                        </p>
	                    </div>
	                </div>
	                <!-- Content -->
	            </div>
	           	<script>
					var viewed=${notice.viewed};
					isviewed.push(viewed);
					
					var noticeTime=${notice.timestamp};
					setTime('noticeTimeStamp${noticeLoop.index}',noticeTime);
					
					var noticeContent=${notice.noticeText};
					var id="#noticeEditor${noticeLoop.index}";
					
					instantiateEditor(id,noticeContent);
				</script>
			
	      </c:forEach>
            <!-- Card -->
        </div>
            <!--Grid row-->
        </div>
    </main> 
    <!--Main layout-->
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
    <script type="text/javascript">
        // Animations initialization
        new WOW().init();
        $('.carousel').carousel({
            interval: false
})
        // Tooltips Initialization
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
    </script>
  
    <script type="text/javascript">
        setTimeout(function(){

    $('.progress-bar').each(function() {
        var me = $(this);
        var perc = me.attr("data-percentage");

        var current_perc = 0;

        var progress = setInterval(function() {
            if (current_perc>=perc) {
                clearInterval(progress);
            } else {
                current_perc +=5;
                me.css('width', (current_perc)+'%');
            }

//            me.text((current_perc)+'%');

        }, 100);

    });

},250);
    </script>

 <script type="text/javascript">
        $(document).ready(function() { document.getElementById("toggbt").click();});
        // Animations initialization
        new WOW().init();
        $('.carousel').carousel({
            interval: false
})
    </script>

<script>
		
		var elements = document.querySelectorAll(".notice");
		var length = elements.length;
		var flag= new Array(length);
        
		function reveal()
        {

            for(var count = 0; count < length; count++)
           {
               /* offsetParent may not be the body if the element container is positioned. Therefore we need to find the distance from the body by adding all the offsetTop's of all offsetParent's.  */
            var offsetParentTop = 0;
            var temp = elements[count];
			var temp1 = elements[count];
			var outerheight=$(temp1).outerHeight(true);
			//console.log(outerheight);
               do
               {
                   if(!isNaN(temp.offsetTop))
                   {
                        offsetParentTop += temp.offsetTop;
                   }
               }while(temp = temp.offsetParent);
               
			//   console.log("parent"+offsetParentTop);
               var pageYOffset = window.pageYOffset;
               var viewportHeight = window.innerHeight;       
               
               if( offsetParentTop < (pageYOffset + viewportHeight) && flag[count]== undefined && (offsetParentTop + outerheight >= pageYOffset || offsetParentTop > pageYOffset))
               {	flag[count]= true;
                   console.log(elements[count].id+ " is visible");
				   window.setTimeout(isViewed,1000,count);
                }
				else if(flag[count]==true && ((offsetParentTop + outerheight) <= pageYOffset || offsetParentTop>=pageYOffset+viewportHeight))
				{
				    flag[count]= undefined;
					console.log(elements[count].id+ " is out of view");
				}
            }
        }
        
        /* Attach event handlers to resize and scroll event */
        window.addEventListener("resize",reveal);
        window.addEventListener("scroll",reveal);
		
        var countIndex;
		function isViewed(count)
		{
			if(flag[count]==true)
			{
				if(isviewed[count]==false)
				{
					countIndex=count;
					countAsView(count);
					console.log("This Is Viewed-->>"+count);
				}
			
				else
				console.log("Already Viewed-->>"+count);
			}
			else
				console.log("This Is Not Viewed-->>"+count);
		}
		
		function getXmlHttpRequestObject()
		{
			var xmlHttpReq;
	
			if(window.XMLHttpRequest)
			{
			    request=new window.XMLHttpRequest();
			}
			else if(window.ActiveXObject)
			{
			    request=new window.ActiveXObject();
			}
			else
			{
			    request=null;
			}
			
			return request;
		}

		function countAsView(x)
		{   
		    var val=x
		    var nid=document.getElementById('noticeId'+x).innerHTML;
		    request=getXmlHttpRequestObject();
		    request.onreadystatechange=viewed;
		    request.open("post","CountAsNoticeView",true);
		    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");
		    var data="noticeId="+nid+"&count="+x;
		    request.send(data);
		}

		function viewed()
		{
		    if(request.readyState===4 && request.status===200)
		    {
		    	countIndex=request.responseText;
		    	isviewed[countIndex]=true;
		    	console.log(countIndex);
		    }
		}
		
		function showViewers(noticeId)
		{   
		    request=getXmlHttpRequestObject();
		    request.onreadystatechange=viewerShown;
		    request.open("post","showAllViewers",true);
		    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");
		    var data="noticeId="+noticeId;
		    request.send(data);
		}

		function viewerShown()
		{
		    if(request.readyState===4 && request.status===200)
		    {
		    	console.log(request.responseText);
		    }
		}

    </script>
	
</body>

</html>