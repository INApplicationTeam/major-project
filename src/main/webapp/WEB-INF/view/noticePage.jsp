<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    			border: 1px solid #ccc;
		}

		.ql-snow .ql-editor img {
    			max-width: 35%;
    			max-height: 35%;
		}
        
        </style>
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
<body>

	<center><h1>CLASS NOTICES</h1></center>
	
	<center>
	<a href="#no">${currentNotice.creator.uname}</a> Issued <span id="currentNoticeTimeStamp"></span>
	<h2>${currentNotice.title}</h2>
	<div id="currentNoticeEditor" class="notice" style="width: 750px"></div>
	</center>
	<script>
		var currentNoticeTime=${currentNotice.timestamp};
		setTime('currentNoticeTimeStamp',currentNoticeTime);
		
		var noticeText=${currentNotice.noticeText};
		var id="#currentNoticeEditor";
		
		instantiateEditor(id,noticeText);
	</script>
	<hr>
	<c:forEach var="notice" items="${classNotices}" begin="0" varStatus="noticeLoop">
		
		<c:if test="${notice.noticeId != currentNotice.noticeId}">
			<center>
			<a href="#no">${notice.creator.uname}</a> Issued <span id="noticeTimeStamp${noticeLoop.index}"></span>
			<h2>${notice.title}</h2>
			<div id="noticeEditor${noticeLoop.index}" class="notice" style="width: 750px"></div>
			</center>
			
			<script>
				var noticeTime=${notice.timestamp};
				setTime('noticeTimeStamp${noticeLoop.index}',noticeTime);
				
				var noticeContent=${notice.noticeText};
				var id="#noticeEditor${noticeLoop.index}";
				
				instantiateEditor(id,noticeContent);
			</script>
			<hr>
		</c:if>
	</c:forEach>
	
</body>
</html>