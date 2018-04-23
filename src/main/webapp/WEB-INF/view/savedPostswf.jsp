<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Class Discussion Forum</title>
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
          

        </script>

<h1>SAVED POSTS</h1>
<hr>

<c:set var="countQue" value="-1" scope="page" />
	
	<c:forEach var="posts" items="${savedPosts}" begin="0" varStatus="postLoop">
	
		<c:if test="${posts.getClass().name == 'model.springmodel.ClassDiscussion'}">
			
			<a href="#no" style="float: right" onclick="unSave('${posts.id}','${postLoop.index}');">Un-Save</a><br>
			
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
			
			<a href="#no" style="float: right" onclick="unSave('${posts.eid}','${postLoop.index}');">Un-Save</a><br>
			
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
			
			<a href="#no" style="float: right" onclick="unSave('${posts.queid}','${postLoop.index}');">Un-Save</a><br>
			
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
			
			<a href="#no" style="float: right" onclick="unSave('${posts.qid}','${postLoop.index}');">Un-Save</a><br>
			
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


	function unSave(postId,index)
	{
		request=getXmlHttpRequestObject();
	    request.onreadystatechange=unSaved;
	    request.open("post","unSavePost",true);
	    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");    
	    var data="postId="+parseInt(postId)+"&postType="+postTypes[index];
	    request.send(data);
	}
	
	function unSaved()
	{
		if(request.readyState===4 && request.status===200)
	    {
			if(request.responseText!=-1)
			{
				console.log("unsaved");
				alert('Un-Saved Successfully...');
			}
	    }
	}
	
	</script>
    		

</body>
</html>