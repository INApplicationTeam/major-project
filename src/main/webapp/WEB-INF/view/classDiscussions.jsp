<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
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
         <style>
        
        img.resize {
  				max-width:15%;
  				max-height:15%;
  				float: right;
		}
			
		
		b, strong {
    			font-weight: bolder;
		}

		.discEditor{
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
        
        </style>
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

        </script>
    
</head>

<body class="blue-grey lighten-5">

<%@include file="navBarAndSideBar.jsp"%>

    <!--Main layout-->
    <main class="pt-4 mx-lg-5" id="blur">
        <div class="container-fluid mt-5 pt-3 ml-3 pr-0">

            <!-- Heading -->
            <div class="card">

                <!--Card content-->
                <div class="card-body d-sm-flex justify-content-between py-3">

                    <h5 class="mb-2 mb-sm-0">
                        ${branchsec }/${sem } sem
                    </h5>
                    <a href="../../poll/createpoll.jsp?var=classpoll">
                    <button type="button" class="btn btn-outline-primary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Create poll</button>
                    </a>
                    
                   <a href="startClassDiscussion">
                    <button type="button" class="btn btn-outline-default waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Start Discussion</button>
                    </a>
                    
                    <a href="addEventForm">
                    <button type="button" class="btn btn-outline-secondary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Add event</button>
                    </a>
                    
                    <a href="../../Post_Question.jsp?classQue=true">
                    <button type="button" class="btn btn-outline-success waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Ask Question</button>
                    </a>
                    <div>
            <a href="showSavedPosts"><i class="fa fa-thumb-tack" aria-hidden="true"></i> My Saved Posts&nbsp;&nbsp;</a>
                        <div class="btn-group">
                            <a class="dropdown-toggle blue-text" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-filter" aria-hidden="true"></i>
                                <span class="sr-only">Toggle Dropdown</span>
                            </a>
                            <div class="dropdown-menu dropdown-pull-right mr-3">
                                 <a class="dropdown-item" href="showPoll">Polls</a>
                                <a class="dropdown-item" href="showDiscussions">Discussions</a>
                                <a class="dropdown-item" href="showEvents">Events</a>
                                <a class="dropdown-item" href="showClassQuestions">Questions</a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <!-- Heading -->

            <!--Grid row-->
            <div class="row wow fadeIn">

                
                <div class="col-md-9">
                
                <c:forEach var="discussion" items="${discussionsList}" begin="0" varStatus="loop">
                    <!--CARD 1 -->
                    <div class="card mb-3 mt-4">
                        <div class="card-body pb-0">
                            <small>
                                <a href="../../UserProfile?uid=${discussion.userModel.uid}">${discussion.userModel.uname} </a> initiated discussion <span id="timestamp${loop.index}"></span>
                            
                            </small>
                            <h4 style="font-size: 24px;" class="mt-2"><a>${discussion.title}</a></h4>
                            <small class="">
                            	<strong>Description: </strong>
                            	
                            </small>
                            <div id="disEditor${loop.index}" class="discEditor"></div>
            
                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2">
                            
                            <a onclick="showComments('first${loop.index}','firsthide${loop.index}')" id='firsthide${loop.index}' class="float-right blue-text"><i class="fa fa-angle-double-down ml-4" aria-hidden="true"></i><small> Show Comments</small></a>
                            <a><i class="fa fa-angle-double-up float-right blue-text" aria-hidden="true" id="first${loop.index}" onclick="closeComments('first${loop.index}','firsthide${loop.index}')" style="display: none;"> Hide Comments</i></a>                            
                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2 first${loop.index}" style="display: none;font-size: 15px;">
                       
                        <c:forEach var="classComment" items="${discussion.classCommentList}" begin="0" varStatus="innerloop">
                            <div class="media d-block d-md-flex mt-2 ml-5">
                                <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="../../ImageLoader?uid=${classComment.userModel.uid}" alt="Generic placeholder image">
                                <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                    <a class="mt-0 blue-text" href="../../UserProfile?uid=${classComment.userModel.uid}">${classComment.userModel.uname}</a>
                                    <a class="mt-0 blue-text pull-right" onclick="showReplyBox('replyBox${loop.index}${innerloop.index}')"><i class="fa fa-reply" aria-hidden="true"></i></a>

                                   	${classComment.commentText}
									<br>
									
									<a href="#no" id="likeComment${loop.index}${innerloop.index}" onclick="likeComment('${loop.index}${innerloop.index}','${classComment.commentId}','${classComment.liked}')"><i class="fa fa-thumbs-o-up pl-4" aria-hidden="true" id="likeIcon${loop.index}${innerloop.index}"></i> &nbsp;<span id="showLikes${loop.index}${innerloop.index}"> ${classComment.likes}</span></a>
                                  
                                    <small id="commenttimestamp${loop.index}${innerloop.index}" class="text-muted pull-right"></small>
									
								<c:forEach var="commentReply" items="${classComment.commentReplyList}" begin="0" varStatus="replyLoop">
                                    <div class="media d-block d-md-flex mt-3">
                                        <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="../../ImageLoader?uid=${commentReply.userModel.uid}" alt="Generic placeholder image">
                                        <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                            <a class="mt-0 blue-text" href="../../UserProfile?uid=${classComment.userModel.uid}">${commentReply.userModel.uname}</a>
                                            ${commentReply.replyText}
                                            <br>
                                            <small id="replytimestamp${loop.index}${innerloop.index}${replyLoop.index}" class="text-muted pull-right">3 minutes ago</small>
                                        </div>
                                    </div>
                                    <script type="text/javascript">
										var replytimestamp=${commentReply.timestamp};
										document.getElementById('replytimestamp${loop.index}${innerloop.index}${replyLoop.index}').innerHTML=time_ago(new Date(replytimestamp));
									</script>
								</c:forEach>
                                    
                                    <div class="media d-block d-md-flex mt-3">
                                        <div id="replyBox${loop.index}${innerloop.index}" class="media-body text-center text-md-left ml-md-3 ml-0" style="display:none;">
                                                <label for="replyFormComment">Your Reply</label>
                                                <form:form action="postCommentReply?commentId=${classComment.commentId}" modelAttribute="ClassReplyModel" method="POST">
                                                	<form:textarea cssClass="form-control" rows="2" path="replyText"/>
                                                	<button type="submit" class="btn btn-primary btn-sm pull-right"><i class="fa fa-comment"></i> Reply</button>
                                                </form:form>
       
                                        </div>
                                    </div>
                                    

                                </div>
                            </div>
                            <script type="text/javascript">
								if('${classComment.liked}'=='true')
								{
									document.getElementById('likeIcon${loop.index}${innerloop.index}').setAttribute("class","fa fa-thumbs-up pl-4");
								}
								
								var commenttimestamp=${classComment.timestamp};
								document.getElementById('commenttimestamp${loop.index}${innerloop.index}').innerHTML=time_ago(new Date(commenttimestamp));
							</script>
                       	</c:forEach> 
                            
                            <div class="form-group ml-5 mb-4">
                                <label for="replyFormComment">Your comment</label>
                                <form:form action="postComment?disId=${discussion.id}" modelAttribute="ClassCommentModel" method="POST">
                                	<form:textarea cssClass="form-control" path="commentText" id="replyFormComment" rows="3"/>
                                	<button type="submit" class="btn btn-primary btn-sm pull-right"><i class="fa fa-comment"></i> Post</button>
                                </form:form>
                            </div>
                        </div>
                    </div>
                    <!--CARD 1 -->

<script type="text/javascript">

	var quillShow=new Quill('#disEditor${loop.index}',configForShow);
	var quillContents=${discussion.content};
	quillShow.setContents(quillContents);
	quillShow.enable(false);
	var timestamp=${discussion.timeStamp};
	document.getElementById('timestamp${loop.index}').innerHTML=time_ago(new Date(timestamp));

</script>
                    
                </c:forEach>

                </div>
                <div class="col-md-3 mx-0 my-0 px-0 py-0">

                <ul class="list-group mt-4 ml-2 mb-4 wow tada">
                    <li class="list-group-item d-flex justify-content-between align-items-center primary-color">
                        <h4 class="mb-0 pb-0 white-text"><strong>Pinned Posts</strong></h4>
                    </li>
                    
                    <c:forEach var="pinPost" items="${allPinnedPosts}" begin="0" varStatus="pendingPostLoop">
						<c:if test="${pinPost.post_type.toUpperCase() == 'QUESTION'}">
							<li class="list-group-item d-flex justify-content-between align-items-center">
                        		<a href="../question/allAnswers?qid=${pinPost.postid}" style="color:black;">${pinPost.title}</a>
                        		<span class="badge badge-primary badge-pill">${pinPost.post_type.toUpperCase()}</span>
                    		</li>
						</c:if>
						
						<c:if test="${pinPost.post_type.toUpperCase() != 'QUESTION'}">
							<li class="list-group-item d-flex justify-content-between align-items-center">
                        		<a href="showPinnedPost?postId=${pinPost.postid}&postType=${pinPost.post_type}" style="color:black;">${pinPost.title}</a>
                        		<span class="badge badge-primary badge-pill">${pinPost.post_type.toUpperCase()}</span>
                    		</li>
						</c:if>
					</c:forEach>
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
        new WOW().iinit();
        $('.carousel').carousel({
            interval: false
})
        // Tooltips Initialization
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
    </script>
    <script type="text/javascript">
        function showComments(postno,id) {
        var List=document.getElementsByClassName(postno);
        for (var i = 0; i <List.length; i++) {
           List[i].style.display="block";
        }
        document.getElementById(id).style.display="none";
        document.getElementById(postno).style.display="block";
        document.getElementById(postno).scrollIntoView(true);
        }
        function closeComments(postno,id) {
            var List=document.getElementsByClassName(postno);
            for (var i = 0; i <List.length; i++) {
               List[i].style.display="none";
            }
        document.getElementById(postno).style.display="none";
        document.getElementById(id).style.display="block";
        }
        function dropdown1(id1) {
    document.getElementById("dropdownMenu1").innerHTML = document.getElementById(id1).innerHTML;
}

    </script>
    
    <script>
    
	    function showReplyBox(id)
	    {
	    	console.log("inside");
	    	if(document.getElementById(id).style.display==="none")
	    		document.getElementById(id).style.display="block";
	    	
	    	else
	    		document.getElementById(id).style.display="none";
	    	
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

		var likeIndex;
		function likeComment(x,commentId,isLiked)
		{   	
			
			likeIndex=x;
			var likesCount=document.getElementById("showLikes"+likeIndex).innerHTML;
			var innerText=document.getElementById("likeIcon"+likeIndex).className;
			
			console.log(innerText);
			
			if(innerText=='fa fa-thumbs-o-up pl-4')
			{	
			    request=getXmlHttpRequestObject();
			    request.onreadystatechange=commentLiked;
			    request.open("post","LikeComment",true);
			    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");    
			    var data="commentId="+commentId+"&likesCount="+parseInt(likesCount);
			    request.send(data);
			}
			else if(innerText=='fa fa-thumbs-up pl-4')
			{
				request=getXmlHttpRequestObject();
			    request.onreadystatechange=commentUnLiked;
			    request.open("post","UnLikeComment",true);
			    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");    
			    var data="commentId="+commentId+"&likesCount="+parseInt(likesCount);
			    request.send(data);
			}
		}
		
		function commentLiked()
		{
		    if(request.readyState===4 && request.status===200)
		    {
		        var result=request.responseText; 
		     
		        if(result==1)
		    	{
		        	var showLikes=document.getElementById("showLikes"+likeIndex);
		        	showLikes.innerHTML=parseFloat(showLikes.innerHTML)+1;
		        	document.getElementById("likeIcon"+likeIndex).setAttribute("class","fa fa-thumbs-up pl-4");
		    	}
		    }
		}
		
		function commentUnLiked()
		{
			if(request.readyState===4 && request.status===200)
		    {
		        var result=request.responseText; 
		     
		        if(result==1)
		    	{
		        	var showLikes=document.getElementById("showLikes"+likeIndex);
		        	showLikes.innerHTML=parseFloat(showLikes.innerHTML)-1;
		        	document.getElementById("likeIcon"+likeIndex).setAttribute("class","fa fa-thumbs-o-up pl-4");
		    	}
		    }
		}

		
		
		</script>
</body>

</html>