<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" type="image/png" href="MDB Free/img/img1.png" />
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    
    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui.css">
    
    <script src="https://cdn.quilljs.com/1.2.3/quill.js"></script>
    <script src="https://cdn.quilljs.com/1.2.3/quill.min.js"></script>
    <link href="https://cdn.quilljs.com/1.1.3/quill.snow.css" rel="stylesheet">
    <link href="https://cdn.quilljs.com/1.1.3/quill.bubble.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/../images/logo.png" /> 
    <title>Korero</title>
    <script>
    $(document).ready(function() {
	$(function() {
		$("#search").autocomplete({

			source : function(request, response) {
				$.ajax({
					url : "../../SearchAutoComplete",
					type : "get",
					data : {
						term : request.term
					},
					dataType : "json",
					success : function(data) {
						response(data);
					}
				});
			}
                         
		});
	});
        
        
});
    
	</script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/MDB Free/font-awesome-4.7.0/css/font-awesome.min.css">

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/MDB Free/css/bootstrap.min.css" rel="stylesheet">

    <!-- Material Design Bootstrap -->
    <link href="${pageContext.request.contextPath}/MDB Free/css/mdb.min.css" rel="stylesheet">
    
    <link href="${pageContext.request.contextPath}/MDB Free/css/quepage.css" rel="stylesheet">

    <!-- Template styles -->
    <style rel="stylesheet">
        /* TEMPLATE STYLES */
        
        main {
            padding-top: 25px;
            padding-bottom: 2rem;
        }
        
        .widget-wrapper {
            padding-bottom: 2rem;
            border-bottom: 1px solid #e0e0e0;
            margin-bottom: 2rem;
        }
                
        footer.page-footer {
            background-color: #53463d;
            margin-top: 2rem;
         
        }
        
  
  		#editor{
		  font-family: "roboto";
		  font-size: 21px;
		  font-weight: 300;
		 
		}
		
		.editorans{
		  font-family: "roboto";
		  font-size: 21px;
		  font-weight: 300;
		  word-break: break-word;
		}
		
		b, strong {
    	  font-weight: bold;
		}


		pre{
		 font-size: 90%;
		}

		.ql-snow .ql-editor img {
    	 max-width: 50%;
         max-height: 50%;
        }
    </style>
 
</head>

<body>
    <script>
    
   var ansIndex=0;
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
        "placeholder": 'Write your answer here...'
	};
    console.log(typeof toolbarOptions);
    var quill;
   
   var configForShow = {
           "theme": "snow",
           "modules": {
           "toolbar": false
}
           
};
       var quillShow;
       function instantiateEditor(i)
       {
       quillShow=new Quill('#editor'+i,configForShow);
  	}

   
    
  //  var quill=new Quill('#editor',config);
    //quill.enable(false)

    	var isviewed=[];
        var utype='${utype}';
            
            
