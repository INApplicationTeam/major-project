<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>About Class</title>
       <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/kext/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/kext/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="${pageContext.request.contextPath}/kext/css/mdb.min.css" rel="stylesheet">
    <!-- Your custom styles (optional) -->
    <link href="${pageContext.request.contextPath}/kext/css/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/kext/css/sidebar.css">
  <style type="text/css">
    @media (min-width: 800px) and (max-width: 850px) {
            .navbar:not(.top-nav-collapse) {
                background: #1C2331!important;
            }
        }
        
.top-nav-collapse {
  background-color: #fff; }

/* Adding color to the Navbar on mobile */
@media only screen and (max-width: 768px) {
  .navbar {
    background-color: #1C2331; } }

/* Footer color for sake of consistency with Navbar */
.page-footer {
  background-color: #1C2331; }

  </style>
</head>

<body class="rgba-grey-slight">

    <!--Main Navigation-->
<%@include file="navBarAndSideBar.jsp" %>
    <!--Main Navigation-->

  <!--Main layout-->
    <!--Main layout-->
    <main class="pt-4 mx-lg-5" id="blur">
        <div class="container-fluid mt-5 pt-3 ml-3 pr-0 pl-5">
      <section>

        <h4 class="h4 ml-5 display-4">${classname}</h4>
        <hr class="mb-4">
        <h3 class="h3 mb-5 pl-5" style="display: inline-block;">Faculty List</h3>
        <h3 class="h3 mb-5 pull-right pl-5 mr-5" style="padding-right: 100px;">Class Coordinator</h3>
        <h3 class="h3 mb-5 pull-right pl-5 mr-5" style="padding-right: 100px;">Class Representative</h3>

        <!--Grid row-->
        <div class="row wow fadeIn">

          <!--Grid column -1 faculty-->
          <div class="col-lg-4 col-md-12 px-4">
		<c:forEach var="faculty" items="${classSubjectFaculty}">
		
            <!--First row-->
            <div class="row">
              <div class="col-1 mr-3">
                <img src="../../ImageLoader?uid=${faculty.userModel.uid }" class="img-fluid z-depth-1 rounded-circle avatar mr-2" alt="Responsive image">
              </div>
              <div class="col-10">
                <h5 class="feature-title">${faculty.userModel.uname }</h5>
                <p class="grey-text"><span class="badge badge-primary">${faculty.subject.subject}</span></p>
              </div>
            </div>
            <!--/First row-->

            <div style="height:30px"></div>
			
            </c:forEach>
          </div>
          <!--/Grid column-->

          <!--Grid column-2 CR 2-->
          <div class="col-lg-4 col-md-12 border-right">
			<c:forEach var="cr" items="${CR}">
			
            <!--First row-->
            <div class="row">
              <div class="col-1 mr-3">
                <img src="../../ImageLoader?uid=${cr.userModel.uid }" class="img-fluid z-depth-1 rounded-circle avatar mr-2" alt="Responsive image">
              </div>
              <div class="col-10">
                <h5 class="feature-title">${cr.userModel.uname }</h5>
               
              </div>
            </div>
            <!--/First row-->

            <div style="height:30px"></div>
			</c:forEach>
          

          </div>
          <!--/Grid column-->

          <!--Grid column coordinator-->
          <div class="col-lg-4 col-md-12">
			<c:forEach var="coordinator" items="${classCoordinator}">
            <!--First row-->
            <div class="row">

              <div class="col-1 mr-3">
                <img src="../../ImageLoader?uid=${coordinator.fid }" class="img-fluid z-depth-1 rounded-circle avatar mr-2" alt="Responsive image">
              </div>
              <div class="col-10">
                <h5 class="feature-title">${coordinator.name }</h5>
                <p class="grey-text"><span class="badge badge-danger ml-3">class coordinator</span></p>
              </div>
            </div>
            <!--/First row-->

            <div style="height:30px"></div>
			</c:forEach>
            
          </div>
          <!--/Grid column-->

        </div>
        <!--/Grid row-->

      </section>
      <!--Section: Main features & Quick Start-->

      <hr class="my-5">

      <!--Section: More-->
      <section class="mb-5">

        <h2 class="my-5 h3 text-center">Student List</h2>

        <div class="row features-small wow fadeIn">
	
		<c:forEach var = "members" items="${classmembers }">
        <!--First row-->
        
          <!--Grid column-->
          <div class="col-xl-3 col-lg-6">
            <!--Grid row-->
            <div class="row" style="height:80px">
              <div class="col-2">
                <img src="../../ImageLoader?uid=${members.sid }" class="img-fluid z-depth-1 rounded-circle avatar mr-2" alt="Responsive image">
              </div>
              <div class="col-10 mb-2 pl-3">
                <h5 class="feature-title">${members.name}</h5>
              </div>
            </div>
            <!--/Grid row-->
          </div>
          <!--/Grid column-->

        <!--/First row-->
	</c:forEach>

       </div>
      </section>
      <!--Section: More-->

    </div>
  </main>
  <!--Main layout-->

  <!--Footer-->
  <footer class="page-footer text-center font-small mt-4 wow fadeIn">

    <!--Copyright-->
    <div class="footer-copyright py-3">
      © 2018 Copyright:
      <a href="" target="_blank">Korero Inc.</a>
    </div>
    <!--/.Copyright-->

  </footer>
  <!--/.Footer-->

  <!-- SCRIPTS -->
  <!-- JQuery -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/mdb.min.js"></script>
  <!-- Initializations -->
  <script type="text/javascript">
    // Animations initialization
    new WOW().init();
  </script>
</body>

</html>