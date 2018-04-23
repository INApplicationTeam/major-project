<%@page import="model.StudentModel"%>
<%@page import="model.FacultyModel"%>
<%@page import="model.QuestionModel"%>
<%@page import="model.RelatedQuestionModel"%>
<%
RelatedQuestionModel rlqm=(RelatedQuestionModel)session.getAttribute("relques");
RelatedQuestionModel rlqm1=(RelatedQuestionModel)session.getAttribute("relques1");

String utype=session.getAttribute("utype").toString();
FacultyModel fm;
StudentModel sm;
String uname="",uid="";
if(utype.equals("student"))
{
    sm=(StudentModel)session.getAttribute("userModel");
    uname=sm.getName();
    uid=sm.getSid();
}
else if(utype.equals("faculty"))
{
    fm=(FacultyModel)session.getAttribute("userModel");
    uname=fm.getName();
    uid=fm.getFid();
}

String uvc=request.getParameter("uvc");
String tc=request.getParameter("tc");
String notificationsJson=(String)session.getAttribute("usernotifications");
%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76" href="img/apple-icon.png" />
<link rel="icon" type="image/png" href="MDB Free/img/img1.png" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>Korero</title>
    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
    <script src="js/jquery-1.10.2.js"></script>

    <script src="js/jquery-ui.js"></script>
    <link rel="stylesheet" href="js/jquery-ui.css">
<script>
$(document).ready(function() {
	$(function() {
		$("#search").autocomplete({

			source : function(request, response) {
				$.ajax({
					url : "SearchAutoComplete",
					type : "get",
					data : {
						term : request.term
					},
					dataType : "json",
					success : function(data) {
						response(data);
					}
				});
			}
                         
		});
	});
        
        
});
</script>
    
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />

  <!-- Font Awesome -->
<link href="kext/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<!-- Bootstrap core CSS -->
<link href="kext/css/bootstrap.min.css" rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="kext/css/mdb.min.css" rel="stylesheet">
<!-- Your custom styles (optional) -->
<link href="kext/css/style.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="kext/css/sidebar.css">
    <link rel="stylesheet" type="text/css" href="kext/css/calendar.css">
	
	

<script src="https://cdn.quilljs.com/1.2.3/quill.js"></script>
<script src="https://cdn.quilljs.com/1.2.3/quill.min.js"></script>
<!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>-->
<link href="https://cdn.quilljs.com/1.1.3/quill.snow.css"
	rel="stylesheet">
<link href="https://cdn.quilljs.com/1.1.3/quill.bubble.css"
	rel="stylesheet">


<!--     Fonts and icons     -->
<link
	href='https://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons'
	rel='stylesheet' type='text/css'>
<style type="text/css">
.limittext {
	white-space: nowrap;
	width: 100%;
	overflow: hidden;
	text-overflow: ellipsis;
}

.card {
	margin: 15px 0;
}

img.resize {
	max-width: 15%;
	max-height: 15%;
	float: right;
}



b, strong {
	font-weight: bold;
}

.ans {
	font-family: "roboto";
	font-size: 16px;
	font-weight: 400;
	word-wrap: break-word;
}

pre {
	font-size: 90%;
}

.ql-container.ql-snow {
	border: 0px solid #ccc;
}

.ql-snow .ql-editor img {
	max-width: 50%;
	max-height: 50%;
}

.ui-widget-content a {
    color: #000000;
    background: #ffffff url(images/ui-bg_flat_75_ffffff_40x100.png) 50% 50% repeat-x;
}
.ui-widget {
    font-family: Roboto;
    font-size: 1.1em;
}
.ui-corner-all, .ui-corner-bottom, .ui-corner-right, .ui-corner-br {
border-bottom-right-radius: 0px;
border-bottom-left-radius: 0px;
border-top-right-radius: 0px;
border-top-left-radius: 0px;
}


