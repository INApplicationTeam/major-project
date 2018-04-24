<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
			
		

		b, strong {
    			font-weight: bolder;
		}

		.quillEditor{
		  		font-family: "Roboto";
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
    
</head>

<body class="rgba-grey-slight">

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
  		  return "on "+new Date(time).toDateString();
  		}
        
        var configForShow = {
                   "theme": "snow",
                   "modules": {
                   "toolbar": false
       			} 
        };
        
        var quillShowDis,quillShowEvent;
               
        function setDiscussion(index,discussionContent)
        {
        	quillShowDis=new Quill('#disEditor'+index,configForShow);
        	quillShowDis.setContents(discussionContent);
        	quillShowDis.enable(false);
        }
        
        function setEvent(index,desc)
        {
        	quillShowEvent=new Quill('#eventEditor'+index,configForShow);
        	quillShowEvent.setContents(desc);
        	quillShowEvent.enable(false);
        }
        </script>


    <%@include file="navBarAndSideBar.jsp" %>


    <!--Main layout-->
    <main class="pt-4 mx-lg-5" id="blur">
        <div class="container-fluid mt-5 pt-3 ml-3 pr-0">

            <!-- Heading -->
            <div class="card">

                <!--Card content-->
                <div class="card-body d-sm-flex justify-content-between py-3">

                    <h5 class="mb-2 mb-sm-0">
                       ${branchsec}/ ${sem } sem
                    </h5>
                    
                    <div>
                    <a href="showSavedPosts"><i class="fa fa-thumb-tack" aria-hidden="true"></i> My Saved Posts&nbsp;&nbsp;</a>
                    <a href="showPendingPosts"><i class="fa fa-circle" aria-hidden="true"></i> Pending Posts&nbsp;</a>
                      
                    </div>
                </div>
            </div>
            <!-- Heading -->

            <!--Grid row-->
            <div class="row wow fadeIn">

                
                <div class="col-md-9">
				<c:forEach var="posts" items="${pendingPosts}" begin="0" varStatus="postLoop">
                 
                 <c:if test="${posts.getClass().name == 'model.springmodel.ClassDiscussion'}">
                 <div class="card mb-3 mt-3">
                        <div class="card-body pb-2">
                            <small>
                                <a href="../../UserProfile?uid=${posts.userModel.uid}">${posts.userModel.uname}</a> initiated discussion  <span id="discTimestamp${postLoop.index}"></span>
                                
                            </small>
                            <form:form action="acceptOrRejectPost" modelAttribute="acceptOrReject" method="POST">
								<form:hidden path="postid" value="${posts.id}"/>
								<form:hidden path="post_type" value="discussion"/>
								<form:hidden path="reviewed" id="isReviewed${postLoop.index}"/>
								<form:hidden path="title" value="${posts.title}"/>
								<input style="display: none" type="submit" value="Approve" id="approveSubmit${postLoop.index}"><input style="display: none" type="submit" value="Reject" id="rejectSubmit${postLoop.index}">
							</form:form>
							
							<button class="float-right btn btn-danger btn-sm px-3" onclick="rejectPost('${postLoop.index}')"><i class="fa fa-close"></i> Reject</button>
				            <button class="float-right btn btn-success btn-sm px-3" onclick="acceptPost('${postLoop.index}')"><i class="fa fa-check"></i> Approve</button>
				                            
                            <h4 style="font-size: 24px;" class="mt-2"><a>${posts.title}</a></h4>
                            <small class=""><strong>Description: </strong>
                            </small>
                            <div id="disEditor${postLoop.index}" class="quillEditor"></div>
								<script>
									var disContent=${posts.content};
									setDiscussion('${postLoop.index}',disContent);
									var time=${posts.timeStamp};
									document.getElementById('discTimestamp${postLoop.index}').innerHTML=time_ago(new Date(time));
								</script>
                        </div>
                        
                       
                    </div>
                    </c:if>
                    <!-- Card 1 ends-->
					
					<c:if test="${posts.getClass().name == 'model.springmodel.Events'}">
                    <div class="card my-3">
                        <div class="card-body pb-2">
                            <small>
                                <a href="../../UserProfile?uid=${posts.userModel.uid}">${posts.userModel.uname}</a> created event <span id="eventTime${postLoop.index}"></span>
                               
                            </small>
                            <form:form action="acceptOrRejectPost" modelAttribute="acceptOrReject" method="POST">
								<form:hidden path="postid" value="${posts.eid}"/>
								<form:hidden path="post_type" value="event"/>
								<form:hidden path="reviewed" id="isReviewed${postLoop.index}"/>
								<form:hidden path="title" value="${posts.title}"/>
								<input id="approveSubmit${postLoop.index}" style="display:none" type="submit" value="Approve" onclick="acceptPost('${postLoop.index}')"><input id="rejectSubmit${postLoop.index}" style="display:none" type="submit" value="Reject" onclick="rejectPost('${postLoop.index}')">
							</form:form>
							
                            <button class="float-right btn btn-danger btn-sm px-3" onclick="rejectPost('${postLoop.index}')"><i class="fa fa-close"></i> Reject</button>
                        	<button class="float-right btn btn-success btn-sm px-3" onclick="acceptPost('${postLoop.index}')"><i class="fa fa-check"></i> Approve</button>
                            
                            <h4 style="font-size: 24px;" class="mt-2"><a>${posts.title}</a></h4>
                            <small>
                                <strong>Description: </strong>
                            </small>
                            <div id="eventEditor${postLoop.index}" class="quillEditor"></div>
                            
                            <div class="text-center" style='overflow:hidden; white-space:nowrap;'>
                                <strong class="pr-1 wow bounceInLeft" data-wow-delay="0.4s" id="startdate${postLoop.index}">21 Dec'18</strong>
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <hr style='display:inline-block; width:60%;vertical-align: middle;' />
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <strong class="pr-1 wow bounceInRight" data-wow-delay="0.4s" id="lastdate${postLoop.index}">21 Dec'18</strong>
                            </div>
							
							<script>
								var startDate=${posts.startdate};
								var endDate=${posts.enddate};
								var eventTime=${posts.timestamp};
								var desc=${posts.description};
								
								document.getElementById("startdate${postLoop.index}").innerHTML=time_ago(new Date(startDate));
								document.getElementById("lastdate${postLoop.index}").innerHTML=time_ago(new Date(endDate));
								document.getElementById("eventTime${postLoop.index}").innerHTML=time_ago(new Date(eventTime));
								setEvent('${postLoop.index}',desc);
							</script>
                        </div>
                        

                    </div>
                    </c:if>
                    <!-- Card 1 ends-->
					</c:forEach>
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

    // Tooltips Initialization
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
    </script>
        
        <script>
		function acceptPost(index)
		{
			document.getElementById("isReviewed"+index).value=true;
			document.getElementById("approveSubmit"+index).click();
		}
		
		function rejectPost(index)
		{
			document.getElementById("isReviewed"+index).value=false;
			document.getElementById("rejectSubmit"+index).click();
		}
	</script>
</body>

</html>