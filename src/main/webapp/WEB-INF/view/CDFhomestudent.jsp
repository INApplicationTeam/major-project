<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Discussion Forum</title>
		
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
  		  return new Date(time).toDateString();
  		}
        
        var quillAnswers=[];
        
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
        var quillShowAns,quillShowDis;
        
        function instantiateEditor(index,postIndex)
        {
        	console.log(index);
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
        
        function setDiscussion(index,discussionContent)
        {
        	quillShowDis=new Quill('#disEditor'+index,configForShow);
        	quillShowDis.setContents(discussionContent);
        	quillShowDis.enable(false);
        }
        </script>
    

<h1>CLASS DISCUSSION FORUM</h1>
<select name="Session" onchange="location = this.value;">
    	<option selected disabled>Semester</option>
    	<c:forEach varStatus="sem" begin="1" end="${currentsem}">
    	
	 	<option value="showSession?sem=${sem.index}">${sem.index}</option> 
	  	
	 	 </c:forEach>
	</select>
	
<a href="../../MyFeed">MY FEED</a>
<hr>
<h3>CHOOSE YOUR POST TYPE...</h3>
<a href="../../poll/createpoll.jsp?var=classpoll"><button id="create_poll">Create Poll</button></a>
<a href="../../Post_Question.jsp?classQue=true"><button id="create_que">Ask question</button></a>
<a href="addEventForm"><button id="create_event">Create Event</button></a>
<a href="showDiscussions"><button id="create_disc">Start Discussion</button></a>

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
	<center><h1>CLASS POSTS</h1></center>
	<c:set var="countQue" value="-1" scope="page" />
	
	<c:forEach var="posts" items="${allClassPosts}" begin="0" varStatus="postLoop">
		<c:if test="${posts.getClass().name == 'model.springmodel.ClassDiscussion'}">
			
			<i><a href="">${posts.userModel.uname}</a></i> Posted <b>DISCUSSION</b><br>
			<h4>Title : <i>${posts.title}</i></h4> 
			<div id="disEditor${postLoop.index}"></div>
			<script>setDiscussion('${postLoop.index}',${posts.content});</script>
			<hr>
		</c:if>
		
		<c:if test="${posts.getClass().name == 'model.springmodel.Events'}">
			
			<i><a href="">${posts.userModel.uname}</a></i> Posted <b>EVENT</b><br>
			<h4>Title : <i>${posts.title}</i></h4> 
			<p><b>Description:</b>  ${posts.description} </p>
			<b>Start Date:</b> <span id="startdate${postLoop.index}"></span><br><br>
			<b>Last Date:</b> <span id="lastdate${postLoop.index}"></span><br><br>
			<hr>
			
			<script>
			var startDate=${posts.startdate};
			var endDate=${posts.enddate};
			
			document.getElementById("startdate${postLoop.index}").innerHTML=time_ago(new Date(startDate));
			document.getElementById("lastdate${postLoop.index}").innerHTML=time_ago(new Date(endDate));
			</script>
		</c:if>
		
		<c:if test="${posts.getClass().name == 'model.springmodel.PollQueDetails'}">
			
			<i><a href="">${posts.userModel.uname}</a></i> Posted <b>POLL</b><br>
			<h4>${posts.question}</h4>
			<c:forEach var="option" items="${posts.options}">
				<i>${option.options}</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${option.pollResult.count}<br>
			</c:forEach>
			<hr>
		</c:if>
		
		<c:if test="${posts.getClass().name == 'model.springmodel.Question'}">
			<c:set var="countQue" value="${countQue + 1}" scope="page"/>
			
			<i><a href="">${posts.userModel.uname}</a></i> Posted <b>QUESTION</b><br>
			<h4>${posts.que}</h4>
			
			<a href="" id="answerer${postLoop.index}" style="color: #0099cc;"></a> answered<br>
			<div style="width:1000px;"><span class="ansImg" ></span><div class="ans" style="margin-bottom: 1px" id="ansEditor${postLoop.index}"></div></div>	    
    		<a class="read" onclick="instantiateEditor('${countQue}','${postLoop.index}')"> Read more </a><br>               
                                
			<c:if test="${fn:length(posts.mostUpvotedAnswer) == 0}">
				<script>
					setNoOne(quillAnswers.length,'${postLoop.index}');
				</script>
			</c:if>
	
			<c:if test="${fn:length(posts.mostUpvotedAnswer) gt 0}">
				<c:forEach var="answer" items="${posts.mostUpvotedAnswer}">
					<script>
						setAnswer(quillAnswers.length,'${postLoop.index}',${answer.answer},'${answer.userModel.uname}');
					</script>
				</c:forEach>
			</c:if>	
			
			<hr>
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
    </script>

</body>
</html>