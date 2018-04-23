<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Class Discussion Forum</title>
		<script src="https://cdn.quilljs.com/1.2.3/quill.js"></script>
        <script src="https://cdn.quilljs.com/1.2.3/quill.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <link href="https://cdn.quilljs.com/1.1.3/quill.snow.css" rel="stylesheet">
        <link href="https://cdn.quilljs.com/1.1.3/quill.bubble.css" rel="stylesheet">
        
           <!-- Font Awesome -->
<link href="${pageContext.request.contextPath}/kext/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/kext/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="${pageContext.request.contextPath}/kext/css/mdb.min.css"
	rel="stylesheet">
<!-- Your custom styles (optional) -->
<link href="${pageContext.request.contextPath}/kext/css/style.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/kext/css/sidebar.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	
</head>
<body>

<%@include file="navBarAndSideBar.jsp"%>
 <main class="pt-4 mx-lg-5" id="blur">
<div class="conatiner-fluid">
    <div class="row mt-10">
    <div class="col-md-1"></div>
        <div class="col-md-10">
<div class="card mt-5 mb-5">

    <!-- Card body -->
    <div class="card-body ml-3">

        <!-- Default form subscription -->
<form:form action="saveDiscussion" modelAttribute="ClassDiscussionModel" method="POST" onsubmit="collectdata()">
            <p class="h4 text-center py-4">Start Discussion here</p>

            <!-- Default input name -->
            <label for="defaultFormCardNameEx" class="font-weight-light">Topic</label>
            <form:input type="text" path="title" id="defaultFormCardNameEx" cssClass="form-control"/>
            
            <br>

            <!-- Default input email -->
            <label for="defaultFormCardEmailEx" class="font-weight-light">Content</label>
			 <form:hidden path="content" id="contentid" cssClass="form-control"/>
	
			<div id="toolbar"></div>
			<div id="editor" style="height: 200px"></div>
			
            <div class="text-center py-4 mt-3">
                <button class="btn btn-outline-primary" type="submit" onclick="startDiscussion()">Post<i class="fa fa-paper-plane-o ml-2"></i></button>
            </div>
            
            <div style="display:none">
            <input type="submit" value="ISSUE" id="submitDiscussion"/>
            </div>
            
        </form:form>
        <!-- Default form subscription -->

    </div>
    <!-- Card body -->
               </div>       
  </div>
  </div>
  </div>
  </main>



<!-- 

<h1>Class Discussions</h1>

<hr>

<h2>Start New Discussion here...</h2>
		<form:form action="saveDiscussion" modelAttribute="ClassDiscussionModel" method="POST" onsubmit="collectdata()">

			<label>Title</label><br>
			<form:input path="title"/><br><br>
	
			<label>Content</label>
			<form:hidden path="content" id="contentid"/><br><br>
	
			<div id="toolbar"></div>
			<div id="editor"></div><br>
			
			<input type="submit" value="POST"/>
		</form:form>
-->
<script>
function startDiscussion()
{
	$('#submitDiscussion').click();
}



            var toolbarOptions =[
                ['bold','italic','underline','strike'], 
                ['blockquote','code-block'],
                [{'header' : [1,2,3,4,5,6,false] }],
                [{'list': 'ordered'},{'list': 'bullet'}],
                [{'script': 'sub'},{'script': 'super'}],
                [{'indent': '-1'},{'indent': '+1'}],
                [{'direction': 'rtl'}],
                [{'size': ['small',false,'large','huge']}],
                ['link','image','video','formula'],
                [{'align': []}]
            ];
            
            var config = {
                "theme": "snow",
                "modules": {
                "toolbar": toolbarOptions
  				},
                "placeholder": 'Write your post here...'
			};
           
           	var quill=new Quill('#editor',config);
           	
           	function collectdata()
           	{
           		document.getElementById("contentid").value=JSON.stringify(quill.getContents());
           	}
           	
          
             
</script>
</body>
</html>