function setReportButton(x)
{
    var repClass=document.getElementsByClassName("report");
   
    if(utype==="faculty")
    {
    	repClass[x].innerHTML="DELETE";
    }
}

    </script>

    <header>

        <!--Navbar-->
        <nav class="navbar fixed-top navbar-toggleable-md navbar-dark bg-info" >
            <div class="container" >
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarNav1" aria-controls="navbarNav1" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                 <a class="navbar-brand" href="../../MyFeed">
                <img src="${pageContext.request.contextPath}/MDB Free/img/logo.png" class="img-fluid" style="width: 180px">
            </a>
                <div class="collapse navbar-collapse" id="navbarNav1">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="../../MyFeed">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../../MyProfile">Profile</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../../Post_Question.jsp">Ask a question</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../../AboutUs.jsp">About Us</a>
                        </li>
                        
                        
                    </ul>
                
                    
                    <ul class="navbar-nav ml-auto">
                    <form class="form-inline waves-effect waves-light navbar-form navbar-right" action="AskQuestion" role="search">
                        <input class="form-control" type="text" placeholder="Search -- Question,  @Username,  #Workspaces" id="search" name="search" style="width:400px"  >
                       <button type="submit" class="btn btn-info btn-sm" >
								<i class="fa fa-search"></i><div class="ripple-container"></div>
							</button>
                    </form>

                        
                      
                
                    </ul>
                    </div>
            </div>
        </nav>
	    <!--/.Navbar-->

    </header>

    <main class="mt-3" style="margin-right: 0px;">

        <!--Main layout-->
        <div class="container" style="margin-left: 60px;margin-right:0px;">
            <div class="row">

                <!--Main column-->
                <div class="col-lg-9">
                <!--Jumbotron-->
                <c:if test="${not empty question}">
                    <div class="jumbotron">
                        <mark> <a href="../../UserProfile?uid=${question.userModel.uid}">${question.userModel.uname}</a> asked
                        </mark>
                        <h1 class="h1-responsive"><strong>${question.que}</strong></h1>
                        <hr class="my-2">
                        <p>On date ${question.timestamp} in <mark class="mr-2"><a href="../../WorkSpaceContent?did=${question.domain.did}&dname=${question.domain.dname}">${question.domain.dname}</a></mark>
                        </p>
                        
                        <p>
                            <c:forEach var="tag" items="${question.tags}">
                        		<span class=" orange badge badge-primary" >${tag.kname}</span>
                        	</c:forEach>
                        </p>
                      <button class="btn btn-info btn-sm" onclick="show()" id="ansbtn" style="font-size: 16px"></button>	<button class="btn btn-info btn-sm" id="followbtn" style="font-size: 16px" onclick="followQuestion('${question.qid}')"></button>
                        <form style="display: none" id="answerarea">
                            <div id="toolbar"></div>
                            <div id="editor"></div>
                            <div style="text-align: center"> <input  type="button" class="btn btn-info btn-md" name="submit" style="font-size: 20px" value="POST ANSWER" id="subAns" /></div>
                        </form>
                    </div>
                        
                    <!--/.Jumbotron-->
                    <!--Post-->
                 
                  <script> quill=new Quill('#editor',config);</script>
       
                    <c:forEach var="answer" items="${question.answers}" begin="0" varStatus="answerLoop">    
                  
						<c:if test="${answer.userModel.uid == isAnswered.userModel.uid}">
            				<c:set var="ansIndex" value="${answerLoop.index}" scope="request"/>
		
            				<script>
            					ansIndex='${answerLoop.index}';
                				document.getElementById("answerarea").setAttribute("action","../../PostAnswer?ansindex=${answerLoop.index}");
            				</script>
            			</c:if>
                    
                    <div class="post-wrapper wow fadeIn" data-wow-delay="0.2s">
                        <div class="col-md-12">
                            <!--First review-->
                            <div class="media mb-1">
                                <a class="media-left waves-light">
                                    <img class="rounded-circle" src="<%="../../ImageLoader?uid="%>${answer.userModel.uid}"  alt="Generic placeholder image" class="img-circle img-responsive" style="width:100px; height: 100px;">
                                </a>
                                <div class="media-body">
                                    <h5 class="media-heading"><a href="../../UserProfile?uid=${answer.userModel.uid}">${answer.userModel.uname}</a></h5>
                                    <small class="text-muted">answered on ${answer.timestamp}</small>
                                    <br><br>
                                    <p>
                                        <div class="toolbarans" id="toolbar${answerLoop.index}"></div>
                                        <div class="editorans" id="editor${answerLoop.index}"></div>
                                        <br><br>
                                    </p>
                                    VIEWS
                                    <span class="viewcount">${answer.views}</span>
                                    <button value="upvote&qid=${question.qid}&uid=${answer.userModel.uid}&index=${answerLoop.index}" class="up btn btn-info" onclick="upvote(${answerLoop.index})"><i class="fa fa-smile-o"></i>&nbsp;&nbsp;Voilà!</button>
                                    <span class="upvotecount">${answer.upvotes}</span>
                                    <button value="downvote&qid=${question.qid}&uid=${answer.userModel.uid}&index=${answerLoop.index}"  class=" down btn btn-unique" onclick="downvote(${answerLoop.index})"><i class=" fa fa-meh-o"></i>&nbsp;&nbsp;Bléh!</button>
                                    <span class="downvotecount">${answer.downvotes}</span>
                                    <button value="qid=${question.qid}&uid=${answer.userModel.uid}" class="report btn btn-danger " onclick="report(${answerLoop.index})">REPORT ABUSE <i class="fa fa-ban float-right"></i></button>    
                                    <input type="text" style="display:none" value="&uid=${answer.userModel.uid}&views=${answer.views}" id="hiddenanswer${answerLoop.index}"/>
                                    <script>
                                    	setReportButton('${answerLoop.index}'); 
                                    	var view=${answer.viewed};
                                    	isviewed.push(view); 
                                    </script>
                                </div>
                            </div>
                        </div>
                    </div>
                        <!--/.Post-->
<hr>
						<script>
						    var indexOfAnswer=${answerLoop.index};
							instantiateEditor(indexOfAnswer);
        					var ansText=${answer.answer};
							quillShow.setContents(ansText);
        					quillShow.enable(false);
        				</script>
					</c:forEach>
                 </c:if>
                  <c:if test="${empty question}">
                  	<p>NO PAGE FOUND</p>
                  </c:if>

                
