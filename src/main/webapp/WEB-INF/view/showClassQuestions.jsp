<!DOCTYPE html>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

			.ans{
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
	<div id="toolbarque" style="display: none"></div>
    <div id="editorque" style="display: none"></div>
         
	<script>
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
         var quillShowAns;
         
         function instantiateEditor(i)
         {
            ans=quillAnswers[i];
            quillShowAns=new Quill('#ansEditor'+i,configForShow);
            quillShowAns.setContents(ans);
            quillShowAns.enable(false);  
            document.getElementsByClassName("ansImg")[i].innerHTML="";
            document.getElementsByClassName("read")[i].innerHTML="";
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

	</script>

    <!--Main Navigation-->
    <header>

        <!-- Navbar -->
        <nav class="navbar fixed-top navbar-expand-lg navbar-light white scrolling-navbar" style="margin-left: 30px;box-shadow: none;">
            <div class="container-fluid">

                <!-- Brand -->
                <a class="navbar-brand waves-effect" href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">
                    <strong class="blue-text">Korero</strong>
                </a>

                <!-- Collapse -->
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Links -->
                <div class="collapse navbar-collapse" id="navbarSupportedContent">

                    <!-- Left -->
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link waves-effect" href="#">Home
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link waves-effect" href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">About this class</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link waves-effect" href="https://mdbootstrap.com/getting-started/" target="_blank">Blogs</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link waves-effect" href="https://mdbootstrap.com/bootstrap-tutorial/" target="_blank">Notice</a>
                        </li>
                    </ul>
                    <!-- Right -->
                    <ul class="navbar-nav nav-flex-icons">
                        <li class="nav-item mr-4">
                            <form class="form-inline ml-auto">
                                <div class="md-form mt-0">
                                    <i class="fa fa-search" aria-hidden="true"></i>
                                    <input class="form-control" type="text" placeholder="Search" aria-label="Search">
                                </div>
                            </form>
                        </li>
                        <li class="nav-item mr-2">
                            <!-- Basic dropdown -->
                            <div class="btn-group">
                                <a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-bell"></i>
                                </a>

                                <div class="dropdown-menu dropdown-pull-right">
                                    <a class="dropdown-item" href="#">Action</a>
                                    <a class="dropdown-item" href="#">Another action Another action Another action Another action</a>
                                    <a class="dropdown-item" href="#">Something else here</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#">Separated link</a>
                                </div>
                            </div>
                            </a>
                        </li>
                    </ul>

                </div>

            </div>
        </nav>
        <!-- Navbar -->

                <!-- Sidebar -->
        <div class="leftside pt-2" onmouseover="javascript:document.getElementById('blur').style.filter='blur(3px)';" onmouseout="javascript:document.getElementById('blur').style.filter='blur(0)';">
            <div class="text-center" style="padding: 10px;">
                <img src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg" class="img-fluid z-depth-1 rounded-circle" style="max-height: 150px;"  alt="Responsive image">
            </div>
            <div class="item">
                <span class="fa fa-bel"></span>
                Shreeya Nagar
            </div>
            <div class="item">
                <span class="fa fa-user"></span>
                 Profile
            </div>
            <div class="item">
                <span class="fa fa-pie-chart"></span>
                Dashboard
            </div>
            <div class="item active">
                <span class="fa fa-institution"></span>
                Book Advice
            </div>
            <div class="item">
                <span class="fa fa-bar-chart-o"></span>
                Polling
            </div>
            <div class="item">
                <span class="fa fa-graduation-cap"></span>
                Class Discussion
            </div> 
            <div class="item">
                <span class="fa fa-sign-out"></span>
                LogOut
            </div> 
        </div>

                <!-- Sidebar -->

    </header>
    <!--Main Navigation-->

    <!--Main layout-->
    <main class="pt-4 mx-lg-5" id="blur">
        <div class="container-fluid mt-5 pt-3 ml-3 pr-0">

            <!-- Heading -->
            <div class="card">

                <!--Card content-->
                <div class="card-body d-sm-flex justify-content-between py-3">

                    <h4 class="mb-2 mb-sm-0">
                        <a href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">CS-B/</a>
                        <span>
                        <!-- Split button -->
                        <div class="btn-group">
                            <a class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                8th sem
                                <span class="sr-only">Toggle Dropdown</span>
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="#">Action</a>
                                <a class="dropdown-item" href="#">Another action</a>
                                <a class="dropdown-item" href="#">Something else here</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">Separated link</a>
                            </div>
                        </div>
                        </span>
                    </h4>
                    <button type="button" class="btn btn-outline-primary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Create poll</button>
                    <button type="button" class="btn btn-outline-default waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Start Discussion</button>
                    <button type="button" class="btn btn-outline-secondary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Add event</button>
                    <button type="button" class="btn btn-outline-success waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Ask Question</button>

                    <div>
                    <a href=""><i class="fa fa-thumb-tack" aria-hidden="true"></i> My Saved Posts&nbsp;&nbsp;</a>
                    <a href=""><i class="fa fa-circle" aria-hidden="true"></i> My Posts&nbsp;</a>
                        <div class="btn-group">
                            <a class="dropdown-toggle blue-text" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-filter" aria-hidden="true"></i>
                                <span class="sr-only">Toggle Dropdown</span>
                            </a>
                            <div class="dropdown-menu dropdown-pull-right mr-3">
                                <a class="dropdown-item" href="#">Action</a>
                                <a class="dropdown-item" href="#">Another action</a>
                                <a class="dropdown-item" href="#">Something else</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">Separated link</a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <!-- Heading -->

            <!--Grid row-->
            <div class="row wow fadeIn">

                
                <div class="col-md-9">
                    <!--CARD 1 -->
                    <c:forEach var="question" items="${questionList}" begin="0" varStatus="queLoop">
	                    <div class="card mb-3 mt-3">
	                        <div class="card-body pb-0">
	                            <small>
	                                <a href="">${question.userModel.uname}</a> posted  <span id="queTimestamp${queLoop.index}"></span> in <a href="">${question.domain.dname}</a>
	                                
	                                <a class="blue-text"><i class="fa fa-thumb-tack float-right blue-text mr-2" aria-hidden="true"></i></a>
	                                <a class="blue-text"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
	                            </small>
	                            <h4 style="font-size: 24px;" class="mt-2"><a href="../question/allAnswers?qid=${question.qid}" style="color: black;">${question.que} </a></h4>
	                            <div class="white" style="border-style: round;border-radius: 20px;display: inline-block;">
	                                <img src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg" class="avatar img-fluid z-depth-1 rounded-circle" alt="Responsive image" />
	                                <a class="pl-1" href="" id="answerer${queLoop.index}">Rohit Jangid</a><small> answered</small>
	                            </div>
	                            <p class="pl-5">
	                            	<div><span class="ansImg" ></span><div class="ans" style="margin-bottom: 1px" id="ansEditor${queLoop.index}"></div></div>
	                                <a class="blue-text read" href="#no" onclick="instantiateEditor('${queLoop.index}')"><i class="fa fa-angle-double-right pl-2"></i> More</a>
	                            </p>
	                            
	                            <c:if test="${fn:length(question.mostUpvotedAnswer) == 0}">
									<script>
										var index=${queLoop.index};
										document.getElementById("answerer${queLoop.index}").innerHTML="No one";
										quillAnswers.push({"ops":[{"insert":""}]});
										document.getElementsByClassName("read")[index].innerHTML="";
									</script>
								</c:if>
								
								<c:if test="${fn:length(question.mostUpvotedAnswer) gt 0}">
									<c:forEach var="answer" items="${question.mostUpvotedAnswer}" begin="0" varStatus="UpVotedAnswer">
										<c:if test="${UpVotedAnswer.index == 0}">
											<script>
												var index=${queLoop.index};
												document.getElementById("answerer${queLoop.index}").innerHTML='${answer.userModel.uname}';
												var answerText=${answer.answer};
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
									          		instantiateEditor(index);
									        	}
											</script>
										</c:if>
									</c:forEach>
								</c:if>
							</div>
	                    </div>
	                    <script>
	                    var queTimeStamp=${question.timestamp};
	                    document.getElementById('queTimestamp${queLoop.index}').innerHTML=time_ago(queTimeStamp);
	                    </script>
                    </c:forEach>
                    <!--CARD 1 -->
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
      
        // Tooltips Initialization
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
    </script>
    
</body>

</html>