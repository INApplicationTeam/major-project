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
</head>
<body>
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

<script>
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