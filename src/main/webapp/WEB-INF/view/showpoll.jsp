<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/png" href="../MDB Free/img/img1.png" />
        
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
    
        
        <!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
        
        
        <title>Korero</title>
     
                     </head>
    <body class="blue-grey lighten-5">
    
    <%@include file="navBarAndSideBar.jsp" %>

 <main class="pt-4 mx-lg-5" id="blur">
        <div class="container-fluid mt-5 pt-3 ml-3 pr-0">


            <!-- Heading -->
            <div class="card">

                <!--Card content-->
                <div class="card-body d-sm-flex justify-content-between py-3">

                    <h5 class="mb-2 mb-sm-0">
                        ${branchsec }/${sem } sem
                    </h5>
                    <a href="../../poll/createpoll.jsp?var=classpoll">
                    <button type="button" class="btn btn-outline-primary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Create poll</button>
                    </a>
                    
                   <a href="startClassDiscussion">
                    <button type="button" class="btn btn-outline-default waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Start Discussion</button>
                    </a>
                    
                    <a href="addEventForm">
                    <button type="button" class="btn btn-outline-secondary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Add event</button>
                    </a>
                    
                    <a href="../../Post_Question.jsp?classQue=true">
                    <button type="button" class="btn btn-outline-success waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Ask Question</button>
                    </a>
                    <div>
					<a href="showSavedPosts"><i class="fa fa-thumb-tack" aria-hidden="true"></i> My Saved Posts&nbsp;&nbsp;</a>
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


	<!--CARD 1 -->
 <div class="row wow fadeIn">
 	
 
  <div class="col-md-9">
	<c:forEach var="poll" items="${showpoll}">
		<c:if test="${poll.isVoted}">

			 <div class="card mb-3 mt-4">
				<div class="card-body pb-0">
					<small> <a href="../../UserProfile?uid=${posts.userModel.uid}">${poll.userModel.uname}</a> created this poll </a>
					</small> <strong>
						<h4 style="font-size: 24px;" class="mt-2">
							<a>Q. ${poll.question}</a>
						</h4>
					</strong>
					<c:set var = "totalcount" scope = "page" value = "0"/>
					<c:forEach var="optiondetails" items="${poll.options}" begin="0" varStatus="innerloop">
						<c:set var = "totalcount" scope = "page" value = "${totalcount + optiondetails.pollResult.count}"/>
					</c:forEach>
					
					<c:forEach var="optiondetails" items="${poll.options}" begin="0" varStatus="innerloop">

						<form:form action="votepoll" method="post" modelattribute="poll">
								 <fmt:formatNumber var = "i" type = "number" value = "${optiondetails.pollResult.count/totalcount *100}"  minFractionDigits="0" maxFractionDigits="0"/>
						
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
		
		<c:if test="${!poll.isVoted}">
			 <!--CARD 1 -->
			 
                    <div class="card mb-3 mt-4">
                        <div class="card-body pb-0">
                            <small>
                                <a href="../../UserProfile?uid=${posts.userModel.uid}">${poll.userModel.uname}</a> created this poll</a>
                             
                            </small>
                            
                            <strong>
                            <h4 style="font-size: 24px;" class="mt-2"><a>${poll.question}</a></h4>                                
                            </strong>
                            <c:forEach var="optiondetails" items="${poll.options}" begin="0" varStatus="innerloop">
                            
                            <div class="row mb-2">
                                <div class="col-md-12 pr-3 pb-4 pt-1">
                                    <button type="button" class="btn btn-default btn-lg btn-block pb-2 pt-2 mb-2" onclick="setPollIdAndOptionId(${optiondetails.pollResult.opid},${poll.queid})"><i class="fa fa-mail-forward pull-left" aria-hidden="true"></i>${optiondetails.options}</button>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                    </div>
                     <!--CARD 1 -->
		
		</c:if>
	</c:forEach>
		</div>

			<div class="col-md-3 mx-0 my-0 px-0 py-0">

                <ul class="list-group mt-4 ml-2 mb-4 wow tada">
                    <li class="list-group-item d-flex justify-content-between align-items-center primary-color">
                        <h4 class="mb-0 pb-0 white-text"><strong>Pinned Posts</strong></h4>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Cras justo odio
                        <span class="badge badge-primary badge-pill">event</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Dapibus ac facilisis in
                        <span class="badge badge-primary badge-pill">poll</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Morbi leo risus
                        <span class="badge badge-primary badge-pill">discussion</span>
                    </li>
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
	<!--CARD 1 -->
	</div>
	</main>
	
	
	<div  class="abc" style="display: none">
	<form action="../../QueVotedController" id="pollSubmit" method="post" >

		<input type="text" id="opt1" name="opt">
		<input type="text"name="scope" value="class"> 
		<input type=SUBMIT value="SUBMIT" id="submitpoll">
	</form>
	</div>



	<a href="CDFhomestudent">Back</a>
</body>
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

</html>