.ui-menu .ui-menu-item {

list-style-image: none;

}
</style>
</head>



	

	
<body class="rgba-grey-slight">

	<div id="toolbarque" style="display: none"></div>
	<div id="editorque" style="display: none"></div>
	<script>
         
         	var quillAnswers=[];
         	var isFullShow=[];
         	
            var configque = {
                "theme": "snow",
                "modules": {
                "toolbar": false
  }
  
};
            var config = {
                "theme": "snow",
                "modules": {
                "toolbar": false
  }
               
};
             var quillque;
            quillque=new Quill('#editorque',configque);
                     
        
        </script>
 
 <script>
            
            var configForShow = {
                "theme": "snow",
                "modules": {
                "toolbar": false
  				}
                
			};
            var quillShowAns;
            function instantiateEditor(i)
            {
            	ans=quillAnswers[i];
                quillShowAns=new Quill('#ans'+i,configForShow);
                quillShowAns.setContents(ans);
                quillShowAns.enable(false);  
                document.getElementsByClassName("ansImg")[i].innerHTML="";
                document.getElementsByClassName("read")[i].innerHTML="";
            }
            
            
            function destroyHandler()
            {
            	     	window.location="LogOut";
            }
            
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
      	
            
        </script>
 
<!--Main Navigation-->
<header>

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
						href="major/message/inbox"
						target="_blank">Message</a></li>
					<li class="nav-item"><a class="nav-link waves-effect"
						href="Post_Question.jsp">Ask a question</a>
					</li>
					<li class="nav-item"><a class="nav-link waves-effect"
						href="AboutUs.jsp">About Us</a>
					</li>
				</ul>

				<!-- Right -->
				<ul class="navbar-nav nav-flex-icons">
					<li class="nav-item mr-4">
							<div class="md-form mt-0">
								<form class="navbar-form navbar-right" role="search" action="AskQuestion">
								<i class="fa fa-search" aria-hidden="true"></i>
                                    <input class="form-control" type="text" placeholder="Search -- Question,  @Username,  #Workspaces" id="search" name="search" aria-label="Search" style="width: 400px;">
							<span class="material-input"></span>
							 <button type="submit" class="btn btn-info btn-sm" >
								<i class="fa fa-search"></i><div class="ripple-container"></div>
							</button>
						</form>
							</div>
					</li>
					<li class="nav-item mr-2">
						<!-- Basic dropdown -->
						<div class="btn-group">
							<a class="dropdown-toggle nav-link" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false" onclick="showNotifications()"> <i
								class="fa fa-bell"></i>
								<span class="notification" id="notificationCount"></span>
							</a>

							<div class="dropdown-menu dropdown-pull-right" id="notifications">
							</div>
						</div> 
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
			<img src="ImageLoader?uid=<%=uid%>"
				class="img-fluid z-depth-1 rounded-circle"
				style="max-height: 150px;" alt="Responsive image">
		</div>
		<div class="item">
			<span class="fa fa-bel"></span><%=uname%>
		</div>
		
		<a href="MyProfile">
			<div class="item">
				<span class="fa fa-user"></span> Profile
			</div>
		</a> 
		
		<a href="MyFeed">

			<div class="item">
				<span class="fa fa-pie-chart"></span> My Feed
			</div>
		</a> 
		
		<a href="book advisory/bookhome.jsp">
			<div class="item active">
				<span class="fa fa-institution"></span> Book Advice
			</div>
		</a>
		
		 <a href="poll/pollhome.jsp">
			<div class="item">
				<span class="fa fa-bar-chart-o"></span> Polling
			</div>
		</a> 
		
		<a href="major/class/CDFhome<%=utype%>">
			<div class="item">
				<span class="fa fa-graduation-cap"></span> Class Discussion
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
<!--Main Navigation-->