<hr>
<!--                        Pagination
                    <nav>
                        <ul class="pagination flex-center pg-dark  wow fadeIn" data-wow-delay="0.2s">
                            Arrow left
                            <li class="page-item">
                                <a class="page-link" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                    <span class="sr-only">Previous</span>
                                </a>
                            </li>

                            Numbers
                            <li class="page-item active"><a class="page-link">1</a></li>
                            <li class="page-item"><a class="page-link">2</a></li>
                            <li class="page-item"><a class="page-link">3</a></li>
                            <li class="page-item"><a class="page-link">4</a></li>
                            <li class="page-item"><a class="page-link">5</a></li>

                            Arrow right
                            <li class="page-item">
                                <a class="page-link" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                    /.Pagination-->

                </div>

<!--           Sidebar-->
                <div class="col-lg-3" style="max-width: 100%;">

                   <div class="widget-wrapper wow fadeIn" id="stck" data-wow-delay="0.4s">
                        <h4 id="stck">Related Questions:</h4>
                        <br>
                      
                        <c:forEach var="relQues" items="${RelatedQuestions}">
                        	<div class="card card-block">
                           
                            	<a href="allAnswers?qid=${relQues.qid}">${relQues.que}</a>
                          
                        	</div>
                        </c:forEach>
                     
                   </div> 
                </div>
<!--                /.Sidebar-->
            </div>
        </div>
        <!--/.Main layout-->

    </main>

   


    <!-- SCRIPTS -->
    <!-- JQuery -->
<!--    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>-->

    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/MDB Free/js/tether.min.js"></script>

    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/MDB Free/js/bootstrap.min.js"></script>

    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/MDB Free/js/mdb.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/MDB Free/js/sticky/jquery.sticky.js"></script>

    <script>
    new WOW().init();
    </script>
  <script type="text/javascript">
    $(window).load(function(){
      $("#stck").sticky({ topSpacing: 70 });
    });
    </script>
    
    <script>
            
            var index;
            
            
function getXmlHttpRequestObject()
{
var xmlHttpReq;

if(window.XMLHttpRequest){
    request=new window.XMLHttpRequest();
}
else if(window.ActiveXObject){
    request=new window.ActiveXObject();
}
else{
    request=null;
}
return request;
}

function upvote(x)
{   
    index=x;
    var up=document.getElementsByClassName("up");
    var val=up[x].value;
    request=getXmlHttpRequestObject();
    request.onreadystatechange=showVoteCount;
    request.open("post","../../UpDown",true);
    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");
    
    var data="uvote="+val;
    request.send(data);
}

function downvote(x)
{   
    index=x;
    var down=document.getElementsByClassName("down");
    var val=down[x].value;
    request=getXmlHttpRequestObject();
    request.onreadystatechange=showVoteCount;
    request.open("post","../../UpDown",true);
    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");
    
    var data="uvote="+val;
    request.send(data);
}

function report(x)
{
    
    var rep=document.getElementsByClassName("report");
    var val=rep[x].value;
    var type="";
    var yo=rep[x].innerHTML;
    request=getXmlHttpRequestObject();
    request.onreadystatechange=showAlert;
    request.open("post","../../ReportAnswer",true);
    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");
    if(yo.search("DELETE")!==-1)
        type="faculty";
    
    else if(yo.search("REPORT ABUSE")!==-1)
        type="student";
    
    val=val+"&type="+type+"&index="+x;
    var data=val;
    request.send(data);
    
}

function showVoteCount()
{
    if(request.readyState===4 && request.status===200){
        var up=document.getElementsByClassName("upvotecount");
        var down=document.getElementsByClassName("downvotecount");
        var updowncount=JSON.parse(request.responseText);
        up[index].innerHTML=updowncount.uvotes;
        down[index].innerHTML=updowncount.dvotes;
    }
}

function showAlert()
{
    if(request.readyState===4 && request.status===200){
       alert(request.responseText);
       location.reload();
    }
    
}

var isfollowed=${isFollowed}; 

console.log("hello");
var id=document.getElementById("followbtn");

if(isfollowed==true)
{
	id.innerHTML="FOLLOWED";
}
else
{
	id.innerHTML="FOLLOW";
}	


function followQuestion(qid)
{
	console.log(qid);
    request=getXmlHttpRequestObject();
    request.onreadystatechange=queFollowed;
    request.open("post","../../FollowQuestion",true);
    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");
    
    var data="qid="+qid+"&isfollowed="+isfollowed;
    request.send(data);
}

function queFollowed()
{
	if(request.readyState===4 && request.status===200)
	{
	       var data=request.responseText;
	       console.log(data);
	       if(data.trim()=="follow")
	       {
	    	   isfollowed=true;
	    	   document.getElementById("followbtn").innerHTML="FOLLOWED";
	       }
	       else if(data.trim()=="unfollow")
	       {
	    	   isfollowed=false;
	    	   document.getElementById("followbtn").innerHTML="FOLLOW";
	       }
	}
	
}
</script>


