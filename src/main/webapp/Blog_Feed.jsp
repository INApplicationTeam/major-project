<%@page import="model.*"%>
<%@page import="java.util.ArrayList"%>

<%
ArrayList<BlogModel> albm=(ArrayList<BlogModel>)session.getAttribute("bloglist");
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<!-- Font Awesome -->
<link rel="stylesheet"
	href="kext/font-awesome-4.7.0/css/font-awesome.min.css">

<!-- Bootstrap core CSS -->
<link href="kext/css/bootstrap.min.css" rel="stylesheet">

<!-- Material Design Bootstrap -->
<link href="kext/css/mdb.min.css" rel="stylesheet">

<!-- Template styles -->

<link rel="stylesheet" type="text/css" href="kext/css/bloghome.css">

<script src="https://cdn.quilljs.com/1.2.3/quill.js"></script>
    <script src="https://cdn.quilljs.com/1.2.3/quill.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <link href="https://cdn.quilljs.com/1.1.3/quill.snow.css" rel="stylesheet">
    <link href="https://cdn.quilljs.com/1.1.3/quill.bubble.css" rel="stylesheet">

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
<body>

	<!-- Main navigation -->
	<header>
		<!--Navbar-->
		<nav
			class="navbar navbar-expand-sm navbar-light fixed-top scrolling-navbar py-2 px-5">
			<a class="navbar-brand" href="#"> <strong>Korero</strong>
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent-7"
				aria-controls="navbarSupportedContent-7" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent-7">
				<ul class="navbar-nav mr-auto black-text">
					<li class="nav-item"><a class="nav-link" href="#">Home </a></li>
					<li class="nav-item"><a class="nav-link" href="#">Profile</a>
					</li>
					<li class="nav-item active"><a class="nav-link" href="#">Blogs</a>
						<span class="sr-only">(current)</span></li>

					<li class="nav-item"><a class="nav-link" href="#">Ask a
							Question</a></li>
				</ul>
				<form class="form-inline">
					<div class="md-form mt-0">
						<input class="form-control mr-sm-2" type="text"
							placeholder="Search" aria-label="Search">
					</div>
				</form>
			</div>
		</nav>
	</header>
	<!-- Main navigation -->
	<main class="mt-5">
	<div class="container-fluid pt-2">
		<div class="row">
			<div
				class="col-xl-3 col-lg-3 col-md-3 col-sm-3 project wow animated animated4 fadeInLeft">
				<div class="project-hover">
					<h3>MOST ACTIVE WORKSPACE</h3>
					<hr />
					<h3>
						<span class="badge">New</span>
					</h3>
					<h3>
						<span class="badge">New</span>
					</h3>
					<h3>
						<span class="badge">New</span>
					</h3>
					<a href="#">Read this workspace's blogs</a>
				</div>
			</div>
			<div
				class="col-xl-3 col-lg-3 col-md-3 col-sm-3 project project-2 wow animated animated3 fadeInLeft">
				<div class="project-hover">
					<h2>TOTAL NUMBER OF BLOGS</h2>
					<hr />
					<h1>
						<p class="badge">55</p>
					</h1>
					<p>Thank you for your contribution. Korero rewards all the blog
						writers heads up!</p>

				</div>
			</div>
			<div
				class="col-xl-3 col-lg-3 col-md-3 col-sm-3 project project-3 wow animated animated2 fadeInLeft">
				<div class="project-hover">
					<h2>TOP WRITERS</h2>
					<hr />
					<p>
					<div class="blue lighten-4"
						style="border-style: round; border-radius: 20px; display: inline-block;">
						<img src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg"
							class="avatar img-fluid z-depth-1 rounded-circle"
							alt="Responsive image" /> <a class="pl-1 mr-3" href=""><strong>Shreeya
								Nagar</strong></a>
					</div>
					</p>
					<p>
					<div class="blue lighten-4"
						style="border-style: round; border-radius: 20px; display: inline-block;">
						<img src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg"
							class="avatar img-fluid z-depth-1 rounded-circle"
							alt="Responsive image" /> <a class="pl-1 mr-3" href=""><strong>Shreeya
								Nagar</strong></a>
					</div>
					</p>
					<p>
					<div class="blue lighten-4"
						style="border-style: round; border-radius: 20px; display: inline-block;">
						<img src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg"
							class="avatar img-fluid z-depth-1 rounded-circle"
							alt="Responsive image" /> <a class="pl-1 mr-3" href=""><strong>Shreeya
								Nagar</strong></a>
					</div>
					</p>
				</div>
			</div>
			<div
				class="col-xl-3 col-lg-3 col-md-3 col-sm-3 project project-4 wow animated fadeInLeft">
				<div class="project-hover">
					<h2>TRENDING TAGS</h2>
					<hr />
					<p>
					<h3>
						<span class="badge">New</span>
					</h3>
					</p>
					<p>
					<h3>
						<span class="badge">New</span>
					</h3>
					</p>
					<p>
					<h3>
						<span class="badge">New</span>
					</h3>
					</p>

				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
	<div class="container-fluid mt-5">

		<div class="row">
			
			<div class="col-md-9">
			<%if(albm!=null){ for(int i=0;i<albm.size();i+=3){ %>
				<div class="card-deck mt-4">
					<!--Panel-->
					<% BlogModel bm=albm.get(i); %>
					<div class="card ">
						<div class="card-body">
							<h4 class="card-title pt-2 mb-0">
								<a href="BlogContentSingle?bid=<%=bm.getBlogId() %>"><strong><%=bm.getTitle() %></strong></a>
							</h4>
							<small>- by</small> <a href="" class="mt-0 pt-0"
								style="display: inline-block;"> <%=bm.getUname() %></a> in
							<div class="blue lighten-4"
								style="border-style: round; border-radius: 20px; display: inline-block;">
								<img
									src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg"
									class="avatar img-fluid z-depth-1 rounded-circle"
									alt="Responsive image" />
							</div>

							<p class="card-text mb-1">
								<div class="toolbar"></div>
								<div class="editor"></div>
							</p>

							<p class="card-text pt-1">
								<small class="text-muted"><%=bm.getTimestamp() %></small> <a>
									<span class="badge badge-danger float-right"><i
										class="fa fa-heart px-1 py-1" aria-hidden="true"></i><%=bm.getUpvotes() %></span>
								</a>
							</p>
						</div>
					</div>

					<!--/.Panel-->
					<!--Panel-->
					<% bm=albm.get(i+1); %>
					<div class="card ">
						<div class="card-body">
							<h4 class="card-title pt-2 mb-0">
								<a href="BlogContentSingle?bid=<%=bm.getBlogId() %>"><strong><%=bm.getTitle() %></strong></a>
							</h4>
							<small>- by</small> <a href="" class="mt-0 pt-0"
								style="display: inline-block;"> <%=bm.getUname() %></a> in
							<div class="blue lighten-4"
								style="border-style: round; border-radius: 20px; display: inline-block;">
								<img
									src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg"
									class="avatar img-fluid z-depth-1 rounded-circle"
									alt="Responsive image" />
							</div>

							<p class="card-text mb-1"><div class="toolbar"></div>
								<div class="editor"></div></p>

							<p class="card-text pt-1">
								<small class="text-muted"><%=bm.getTimestamp() %></small> <a>
									<span class="badge badge-danger float-right"><i
										class="fa fa-heart px-1 py-1" aria-hidden="true"></i><%=bm.getUpvotes() %></span>
								</a>
							</p>
						</div>
					</div>

					<!--/.Panel-->
					<!--Panel-->
					<% bm=albm.get(i+2); %>
					<div class="card ">
						<div class="card-body">
							<h4 class="card-title pt-2 mb-0">
								<a href="BlogContentSingle?bid=<%=bm.getBlogId() %>"><strong><%=bm.getTitle() %></strong></a>
							</h4>
							<small>- by</small> <a href="" class="mt-0 pt-0"
								style="display: inline-block;"> <%=bm.getUname() %></a> in
							<div class="blue lighten-4"
								style="border-style: round; border-radius: 20px; display: inline-block;">
								<img
									src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg"
									class="avatar img-fluid z-depth-1 rounded-circle"
									alt="Responsive image" />
							</div>

							<p class="card-text mb-1"><div class="toolbar"></div>
								<div class="editor"></div></p>

							<p class="card-text pt-1">
								<small class="text-muted"><%=bm.getTimestamp() %></small> <a>
									<span class="badge badge-danger float-right"><i
										class="fa fa-heart px-1 py-1" aria-hidden="true"></i><%=bm.getUpvotes() %></span>
								</a>
							</p>
						</div>
					</div>

					<!--/.Panel-->


				</div>
				<%}} %>
			</div>
			

			<div class="col-md-3">
				<!--Carousel Wrapper-->
				<div id="carousel-example-1z" class="carousel slide carousel-fade"
					data-ride="carousel">
					<!--Indicators-->
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-1z" data-slide-to="0"
							class="active"></li>
						<li data-target="#carousel-example-1z" data-slide-to="1"></li>
						<li data-target="#carousel-example-1z" data-slide-to="2"></li>
					</ol>
					<!--/.Indicators-->
					<!--Slides-->
					<div class="carousel-inner" role="listbox">
						<!--First slide-->
						<div class="carousel-item active">
							<div class="widget-wrapper wow fadeIn" data-wow-delay="0.4s">
								<h4>Other suggested blogs:</h4>
								<br>
								<div class="list-group">
									<a href="#" class="list-group-item active">Computer Science</a>
									<a href="#" class="list-group-item">Information Technology</a>
									<a href="#" class="list-group-item">Mechanical</a> <a href="#"
										class="list-group-item">Civil</a> <a href="#"
										class="list-group-item">Parties</a>
								</div>
							</div>

						</div>
						<!--/First slide-->
						<!--Second slide-->
						<div class="carousel-item">
							<div class="widget-wrapper wow fadeIn" data-wow-delay="0.4s">
								<h4>Other suggested blogs:</h4>
								<br>
								<div class="list-group">
									<a href="#" class="list-group-item active">Dance</a> <a
										href="#" class="list-group-item">Music</a> <a href="#"
										class="list-group-item">EP cell</a> <a href="#"
										class="list-group-item">I don't know</a> <a href="#"
										class="list-group-item">whatever</a>
								</div>
							</div>
						</div>
						<!--/Second slide-->
						<!--Third slide-->
						<div class="carousel-item">
							<div class="widget-wrapper wow fadeIn" data-wow-delay="0.4s">
								<h4>Other suggested blogs:</h4>
								<br>
								<div class="list-group">
									<a href="#" class="list-group-item active">Chemical</a> <a
										href="#" class="list-group-item">Electronic &
										communication</a> <a href="#" class="list-group-item">Library</a>
									<a href="#" class="list-group-item">Placement cell</a> <a
										href="#" class="list-group-item">Others</a>
								</div>
							</div>
						</div>
						<!--/Third slide-->
					</div>
					<!--/.Slides-->
					<!--Controls-->
					<a class="carousel-control-prev" href="#carousel-example-1z"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carousel-example-1z"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
					<!--/.Controls-->
				</div>
				<!--/.Carousel Wrapper-->
			</div>
		</div>
	</div>
	</div>
	
	<script>
	
	var configForShow = {
            "theme": "snow",
            "modules": {
            "toolbar": false
}
            
};
	
	var toolElements=document.getElementsByClass('toolbar');
	var editElements=document.getElementsByClass('editor');
	
	console.log(typeof obj);
	var quill;
    quill=new Quill('#editor',configForShow);
    console.log(quill);
    quill.setContents(obj);
    quill.enable(false);
	
	
	</script>
	
	</main>
	<!--Footer-->
	<footer class="page-footer transparent mt-4">
		<!--Copyright-->
		<div class="footer-copyright py-3 text-center black-text">
			© 2018 Copyright: <a href=""><strong class="black-text">Korero
					Inc.</strong></a>
		</div>
		<!--/.Copyright-->
	</footer>
	<!--/.Footer-->
	<!-- JQuery -->
	<script type="text/javascript" src="kext/js/jquery-3.2.1.min.js"></script>

	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="kext/js/bootstrap.min.js"></script>

	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="kext/js/mdb.min.js"></script>

	<script>

$('.carousel').carousel({
  interval: 3000
})

new WOW().init();

    </script>

</body>
</html>