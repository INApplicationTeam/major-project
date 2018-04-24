

<!--Main Navigation-->
<header>
<%@page import="model.UserModel"%>
	<%
	String utype=session.getAttribute("utype").toString();
	Object obj =session.getAttribute("userModel");
	UserModel um=new UserModel();
	String uname=um.getUserName(obj);
	String uid=um.getUserId(obj);
%>

	<!-- Navbar -->
	<nav
		class="navbar fixed-top navbar-expand-lg navbar-light white scrolling-navbar"
		style="margin-left: 30px; box-shadow: none;">
		<div class="container-fluid">

			<!-- Brand -->
			<a class="navbar-brand waves-effect"
				href="https://mdbootstrap.com/material-design-for-bootstrap/"
				target="_blank"> <strong class="blue-text">Korero</strong>
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
						href="../../MyFeed">Home <span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link waves-effect"
						href="aboutClass">About this class</a></li>
					<li class="nav-item"><a class="nav-link waves-effect"
						href="../../LoadBlogFeed">Blogs</a>
					</li>
					<li class="nav-item"><a class="nav-link waves-effect"
						href="showNotices">Notice</a>
					</li>
				</ul>

				
			</div>

		</div>
	</nav>
	<!-- Navbar -->

	<!-- Sidebar -->
	<div class="leftside pt-2"
		onmouseover="javascript:document.getElementById('blur').style.filter='blur(3px)';"
		onmouseout="javascript:document.getElementById('blur').style.filter='blur(0)';">
		<div class="text-center" style="padding: 10px;">
			<img src="../../ImageLoader?uid=<%=uid%>"
				class="img-fluid z-depth-1 rounded-circle"
				style="max-height: 150px;" alt="Responsive image">
		</div>
		<div class="item">
			<span class="fa fa-bel"></span><%=uname%>
		</div>
		
		<a href="../../MyProfile">
			<div class="item">
				<span class="fa fa-user"></span> Profile
			</div>
		</a> 
		
		<a href="../../MyFeed">

			<div class="item">
				<span class="fa fa-pie-chart"></span> My Feed
			</div>
		</a> 
		
		<a href="../../book advisory/bookhome.jsp">
			<div class="item active">
				<span class="fa fa-institution"></span> Book Advice
			</div>
		</a>
		
		 <a href="../../poll/pollhome.jsp">
			<div class="item">
				<span class="fa fa-bar-chart-o"></span> Polling
			</div>
		</a> 
		
		<a href="CDFhome<%=utype%>">
			<div class="item">
				<span class="fa fa-graduation-cap"></span> Class Discussion
			</div>
		</a>
		
		<a onclick="destroyHandler()">
		<div class="item">
                <span class="fa fa-sign-out"></span>
                LogOut
            </div>
           </a> 
	</div>
	<!-- Sidebar -->

</header>
<!--Main Navigation-->
<<script type="text/javascript">
function destroyHandler()
{
	     	window.location="../../LogOut";
}
</script>

