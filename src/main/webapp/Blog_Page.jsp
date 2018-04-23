<%@page import="model.*"%>
<%@page import="java.util.ArrayList"%>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">

<%
	BlogModel bm = (BlogModel) session.getAttribute("blogmodel");
	ArrayList<BlogCommentModel> arbcm = bm.getArbcm();
	ArrayList<BlogModel> albm = (ArrayList<BlogModel>) session.getAttribute("recentblogsmodel");
	String status=(String)session.getAttribute("status");
	System.out.println(status);
%>

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Korero</title>
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- Bootstrap core CSS -->
<link href="kext/css/bootstrap.min.css" rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="kext/css/mdb.min.css" rel="stylesheet">
<!-- Your custom styles (optional) -->
<link href="kext/css/blog.css" rel="stylesheet">

<script src="https://cdn.quilljs.com/1.2.3/quill.js"></script>
<script src="https://cdn.quilljs.com/1.2.3/quill.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link href="https://cdn.quilljs.com/1.1.3/quill.snow.css"
	rel="stylesheet">
<link href="https://cdn.quilljs.com/1.1.3/quill.bubble.css"
	rel="stylesheet">

<style rel="stylesheet">
/* TEMPLATE STYLES */
#editor {
	font-family: "roboto";
	font-size: 1rem;
	font-weight: 400;
	word-break: break-word;
}

b, strong {
	font-weight: bold;
}

pre {
	font-size: 90%;
}

.ql-snow .ql-editor img {
	max-width: 50%;
	max-height: 50%;
}

.ql-container.ql-snow {
	border: 0px solid #ccc;
}

