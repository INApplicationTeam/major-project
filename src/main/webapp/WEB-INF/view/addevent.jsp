<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>add Event</title>
<script src="https://cdn.quilljs.com/1.2.3/quill.js"></script>
        <script src="https://cdn.quilljs.com/1.2.3/quill.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <link href="https://cdn.quilljs.com/1.1.3/quill.snow.css" rel="stylesheet">
        <link href="https://cdn.quilljs.com/1.1.3/quill.bubble.css" rel="stylesheet">
        
          <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/kext/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/kext/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="${pageContext.request.contextPath}/kext/css/mdb.min.css" rel="stylesheet">
    <!-- Your custom styles (optional) -->
    <link href="${pageContext.request.contextPath}/kext/css/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/kext/css/sidebar.css">
        
        	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
        
        
       <style>
		
		iframe{
				width:180px;
  				height:90px;
  				float: right;
  				margin:10px;
		}	
		
		b, strong {
    			font-weight: bolder;
		}

		#eventEditor{
		  		font-family: "Roboto";
		  		font-size: 16px;
		  		font-weight: 400;
		  		word-wrap: break-word;
		}
		
		
		pre{
				font-size: 90%;
		}

		
		.ql-snow .ql-editor img {
    			max-width: 35%;
    			max-height: 35%;
		}
        
        </style>


</head>
<body class="blue-grey lighten-5">
<%@include file="navBarAndSideBar.jsp"%>

 <main class="pt-4 mx-lg-5" id="blur">
<div class="conatiner-fluid">

<div class="row mt-10">
    <div class="col-md-1"></div>
        <div class="col-md-10">
<div class="card mt-5 mb-5">

    <!-- Card body -->
    <div class="card-body">

        <!-- Default form subscription -->
	<form:form action="addEvent" modelAttribute="Events" method="POST" onsubmit=" return setFormFields()">			
            <p class="h4 text-center py-4">Create Event</p>

            <!-- Default input name -->
            <label for="defaultFormCardNameEx" class="font-weight-light">Title</label>
            <form:input path="title" type="text" id="defaultFormCardNameEx" cssClass="form-control"/>
            
            <br>
  
            <!-- Default input email -->
           <label for="defaultFormCardEmailEx" class="font-weight-light">Description</label>
			 <form:hidden path="description" id="contentid" cssClass="form-control"/>
	
			<div id="eventToolbar"></div>
			<div id="eventEditor" style="height: 200px"></div>
		
			<br/>
			
			<label for="defaultFormCardEmailEx" class="font-weight-light">Start Date</label>
			<input type="datetime-local"  id="start"/>
			 <form:hidden id="startLong" path="startdate" cssClass="form-control"/>
			 
			 
			 <label for="defaultFormCardEmailEx" class="font-weight-light">End Date</label>
			 <input type="datetime-local"  id="end"/>
			 <form:hidden id="endLong" path="enddate" cssClass="form-control"/>
			 
			 <div style="display: none">
	              <form:select path="scope" >
				<form:option value="${Events.scope}">${Events.scope}</form:option>
				</form:select>
				
				<input type="submit" value="POST EVENT" id="submitEvent" />		 
			 </div>

            <div class="text-center py-4 mt-3">
                <button class="btn btn-outline-primary" type="submit" onclick="addEvent()">Post<i class="fa fa-paper-plane-o ml-2"></i></button>
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
	<h1>CREATE EVENT</h1>
	<form:form action="addEvent" modelAttribute="Events" method="POST" onsubmit=" return setFormFields()">			
			<table>
				<tr>
					<td><label>Title</label></td>
					 <td><form:input path="title"/></td>
				</tr>
				
				<tr>
					<td><label>Description</label></td>
					<td>
						<div id="eventToolbar"></div>
						<div id="eventEditor"></div>
					</td>
					<form:hidden path="description" id="contentid"/>
				</tr>
				
				<tr>
					<td><label>Start Date</label></td>
					 <td><input type="datetime-local"  id="start"/></td>
					 <form:hidden id="startLong" path="startdate"/>
				</tr>
				
				<tr>
					<td><label>End Date</label></td>
					 <td><input type="datetime-local"  id="end"/></td>
					 <form:hidden id="endLong" path="enddate"/>
				</tr>
				<tr>
				<td><label>Scope</label></td>
				<td>
				<form:select path="scope" >
				<form:option value="${Events.scope}">${Events.scope}</form:option>
				</form:select>
				</td>
					
				</tr>
				
				
				<tr>
					<td><label></label></td>
					<td><input type="submit" value="POST EVENT" /></td>
					
				</tr>
			</table>
  
  	</form:form>
  	 -->
  	 
  	<script type="text/javascript">
  	
  	function addEvent()
  	{
  		$('#submitEvent').click();
  	}
  	
  		function setlongdates()
  		{
  			document.getElementById("startLong").value=new Date(document.getElementById("start").value).getTime();
  			document.getElementById("endLong").value=new Date(document.getElementById("end").value).getTime();
  		};
  		
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
            "placeholder": 'Write Event Description Here...'
		};
       
       	var quill=new Quill('#eventEditor',config);
       	
       	function collectdata()
       	{
       		document.getElementById("contentid").value=JSON.stringify(quill.getContents());
       	}
       	
       	function setFormFields()
       	{
       		setlongdates();
       		collectdata();
       	}
      
         
	</script>
</body>
</html>