<%@page import="model.BlogModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.AllBlogModel"%>


<%
	AllBlogModel abm = (AllBlogModel) session.getAttribute("domainblogs");
	ArrayList<BlogModel> albm = abm.getAbm();
	String dname = request.getParameter("dname");
	String did = request.getParameter("did");
	String domain[] = dname.split(" ");
	dname = "";
	for (String d : domain) {
		dname += d.charAt(0) + d.substring(1).toLowerCase() + " ";
	}
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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link href="https://cdn.quilljs.com/1.1.3/quill.snow.css"
	rel="stylesheet">
<link href="https://cdn.quilljs.com/1.1.3/quill.bubble.css"
	rel="stylesheet">

<style rel="stylesheet">
img.resize {
	max-width: 15%;
	max-height: 15%;
	float: right;
}

iframe {
	width: 180px;
	height: 90px;
	float: right;
	margin: 10px;
}

b, strong {
	font-weight: bold;
}

.blog {
	font-family: "roboto";
	font-size: 15px;
	font-weight: 400;
	word-wrap: break-word;
}

pre {
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

<script>
	function time_ago(time) {

		switch (typeof time) {
		case 'number':
			break;
		case 'string':
			time = +new Date(time);
			break;
		case 'object':
			if (time.constructor === Date)
				time = time.getTime();
			break;
		default:
			time = +new Date();
		}
		var time_formats = [ [ 60, 'seconds', 1 ], // 60
		[ 120, '1 minute ago', '1 minute from now' ], // 60*2
		[ 3600, 'minutes', 60 ], // 60*60, 60
		[ 7200, '1 hour ago', '1 hour from now' ], // 60*60*2
		[ 86400, 'hours', 3600 ], // 60*60*24, 60*60
		[ 172800, 'Yesterday', 'Tomorrow' ], // 60*60*24*2
		[ 604800, 'days', 86400 ], // 60*60*24*7, 60*60*24
		];
		var seconds = (+new Date() - time) / 1000, token = 'ago', list_choice = 1;

		if (seconds == 0) {
			return 'Just now'
		}
		if (seconds < 0) {
			seconds = Math.abs(seconds);
			token = 'from now';
			list_choice = 2;
		}
		var i = 0, format;
		while (format = time_formats[i++])
			if (seconds < format[0]) {
				if (typeof format[2] == 'string')
					return format[list_choice];
				else
					return Math.floor(seconds / format[2]) + ' ' + format[1]
							+ ' ' + token;
			}
		return "on " + new Date(time).toDateString();
	}

	function setTime(id, time) {
		document.getElementById(id).innerHTML = time_ago(new Date(time));
	}
</script>

</head>
<body>

	<div id="toolbarque" style="display: none"></div>
	<div id="editorque" style="display: none"></div>


	<script>
		var configque = {
			"theme" : "snow",
			"modules" : {
				"toolbar" : false
			}

		};

		var quillBlogs = [];

		var quillque = new Quill('#editorque', configque);

		function setBlogContent(index, postIndex, blogText) {
			console.log(blogText);
			quillBlogs.push(blogText);
			window.delta = blogText;
			var content = "";
			var imgObj, count = 0, count1 = 0;
			var endLineCounter = 0;
			var isStillLeft = false;

			for (var i = 0; i < delta.ops.length; i++) {
				var del = delta.ops[i];

				if (typeof del.insert !== 'object' && count1 == 1) {
					if (del.insert.indexOf("\n") != -1) {
						endLineCounter++;
					}

					if (endLineCounter < 5) {
						count1 = 0;
						content = content
								+ del.insert.substr(1, del.insert.length);
						continue;
					} else {
						isStillLeft = true;
						break;
					}

				}

				if (typeof del.insert !== 'object') {
					if (del.insert.indexOf("\n") != -1) {
						endLineCounter++;
					}

					if (endLineCounter < 5) {
						content = content + del.insert;
					} else {
						isStillLeft = true;
						break;
					}
				} else if (count == 0) {
					count++;
					imgObj = del.insert;
					count1 = 1;
				}
			}

			if (imgObj !== undefined) {
				var opsarr = {
					"ops" : [ {
						"insert" : ""
					} ]
				};
				opsarr.ops[0].insert = imgObj;
				quillque.setContents(opsarr);
				var imgarea = document.getElementsByClassName("blogImg")[index];
				imgarea.innerHTML = quillque.root.innerHTML;

				if (imgObj.hasOwnProperty('image')) {
					var imgTag = imgarea.getElementsByTagName('p')[0].childNodes[0];
					imgTag.setAttribute("class", "resize");
				} else {
					var imgTag = imgarea.getElementsByTagName('p')[0];
					imgTag
							.removeChild(imgarea.getElementsByTagName('p')[0].childNodes[0]);
				}
				imgObj = undefined;
			}

			var c = document.getElementsByClassName("blog");

			if (content.length > 250) {
				c[index].innerText = content.substr(0, 250) + "...";
			}

			else if (isStillLeft) {
				c[index].innerText = content;
			}

			else {
				c[index].innerText = content;
				//document.getElementsByClassName("readBlog")[index].innerHTML="";
			}

		}
	</script>

	<!-- Main navigation -->
	<header>
		<!--Navbar-->
		<nav
			class="navbar navbar-expand-sm navbar-light fixed-top scrolling-navbar py-2 px-5">
			<a class="navbar-brand" href="MyFeed"> <strong>Korero</strong>
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent-7"
				aria-controls="navbarSupportedContent-7" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent-7">
				<ul class="navbar-nav mr-auto black-text">
					<li class="nav-item"><a class="nav-link" href="MyFeed">Home
					</a></li>
					<li class="nav-item"><a class="nav-link" href="MyProfile">Profile</a>
					</li>
					<li class="nav-item active"><a class="nav-link" href="#">Blogs</a>
						<span class="sr-only">(current)</span></li>

					<li class="nav-item"><a class="nav-link"
						href="Post_Question.jsp">Ask a Question</a></li>
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
	<main class="mt-5"> <br>
	<div class="card mx-4 mt-3 stylish-color">
		<div class="card-body">
			<h3 class=" text-center white-text">
		<strong>#<%=dname%></strong>
	</h3>
		
		</div>
	</div>


	<div class="container-fluid mt-5">

		<div class="row">

			<div class="col-md-9">
				<%
					if (albm != null) {
						for (int i = 0; i < albm.size(); i += 3) {
				%>
				<div class="card-deck mt-4">
					<!--Panel-->
					<%
						BlogModel bm;
						if(i<albm.size()){
						bm = albm.get(i);
					%>
					<div class="card ">
						<div class="card-body">
							<h4 class="card-title pt-2 mb-0">
								<a href="BlogContentSingle?bid=<%=bm.getBlogId()%>"><strong><%=bm.getTitle()%></strong></a>
							</h4>
							<small>- by</small> <a href="" class="mt-0 pt-0"
								style="display: inline-block;"> <%=bm.getUname()%></a> <br>
							<div class="card-text mb-1">
								<span class="blogImg"></span>
								<div class="blog" style="margin-bottom: 1px;"
									id="blogEditor<%=i%>"></div>
							</div>


							<script>
								var index =
							<%=i%>
								;
								var blogText =
							<%=bm.getBlogContent()%>
								;
								setBlogContent(index, index, blogText);
							</script>


						</div>
						<div class="card-footer">
							<p class="card-text pt-1">
								<small class="text-muted" id="<%=i%>"></small> <span
									class="badge badge-danger float-right"><i
									class="fa fa-thumbs-up px-1 py-1" aria-hidden="true"></i><%=bm.getUpvotes()%></span>

							</p>
							<script type="text/javascript">
								setTime(
							<%=i%>
								,
							<%=bm.getTimestamp()%>
								)
							</script>
						</div>
					</div>
					<%} %>
					<!--/.Panel-->
					<!--Panel-->
					<%
					if(i+1<albm.size()){
						bm = albm.get(i + 1);
					%>
					<div class="card ">
						<div class="card-body">
							<h4 class="card-title pt-2 mb-0">
								<a href="BlogContentSingle?bid=<%=bm.getBlogId()%>"><strong><%=bm.getTitle()%></strong></a>
							</h4>
							<small>- by</small> <a href="" class="mt-0 pt-0"
								style="display: inline-block;"> <%=bm.getUname()%></a> <br>
							<div class="card-text mb-1">
								<span class="blogImg"></span>
								<div class="blog" style="margin-bottom: 1px;"
									id="blogEditor<%=i + 1%>"></div>
							</div>


							<script>
								var index =
							<%=i + 1%>
								;
								var blogText =
							<%=bm.getBlogContent()%>
								;
								setBlogContent(index, index, blogText);
							</script>

						</div>
						<div class="card-footer">
							<p class="card-text pt-1">
								<small class="text-muted" id="<%=i + 1%>"></small> <span
									class="badge badge-danger float-right"><i
									class="fa fa-thumbs-up px-1 py-1" aria-hidden="true"></i><%=bm.getUpvotes()%></span>

							</p>
							<script type="text/javascript">
								setTime(
							<%=i + 1%>
								,
							<%=bm.getTimestamp()%>
								)
							</script>
						</div>
					</div>
					<%} %>
					<!--/.Panel-->
					<!--Panel-->
					<%
					if(i+2<albm.size()){
						bm = albm.get(i + 2);
					%>
					<div class="card ">
						<div class="card-body">
							<h4 class="card-title pt-2 mb-0">
								<a href="BlogContentSingle?bid=<%=bm.getBlogId()%>"><strong><%=bm.getTitle()%></strong></a>
							</h4>
							<small>- by</small> <a href="" class="mt-0 pt-0"
								style="display: inline-block;"> <%=bm.getUname()%></a> <br>
							<div class="card-text mb-1">
								<span class="blogImg"></span>
								<div class="blog" style="margin-bottom: 1px;"
									id="blogEditor<%=i + 2%>"></div>
							</div>


							<script>
								var index =
							<%=i + 2%>
								;
								var blogText =
							<%=bm.getBlogContent()%>
								;
								setBlogContent(index, index, blogText);
							</script>

						</div>
						<div class="card-footer">
							<p class="card-text pt-1">
								<small class="text-muted" id="<%=i + 2%>"></small> <span
									class="badge badge-danger float-right"><i
									class="fa fa-thumbs-up px-1 py-1" aria-hidden="true"></i><%=bm.getUpvotes()%></span>

							</p>
							<script type="text/javascript">
								setTime(
							<%=i + 2%>
								,
							<%=bm.getTimestamp()%>
								)
							</script>
						</div>
					</div>
					<%} %>
					<!--/.Panel-->


				</div>
				<%
					}
					}
				%>
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
									<a href="WorkSpaceContent?did=1&dname=Computer Science"
										class="list-group-item active">Computer Science</a> <a
										href="WorkSpaceContent?did=3&dname=Information Technology"
										class="list-group-item">Information Technology</a> <a
										href="WorkSpaceContent?did=2&dname=Mechanical"
										class="list-group-item">Mechanical</a> <a
										href="WorkSpaceContent?did=8&dname=Civil"
										class="list-group-item">Civil</a> <a
										href="WorkSpaceContent?did=14&dname=Scholarship"
										class="list-group-item">Scholarship</a>
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
									<a href="WorkSpaceContent?did=19&dname=Dance"
										class="list-group-item active">Dance</a> <a
										href="WorkSpaceContent?did=18&dname=Music"
										class="list-group-item">Music</a> <a
										href="WorkSpaceContent?did=20&dname=Literary Club"
										class="list-group-item">Literary Club</a> <a
										href="WorkSpaceContent?did=16&dname=Hostel"
										class="list-group-item">Hostel</a> <a
										href="WorkSpaceContent?did=10&dname=Sports"
										class="list-group-item">Sports</a>
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
									<a href="WorkSpaceContent?did=7&dname=Chemical"
										class="list-group-item active">Chemical</a> <a
										href="WorkSpaceContent?did=5&dname=Electronics"
										class="list-group-item">Electronic & Communication</a> <a
										href="WorkSpaceContent?did=9&dname=Library"
										class="list-group-item">Library</a> <a
										href="WorkSpaceContent?did=11&dname=Placement Cell"
										class="list-group-item">Placement cell</a> <a
										href="WorkSpaceContent?did=25&dname=Others"
										class="list-group-item">Others</a>
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
			"theme" : "snow",
			"modules" : {
				"toolbar" : false
			}

		};

		var toolElements = document.getElementsByClass('toolbar');
		var editElements = document.getElementsByClass('editor');

		console.log(typeof obj);
		var quill;
		quill = new Quill('#editor', configForShow);
		console.log(quill);
		quill.setContents(obj);
		quill.enable(false);
	</script> </main>
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
			interval : 3000
		})

		new WOW().init();
	</script>

</body>
</html>