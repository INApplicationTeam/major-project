
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Choose Class</title>

<!-- Font Awesome -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/MDB Free/font-awesome-4.7.0/css/font-awesome.min.css">
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/MDB Free/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="${pageContext.request.contextPath}/MDB Free/css/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/MDB Free/css/chip.css">

    <!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
        


</head>
<body style="background-image: url('../../img/testd.jpg'); font-size:20px;">

      <button type="button" class="btn btn-primary" id="om" data-toggle="modal" data-target="#centralModalInfo" style="visibility:hidden" data-backdrop="static" data-keyboard="false">Small </button> <br>


<div class="modal fade mt-5" id="centralModalInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
    <div class="modal-dialog modal-notify modal-info modal-lg" role="document">
        <!--Content-->
        <div class="modal-content" style="border: none;">
            <!--Header-->
            <div class="modal-header" style="background-color: #33b5e5;box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12);color: #ffffff;border-bottom: none;">
                <div class="heading lead">Select Class</div>

                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="goToFeed()">
                    <span aria-hidden="true" class="white-text">&times;</span>
                </button>
            </div>

             <div class="modal-body" >
                            <!--Table-->
                            <table class="table table-sm table-responsive-md btn-table">

                                <!--Table head-->
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Class</th>
                                        <th>batch</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <!--Table head-->

                                <!--Table body-->
                                <tbody>
                                <c:forEach var="coordinator" items="${coordinatorClassList}">
                                    <tr>
                                        <th scope="row">1</th>
                                        <td><button type="button" class="btn btn-primary btn-rounded btn-sm my-0" onclick="coordinatorFunction()">${coordinator.branch}-${coordinator.sec}</button></td>
                                        <td>${coordinator.batch}</td>
                                        <td>Coordinator</td>
                                    </tr>
                                    <div style="display: none">
				                 <form:form action="classdiscussionfaculty" modelAttribute="choosedClass" method="POST">
									<form:hidden path="classid" value="${coordinator.classid}"/>
									<form:hidden path="yearOfTeaching" value="${currentYear}"/>
									<input type="submit" value="Go To Class" id="submitCoordinator">
								</form:form>
								</div>
                                    </c:forEach>
                                    
                                    <c:forEach var="subjectClass" items="${subjectClassList}">
                                    <tr>
                                        <th scope="row">2</th>
                                        <td><button type="button" class="btn btn-primary btn-rounded btn-sm my-0" onclick="facultyFunction()">${subjectClass.branch}-${subjectClass.sec}</button></td>
                                        <td>${subjectClass.batch}</td>
                                        <td>${subjectClass.subject.subject}</td>
                                    </tr>
                                    <div style="display: none">
                                    		<form:form action="classdiscussionfaculty" modelAttribute="choosedClass" method="POST">
												<form:hidden path="classid" value="${subjectClass.classid}"/>
												<form:hidden path="yearOfTeaching" value="${currentYear}"/>
												<input type="submit" value="Go To Class" id="submitFaculty">
											</form:form>
											</div>
                                    </c:forEach>
                                    
             
                                </tbody>
                                <!--Table body-->

                            </table>
                            <!--Table-->
                        </div>
                        <div class="modal-footer">
                        	<a href="CDFhomefaculty?year=${currentYear-1}">
                        	 <button type="button" class="btn btn-primary btn-sm">Previous Year</button>
                        	</a> 
                        	
                        	 <a href="CDFhomefaculty?year=${currentYear+1}">
                        	 <button type="button" class="btn btn-primary btn-sm">Next Year</button></a>
                        
                        </div>
                </div>
                </div>
 
		</div>

<div style="display: none">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

</div>
	
</body>
     <script src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
     <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui.css">
     
 <script type="text/javascript" src="${pageContext.request.contextPath}/MDB Free/js/jquery-3.1.1.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/MDB Free/js/tether.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/MDB Free/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/MDB Free/js/mdb.min.js"></script>
    
<script type="text/javascript">
function coordinatorFunction()
{
	$('#submitCoordinator').click();
}
function facultyFunction()
{
	$('#submitFaculty').click();
}

var modal=document.getElementById("centralModalInfo");
document.getElementById("om").click();
window.onclick = function(event) {
    if(event.target===modal)
    {
     
     } //location.reload();
};
</script>
</html>