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
        
        <style>
        a{
        	color: #0099cc;
        }
        
        img.resize {
  				max-width:15%;
  				max-height:15%;
  				float: right;
		}
		
		iframe{
				width:180px;
  				height:90px;
  				float: right;
  				margin:10px;
		}	
		.card img {
    			width: auto;
    			height: auto;
		}

		b, strong {
    			font-weight: bold;
		}

		
		pre{
				font-size: 90%;
		}

		.ql-container.ql-snow {
    			border: 1px solid #ccc;
		}

		.ql-snow .ql-editor img {
    			max-width: 35%;
    			max-height: 35%;
		}
        
        </style>

</head>
<body>
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
  	
  	<script type="text/javascript">
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