<script>      
      var TT;
      
       $('#subAns').click(function(){
        
        window.delta=quill.getContents();
		var content="";
		for(var i=0;i<delta.ops.length;i++)
		{
			var del=delta.ops[i];
			content=content+del.insert;
		}
	
		if(content.replace(/\n/g, '').trim().length===0)
		{
			
			alert("You Cannot Post Empty Answer...!!!!");
		}
		else
		{	
         $.ajax({
        url: "../../PostAnswer?ansindex="+ansIndex+"&btnvalue="+document.getElementById("subAns").value+"&qid=${question.qid}&que=${question.que}&queUserId=${question.userModel.uid}",
        type: 'POST',
        dataType: 'json',
        data: JSON.stringify(delta),
        contentType: 'application/json',
        mimeType: 'application/json',
        success : function(data) {
        	
        	websocket.send(JSON.stringify(data));
            alert("Answer Posted Successfully...!!!");
            window.location="allAnswers?qid=${question.qid}";
            
        //quill.setContents({"ops": [{"insert": "\n"}]});
	}
        });
		}

       });
           
        
        </script>
        
        
        
        <script>
        checkFlag();
        function checkFlag()
        {
            var flag='${flag}';
            if(flag==="true")
                document.getElementById("ansbtn").innerHTML="EDIT ANSWER";
            else if(flag==="false")
                document.getElementById("ansbtn").innerHTML="WRITE ANSWER";
        }
        function show()
        {
         	<c:if test="${not empty isAnswered}">
        		var answerText=${isAnswered.answer};
         		quill.setContents(answerText);
         	</c:if>
         	
           if(document.getElementById("answerarea").style.display==="none")
        {
           document.getElementById("answerarea").style.display="block";
           
            if(document.getElementById("ansbtn").innerHTML.search("EDIT ANSWER")!=-1)
            {
              document.getElementById("subAns").value="UPDATE ANSWER";
            }
        }
        else if(document.getElementById("answerarea").style.display==="block")
        {
            
            document.getElementById("answerarea").style.display="none";
        }
        
}
    </script>
    
    <!--now for showing answers-->
    

       <script>
					            var elements = document.querySelectorAll(".editorans");
								var length = elements.length;
								
								var flag= new Array(length);
        function reveal()
        {

            for(var count = 0; count < length; count++)
           {
               /* offsetParent may not be the body if the element container is positioned. Therefore we need to find the distance from the body by adding all the offsetTop's of all offsetParent's.  */
              var offsetParentTop = 0;
               var temp = elements[count];
			var temp1 = elements[count];
			var outerheight=$(temp1).outerHeight(true);
			//console.log(outerheight);
               do
               {
                   if(!isNaN(temp.offsetTop))
                   {
                        offsetParentTop += temp.offsetTop;
                   }
               }while(temp = temp.offsetParent);
               
			//   console.log("parent"+offsetParentTop);
               var pageYOffset = window.pageYOffset;
               var viewportHeight = window.innerHeight;       
               
               if( offsetParentTop < (pageYOffset + viewportHeight) && flag[count]== undefined && (offsetParentTop + outerheight >= pageYOffset || offsetParentTop > pageYOffset))
               {	flag[count]= true;
                   console.log(elements[count].id+ " is visible");
				   window.setTimeout(isViewed,1000,count);
                }
				else if(flag[count]==true && ((offsetParentTop + outerheight) <= pageYOffset || offsetParentTop>=pageYOffset+viewportHeight))
				{
				    flag[count]= undefined;
					console.log(elements[count].id+ " is out of view");
				}
            }
        }
        
        /* Attach event handlers to resize and scroll event */
        window.addEventListener("resize",reveal);
        window.addEventListener("scroll",reveal);
		
        var countIndex;
		function isViewed(count)
		{
			if(flag[count]==true)
			{
				if(isviewed[count]==false)
				{
					countIndex=count;
					countAsView(count);
					console.log("This Is Viewed-->>"+count);
				}
			
				else
				console.log("Already Viewed-->>"+count);
			}
			else
				console.log("This Is Not Viewed-->>"+count);
		}
		
		
		function countAsView(x)
		{   
		    var val=x
		    
		    request=getXmlHttpRequestObject();
		    request.onreadystatechange=viewed;
		    request.open("post","../../CountAsView",true);
		    request.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");
		    var data="index="+val+"&qid=${question.qid}";
		    data=data+document.getElementById("hiddenanswer"+val).value;
		    request.send(data);
		}

		function viewed()
		{
		    if(request.readyState===4 && request.status===200)
		    {
		    	isviewed[countIndex]=true;
		        document.getElementsByClassName("viewcount")[countIndex].innerHTML=request.responseText;
		    }
		}
		
    </script>
    
   <script src="${pageContext.request.contextPath}/js/Notifications.js"></script>
</body>

</html>