<main class="pt-4 mx-lg-5" id="blur">
	<div class="conatiner-fluid mt-5 pt-3 ml-3 pr-0">

            <div class="row wow fadeIn">
                <div class="col-md-9">
            <!-- Heading -->
         
            <div class="card card-body py-2 mt-2">
                    <a class="card-text black-text"><%String name[]=uname.split(" ");%>
                    <h4 class="h4-responsive pt-2">Hi <%=name[0] %> !</h4></a>
                </div>
                        

                    <!--CARD 1 -->
                    <%if(rlqm!=null){int i=0;for(QuestionModel qm: rlqm.getRelatedque()){%>
                    <div class="card mb-3">
                        <div class="card-body pb-0">
                            <small>
                                <a href="UserProfile?uid=<%= qm.getUid() %>"><%= qm.getUname() %></a> posted <span id="<%=i%>"></span> in
                                 <a href="WorkSpaceContent?did=<%= qm.getDomain() %>&dname=<%= qm.getdName() %>"><%= qm.getdName() %></a>
                            </small>
                            <h4 style="font-size: 24px"  class="mt-2"><a href="major/question/allAnswers?qid=<%=qm.getQid()%>" style="color: black"><%= qm.getQue() %></a></h4>
                            <div class="white" style="border-style: round;border-radius: 20px;display: inline-block;">
                                <img src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg" class="avatar img-fluid z-depth-1 rounded-circle" alt="Responsive image" />
                                <a class="pl-1" href="ImageLoader?uid=<%= qm.getTopAnswerer() %>">
									<%if(qm.getAnswererName().equals("No one")){%><a style="color: #0099cc;"> <%= qm.getAnswererName() %></a>
											<%}else{%><a href="UserProfile?uid=<%= qm.getTopAnswerer() %>" style="color: #0099cc;"> <%= qm.getAnswererName() %></a>
											<%}%></a><small> answered</small>
                            </div>
                            <p class="pl-5">
                            <span class="ansImg"></span>
											<div class="lead ans" style="margin-bottom: 1px;"></div>
											<a class="read" href="#no" style="color: #0099cc;"
												onclick="instantiateEditor('<%=i%>')">Read more</a><br>
											<!--   <a href="#no" style="color: #0099cc;" onclick="instantiateEditor('<%=i%>')">Read more quill</a>-->
											<script>
                                                                                        	
                                                                                        	quillAnswers.push(<%= qm.getMostUpvotedAnswer() %>);
                                                                                            quillque.setContents(<%= qm.getMostUpvotedAnswer() %>); 
                                                                                            //var htmlcontent=quillque.root.innerHTML;
                                                                                            //var htmlcontent=quillque.getText();
                                                                                            window.delta=quillque.getContents();
                                                                                            var content="";
                                                                                        	var imgObj,count=0,count1=0;
                                                                                        	console.log(delta);
																							for(var i=0;i<delta.ops.length;i++)
																							{
																								var del=delta.ops[i];
																							
																								console.log(del.insert);
																							
																								if(typeof del.insert!=='object' && count1==1)
																								{
																									count1=0;
																									content=content+del.insert.substr(1,del.insert.length);
																									continue;
																								}
																								
																								if(typeof del.insert!=='object')
																									content=content+del.insert;
																								
																								else if(count==0)
																								{
																									count++;
																									imgObj=del.insert;
																									count1=1;
																								}
																							}
																						
																							if(imgObj!== undefined)
																							{
																								var opsarr={"ops":[{"insert":""}]};
																								opsarr.ops[0].insert=imgObj;
																								quillque.setContents(opsarr);
																								var imgarea=document.getElementsByClassName("ansImg")[<%=i%>];
																								imgarea.innerHTML=quillque.root.innerHTML;
																								var imgTag=imgarea.getElementsByTagName('p')[0].childNodes[0];
																								imgTag.setAttribute("class","resize");
																								imgObj=undefined;
																								
																							}
		                                                                                    var c=document.getElementsByClassName("ans");
		                                                                                    
		                                                                                    if(content.length>300)
	                                                                                        {
		                                                                                    	c[<%=i%>].innerText=content.substr(0,300)+"...";
		                                                                                    	isFullShow.push(false);
	                                                                                        }
		                                                                                    
		                                                                                    else
		                                                                                    {
		                                                                                    	c[<%=i%>].innerText=content;
		                                                                                    	isFullShow.push(true);
		                                                                                    	
		                                                                                    }
                                                                                        </script>
                      <!--           <a class="blue-text"><i class="fa fa-angle-double-right pl-2"></i> More</a>
                        -->
                            </p>
                        </div>
                      

                    </div>
                    <script type="text/javascript">
        		    setTime(<%=i%>,<%=qm.getQuedate()%>)
        		    </script>
							<%i++;}%>
							<script>
        var ansElements = document.querySelectorAll('.ans');
        var readElements = document.querySelectorAll('.read');
       
        for (var i = 0; i < ansElements.length; i++)
        {
            readElements[i].id = 'read' + i;
            ansElements[i].id = 'ans' + i;
            
            if(isFullShow[i])
            {
            	instantiateEditor(i);
            }
        
         }</script>
                    <%}%>
                    <!-- Card 1 ends-->

                    
                </div>
                
                <div class="col-md-3">
                <div id="my-calendar"></div> 
                <% if(utype.equals("faculty")){ %>
                <div class="card card-body py-2 mt-2">
                    <a class="card-text blue-text" href="major/class/addEventForm?type=<%=utype%>"><i class="fa fa-plus"></i> Add global event</a>
                </div>
                <%} %>
                <div class="list-group mt-4">
                    <a href="#" class="list-group-item disabled black-text"><h5 class="h5-responsive"><strong>Questions for you</strong></h5></a>
                   		<%if(rlqm1!=null && rlqm1.getRelatedque()!=null ){int i=0;for(QuestionModel qm: rlqm1.getRelatedque()){ %>
                   
                    <a href="major/question/allAnswers?qid=<%=qm.getQid()%>" class="list-group-item"><%= qm.getQue() %></a>
                    <%i++;
                       if(i==10)
                    	   break;
                   		}}%>
                </div>
                                
                </div>
            </div>

