<%@page import="model.*"%>
<%@page import="java.util.ArrayList"%>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">

<% 
BlogModel bm=(BlogModel)session.getAttribute("blogmodel");
ArrayList<BlogCommentModel> arbcm=bm.getArbcm();
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

</head>

<body class="grey lighten-3">

	<!--Main Navigation-->
	<header>

		<!-- Navbar -->
		<nav
			class="navbar fixed-top navbar-expand-lg navbar-light white scrolling-navbar">
			<div class="container">

				<!-- Brand -->
				<a class="navbar-brand waves-effect" href="" target="_blank"> <strong
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
							href="#">Home </a></li>
						<li class="nav-item"><a class="nav-link waves-effect"
							href="https://mdbootstrap.com/material-design-for-bootstrap/"
							target="_blank">Profile</a></li>
						<li class="nav-item"><a class="nav-link waves-effect active"
							href="https://mdbootstrap.com/getting-started/" target="_blank">Blogs</a>

						</li>
						<li class="nav-item"><a class="nav-link waves-effect"
							href="https://mdbootstrap.com/bootstrap-tutorial/"
							target="_blank">Ask a Question</a></li>
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
								<% if(bm.getTitle()!=null){ %>
								<%= bm.getTitle() %>
								<%}%>
							</h2>
							<small class="text-muted" style="display: inline-block;">written
								<% if(bm.getTimestamp()!=null){ %> <%= bm.getTimestamp() %> <%}%>
							</small>
							<div class="text-muted pull-right" style="display: inline-block;">
								by <a class="blue-text">
									<% if(bm.getUname() !=null){ %> <%= bm.getUname() %> <%}%>
								</a>
							</div>

							<p>
							<div id="toolbar"></div>
							<div id="editor"></div>
							<br>
							<br>
							</p>

							<a><i class="fa fa-thumbs-o-up fa-lg" aria-hidden="true"></i>
								<%=bm.getUpvotes() %></a> <a><i
								class="fa fa-thumbs-o-down pl-3 fa-lg" aria-hidden="true"></i> <%=bm.getDownvotes() %></a>

							<div class="blue lighten-4 pull-right"
								style="border-style: round; border-radius: 20px; display: inline-block;">
								<img
									src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg"
									class="avatar img-fluid z-depth-1 rounded-circle"
									alt="Responsive image" /> <a class="pl-1 mr-3" href="">
									<% if(bm.getDname()!=null){ %> <%= bm.getDname() %> <%}%>
								</a>
							</div>


						</div>

					</div>
					<!--/.Card-->

					<!--Comments-->
					<div class="card card-comments mb-3 wow fadeIn">
						<div class="card-header font-weight-bold"><%=arbcm.size() %>
							Comment(s)
						</div>
						<div class="card-body">
							<% System.out.println(bm.getBlogId()); if(arbcm!=null){ for(BlogCommentModel bcm : arbcm){ if(bcm!=null){ %>
							<div class="media d-block d-md-flex mt-4">
								<img class="d-flex mb-3 mx-auto rounded-circle"
									src="ImageLoader?uid=<%=bcm.getUid() %>"
									alt="Generic placeholder image">
								<div class="media-body text-center text-md-left ml-md-3 ml-0">
									<h5 class="mt-0 font-weight-bold"><%=bcm.getUname() %></h5>
									<%=bcm.getComment() %>
								</div>
							</div>
							<%}}} %>

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

						<div class="card-header">Related articles</div>

						<!--Card content-->
						<div class="card-body">

							<ul class="list-unstyled">
								<li class="media"><img class="d-flex mr-3"
									src="https://mdbootstrap.com/img/Photos/Others/placeholder7.jpg"
									alt="Generic placeholder image">
									<div class="media-body">
										<a href="">
											<h5 class="mt-0 mb-1 font-weight-bold">List-based media
												object</h5>
										</a> Cras sit amet nibh libero, in gravida nulla (...)
									</div></li>
								<li class="media my-4"><img class="d-flex mr-3"
									src="https://mdbootstrap.com/img/Photos/Others/placeholder6.jpg"
									alt="An image">
									<div class="media-body">
										<a href="">
											<h5 class="mt-0 mb-1 font-weight-bold">List-based media
												object</h5>
										</a> Cras sit amet nibh libero, in gravida nulla (...)
									</div></li>
								<li class="media"><img class="d-flex mr-3"
									src="https://mdbootstrap.com/img/Photos/Others/placeholder5.jpg"
									alt="Generic placeholder image">
									<div class="media-body">
										<a href="">
											<h5 class="mt-0 mb-1 font-weight-bold">List-based media
												object</h5>
										</a> Cras sit amet nibh libero, in gravida nulla (...)
									</div></li>
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
	
	
	var obj=<%=bm.getBlogContent()%>;
	console.log(typeof obj);
	var quill;
    quill=new Quill('#editor',configForShow);
    console.log(quill);
    quill.setContents(obj);
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
</body>

</html>