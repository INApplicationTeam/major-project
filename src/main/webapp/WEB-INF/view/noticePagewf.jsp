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
<body>

	<center><h1>CLASS NOTICES</h1></center>

	<c:forEach var="notice" items="${classNotices}" begin="0" varStatus="noticeLoop">
		
			<center>
			<span id="noticeId${noticeLoop.index}" style="display:none">${notice.noticeId}</span>
			<a href="#no">${notice.creator.uname}</a> Issued <span id="noticeTimeStamp${noticeLoop.index}"></span>
			<h2>${notice.title}</h2>
			<div id="noticeEditor${noticeLoop.index}" class="notice" style="width: 750px"></div>
			VIEWS <span>${notice.viewers}</span><br>
			<a href="#no" onclick="showViewers(${notice.noticeId})">SHOW VIEWERS</a> 
			</center>
			
			<script>
			
				var viewed=${notice.viewed};
				isviewed.push(viewed);
				
				var noticeTime=${notice.timestamp};
				setTime('noticeTimeStamp${noticeLoop.index}',noticeTime);
				
				var noticeContent=${notice.noticeText};
				var id="#noticeEditor${noticeLoop.index}";
				
				instantiateEditor(id,noticeContent);
			</script>
			<hr>
	
	</c:forEach>
	
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