<!-- ************************************************************************************************************* -->
<!-- ************************************************************************************************************* -->
<!-- ************************************************************************************************************* -->
<!-- ************************************************************************************************************* -->
<!-- Button trigger modal -->
            <button type="button" class="btn btn-primary btn-sm my-0 py-0" id='modalbtn' data-toggle="modal" data-target="#exampleModal" style="visibility: hidden;">
                Launch demo modal
            </button>

            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="false">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Choose your class</h5>

                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <!--Table-->
                            <table class="table table-sm table-responsive-md btn-table">

                                <!--Table head-->
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Class</th>
                                        <th>batch</th>
                                        <th>Subject</th>
                                    </tr>
                                </thead>
                                <!--Table head-->

                                <!--Table body-->
                                <tbody>
                                    <tr>
                                        <th scope="row">1</th>
                                        <td><button type="button" class="btn btn-primary btn-rounded btn-sm my-0">CS-B</button><span class="badge indigo">Coordinator</span></td>
                                        <td>2018</td>
                                        <td>Operating system</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">2</th>
                                        <td><button type="button" class="btn btn-primary btn-rounded btn-sm my-0">CS-B</button></td>
                                        <td>2017</td>
                                        <td>Soft computing</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">3</th>
                                        <td><button type="button" class="btn btn-primary btn-rounded btn-sm my-0">CS-B</button></td>
                                        <td>2016</td>
                                        <td>ho gaya</td>
                                    </tr>
                                </tbody>
                                <!--Table body-->

                            </table>
                            <!--Table-->
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

<!-- ************************************************************************************************************* -->
<!-- ************************************************************************************************************* -->
<!-- ************************************************************************************************************* -->
<!-- ************************************************************************************************************* -->
<!-- ************************************************************************************************************* -->



</div>
</main>
</body>

		<script src="js/Notifications.js"></script>

		<script>
	var notifications=[];
	
	if('<%=notificationsJson%>'!='null')
	{
		notifications=<%=notificationsJson%>;
	}
	document.getElementById("notificationCount").innerHTML=notifications.length;
	console.log("----Showing notification---")
	console.log(notifications);
	
	websocket.onmessage=function processMessage(message){
		var jsonData=JSON.parse(message.data);
		console.log(jsonData);
		if(jsonData.message!=null)
			{
				notifications.push(jsonData);
				document.getElementById("notificationCount").innerHTML=notifications.length;
				showNotifications();
			}
		
	}

	
	</script>
	  <!--Main layout-->
    <!-- SCRIPTS -->
    <!-- JQuery -->
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="kext/js/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="kext/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="kext/js/mdb.min.js"></script>
    <script type="text/javascript" src="kext/js/calendar.js"></script>

    <!-- Initializations -->
		<script type="text/javascript">
	
//		new WOW().init();

	
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

	
		function showNotifications()
		{
			document.getElementById("notificationCount").innerHTML=notifications.length;
			document.getElementById("notifications").innerHTML="";
			console.log("notifiying..");
			for(var i=notifications.length-1;i>=0;i--)
			{																																										
				document.getElementById("notifications").innerHTML=document.getElementById("notifications").innerHTML+'<a class="dropdown-item" onClick=viewNotification('+i+')>'+notifications[i].message+"\t"+time_ago(new Date(notifications[i].timestamp))+'</a><div class="dropdown-divider"></div>';	
			}

		}
		
		function viewNotification(i)
		{   
		    request=getXmlHttpRequestObject();
		    request.onreadystatechange=notificationViewed;
		    request.open("post","ViewNotification",true);
		    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");
		    var data="nid="+notifications[i].nid+"&uid="+notifications[i].uid;
		    request.send(data);
		}

		function notificationViewed()
		{
		    if(request.readyState===4 && request.status===200)
		    {
		    	console.log("notificationViewed");
		    }
		}

		


	</script>


<!--   Core JS Files   -->
<!--<script src="js/jquery-3.1.0.min.js" type="text/javascript"></script>-->


</html>