.ql-editor {
	line-height: 24px;
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

</script>

</head>

<body class="grey lighten-3">

	<!--Main Navigation-->
	<header>

		<!-- Navbar -->
		<nav
			class="navbar fixed-top navbar-expand-lg navbar-light white scrolling-navbar">
			<div class="container">

				<!-- Brand -->
				<a class="navbar-brand waves-effect" href="MyFeed"> <strong
					class="blue-text">Korero</strong>
				</a>

				<!-- Collapse -->
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<!-- Links -->
				<div class="collapse navbar-collapse" id="navbarSupportedContent">

					<!-- Left -->
					<ul class="navbar-nav mr-auto">
						<li class="nav-item"><a class="nav-link waves-effect"
							href="MyFeed">Home </a></li>
						<li class="nav-item"><a class="nav-link waves-effect"
							href="MyProfile">Profile</a></li>
						<li class="nav-item"><a class="nav-link waves-effect active"
							href="LoadBlogFeed" target="_blank">Blogs</a></li>
						<li class="nav-item"><a class="nav-link waves-effect"
							href="Post_Question.jsp">Ask a Question</a></li>
					</ul>

					<!-- Right -->
					<form class="form-inline">
						<div class="md-form mt-0">
							<input class="form-control mr-sm-2" type="text"
								placeholder="Search" aria-label="Search">
						</div>
					</form>


				</div>

			</div>
		</nav>
		<!-- Navbar -->

	</header>
	<!--Main Navigation-->

	<!--Main layout-->
	<main class="mt-5 pt-5">
	<div class="container">

		<!--Section: Post-->
		<section class="mt-4">

			<!--Grid row-->
			<div class="row">

				<!--Grid column-->
				<div class="col-md-8 mb-4">
					<!--Card-->
					<div class="card mb-4 wow fadeIn">

						<!--Card content-->
						<div class="card-body">


							<h2 style="display: inline-block;">
								<%
									if (bm.getTitle() != null) {
								%>
								<%=bm.getTitle()%>
								<%
									}
								%>
							</h2>
							<small class="text-muted" style="display: inline-block;"
								id="blog"> </small>
							<script type="text/javascript">
        		    setTime("blog",<%=bm.getTimestamp()%>)
        		    </script>
							<br>
							<div class="text-muted" style="display: inline-block;">
								by <a class="blue-text"
									href="UserProfile?uid=<%=bm.getUid()%>"> <%
 	if (bm.getUname() != null) {
 %>
									<%=bm.getUname()%> <%
 	}
 %>
								</a>
							</div>

							<p>
							<div id="toolbar"></div>
							<div id="editor"></div>
							<br> <br>
							</p>
							<%
								System.out.println(bm.getBlogId() + "***");
							
								
							%>
							<a value="" id="up" onclick="upvote()"><i
								class="fa fa-thumbs-o-up fa-lg" id="upi"
								aria-hidden="true"></i> <span id="upvotecount"> <%=bm.getUpvotes()%>
							</span></a> <a value="downvote&bid=<%=bm.getBlogId()%>" id="down"
								onclick="downvote()"><i
								class="fa fa-thumbs-o-down pl-3 fa-lg"
								id="downi" aria-hidden="true"></i> <span id="downvotecount">
									<%=bm.getDownvotes()%></span></a>

							<div class="blue lighten-4 pull-right"
								style="border-style: round; border-radius: 20px; display: inline-block;">
								<img src="imagesdomain/<%=bm.getDimgpath()%>"
									class="avatar img-fluid z-depth-1 rounded-circle"
									alt="Responsive image" /> <a class="pl-1 mr-3"
									href="WorkSpaceContent?did=<%=bm.getDid()%>&dname=<%=bm.getDname()%>">
									<%
										if (bm.getDname() != null) {
									%> <%=bm.getDname()%> <%
 	}
 %>
								</a>
							</div>


						</div>

					</div>
					<!--/.Card-->

					<!--Comments-->
					<div class="card card-comments mb-3 wow fadeIn">
						<div class="card-header font-weight-bold"><%=arbcm.size()%>
							Comment(s)
						</div>
						<div class="card-body">
							<%
								System.out.println(bm.getBlogId());
								if (arbcm != null) {
									for (BlogCommentModel bcm : arbcm) {
										if (bcm != null) {
							%>
							<div class="media d-block d-md-flex mt-4">
								<img class="d-flex mb-3 mx-auto rounded-circle"
									src="ImageLoader?uid=<%=bcm.getUid()%>"
									alt="Generic placeholder image">
								<div class="media-body text-center text-md-left ml-md-3 ml-0">
									<h5 class="mt-0 font-weight-bold"><%=bcm.getUname()%></h5>
									<%=bcm.getComment()%>
								</div>
							</div>
							<%
								}
									}
								}
							%>

						</div>
					</div>
					<!--/.Comments-->

					<!--Reply-->
					<div class="card mb-3 wow fadeIn">
						<div class="card-header font-weight-bold">Comment on Blog</div>
						<div class="card-body">

							<!-- Default form reply -->
							<form
								action="BlogComment?bid=<%=bm.getBlogId()%>&uid=<%=bm.getUid()%>"
								method="post">

								<!-- Comment -->
								<div class="form-group">
									<label for="replyFormComment">Your comment</label>
									<textarea class="form-control" name="comment"
										id="replyFormComment" rows="3"></textarea>
								</div>
								<div class="text-center mt-4">
									<button class="btn btn-info btn-md" type="submit">Post</button>
								</div>
							</form>
							<!-- Default form reply -->



						</div>
					</div>
					<!--/.Reply-->

				</div>
				<!--Grid column-->

				<!--Grid column-->
				<div class="col-md-4 mb-4">

					<!--Card-->
					<div class="card mb-4 wow fadeIn">

						<div class="card-header">Recent Blogs</div>

						<!--Card content-->
						<div class="card-body">

							<ul class="list-unstyled">
								<%
									int i = 0;
									for (BlogModel bm1 : albm) {
								%>
								<li class="media">
									<div class="media-body">

										<h5 class="mt-0 mb-1 font-weight-bold">
											<a href="BlogContentSingle?bid=<%=bm1.getBlogId()%>"><%=bm1.getTitle()%></a>
										</h5>
										<small id="<%=i%>"></small>

									</div>
								</li>

								<script type="text/javascript">
        		    setTime(<%=i%>,<%=bm1.getTimestamp()%>)
        		    </script>
								<li><br></li>
								<%
									i++;
									}
								%>
							</ul>

						</div>

					</div>
					<!--/.Card-->

				</div>
				<!--Grid column-->

			</div>
			<!--Grid row-->

		</section>
		<!--Section: Post-->

	</div>

	<script>
	
	var configForShow = {
            "theme": "snow",
            "modules": {
            "toolbar": false
}
            
};
	
	
	
	//console.log(typeof obj);
	var quill;
    quill=new Quill('#editor',configForShow);
    console.log(quill);
    console.log(typeof '<%=bm.getBlogContent()%>');
    quill.setContents(<%=bm.getBlogContent()%>);
    quill.enable(false);
	
	</script> </main>
	<!--Main layout-->

	<!--Footer-->
	<footer
		class="page-footer text-center font-small transparent mt-4 wow fadeIn">


		<!--Copyright-->
		<div class="footer-copyright py-3 black-text">
			© 2018 Copyright: <a href="" target="_blank"> Korero</a>
		</div>
		<!--/.Copyright-->

	</footer>
	<!--/.Footer-->

	<!-- SCRIPTS -->
	<!-- JQuery -->
	<script type="text/javascript" src="kext/js/jquery-3.2.1.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="kext/js/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="kext/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="kext/js/mdb.min.js"></script>
	<!-- Initializations -->
	<script type="text/javascript">
        // Animations initialization
        new WOW().init();
    </script>


	<script>
            
            var index;
            
            
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

var state='<%=status%>';

function upvote()
{   
	
    var up=document.getElementById("up");
    var val=up.value;
    request=getXmlHttpRequestObject();
    request.onreadystatechange=showVoteCount;
    request.open("post","UpDownBlogs",true);
    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");
    

	if(state=="up")
	{
	uicon=document.getElementById("upi");
	dicon=document.getElementById("downi");
	
	uicon.setAttribute("class","fa fa-thumbs-o-up fa-lg");
	dicon.setAttribute("class","fa fa-thumbs-o-down pl-3 fa-lg");
	
	state="none";
	}
	else if(state=="down")
	{
	uicon=document.getElementById("upi");
	dicon=document.getElementById("downi");
	
	uicon.setAttribute("class","fa fa-thumbs-up fa-lg");
	dicon.setAttribute("class","fa fa-thumbs-o-down pl-3 fa-lg");
	
	state="up";
	}
	else
		{
		uicon=document.getElementById("upi");
		dicon=document.getElementById("downi");
		
		uicon.setAttribute("class","fa fa-thumbs-up fa-lg");
		dicon.setAttribute("class","fa fa-thumbs-o-down pl-3 fa-lg");
		
		state="up";
		}
    
    
    var data="status=upvote&bid="+"<%=bm.getBlogId()%>";
    console.log(data);
    request.send(data);
}

function downvote()
{   
	
	
    
    var down=document.getElementById("down");
    var val=down.value;
    request=getXmlHttpRequestObject();
    request.onreadystatechange=showVoteCount;
    request.open("post","UpDownBlogs",true);
    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");
    
    if(state=="up")
	{
	uicon=document.getElementById("upi");
	dicon=document.getElementById("downi");
	
	uicon.setAttribute("class","fa fa-thumbs-o-up fa-lg");
	dicon.setAttribute("class","fa fa-thumbs-down pl-3 fa-lg");
	
	state="down";
	}
	else if(state=="down")
	{
	uicon=document.getElementById("upi");
	dicon=document.getElementById("downi");
	
	uicon.setAttribute("class","fa fa-thumbs-o-up fa-lg");
	dicon.setAttribute("class","fa fa-thumbs-o-down pl-3 fa-lg");
	
	state="none";
	}
	else
		{
		uicon=document.getElementById("upi");
		dicon=document.getElementById("downi");
		
		uicon.setAttribute("class","fa fa-thumbs-o-up fa-lg");
		dicon.setAttribute("class","fa fa-thumbs-down pl-3 fa-lg");
		
		state="down";
		}
    
    var data="status=downvote&bid="+"<%=bm.getBlogId()%>";
			console.log(data);
			request.send(data);
	}

		function showVoteCount() {
			if (request.readyState === 4 && request.status === 200) {
				var p = document.getElementById("upvotecount");
				var q = document.getElementById("downvotecount");
				var updowncount = JSON.parse(request.responseText);
				console.log(request.responseText);
				p.innerHTML = updowncount.uvotes;
				q.innerHTML = updowncount.dvotes;
			}
		}
	console.log(state);
		function setState(){
		if(state=="up")
			{
			uicon=document.getElementById("upi");
			dicon=document.getElementById("downi");
			
			uicon.setAttribute("class","fa fa-thumbs-up fa-lg");
			dicon.setAttribute("class","fa fa-thumbs-o-down pl-3 fa-lg");
			}
		else if(state=="down")
			{
			uicon=document.getElementById("upi");
			dicon=document.getElementById("downi");
			
			uicon.setAttribute("class","fa fa-thumbs-o-up fa-lg");
			dicon.setAttribute("class","fa fa-thumbs-down pl-3 fa-lg");
			}
		}
		setState();
	</script>





</body>

</html>