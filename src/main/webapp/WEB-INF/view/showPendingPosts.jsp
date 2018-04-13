<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
        
        var configForShow = {
                   "theme": "snow",
                   "modules": {
                   "toolbar": false
       			} 
        };
        
        var quillShowDis;
               
        function setDiscussion(index,discussionContent)
        {
        	quillShowDis=new Quill('#disEditor'+index,configForShow);
        	quillShowDis.setContents(discussionContent);
        	quillShowDis.enable(false);
        }
        </script>
    

	<center>REVIEW POSTS</center>
	<c:forEach var="posts" items="${pendingPosts}" begin="0" varStatus="postLoop">
		
		<c:if test="${posts.getClass().name == 'model.springmodel.ClassDiscussion'}">
			<i><a href="">${posts.userModel.uname}</a></i> Posted <b>DISCUSSION</b><br>
			<h4>Title : <i>${posts.title}</i></h4> 
			<div id="disEditor${postLoop.index}"></div>
			<script>
				var disContent=${posts.content};
				setDiscussion('${postLoop.index}',disContent);
			</script>
			
			<form:form action="acceptOrRejectPost" modelAttribute="acceptOrReject" method="POST">
				<form:hidden path="postid" value="${posts.id}"/>
				<form:hidden path="post_type" value="discussion"/>
				<form:hidden path="reviewed" id="isReviewed${postLoop.index}"/>
				<form:hidden path="title" value="${posts.title}"/>
				<input type="submit" value="Approve" onclick="acceptPost('${postLoop.index}')"><input type="submit" value="Reject" onclick="rejectPost('${postLoop.index}')">
			</form:form>
		</c:if>
		
		<c:if test="${posts.getClass().name == 'model.springmodel.Events'}">	
			<i><a href="">${posts.userModel.uname}</a></i> Posted <b>EVENT</b><br>
			<h4>Title : <i>${posts.title}</i></h4> 
			<p><b>Description:</b>  ${posts.description} </p>
			<b>Start Date:</b> <span id="startdate${postLoop.index}"></span><br><br>
			<b>Last Date:</b> <span id="lastdate${postLoop.index}"></span><br><br>
			
			<script>
			var startDate=${posts.startdate};
			var endDate=${posts.enddate};
			
			document.getElementById("startdate${postLoop.index}").innerHTML=time_ago(new Date(startDate));
			document.getElementById("lastdate${postLoop.index}").innerHTML=time_ago(new Date(endDate));
			</script>
			
			<form:form action="acceptOrRejectPost" modelAttribute="acceptOrReject" method="POST">
				<form:hidden path="postid" value="${posts.eid}"/>
				<form:hidden path="post_type" value="event"/>
				<form:hidden path="reviewed" id="isReviewed${postLoop.index}"/>
				<form:hidden path="title" value="${posts.title}"/>
				<input type="submit" value="Approve" onclick="acceptPost('${postLoop.index}')"><input type="submit" value="Reject" onclick="rejectPost('${postLoop.index}')">
			</form:form>
		</c:if>
	
		<hr>
	</c:forEach>
<hr>
	<script>
		function acceptPost(index)
		{
			document.getElementById("isReviewed"+index).value=true;
		}
		
		function rejectPost(index)
		{
			document.getElementById("isReviewed"+index).value=false;
		}
	</script>
</body>
</html>