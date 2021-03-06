<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


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
		
		b, strong {
    			font-weight: bolder;
		}

		.ans, .discEditor, .eveEditor{
		  		font-family: "Roboto";
		  		font-size: 16px;
		  		font-weight: 400;
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

<body class="blue-grey lighten-5">
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
					
					if(endLineCounter<4)
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
					
					if(endLineCounter<4)
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
				/* var opsarr={"ops":[{"insert":""}]};
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
				imgObj=undefined; */							
			}                                               
        
			var c=document.getElementsByClassName("notice");
                                 
        	if(content.length>100)
        	{
          		c[index].innerText=content.substr(0,100)+"...";
        	}
                               
        	else if(isStillLeft)
        	{
        		c[index].innerText=content;
        	}
        	
        	else
       	 	{
          		c[index].innerText=content;
          		//document.getElementsByClassName("readNotice")[index].innerHTML="";
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
                   <a href="../../poll/createpoll.jsp?var=classpoll"> <button type="button" class="btn btn-outline-primary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Create poll</button></a>
                   <a href="startClassDiscussion"><button type="button" class="btn btn-outline-default waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Start Discussion</button></a>
                   <a href="addEventForm"><button type="button" class="btn btn-outline-secondary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Add event</button></a>
                   <a href="../../Post_Question.jsp?classQue=true"><button type="button" class="btn btn-outline-success waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Ask Question</button></a>
<!--                   <form class="d-flex justify-content-center">
                        <input type="search" placeholder="Type your query" aria-label="Search" class="form-control">
                        <button class="btn btn-primary btn-sm my-0 p" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                 </form>
-->
                    <div>
                    <a href="showSavedPosts"><i class="fa fa-thumb-tack" aria-hidden="true"></i> My Saved Posts&nbsp;&nbsp;</a>
                    <a href="showPendingPosts"><i class="fa fa-circle" aria-hidden="true"></i> Pending Posts&nbsp;</a>
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
                 <!--Carousel Wrapper-->
                <div id="carousel-example-1z" class="carousel slide carousel-fade" data-ride="carousel">
                    <!--Indicators-->
                    <ol class="carousel-indicators">
                        <li data-target="#carousel-example-1z" data-slide-to="0" class="active" style="background-color: black;"></li>
                        <li data-target="#carousel-example-1z" data-slide-to="1" style="background-color: black;"></li>
                        <li data-target="#carousel-example-1z" data-slide-to="2" style="background-color: black;"></li>
                    </ol>
                    <!--/.Indicators-->
                    <!--Slides-->
                    <div class="carousel-inner" role="listbox">
                        <!--First slide-->
                        <c:if test="${fn:length(classNotices) gt 3}">
                        <div class="carousel-item active">
                        <div class="widget-wrapper wow fadeIn" data-wow-delay="0.4s">
                        <br>
                        <div class="card-deck">
                        <!-- Card -->
                        <c:forEach begin="0" end="2" varStatus="noticeFirstLoop">
	                        <div class="card card-image">
	                         <!-- Content -->
	                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
	                                <div>
	                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
	                                    <h3 class="card-title pt-2"><strong>${classNotices.get(noticeFirstLoop.index).title }</strong></h3>
	                                    <p class="notice" id="noticeEditor${noticeFirstLoop.index}">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
	                                    <a class="btn btn-primary" onclick="submitFirstNotice('submit${noticeFirstLoop.index}')"><i class="fa fa-clone left"></i> View Notice</a>
	                                    
	                                    <form:form action="showNotices" method="POST" modelAttribute="bindingNotice">
											<form:hidden path="noticeId" value="${classNotices.get(noticeFirstLoop.index).noticeId}"/>
											<input id="submit${noticeFirstLoop.index}" style="display: none" type="submit" class="readNotice" value="View More"><br>
										</form:form>
	                                </div>
	                            </div>
	                            <!-- Content -->
	                        </div>
	                        <script>
	                        function submitFirstNotice(id)
	                        {
	                        	document.getElementById(id).click();
	                        }
	                        var index=${noticeFirstLoop.index};
	            			var noticeText=${classNotices.get(noticeFirstLoop.index).noticeText};
	            			setNoticeContent(index,index,noticeText);
	                        </script>
                        </c:forEach>
                        <!-- Card -->
                       

                        </div>
                        </div>
                        </div>
                        </c:if>
                        <!--/First slide-->
                        <!--Second slide-->
                        <c:if test="${fn:length(classNotices) gt 6}">
                        <div class="carousel-item">
                        <div class="widget-wrapper wow fadeIn" data-wow-delay="0.4s">
                        <br>
                        <div class="card-deck">
                        <!-- Card -->
                        <c:forEach begin="3" end="5" varStatus="noticeSecondLoop">
                        <div class="card card-image">
                            <!-- Content -->
                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
                                <div>
                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
                                    <h3 class="card-title pt-2"><strong>${classNotices.get(noticeSecondLoop.index).title }</strong></h3>
                                    <p class="notice" id="noticeEditor${noticeSecondLoop.index}">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a class="btn btn-primary" onclick="submitSecondNotice('submit${noticeSecondLoop.index}')"><i class="fa fa-clone left"></i> View Notice</a>
                                    
                                    <form:form action="showNotices" method="POST" modelAttribute="bindingNotice">
											<form:hidden path="noticeId" value="${classNotices.get(noticeSecondLoop.index).noticeId}"/>
											<input id="submit${noticeSecondLoop.index}" style="display: none" type="submit" class="readNotice" value="View More"><br>
									</form:form>
                                </div>
                            </div>
                            <!-- Content -->
                        </div>
                        <script>
	                        function submitSecondNotice(id)
	                        {
	                        	document.getElementById(id).click();
	                        }
	                        var index=${noticeSecondLoop.index};
	            			var noticeText=${classNotices.get(noticeSecondLoop.index).noticeText};
	            			setNoticeContent(index,index,noticeText);
	                        </script>
                        </c:forEach>
                        <!-- Card -->
                       
                        </div>
                    </div>
                        </div>
                        </c:if>
                        <!--/Second slide-->
                        <!--Third slide-->
                        <c:if test="${fn:length(classNotices) gt 9}">
                        <div class="carousel-item">
                        <div class="widget-wrapper wow fadeIn" data-wow-delay="0.4s">
                        <br>
                        <div class="card-deck">
                        <!-- Card -->
                        <div class="card card-image">
                            <!-- Content -->
                            <c:forEach begin="6" end="8" varStatus="noticeThirdLoop">
                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
                                <div>
                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
                                    <h3 class="card-title pt-2"><strong>${classNotices.get(noticeThirdLoop.index).title }</strong></h3>
                                    <p class="notice" id="noticeEditor${noticeThirdLoop.index}">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a class="btn btn-primary" onclick="submitThirdNotice('submit${noticeThirdLoop.index}')"><i class="fa fa-clone left"></i> View Notice</a>
                               		
                               		<form:form action="showNotices" method="POST" modelAttribute="bindingNotice">
											<form:hidden path="noticeId" value="${classNotices.get(noticeThirdLoop.index).noticeId}"/>
											<input id="submit${noticeThirdLoop.index}" style="display: none" type="submit" class="readNotice" value="View More"><br>
									</form:form>
                                </div>
                            </div>
                            <script>
	                        function submitThirdNotice(id)
	                        {
	                        	document.getElementById(id).click();
	                        }
	                        var index=${noticeThirdLoop.index};
	            			var noticeText=${classNotices.get(noticeThirdLoop.index).noticeText};
	            			setNoticeContent(index,index,noticeText);
	                        </script>
                            </c:forEach>
                            <!-- Content -->
                        </div>
                        <!-- Card -->
                        </div>
                    </div>
                        </div>
                        </c:if>
                        <!--/Third slide-->
                    </div>
                    <!--/.Slides-->
                    <!--Controls-->
                    <a class="carousel-control-prev" href="#carousel-example-1z" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true" style="background-color: black"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carousel-example-1z" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true" style="background-color: black"></span>
                        <span class="sr-only">Next</span>
                    </a>
                    <!--/.Controls-->
                </div>
                <!--/.Carousel Wrapper-->
                    <!--CARD 1 start -->
                   <c:if test="${pinnedPostType == 'discussion'}">
                    
                    <div class="card mb-3 mt-3">
                        <div class="card-body pb-0">
                            <small>
                                <a href="../../UserProfile?uid=${pinnedPost.userModel.uid}">${pinnedPost.userModel.uname} </a> initiated discussion <span id="discussionTime-1"></span>
               	
                            </small>
                            <h4 style="font-size: 24px;" class="mt-2"><a>${pinnedPost.title}</a></h4>
                            <small class="">
                            	<strong>Description: </strong>
                            	
                            </small>
                            <div id="disEditor-1" class="discEditor"></div>
                            <script>
								var pinDisContent=${pinnedPost.content};
								setDiscussion('-1',pinDisContent);
							</script>
						
                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2">
                            
                            <a onclick="showComments('first-1','firsthide-1')" id='firsthide-1' class="float-right blue-text"><i class="fa fa-angle-double-down ml-4" aria-hidden="true"></i><small> Show Comments</small></a>
                            <a><i class="fa fa-angle-double-up float-right blue-text" aria-hidden="true" id="first-1" onclick="closeComments('first-1','firsthide-1')" style="display: none;"> Hide Comments</i></a>                            
                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2 first-1" style="display: none;font-size: 15px;">
                       
                        <c:forEach var="classComment" items="${pinnedPost.classCommentList}" begin="0" varStatus="commentLoop">
                            <div class="media d-block d-md-flex mt-2 ml-5">
                                <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (20).jpg" alt="Generic placeholder image">
                                <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                    <a class="mt-0 blue-text">${classComment.userModel.uname}</a>
                                    <a class="mt-0 blue-text pull-right" onclick="showReplyBox('replyBox-1${commentLoop.index}')"><i class="fa fa-reply" aria-hidden="true"></i></a>

                                   	${classComment.commentText}
									<br>
									
									<a href="#no" id="likeComment-1${commentLoop.index}" onclick="likeComment('-1${commentLoop.index}','${classComment.commentId}','${classComment.liked}')"><i class="fa fa-thumbs-o-up pl-4" aria-hidden="true" id="likeIcon-1${commentLoop.index}"></i> &nbsp;<span id="showLikes-1${commentLoop.index}"> ${classComment.likes}</span></a>
                                  
                                    <small id="commenttimestamp-1${commentLoop.index}" class="text-muted pull-right"></small>
									
								<c:forEach var="commentReply" items="${classComment.commentReplyList}" begin="0" varStatus="replyLoop">
                                    <div class="media d-block d-md-flex mt-3">
                                        <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (27).jpg" alt="Generic placeholder image">
                                        <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                            <a class="mt-0 blue-text">${commentReply.userModel.uname}</a>
                                            ${commentReply.replyText}
                                            <br>
                                            <small id="replytimestamp-1${commentLoop.index}${replyLoop.index}" class="text-muted pull-right">3 minutes ago</small>
                                        </div>
                                    </div>
                                    <script type="text/javascript">
										var replytimestamp=${commentReply.timestamp};
										document.getElementById('replytimestamp-1${commentLoop.index}${replyLoop.index}').innerHTML=time_ago(new Date(replytimestamp));
									</script>
								</c:forEach>
                                    
                                    <div class="media d-block d-md-flex mt-3">
                                        <div id="replyBox-1${commentLoop.index}" class="media-body text-center text-md-left ml-md-3 ml-0" style="display:none;">
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
									document.getElementById('likeIcon-1${commentLoop.index}').setAttribute("class","fa fa-thumbs-up pl-4");
								}
								
								var commenttimestamp=${classComment.timestamp};
								document.getElementById('commenttimestamp-1${commentLoop.index}').innerHTML=time_ago(new Date(commenttimestamp));
							</script>
                       	</c:forEach> 
                            
                            <div class="form-group ml-5 mb-4">
                                <label for="replyFormComment">Your comment</label>
                                <form:form action="postComment?disId=${pinnedPost.id}" modelAttribute="ClassCommentModel" method="POST">
                                	<form:textarea cssClass="form-control" path="commentText" id="replyFormComment" rows="3"/>
                                	<button type="submit" class="btn btn-primary btn-sm pull-right"><i class="fa fa-comment"></i> Post</button>
                                </form:form>
                                <script type="text/javascript">
									var discussionTime=${pinnedPost.timeStamp};
									setTime('discussionTime-1',discussionTime);
								</script>
                            </div>
                        </div>
                    </div>
                   </c:if>
                   
                   <c:if test="${pinnedPostType == 'event'}">
                     <div class="card my-3">
                        <div class="card-body pb-2">
                            <small>
                                <a href="../../UserProfile?uid=${pinnedPost.userModel.uid}">${pinnedPost.userModel.uname}</a> created event <span id="eventtimestamp-1"></span>
                           
                            </small>
                            <h4 style="font-size: 24px;" class="mt-2"><a>${pinnedPost.title}</a></h4>
                            <small>
                                <strong>Description: </strong>
                                
                            </small>
                            <div id="eventEditor-1" class="eveEditor"></div>
                            <div class="text-center" style='overflow:hidden; white-space:nowrap;'>
                                <strong class="pr-1 wow bounceInLeft" data-wow-delay="0.4s"><span id="startdate-1"></span></strong>
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <hr style='display:inline-block; width:60%;vertical-align: middle;' />
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <strong class="pr-1 wow bounceInRight" data-wow-delay="0.4s"><span id="lastdate-1"></span></strong>
                            </div>

                        </div>
                        

                    </div>
                    <script>
						
						var startDate=${pinnedPost.startdate};
						var endDate=${pinnedPost.enddate};
						var creationDate=${pinnedPost.timestamp};
						var eventContent=${pinnedPost.description};
					
						setTime('startdate-1',startDate);
						setTime('lastdate-1',endDate);
						setTime('eventtimestamp-1',creationDate);
						setEventContent('-1',eventContent);
						
					</script>
                   </c:if>
                   
                   <c:if test="${pinnedPostType == 'poll'}">
                   	<c:if test="${pinnedPost.isVoted}">

			<div class="card mb-3 mt-3">
				<div class="card-body pb-0">
					<small> <a href="../../UserProfile?uid=${pinnedPost.userModel.uid}">${pinnedPost.userModel.uname}</a> created this poll 
						
               	
				
							
					</small> <strong>
						<h4 style="font-size: 24px;" class="mt-2">
							<a>Q. ${pinnedPost.question}</a>
						</h4>
					</strong>
					<c:set var = "totalcount" scope = "page" value = "0"/>
					<c:forEach var="optiondetails" items="${pinnedPost.options}" begin="0" varStatus="innerloop">
						<c:set var = "totalcount" scope = "page" value = "${totalcount + optiondetails.pollResult.count}"/>
					</c:forEach>
					
					<c:forEach var="optiondetails" items="${pinnedPost.options}" begin="0" varStatus="innerloop">

						<form:form action="votepoll" method="post" modelattribute="poll">
						
								 <fmt:formatNumber var = "i" type = "number" value = "${optiondetails.pollResult.count/totalcount *100}" minFractionDigits="0" maxFractionDigits="0"/>
					
						
							<div class="row">
                                <div class="col-md-11 pr-0 pb-4">
                                    <div class="progress" style="height: 25px;border-bottom-right-radius: 0px;border-top-right-radius: 0;">
                                        <div class="progress-bar success" role="progressbar" style="width: 0%" data-percentage="${i}" aria-valuemin="0" aria-valuemax="100">
                                            <div style="position: absolute;float: left;margin-left: 20px;font-size: 20px;">
                                                <strong class="black-text">${ optiondetails.options}</strong>
                                            </div>                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-1 pl-0">
                                    <span class="badge cyan" style="font-size: 18px;display: block;"><strong>${i }%</strong></span>
                                </div>
                            </div>
                            
                            

						</form:form>
					</c:forEach>

				</div>
			</div>
		</c:if>
		
		<c:if test="${!pinnedPost.isVoted}">
			 <!--CARD 1 -->
			 
                    <div class="card mb-3 mt-3">
                        <div class="card-body pb-0">
                            <small>
                                <a href="../../UserProfile?uid=${pinnedPost.userModel.uid}">${pinnedPost.userModel.uname}</a> created this poll</a>
                              
                              
                            </small>
                            
                            <strong>
                            <h4 style="font-size: 24px;" class="mt-2"><a>${pinnedPost.question}</a></h4>                                
                            </strong>
                            <c:forEach var="optiondetails" items="${pinnedPost.options}" begin="0" varStatus="innerloop">
                            
                            <div class="row mb-2">
                                <div class="col-md-12 pr-3 pb-4 pt-1">
                                    <button type="button" class="btn btn-default btn-lg btn-block pb-2 pt-2 mb-2" onclick="setPollIdAndOptionId(${optiondetails.pollResult.opid},${pinnedPost.queid})"><i class="fa fa-mail-forward pull-left" aria-hidden="true"></i>${optiondetails.options}</button>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                    </div>
                     <!--CARD 1 -->
		
		</c:if>
                   	
                   </c:if>
                   
                  <c:set var="countQue" value="-1" scope="page" />

			<c:forEach var="posts" items="${allClassPosts}" begin="0" varStatus="postLoop">
                  <c:if test="${posts.getClass().name == 'model.springmodel.Question'}">
                   	
                   		<c:set var="countQue" value="${countQue + 1}" scope="page"/>
                    <div class="card mb-3 mt-3">
                        <div class="card-body pb-0">
                            <small>
                                <a href="../../UserProfile?uid=${posts.userModel.uid}">${posts.userModel.uname}</a> posted on <span id="questiontime${postLoop.index}"></span> in <a href="../../WorkSpaceContent?did=${posts.domain.did}&dname=${posts.domain.dname}">${posts.domain.dname}</a>
               					
               					<c:if test="${checkPinned[postLoop.index]==false}">
									<a class="blue-text" onclick="pinPost('${posts.qid}','${postLoop.index}');" id="pin${postLoop.index}"><i class="fa fa-thumb-tack float-right grey-text mr-2" id="iconPin${postLoop.index}" aria-hidden="true"></i></a>
								</c:if>
				
								<c:if test="${checkPinned[postLoop.index]==true}">
									<a class="blue-text" onclick="unPinPost('${posts.qid}','${postLoop.index}');" id="pin${postLoop.index}"><i class="fa fa-thumb-tack float-right blue-text mr-2" id="iconPin${postLoop.index}" aria-hidden="true"></i></a>
								</c:if>
               					
               					
                                <a class="blue-text" onclick="saveAsBookmark('${posts.qid}','${postLoop.index}');"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
                            </small>
                            <h4 style="font-size: 24px;" class="mt-2"><a href="../question/allAnswers?qid=${posts.qid}" style="color:black">${posts.que}</a></h4>
                            <div class="white" style="border-style: round;border-radius: 20px;display: inline-block;">
                                <img src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg" id="answererImg${postLoop.index}" class="avatar img-fluid z-depth-1 rounded-circle" alt="Responsive image" />
                                <a class="pl-1" href="" id="answerer${postLoop.index}">Rohit Jangid</a><small> answered</small>
                            </div>
                            <p class="pl-5">
                            	<div><span class="ansImg" ></span><div class="ans" style="margin-bottom: 1px" id="ansEditor${postLoop.index}"></div></div>
                                <a class="blue-text read" onclick="instantiateEditor('${countQue}','${postLoop.index}')"><i class="fa fa-angle-double-right pl-2"></i> More</a>
                            </p>
                            <c:if test="${fn:length(posts.mostUpvotedAnswer) == 0}">
								<script>
					
									setNoOne('${countQue}','${postLoop.index}');
									document.getElementById("answererImg${postLoop.index}").setAttribute("src",'../../ImageLoader?uid=');
								</script>
							</c:if>
					
							<c:if test="${fn:length(posts.mostUpvotedAnswer) gt 0}">
								<c:forEach var="answer" items="${posts.mostUpvotedAnswer}" begin="0" varStatus="mostUpvoted">
									<c:if test="${mostUpvoted.index == 0}">
										<script>
											var answer=${answer.answer};
											setAnswer('${countQue}','${postLoop.index}',answer,'${answer.userModel.uname}');
											document.getElementById("answererImg${postLoop.index}").setAttribute("src",'../../ImageLoader?uid=${answer.userModel.uid}');
											document.getElementById("answerer${postLoop.index}").setAttribute("href",'../../UserProfile?uid=${answer.userModel.uid}');
										</script>
									</c:if>
									
									<c:if test="${mostUpvoted.index gt 0}">
									
									</c:if>
								</c:forEach>
							</c:if>	
							<hr>
							<script>
								var queTime=${posts.timestamp};
								setTime('questiontime${postLoop.index}',queTime);
								postTypes.push("question");
							</script>
					
				        </div>
                
                    </div>
                    </c:if>
                    <!-- question end -->
                    <!-- Card 1 ends-->
                    <!--CARD 1 -->
                    <!-- poll card start -->
          <c:if test="${posts.getClass().name == 'model.springmodel.PollQueDetails'}">          
            <c:if test="${posts.isVoted}">

			<div class="card mb-3 mt-3">
				<div class="card-body pb-0">
					<small> <a href="../../UserProfile?uid=${posts.userModel.uid}">${posts.userModel.uname}</a> created this poll 
						<c:if test="${checkPinned[postLoop.index]==false}">
									<a class="blue-text" onclick="pinPost('${posts.queid}','${postLoop.index}');" id="pin${postLoop.index}"><i class="fa fa-thumb-tack float-right grey-text mr-2" id="iconPin${postLoop.index}" aria-hidden="true"></i></a>
								</c:if>
				
								<c:if test="${checkPinned[postLoop.index]==true}">
									<a class="blue-text" onclick="unPinPost('${posts.queid}','${postLoop.index}');" id="pin${postLoop.index}"><i class="fa fa-thumb-tack float-right blue-text mr-2" id="iconPin${postLoop.index}" aria-hidden="true"></i></a>
								</c:if>
               	
						   <a class="blue-text" onclick="saveAsBookmark('${posts.queid}','${postLoop.index}');"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
							
					</small> <strong>
						<h4 style="font-size: 24px;" class="mt-2">
							<a>Q. ${posts.question}</a>
						</h4>
					</strong>
					<c:set var = "totalcount" scope = "page" value = "0"/>
					<c:forEach var="optiondetails" items="${posts.options}" begin="0" varStatus="innerloop">
						<c:set var = "totalcount" scope = "page" value = "${totalcount + optiondetails.pollResult.count}"/>
					</c:forEach>
					
					<c:forEach var="optiondetails" items="${posts.options}" begin="0" varStatus="innerloop">

						<form:form action="votepoll" method="post" modelattribute="poll">
						
								 <fmt:formatNumber var = "i" type = "number" value = "${optiondetails.pollResult.count/totalcount *100}" minFractionDigits="0" maxFractionDigits="0"/>
					
						
							<div class="row">
                                <div class="col-md-11 pr-0 pb-4">
                                    <div class="progress" style="height: 25px;border-bottom-right-radius: 0px;border-top-right-radius: 0;">
                                        <div class="progress-bar success" role="progressbar" style="width: 0%" data-percentage="${i}" aria-valuemin="0" aria-valuemax="100">
                                            <div style="position: absolute;float: left;margin-left: 20px;font-size: 20px;">
                                                <strong class="black-text">${ optiondetails.options}</strong>
                                            </div>                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-1 pl-0">
                                    <span class="badge cyan" style="font-size: 18px;display: block;"><strong>${i }%</strong></span>
                                </div>
                            </div>
                            
                            

						</form:form>
					</c:forEach>

				</div>
			</div>
		</c:if>
		
		<c:if test="${!posts.isVoted}">
			 <!--CARD 1 -->
			 
                    <div class="card mb-3 mt-3">
                        <div class="card-body pb-0">
                            <small>
                                <a href="../../UserProfile?uid=${posts.userModel.uid}">${posts.userModel.uname}</a> created this poll</a>
                              <c:if test="${checkPinned[postLoop.index]==false}">
									<a class="blue-text" onclick="pinPost('${posts.queid}','${postLoop.index}');" id="pin${postLoop.index}"><i class="fa fa-thumb-tack float-right grey-text mr-2" id="iconPin${postLoop.index}" aria-hidden="true"></i></a>
								</c:if>
				
								<c:if test="${checkPinned[postLoop.index]==true}">
									<a class="blue-text" onclick="unPinPost('${posts.queid}','${postLoop.index}');" id="pin${postLoop.index}"><i class="fa fa-thumb-tack float-right blue-text mr-2" id="iconPin${postLoop.index}" aria-hidden="true"></i></a>
								</c:if>
               	
                                <a class="blue-text" onclick="saveAsBookmark('${posts.queid}','${postLoop.index}');"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
                            </small>
                            
                            <strong>
                            <h4 style="font-size: 24px;" class="mt-2"><a>${posts.question}</a></h4>                                
                            </strong>
                            <c:forEach var="optiondetails" items="${posts.options}" begin="0" varStatus="innerloop">
                            
                            <div class="row mb-2">
                                <div class="col-md-12 pr-3 pb-4 pt-1">
                                    <button type="button" class="btn btn-default btn-lg btn-block pb-2 pt-2 mb-2" onclick="setPollIdAndOptionId(${optiondetails.pollResult.opid},${posts.queid})"><i class="fa fa-mail-forward pull-left" aria-hidden="true"></i>${optiondetails.options}</button>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                    </div>
                     <!--CARD 1 -->
		
		</c:if>
			<script>
				postTypes.push("poll");
			</script>
			
		</c:if>
                    <!-- poll end -->
                     <!--CARD 1 -->
                    
                     <!--CARD 1 -->
						<!-- Discussion Start -->
				<c:if test="${posts.getClass().name == 'model.springmodel.ClassDiscussion'}">
                    <div class="card mb-3 mt-3">
                        <div class="card-body pb-0">
                            <small>
                                <a href="../../UserProfile?uid=${posts.userModel.uid}">${posts.userModel.uname} </a> initiated discussion <span id="discussionTime${postLoop.index}"></span>
                              <c:if test="${checkPinned[postLoop.index]==false}">
									<a class="blue-text" onclick="pinPost('${posts.id}','${postLoop.index}');" id="pin${postLoop.index}"><i class="fa fa-thumb-tack float-right grey-text mr-2" id="iconPin${postLoop.index}" aria-hidden="true"></i></a>
								</c:if>
				
								<c:if test="${checkPinned[postLoop.index]==true}">
									<a class="blue-text" onclick="unPinPost('${posts.id}','${postLoop.index}');" id="pin${postLoop.index}"><i class="fa fa-thumb-tack float-right blue-text mr-2" id="iconPin${postLoop.index}" aria-hidden="true"></i></a>
								</c:if>
               	
                                <a class="blue-text" onclick="saveAsBookmark('${posts.id}','${postLoop.index}');"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
                            </small>
                            <h4 style="font-size: 24px;" class="mt-2"><a>${posts.title}</a></h4>
                            <small class="">
                            	<strong>Description: </strong>
                            	
                            </small>
                            <div id="disEditor${postLoop.index}" class="discEditor"></div>
                            <script>
								postTypes.push("discussion");
								var disContent=${posts.content};
								setDiscussion('${postLoop.index}',disContent);
							</script>
						
                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2">
                            
                            <a onclick="showComments('first${postLoop.index}','firsthide${postLoop.index}')" id='firsthide${postLoop.index}' class="float-right blue-text"><i class="fa fa-angle-double-down ml-4" aria-hidden="true"></i><small> Show Comments</small></a>
                            <a><i class="fa fa-angle-double-up float-right blue-text" aria-hidden="true" id="first${postLoop.index}" onclick="closeComments('first${postLoop.index}','firsthide${postLoop.index}')" style="display: none;"> Hide Comments</i></a>                            
                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2 first${postLoop.index}" style="display: none;font-size: 15px;">
                       
                        <c:forEach var="classComment" items="${posts.classCommentList}" begin="0" varStatus="commentLoop">
                            <div class="media d-block d-md-flex mt-2 ml-5">
                                <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="../../ImageLoader?uid=${classComment.userModel.uid}" alt="Generic placeholder image">
                                <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                    <a class="mt-0 blue-text" href="../../UserProfile?uid=${classComment.userModel.uid}">${classComment.userModel.uname}</a>
                                    <a class="mt-0 blue-text pull-right" onclick="showReplyBox('replyBox${postLoop.index}${commentLoop.index}')"><i class="fa fa-reply" aria-hidden="true"></i></a>

                                   	${classComment.commentText}
									<br>
									
									<a href="#no" id="likeComment${postLoop.index}${commentLoop.index}" onclick="likeComment('${postLoop.index}${commentLoop.index}','${classComment.commentId}','${classComment.liked}')"><i class="fa fa-thumbs-o-up pl-4" aria-hidden="true" id="likeIcon${postLoop.index}${commentLoop.index}"></i> &nbsp;<span id="showLikes${postLoop.index}${commentLoop.index}"> ${classComment.likes}</span></a>
                                  
                                    <small id="commenttimestamp${postLoop.index}${commentLoop.index}" class="text-muted pull-right"></small>
									
								<c:forEach var="commentReply" items="${classComment.commentReplyList}" begin="0" varStatus="replyLoop">
                                    <div class="media d-block d-md-flex mt-3">
                                        <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="../../ImageLoader?uid=${commentReply.userModel.uid}" alt="Generic placeholder image">
                                        <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                            <a class="mt-0 blue-text" href="../../UserProfile?uid=${commentReply.userModel.uid}">${commentReply.userModel.uname}</a>
                                            ${commentReply.replyText}
                                            <br>
                                            <small id="replytimestamp${postLoop.index}${commentLoop.index}${replyLoop.index}" class="text-muted pull-right">3 minutes ago</small>
                                        </div>
                                    </div>
                                    <script type="text/javascript">
										var replytimestamp=${commentReply.timestamp};
										document.getElementById('replytimestamp${postLoop.index}${commentLoop.index}${replyLoop.index}').innerHTML=time_ago(new Date(replytimestamp));
									</script>
								</c:forEach>
                                    
                                    <div class="media d-block d-md-flex mt-3">
                                        <div id="replyBox${postLoop.index}${commentLoop.index}" class="media-body text-center text-md-left ml-md-3 ml-0" style="display:none;">
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
									document.getElementById('likeIcon${postLoop.index}${commentLoop.index}').setAttribute("class","fa fa-thumbs-up pl-4");
								}
								
								var commenttimestamp=${classComment.timestamp};
								document.getElementById('commenttimestamp${postLoop.index}${commentLoop.index}').innerHTML=time_ago(new Date(commenttimestamp));
							</script>
                       	</c:forEach> 
                            
                            <div class="form-group ml-5 mb-4">
                                <label for="replyFormComment">Your comment</label>
                                <form:form action="postComment?disId=${posts.id}" modelAttribute="ClassCommentModel" method="POST">
                                	<form:textarea cssClass="form-control" path="commentText" id="replyFormComment" rows="3"/>
                                	<button type="submit" class="btn btn-primary btn-sm pull-right"><i class="fa fa-comment"></i> Post</button>
                                </form:form>
                                <script type="text/javascript">
									var discussionTime=${posts.timeStamp};
									setTime('discussionTime${postLoop.index}',discussionTime);
								</script>
                            </div>
                        </div>
                    </div>
                    </c:if>
                    <!-- disc end -->
                    <!-- Card 1 ends-->
                    
					<!-- event start -->
					<c:if test="${posts.getClass().name == 'model.springmodel.Events'}">
                    <div class="card my-3">
                        <div class="card-body pb-2">
                            <small>
                                <a href="../../UserProfile?uid=${posts.userModel.uid}">${posts.userModel.uname}</a> created event <span id="eventtimestamp${postLoop.index}"></span>
                                <c:if test="${checkPinned[postLoop.index]==false}">
									<a class="blue-text" onclick="pinPost('${posts.eid}','${postLoop.index}');" id="pin${postLoop.index}"><i class="fa fa-thumb-tack float-right grey-text mr-2" id="iconPin${postLoop.index}" aria-hidden="true"></i></a>
								</c:if>
				
								<c:if test="${checkPinned[postLoop.index]==true}">
									<a class="blue-text" onclick="unPinPost('${posts.eid}','${postLoop.index}');" id="pin${postLoop.index}"><i class="fa fa-thumb-tack float-right float-right blue-text mr-2" id="iconPin${postLoop.index}" aria-hidden="true"></i></a>
								</c:if>
               	
                            
                                <a class="blue-text" onclick="saveAsBookmark('${posts.eid}','${postLoop.index}');"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
                            </small>
                            <h4 style="font-size: 24px;" class="mt-2"><a>${posts.title}</a></h4>
                            <small>
                                <strong>Description: </strong>
                                
                            </small>
                            <div id="eventEditor${postLoop.index}" class="eveEditor"></div>
                            <div class="text-center" style='overflow:hidden; white-space:nowrap;'>
                                <strong class="pr-1 wow bounceInLeft" data-wow-delay="0.4s"><span id="startdate${postLoop.index}"></span></strong>
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <hr style='display:inline-block; width:60%;vertical-align: middle;' />
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <strong class="pr-1 wow bounceInRight" data-wow-delay="0.4s"><span id="lastdate${postLoop.index}"></span></strong>
                            </div>

                        </div>
                        

                    </div>
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
                    </c:forEach>
                    <!-- card end -->
                </div>
                <div class="col-md-3 mx-0 my-0 px-0 py-0">

				<div class="list-group mt-4 ml-2">
				    <a href="issueNotice" class="list-group-item list-group-item-action waves-effect waves-effect">
				        <i class="fa fa-plus pr-1 blue-text" aria-hidden="true"></i> Issue notice
				    </a>
				    <a href="../admin/addCRForm" class="list-group-item list-group-item-action waves-effect"><i class="fa fa-plus pr-1 blue-text" aria-hidden="true"></i>Add/Change class representative</a>
				    <a href="../admin/addformFaculty" class="list-group-item list-group-item-action waves-effect"><i class="fa fa-plus pr-1 blue-text" aria-hidden="true"></i>Add/Change subject faculty</a>
				    <a href="showMyDiscussions" class="list-group-item list-group-item-action waves-effect"><i class="fa fa-asterisk pr-1 blue-text" aria-hidden="true"></i>My all posts</a>
				</div>
                
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
    <div  class="abc" style="display: none">
	<form action="../../QueVotedController" id="pollSubmit" method="post" >

		<input type="text" id="opt1" name="opt">
		<input type="text"name="scope" value="class"> 
		<input type=SUBMIT value="SUBMIT" id="submitpoll">
	</form>
	</div>
    
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
    <script type="text/javascript">
    function setPollIdAndOptionId(opid, queid)
    {
    	document.getElementById("opt1").value=opid+","+queid;
    	console.log(document.getElementById("opt1").value);
    	//document.forms['pollSubmit'].submit();
    	//document.getElementById("pollSubmit").submit();
    	$('#submitpoll').click();
    }

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
<!-- show date events with a modal window -->
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
			document.getElementById('iconPin'+setIndex).setAttribute("class","fa fa-thumb-tack float-right blue-text mr-2");
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
			document.getElementById('iconPin'+setIndex).setAttribute("class","fa fa-thumb-tack float-right grey-text mr-2");
			document.getElementById('pin'+setIndex).setAttribute("onclick","pinPost("+setPostId+","+setIndex+")");
		}
    }
}

function saveAsBookmark(postId,index)
{
	request=getXmlHttpRequestObject();
    request.onreadystatechange=bookmarkSaved;
    request.open("post","saveAsBookmark",true);
    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");    
    var data="postId="+parseInt(postId)+"&postType="+postTypes[index];
    request.send(data);
}

function bookmarkSaved()
{
	if(request.readyState===4 && request.status===200)
    {
		if(request.responseText!=-1)
		{
			console.log("saved");
			alert('Saved Successfully...');
		}
		else
		{
			console.log("already saved");
			alert('Post Is Already Saved...');
		}
    }
}

</script>
</body>

</html>