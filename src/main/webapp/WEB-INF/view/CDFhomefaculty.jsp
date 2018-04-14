<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Class Discussion forum</title>
		
		<script src="https://cdn.quilljs.com/1.2.3/quill.js"></script>
        <script src="https://cdn.quilljs.com/1.2.3/quill.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <link href="https://cdn.quilljs.com/1.1.3/quill.snow.css" rel="stylesheet">
        <link href="https://cdn.quilljs.com/1.1.3/quill.bubble.css" rel="stylesheet">
        
        <style>
        a{
        	color: #0099cc;
        }
        
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
		.card img {
    			width: auto;
    			height: auto;
		}

		b, strong {
    			font-weight: bold;
		}

		.ans{
		  		font-family: "roboto";
		  		font-size: 15px;
		  		font-weight: 300;
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
</head>
<body>

<h1>Welcome to Class ${classid}</h1>
	<c:choose>
		<c:when test="${type=='coordinator' && isCurrentYear==true}">
			<a href="../admin/addCRForm">Add Class Representative</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="../admin/showCR">Show Class Representative</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			<a href="../admin/addformFaculty">Add Subject Faculty</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			<a href="../admin/showFaculty">Show Subject Faculty</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="showPendingPosts">Show Pending Posts</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			<h3>CHOOSE YOUR POST TYPE...</h3>
			<a href="../../poll/createpoll.jsp?var=classpoll"><button id="create_poll">Create Poll</button></a>
			<a href="../../Post_Question.jsp?classQue=true"><button id="create_que">Ask question</button></a>
			<a href="addEventForm"><button id="create_event">Create Event</button></a>
			<a href="startClassDiscussion"><button id="create_disc">Start Discussion</button></a>
			<a href="issueNotice"><button id="create_notice">Issue Notice</button></a>
		</c:when>
		
		<c:when test="${type=='coordinator' && isCurrentYear==false}">
			<a href="../admin/showCR">Show Class Representative</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="../admin/showFaculty">Show Subject Faculty</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</c:when>
		
		<c:when test="${type=='faculty' && isCurrentYear==false}">
			FACULTY
		</c:when>
		
		<c:when test="${type=='faculty' && isCurrentYear==true}">
			FACULTY
			<h3>CHOOSE YOUR POST TYPE...</h3>
			<a href="../../poll/createpoll.jsp?var=classpoll"><button id="create_poll">Create Poll</button></a>
			<a href="../../Post_Question.jsp?classQue=true"><button id="create_que">Ask question</button></a>
			<a href="addEventForm"><button id="create_event">Create Event</button></a>
			<a href="startClassDiscussion"><button id="create_disc">Start Discussion</button></a>
			<a href="issueNotice"><button id="create_notice">Issue Notice</button></a>
		</c:when>
	</c:choose>
	
	<div id="toolbarque" style="display: none"></div>
    <div id="editorque" style="display: none"></div>
    
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
        
        function setTime(id,time)
        {
        	document.getElementById(id).innerHTML=time_ago(new Date(time));
        }
       
        
        var quillAnswers=[];
        
        var quillNotices=[];
        
        var postTypes=[];
        
        var configque = {
            "theme": "snow",
            "modules": {
            "toolbar": false
 			} 
		 };
 
        var configForShow = {
                   "theme": "snow",
                   "modules": {
                   "toolbar": false
       			} 
        };
        
        var quillque=new Quill('#editorque',configque);
        var quillShowAns,quillShowDis,quillShowNotice,quillShowEvent;
        
        function instantiateEditor(index,postIndex)
        {
           ans=quillAnswers[index];
           quillShowAns=new Quill('#ansEditor'+postIndex,configForShow);
           quillShowAns.setContents(ans);
           quillShowAns.enable(false);  
           document.getElementsByClassName("ansImg")[index].innerHTML="";
           document.getElementsByClassName("read")[index].innerHTML="";
        }
        
       
        function setNoOne(index,postIndex)
    	{
			document.getElementById("answerer"+postIndex).innerHTML="No One";
			quillAnswers.push({"ops":[{"insert":""}]});
			document.getElementsByClassName("read")[index].innerHTML="";
    	}
        
        function setAnswer(index,postIndex,answerText,answererName)
        {
        	document.getElementById("answerer"+postIndex).innerHTML=answererName;
			quillAnswers.push(answerText);									
        	window.delta=answerText;
        	var content="";
        	var imgObj,count=0,count1=0;
        
        	for(var i=0;i<delta.ops.length;i++)
			{
				var del=delta.ops[i];
					
				if(typeof del.insert!=='object' && count1==1)
				{
					count1=0;
					content=content+del.insert.substr(1,del.insert.length);
					continue;
				}
			
				if(typeof del.insert !== 'object')
				{
					content=content+del.insert;
				}						
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
				var imgarea=document.getElementsByClassName("ansImg")[index];
				imgarea.innerHTML=quillque.root.innerHTML;
				var imgTag=imgarea.getElementsByTagName('p')[0].childNodes[0];
				imgTag.setAttribute("class","resize");
				imgObj=undefined;							
			}                                               
        
			var c=document.getElementsByClassName("ans");
                                 
        	if(content.length>500)
        	{
          		c[index].innerText=content.substr(0,500)+"...";
        	}
                               
        	else
       	 	{
          		c[index].innerText=content;
          		instantiateEditor(index,postIndex);
        	}
        }
        
        function setNoticeContent(index,postIndex,noticeText)
        {
        	console.log(noticeText);
			quillNotices.push(noticeText);									
        	window.delta=noticeText;
        	var content="";
        	var imgObj,count=0,count1=0;
        	var endLineCounter=0;
        	var isStillLeft=false;
        	
        	for(var i=0;i<delta.ops.length;i++)
			{
				var del=delta.ops[i];
					
				if(typeof del.insert!=='object' && count1==1)
				{
					if(del.insert.indexOf("\n")!=-1)
					{
						endLineCounter++;	
					}
					
					if(endLineCounter<9)
					{
						count1=0;
						content=content+del.insert.substr(1,del.insert.length);
						continue;
					}
					else
					{
						isStillLeft=true;
						break;
					}
					
				}
			
				if(typeof del.insert !== 'object')
				{
					if(del.insert.indexOf("\n")!=-1)
					{
						endLineCounter++;	
					}
					
					if(endLineCounter<9)
					{
						content=content+del.insert;
					}
					else
					{
						isStillLeft=true;
						break;
					}
				}						
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
				var imgarea=document.getElementsByClassName("noticeImg")[index];
				imgarea.innerHTML=quillque.root.innerHTML;
				
				if(imgObj.hasOwnProperty('image'))
				{
					var imgTag=imgarea.getElementsByTagName('p')[0].childNodes[0];
					imgTag.setAttribute("class","resize");
				}
				else
				{
					var imgTag=imgarea.getElementsByTagName('p')[0];
					imgTag.removeChild(imgarea.getElementsByTagName('p')[0].childNodes[0]);
				}
				imgObj=undefined;							
			}                                               
        
			var c=document.getElementsByClassName("notice");
                                 
        	if(content.length>500)
        	{
          		c[index].innerText=content.substr(0,500)+"...";
        	}
                               
        	else if(isStillLeft)
        	{
        		c[index].innerText=content;
        	}
        	
        	else
       	 	{
          		c[index].innerText=content;
          		document.getElementsByClassName("readNotice")[index].innerHTML="";
        	}
        	
        }
        
        function setDiscussion(index,discussionContent)
        {
        	quillShowDis=new Quill('#disEditor'+index,configForShow);
        	quillShowDis.setContents(discussionContent);
        	quillShowDis.enable(false);
        }
        
        function setEventContent(index,eventContent)
        {
        	quillShowEvent=new Quill('#eventEditor'+index,configForShow);
        	quillShowEvent.setContents(eventContent);
        	quillShowEvent.enable(false);
        }
      
        var post_type,post_id;
        
        /* function setPinButton(isPinned,postIndex,postid,posttype)
        {
        	if(isPinned)
			{
        		var attr="unPinPost("+postid+","+String(posttype)+","+"pin"+postIndex+")";
				document.getElementById("pin"+postIndex).innerHTML="Un Pin Post";
				document.getElementById("pin"+postIndex).setAttribute("onclick",attr);
			}
           else
        	{
        		var attr="unPinPost("+postid+","+String(posttype)+","+"pin"+postIndex+")";
        		document.getElementById("pin"+postIndex).innerHTML="Pin Post";
				document.getElementById("pin"+postIndex).setAttribute("onclick",attr);
        	}  
        } */
        
      
        </script>
    

<h1>CLASS DISCUSSION FORUM</h1>
	
<a href="../../MyFeed">MY FEED</a>

<a href="showNotices">NOTICE</a>
	<select name="SHOW" onchange="location = this.value;">
    	<option selected disabled>Show</option>
	 	<option value="showPoll">Polls</option>
	 	<option value="showClassQuestions">Questions</option>
	 	<option value="showDiscussions">Discussions</option>
	 	<option value="showEvents">Events</option>
	</select>
	<hr>
	<h3>Class Members</h3>
		<c:forEach var="temp1" items="${classmembers}" > 
			${temp1.name} &nbsp;
		</c:forEach>
	<hr>
	<h3>Class Representative</h3>
		<c:forEach var="temp2" items="${CR}"> 
			 ${temp2.userModel.uname} &nbsp;
		</c:forEach>
	<hr>
	<h3>Class Coordinator</h3>
		<c:forEach var="temp3" items="${classCoordinator}" > 
			${temp3.name} &nbsp;		
		</c:forEach>
	<hr>
	<center><h1>CLASS NOTICES</h1></center>
	<c:forEach var="notice" items="${classNotices}" begin="0" varStatus="noticeLoop">
		<a href="#no">${notice.creator.uname}</a> issued NOTICE <span id="noticetimestamp${noticeLoop.index}"></span>
		<h2>${notice.title}</h2>
		
		<div style="width:500px; height:190px;  border: 1px solid black">
			<span class="noticeImg" ></span>
			<div class="notice" style="margin-bottom: 1px;" id="noticeEditor${noticeLoop.index}"></div>
			<form:form action="showNotices" method="POST" modelAttribute="bindingNotice">
				<form:hidden path="noticeId" value="${notice.noticeId}"/>
				<input type="submit" class="readNotice" value="View More"><br>
			</form:form>               
		</div>	    
    		
		<script>
			var noticeTimeStamp=${notice.timestamp};
			setTime('noticetimestamp${noticeLoop.index}',noticeTimeStamp);
			var index=${noticeLoop.index};
			var noticeText=${notice.noticeText};
			setNoticeContent(index,index,noticeText);
		</script>	
		<br>
		<hr>
	</c:forEach>
	
	<center><h1>PINNED POSTS</h1></center>
	<table>
		<c:forEach var="pinPost" items="${allPinnedPosts}" begin="0" varStatus="pendingPostLoop">
			<c:if test="${pinPost.post_type.toUpperCase() == 'QUESTION'}">
				[${pinPost.post_type.toUpperCase()}]  <a href="../question/allAnswers?qid=${pinPost.postid}">${pinPost.title}</a><br><br>
			</c:if>
			
			<c:if test="${pinPost.post_type.toUpperCase() != 'QUESTION'}">
				[${pinPost.post_type.toUpperCase()}]  <a href="showPinnedPost?postId=${pinPost.postid}&postType=${pinPost.post_type}">${pinPost.title}</a><br><br>
			</c:if>
		</c:forEach>
	</table>
	<hr>
	<center><h1>PINNED POST DETAILS</h1></center>
	
	<c:if test="${pinnedPostType == 'discussion'}">
			
			<i><a href="">${pinnedPost.userModel.uname}</a></i> Posted <b>DISCUSSION</b> <span id="discussionTime-1"></span><br>
			<h4>Title : <i>${pinnedPost.title}</i></h4> 
			<div id="disEditor-1"></div>
			<script>
				var pinDisContent=${pinnedPost.content};
				setDiscussion('-1',pinDisContent);
			</script>
			
			<c:forEach var="classComment" items="${pinnedPost.classCommentList}" begin="0" varStatus="commentLoop">
				<h3 style="display: inline;">${classComment.userModel.uname}</h3> commented <span id="commenttimestamp-1${commentLoop.index}"></span><br>
				<textarea cols="100" readonly="readonly">${classComment.commentText}</textarea><br><br>
				<a href="#no" id="likeComment-1${commentLoop.index}" onclick="likeComment('-1${commentLoop.index}','${classComment.commentId}','${classComment.liked}')">Like</a>&nbsp;&nbsp;<span id="showLikes-1${commentLoop.index}">${classComment.likes}</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="">Report</a><br>
				
				<c:forEach var="commentReply" items="${classComment.commentReplyList}" begin="0" varStatus="replyLoop">
					<h3 style="display: inline;">${commentReply.userModel.uname}</h3> replied <span id="replytimestamp-1${commentLoop.index}${replyLoop.index}"></span><br>
					<textarea cols="100" readonly="readonly">${commentReply.replyText}</textarea><br><br>
					
					<script type="text/javascript">
						var commentReplyTime=${commentReply.timestamp};
						setTime('replytimestamp-1${commentLoop.index}${replyLoop.index}',commentReplyTime);
					</script>
				</c:forEach>
					
					<form:form action="postCommentReply?commentId=${classComment.commentId}" modelAttribute="ClassReplyModel" method="POST">
						<form:textarea rows="5" cols="100" path="replyText" placeholder="Reply..."/>
						<input type="submit" value="Reply"/>
					</form:form>
			
					<script type="text/javascript">
						if('${classComment.liked}'=='true')
							document.getElementById('likeComment-1${commentLoop.index}').innerHTML="Liked";
						
						var classCommentTime=${classComment.timestamp};
						setTime('commenttimestamp-1${commentLoop.index}',classCommentTime);
					</script>
			</c:forEach>
			
			<form:form action="postComment?disId=${pinnedPost.id}" modelAttribute="ClassCommentModel" method="POST">
				<form:textarea rows="5" cols="100" path="commentText" placeholder="Write Your Comment Here..."/>
				<input type="submit" value="Comment"/>
			</form:form>
			
			<script type="text/javascript">
				var discussionTime=${pinnedPost.timeStamp};
				setTime('discussionTime-1',discussionTime);
			</script>
			
		</c:if>
		
		<c:if test="${pinnedPostType == 'event'}">
			
			<i><a href="">${pinnedPost.userModel.uname}</a></i> Posted <b>EVENT</b> <span id="pinnedeventtimestamp"></span><br>
			<h4>Title : <i>${pinnedPost.title}</i></h4> 
			<p><b>Description:</b>  ${pinnedPost.description} </p>
			<b>Start Date:</b> <span id="pinnedstartdate"></span><br><br>
			<b>Last Date:</b> <span id="pinnedlastdate"></span><br><br>

			
			<script>
				var pinstartDate=${pinnedPost.startdate};
				var pinendDate=${pinnedPost.enddate};
				var pincreationDate=${pinnedPost.timestamp};
			
				setTime('pinnedstartdate',pinstartDate);
				setTime('pinnedlastdate',pinendDate);
				setTime('pinnedeventtimestamp',pincreationDate);
			</script>
		</c:if>
		
		<c:if test="${pinnedPostType == 'poll'}">
					
			<i><a href="">${pinnedPost.userModel.uname}</a></i> Posted <b>POLL</b><br>
			<h4>${pinnedPost.question}</h4>
			<c:forEach var="option" items="${pinnedPost.options}">
				<i>${option.options}</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${option.pollResult.count}<br>
			</c:forEach>
		
		</c:if>
		
	<hr>
	
	<center><h1>CLASS POSTS</h1></center>
	<c:set var="countQue" value="-1" scope="page" />
	
	<c:forEach var="posts" items="${allClassPosts}" begin="0" varStatus="postLoop">
	
		<c:if test="${posts.getClass().name == 'model.springmodel.ClassDiscussion'}">
			
			<div id="PinDiv${postLoop.index}">
				<c:if test="${checkPinned[postLoop.index]==false}">
					<a href="#no" onclick="pinPost('${posts.id}','${postLoop.index}');" id="pin${postLoop.index}">PIN POST</a>
				</c:if>
				
				<c:if test="${checkPinned[postLoop.index]==true}">
					<a href="#no" onclick="unPinPost('${posts.id}','${postLoop.index}');" id="pin${postLoop.index}">UNPIN POST</a>
				</c:if>
			</div>
			
			<i><a href="">${posts.userModel.uname}</a></i> Posted <b>DISCUSSION</b> <span id="discussionTime${postLoop.index}"></span><br>
			<h4>Title : <i>${posts.title}</i></h4> 
			<div id="disEditor${postLoop.index}"></div>
			<script>
				postTypes.push("discussion");
				var disContent=${posts.content};
				setDiscussion('${postLoop.index}',disContent);
			</script>
			
			<c:forEach var="classComment" items="${posts.classCommentList}" begin="0" varStatus="commentLoop">
				<h3 style="display: inline;">${classComment.userModel.uname}</h3> commented <span id="commenttimestamp${postLoop.index}${commentLoop.index}"></span><br>
				<textarea cols="100" readonly="readonly">${classComment.commentText}</textarea><br><br>
				<a href="#no" id="likeComment${postLoop.index}${commentLoop.index}" onclick="likeComment('${postLoop.index}${commentLoop.index}','${classComment.commentId}','${classComment.liked}')">Like</a>&nbsp;&nbsp;<span id="showLikes${postLoop.index}${commentLoop.index}">${classComment.likes}</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="">Report</a><br>
				
				<c:forEach var="commentReply" items="${classComment.commentReplyList}" begin="0" varStatus="replyLoop">
					<h3 style="display: inline;">${commentReply.userModel.uname}</h3> replied <span id="replytimestamp${postLoop.index}${commentLoop.index}${replyLoop.index}"></span><br>
					<textarea cols="100" readonly="readonly">${commentReply.replyText}</textarea><br><br>
					
					<script type="text/javascript">
						var commentReplyTime=${commentReply.timestamp};
						setTime('replytimestamp${postLoop.index}${commentLoop.index}${replyLoop.index}',commentReplyTime);
					</script>
				</c:forEach>
					
					<form:form action="postCommentReply?commentId=${classComment.commentId}" modelAttribute="ClassReplyModel" method="POST">
						<form:textarea rows="5" cols="100" path="replyText" placeholder="Reply..."/>
						<input type="submit" value="Reply"/>
					</form:form>
			
					<script type="text/javascript">
						if('${classComment.liked}'=='true')
							document.getElementById('likeComment${postLoop.index}${commentLoop.index}').innerHTML="Liked";
						
						var classCommentTime=${classComment.timestamp};
						setTime('commenttimestamp${postLoop.index}${commentLoop.index}',classCommentTime);
					</script>
			</c:forEach>
			
			<form:form action="postComment?disId=${posts.id}" modelAttribute="ClassCommentModel" method="POST">
				<form:textarea rows="5" cols="100" path="commentText" placeholder="Write Your Comment Here..."/>
				<input type="submit" value="Comment"/>
			</form:form>
			
			<script type="text/javascript">
				var discussionTime=${posts.timeStamp};
				setTime('discussionTime${postLoop.index}',discussionTime);
			</script>
			<hr>
			
		</c:if>
		
		<c:if test="${posts.getClass().name == 'model.springmodel.Events'}">
			
			<div id="PinDiv${postLoop.index}">
				<c:if test="${checkPinned[postLoop.index]==false}">
					<a href="#no" onclick="pinPost('${posts.eid}','${postLoop.index}');" id="pin${postLoop.index}">PIN POST</a>
				</c:if>
				
				<c:if test="${checkPinned[postLoop.index]==true}">
					<a href="#no" onclick="unPinPost('${posts.eid}','${postLoop.index}');" id="pin${postLoop.index}">UNPIN POST</a>
				</c:if>
			</div>
			
			<i><a href="">${posts.userModel.uname}</a></i> Posted <b>EVENT</b> <span id="eventtimestamp${postLoop.index}"></span><br>
			<h4>Title : <i>${posts.title}</i></h4> 
			<b>Description:</b><br>
			<div id="eventEditor${postLoop.index}"></div>   
			<b>Start Date:</b> <span id="startdate${postLoop.index}"></span><br><br>
			<b>Last Date:</b> <span id="lastdate${postLoop.index}"></span><br><br>
			<hr>
			
			<script>
				postTypes.push("event");
				var startDate=${posts.startdate};
				var endDate=${posts.enddate};
				var creationDate=${posts.timestamp};
				var eventContent=${posts.description};
			
				setTime('startdate${postLoop.index}',startDate);
				setTime('lastdate${postLoop.index}',endDate);
				setTime('eventtimestamp${postLoop.index}',creationDate);
				setEventContent('${postLoop.index}',eventContent);
				
			</script>
		</c:if>
		
		<c:if test="${posts.getClass().name == 'model.springmodel.PollQueDetails'}">
			
			<div id="PinDiv${postLoop.index}">
				<c:if test="${checkPinned[postLoop.index]==false}">
					<a href="#no" onclick="pinPost('${posts.queid}','${postLoop.index}');" id="pin${postLoop.index}">PIN POST</a>
				</c:if>
				
				<c:if test="${checkPinned[postLoop.index]==true}">
					<a href="#no" onclick="unPinPost('${posts.queid}','${postLoop.index}');" id="pin${postLoop.index}">UNPIN POST</a>
				</c:if>
			</div>
			
			<i><a href="">${posts.userModel.uname}</a></i> Posted <b>POLL</b><br>
			<h4>${posts.question}</h4>
			<c:forEach var="option" items="${posts.options}">
				<i>${option.options}</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${option.pollResult.count}<br>
			</c:forEach>
			<hr>
			<script>
				postTypes.push("poll");
			</script>
			
		</c:if>
		
		<c:if test="${posts.getClass().name == 'model.springmodel.Question'}">
			
			<div id="PinDiv${postLoop.index}">
				<c:if test="${checkPinned[postLoop.index]==false}">
					<a href="#no" onclick="pinPost('${posts.qid}','${postLoop.index}');" id="pin${postLoop.index}">PIN POST</a>
				</c:if>
				
				<c:if test="${checkPinned[postLoop.index]==true}">
					<a href="#no" onclick="unPinPost('${posts.qid}','${postLoop.index}');" id="pin${postLoop.index}">UNPIN POST</a>
				</c:if>
			</div>
			
			<c:set var="countQue" value="${countQue + 1}" scope="page"/>
			
			<i><a href="">${posts.userModel.uname}</a></i> Posted <b>QUESTION</b> on <span id="questiontime${postLoop.index}">${posts.timestamp}</span><br>
			<h4><a href="../question/allAnswers?qid=${posts.qid}">${posts.que}</a></h4>
			
			<a href="" id="answerer${postLoop.index}" style="color: #0099cc;"></a> answered<br>
			<div style="width:1000px;"><span class="ansImg" ></span><div class="ans" style="margin-bottom: 1px" id="ansEditor${postLoop.index}"></div></div>	    
    		<a class="read" onclick="instantiateEditor('${countQue}','${postLoop.index}')"> Read more </a><br>               
                                
			<c:if test="${fn:length(posts.mostUpvotedAnswer) == 0}">
				<script>
					setNoOne('${countQue}','${postLoop.index}');
				</script>
			</c:if>
	
			<c:if test="${fn:length(posts.mostUpvotedAnswer) gt 0}">
				<c:forEach var="answer" items="${posts.mostUpvotedAnswer}" begin="0" varStatus="mostUpvoted">
					<c:if test="${mostUpvoted.index == 0}">
						<script>
							var answer=${answer.answer};
							setAnswer('${countQue}','${postLoop.index}',answer,'${answer.userModel.uname}');
						</script>
					</c:if>
					
					<c:if test="${mostUpvoted.index gt 0}">
					
					</c:if>
				</c:forEach>
			</c:if>	
			<hr>
			<script>
				postTypes.push("question");
			</script>
		</c:if>				
	</c:forEach>
    <script>
    	if('${selectedsem}'!='${currentsem}')
    	{
    		document.getElementById("create_que").disabled = true;
    		document.getElementById("create_event").disabled = true;
    		document.getElementById("create_poll").disabled = true;
    		document.getElementById("create_disc").disabled = true;
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
			var innerText=document.getElementById("likeComment"+likeIndex).innerHTML;
			
			if(innerText=='Like')
			{	
				
			    request=getXmlHttpRequestObject();
			    request.onreadystatechange=commentLiked;
			    request.open("post","LikeComment",true);
			    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");    
			    var data="commentId="+commentId+"&likesCount="+parseInt(likesCount);
			    request.send(data);
			}
			else if(innerText=='Liked')
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
		        	document.getElementById("likeComment"+likeIndex).innerHTML="Liked";
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
		        	document.getElementById("likeComment"+likeIndex).innerHTML="Like";
		    	}
		    }
		}

		var setIndex,setPostId;
		function pinPost(postId,index)
		{
			if(confirm('Do You Want To Pin This Post?'))
			{
				setIndex=index;
				setPostId=postId;
				request=getXmlHttpRequestObject();
			    request.onreadystatechange=postPinned;
			    request.open("post","pinClassPost",true);
			    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");    
			    var data="postId="+parseInt(postId)+"&postType="+postTypes[index];
			    request.send(data);
			}
		}
		
		function unPinPost(postId,index)
		{
			if(confirm('Do You Want To Un-Pin This Post?'))
			{
				setIndex=index;
				setPostId=postId;
				request=getXmlHttpRequestObject();
			    request.onreadystatechange=postUnPinned;
			    request.open("post","unPinClassPost",true);
			    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");    
			    var data="postId="+parseInt(postId)+"&postType="+postTypes[index];
			    request.send(data);
			}
		}
		
		function postPinned()
		{
			if(request.readyState===4 && request.status===200)
		    {
				if(request.responseText==1)
				{
					console.log("pinned");
					document.getElementById('pin'+setIndex).innerHTML="UNPIN POST";
					document.getElementById('pin'+setIndex).setAttribute("onclick","unPinPost("+setPostId+","+setIndex+")");
				}
		    }
		}
		
		function postUnPinned()
		{
			if(request.readyState===4 && request.status===200)
		    {
				if(request.responseText==1)
				{
					console.log("unpinned");
					document.getElementById('pin'+setIndex).innerHTML="PIN POST";
					document.getElementById('pin'+setIndex).setAttribute("onclick","pinPost("+setPostId+","+setIndex+")");
				}
		    }
		}
		</script>
	
</body>
</html>