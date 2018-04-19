<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Class discussion forum</title>
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
</head>

<body class="blue-grey lighten-5">

    <!--Main Navigation-->
    <header>

        <!-- Navbar -->
        <nav class="navbar fixed-top navbar-expand-lg navbar-light white scrolling-navbar" style="margin-left: 30px;box-shadow: none;">
            <div class="container-fluid">

                <!-- Brand -->
                <a class="navbar-brand waves-effect" href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">
                    <strong class="blue-text">Korero</strong>
                </a>

                <!-- Collapse -->
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Links -->
                <div class="collapse navbar-collapse" id="navbarSupportedContent">

                    <!-- Left -->
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link waves-effect" href="#">Home
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link waves-effect" href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">About this class</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link waves-effect" href="https://mdbootstrap.com/getting-started/" target="_blank">Blogs</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link waves-effect" href="https://mdbootstrap.com/bootstrap-tutorial/" target="_blank">Notice</a>
                        </li>
                    </ul>

                    <!-- Right -->
                    <ul class="navbar-nav nav-flex-icons">
                        <li class="nav-item mr-4">
                            <form class="form-inline ml-auto">
                                <div class="md-form mt-0">
                                    <input class="form-control" type="text" placeholder="Search" aria-label="Search">
                                </div>
                            </form>
                        </li>
                        <li class="nav-item mr-2">
                            <!-- Basic dropdown -->
                            <div class="btn-group">
                                <a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-bell"></i>
                                </a>

                                <div class="dropdown-menu dropdown-pull-right">
                                    <a class="dropdown-item" href="#">Action</a>
                                    <a class="dropdown-item" href="#">Another action Another action Another action Another action</a>
                                    <a class="dropdown-item" href="#">Something else here</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#">Separated link</a>
                                </div>
                            </div>
                
                            </a>
                        </li>
                    </ul>

                </div>

            </div>
        </nav>
        <!-- Navbar -->

                <!-- Sidebar -->
        <div class="leftside pt-2" onmouseover="javascript:document.getElementById('blur').style.filter='blur(3px)';" onmouseout="javascript:document.getElementById('blur').style.filter='blur(0)';">
            <div class="text-center" style="padding: 10px;">
                <img src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg" class="img-fluid z-depth-1 rounded-circle" style="max-height: 150px;"  alt="Responsive image">
            </div>
            <div class="item">
                <span class="fa fa-bel"></span>
                Shreeya Nagar
            </div>
        <div class="item">
        <span class="fa fa-user"></span>
        Profile
        </div>
        <div class="item">
        <span class="fa fa-pie-chart"></span>
        Dashboard
        </div>
        <div class="item active">
        <span class="fa fa-institution"></span>
        Book Advice</div>
        <div class="item">
        <span class="fa fa-bar-chart-o"></span>
        Polling</div>
        <div class="item">
        <span class="fa fa-graduation-cap"></span>
        Class Discussion</div> 
        </div>
                <!-- Sidebar -->

    </header>
    <!--Main Navigation-->

    <!--Main layout-->
    <main class="pt-4 mx-lg-5" id="blur">
        <div class="container-fluid mt-5 pt-3 ml-3 pr-0">

            <!-- Heading -->
            <div class="card wow fadeIn">

                <!--Card content-->
                <div class="card-body d-sm-flex justify-content-between py-3">

                    <h4 class="mb-2 mb-sm-0">
                        <a href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">CS-B/</a>
                        <span>
                        <!-- Split button -->
                        <div class="btn-group">
                            <a class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                8th sem
                                <span class="sr-only">Toggle Dropdown</span>
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="#">Action</a>
                                <a class="dropdown-item" href="#">Another action</a>
                                <a class="dropdown-item" href="#">Something else here</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">Separated link</a>
                            </div>
                        </div>
                        </span>
                    </h4>
                    <button type="button" class="btn btn-outline-primary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Create poll</button>
                    <button type="button" class="btn btn-outline-default waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Start Discussion</button>
                    <button type="button" class="btn btn-outline-secondary waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Add event</button>
                    <button type="button" class="btn btn-outline-success waves-effect my-0 btn-md mx-0"><i class="fa fa-plus pr-1" aria-hidden="true"></i>Ask Question</button>
<!--                   <form class="d-flex justify-content-center">
                        <input type="search" placeholder="Type your query" aria-label="Search" class="form-control">
                        <button class="btn btn-primary btn-sm my-0 p" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                 </form>
-->
                    <div>
                    <a href=""><i class="fa fa-thumb-tack" aria-hidden="true"></i> My Saved Posts&nbsp;&nbsp;</a>
                    <a href=""><i class="fa fa-circle" aria-hidden="true"></i> My Posts</a>
                    </div>
                </div>
            </div>
            <!-- Heading -->

            <!--Grid row-->
            <div class="row wow fadeIn">

                
                <div class="col-md-9">
                 <!--Carousel Wrapper-->
                <div id="carousel-example-1z" class="carousel slide carousel-fade" data-ride="carousel">
                    <!--Indicators-->
                    <ol class="carousel-indicators">
                        <li data-target="#carousel-example-1z" data-slide-to="0" class="active" style="background-color: black;"></li>
                        <li data-target="#carousel-example-1z" data-slide-to="1" style="background-color: black;"></li>
                        <li data-target="#carousel-example-1z" data-slide-to="2" style="background-color: black;"></li>
                    </ol>
                    <!--/.Indicators-->
                    <!--Slides-->
                    <div class="carousel-inner" role="listbox">
                        <!--First slide-->
                        <div class="carousel-item active">
                        <div class="widget-wrapper wow fadeIn" data-wow-delay="0.4s">
                        <br>
                        <div class="card-deck">
                        <!-- Card -->
                        <div class="card card-image">
                            <!-- Content -->
                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
                                <div>
                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
                                    <h3 class="card-title pt-2"><strong>This is card title</strong></h3>
                                    <p>Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a class="btn btn-primary"><i class="fa fa-clone left"></i> View Notice</a>
                                </div>
                            </div>
                            <!-- Content -->
                        </div>
                        <!-- Card -->
                        <!-- Card -->
                        <div class="card card-image">
                            <!-- Content -->
                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
                                <div>
                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
                                    <h3 class="card-title pt-2"><strong>This is card title</strong></h3>
                                    <p>Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a class="btn btn-primary"><i class="fa fa-clone left"></i> View Notice</a>
                                </div>
                            </div>
                            <!-- Content -->
                        </div>
                        <!-- Card -->
                        <!-- Card -->
                        <div class="card card-image">
                            <!-- Content -->
                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
                                <div>
                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
                                    <h3 class="card-title pt-2"><strong>This is card title</strong></h3>
                                    <p>Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a class="btn btn-primary"><i class="fa fa-clone left"></i> View Notice</a>
                                </div>
                            </div>
                            <!-- Content -->
                        </div>
                        <!-- Card -->

                        </div>
                        </div>
                        </div>
                        <!--/First slide-->
                        <!--Second slide-->
                        <div class="carousel-item">
                        <div class="widget-wrapper wow fadeIn" data-wow-delay="0.4s">
                        <br>
                        <div class="card-deck">
                        <!-- Card -->
                        <div class="card card-image">
                            <!-- Content -->
                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
                                <div>
                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
                                    <h3 class="card-title pt-2"><strong>This is card title</strong></h3>
                                    <p>Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a class="btn btn-primary"><i class="fa fa-clone left"></i> View Notice</a>
                                </div>
                            </div>
                            <!-- Content -->
                        </div>
                        <!-- Card -->
                        <!-- Card -->
                        <div class="card card-image">
                            <!-- Content -->
                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
                                <div>
                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
                                    <h3 class="card-title pt-2"><strong>This is card title</strong></h3>
                                    <p>Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a class="btn btn-primary"><i class="fa fa-clone left"></i> View Notice</a>
                                </div>
                            </div>
                            <!-- Content -->
                        </div>
                        <!-- Card -->
                        <!-- Card -->
                        <div class="card card-image">
                            <!-- Content -->
                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
                                <div>
                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
                                    <h3 class="card-title pt-2"><strong>This is card title</strong></h3>
                                    <p>Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a class="btn btn-primary"><i class="fa fa-clone left"></i> View Notice</a>
                                </div>
                            </div>
                            <!-- Content -->
                        </div>
                        <!-- Card -->

                        </div>
                    </div>
                        </div>
                        <!--/Second slide-->
                        <!--Third slide-->
                        <div class="carousel-item">
                        <div class="widget-wrapper wow fadeIn" data-wow-delay="0.4s">
                        <br>
                        <div class="card-deck">
                        <!-- Card -->
                        <div class="card card-image">
                            <!-- Content -->
                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
                                <div>
                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
                                    <h3 class="card-title pt-2"><strong>This is card title</strong></h3>
                                    <p>Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a class="btn btn-primary"><i class="fa fa-clone left"></i> View Notice</a>
                                </div>
                            </div>
                            <!-- Content -->
                        </div>
                        <!-- Card -->
                        <!-- Card -->
                        <div class="card card-image">
                            <!-- Content -->
                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
                                <div>
                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
                                    <h3 class="card-title pt-2"><strong>This is card title</strong></h3>
                                    <p>Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a class="btn btn-primary"><i class="fa fa-clone left"></i> View Notice</a>
                                </div>
                            </div>
                            <!-- Content -->
                        </div>
                        <!-- Card -->
                        <!-- Card -->
                        <div class="card card-image">
                            <!-- Content -->
                            <div class="text-center d-flex align-items-center rgba-white-light py-5 px-4">
                                <div>
                                    <h5 class="primary-text"><i class="fa fa-newspaper-o"></i> Notice</h5>
                                    <h3 class="card-title pt-2"><strong>This is card title</strong></h3>
                                    <p>Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a class="btn btn-primary"><i class="fa fa-clone left"></i> View Notice</a>
                                </div>
                            </div>
                            <!-- Content -->
                        </div>
                        <!-- Card -->

                        </div>
                    </div>
                        </div>
                        <!--/Third slide-->
                    </div>
                    <!--/.Slides-->
                    <!--Controls-->
                    <a class="carousel-control-prev" href="#carousel-example-1z" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true" style="background-color: black"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carousel-example-1z" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true" style="background-color: black"></span>
                        <span class="sr-only">Next</span>
                    </a>
                    <!--/.Controls-->
                </div>
                <!--/.Carousel Wrapper-->
                    <!--CARD 1 -->
                    <div class="card mb-3 mt-3">
                        <div class="card-body pb-0">
                            <small>
                                <a href="">Shreeya Nagar</a> posted on 12:12:12 in <a href="">Computer science</a>
                                <i class="fa fa-eye float-right mr-2 ml-1" aria-hidden="true"> 18</i>
                                <a class="blue-text"><i class="fa fa-thumb-tack float-right blue-text mr-2" aria-hidden="true"></i></a>
                                <a class="blue-text"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
                            </small>
                            <h4 style="font-size: 24px;" class="mt-2"><a>When will be the Mid Semester exams?</a></h4>
                            <div class="white" style="border-style: round;border-radius: 20px;display: inline-block;">
                                <img src="https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg" class="avatar img-fluid z-depth-1 rounded-circle" alt="Responsive image" />
                                <a class="pl-1" href="">Rohit Jangid</a><small> answered</small>
                            </div>
                            <p class="pl-5">Some quick example text to build on the card title and make up the bulk of the card's content. Some quick example text to build on the card title and make up the bulk of the card's content.
                                <a class="blue-text"><i class="fa fa-angle-double-right pl-2"></i> More</a>
                            </p>
                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2">
                            <a><i class="fa fa-thumbs-o-up pl-4" aria-hidden="true"></i> 55</a>
                            <a><i class="fa fa-thumbs-o-down ml-4" aria-hidden="true"></i> 4</a>
                            <a onclick="showComments('first',this.id)" id='firsthide' class="float-right blue-text"><i class="fa fa-angle-double-down ml-4" aria-hidden="true"></i><small> more answers</small></a>
                            <a><i class="fa fa-angle-double-up float-right blue-text" aria-hidden="true" id="first" onclick="closeComments('first','firsthide')" style="display: none;"> less</i></a>                            
                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2 first" style="display: none;font-size: 15px;">
                            <div class="media d-block d-md-flex mt-2 ml-5">
                                <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (20).jpg" alt="Generic placeholder image">
                                <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                    <a class="mt-0 blue-text">Miley Steward</a>
                                    <a class="mt-0 blue-text pull-right"><i class="fa fa-reply" aria-hidden="true"></i></a>

                                    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
                                    sunt in culpa qui officia deserunt mollit anim id est laborum.

                                    <div class="media d-block d-md-flex mt-3">
                                        <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (27).jpg" alt="Generic placeholder image">
                                        <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                            <a class="mt-0 blue-text">Tommy Smith</a>
                                            Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo
                                            inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
                                        </div>
                                    </div>
                                    <div class="media d-block d-md-flex mt-3">
                                        <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (21).jpg" alt="Generic placeholder image">
                                        <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                            <a class="mt-0 blue-text">Sylvester theaat</a>
                                            Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt
                                            ut labore et dolore magnam aliquam quaerat voluptatem.
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="media d-block d-md-flex mt-2 ml-5 mb-3">
                                <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (30).jpg" alt="Generic placeholder image">
                                <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                    <a class="mt-0 blue-text">Caroline Horwaz</a>
                                    <a class="mt-0 blue-text pull-right"><i class="fa fa-reply" aria-hidden="true"></i></a>
                                    At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias
                                    excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.
                                </div>
                            </div>
                            <div class="form-group ml-5 mb-4">
                                <label for="replyFormComment">Your comment</label>
                                <textarea class="form-control" id="replyFormComment" rows="3"></textarea>
                            </div>
                        </div>
                    </div>
                    <!-- Card 1 ends-->
                    <!--CARD 1 -->
                    <div class="card mb-3">
                        <div class="card-body pb-0">
                            <small>
                                <a href="">Shreeya Nagar</a> created this poll on 12:12:12 for <a href="">CS-B</a>
                                <i class="fa fa-eye float-right mr-2 ml-1" aria-hidden="true"> 18</i>
                                <a class="blue-text"><i class="fa fa-thumb-tack float-right blue-text mr-2" aria-hidden="true"></i></a>
                                <a class="blue-text"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
                            </small>
                            <strong>
                            <h4 style="font-size: 24px;" class="mt-2"><a>When will be the Mid Semester exams?</a></h4>                                
                            </strong>
                            <div class="row mb-2">
                                <div class="col-md-11 pr-0">
                                    <div class="progress" style="height: 25px;border-bottom-right-radius: 0px;border-top-right-radius: 0;">
                                        <div class="progress-bar" role="progressbar" style="width: 0;" data-percentage="0" aria-valuemin="0" aria-valuemax="100">
                                            <div style="position: absolute;float: left;margin-left: 20px;font-size: 20px;">
                                                <strong class="black-text">28 march</strong>
                                            </div>
                                        </div>
                                    </div>                                    
                                </div>
                                <div class="col-md-1 pl-0">
                                    <span class="badge cyan" style="font-size: 18px;display: block;"><strong>0%</strong></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-11 pr-0 pb-4">
                                    <div class="progress" style="height: 25px;border-bottom-right-radius: 0px;border-top-right-radius: 0;">
                                        <div class="progress-bar success" role="progressbar" style="width: 0%" data-percentage="90" aria-valuemin="0" aria-valuemax="100">
                                            <div style="position: absolute;float: left;margin-left: 20px;font-size: 20px;">
                                                <strong class="black-text">28 march</strong>
                                            </div>                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-1 pl-0">
                                    <span class="badge cyan" style="font-size: 18px;display: block;"><strong>90%</strong></span>
                                </div>
                            </div>
                        </div>
                    </div>
                     <!--CARD 1 -->
                    <!--CARD 1 -->
                    <div class="card mb-3">
                        <div class="card-body pb-0">
                            <small>
                                <a href="">Shreeya Nagar</a> created this poll on 12:12:12 for <a href="">CS-B</a>
                                <i class="fa fa-eye float-right mr-2 ml-1" aria-hidden="true"> 18</i>
                                <a class="blue-text"><i class="fa fa-thumb-tack float-right blue-text mr-2" aria-hidden="true"></i></a>
                                <a class="blue-text"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
                            </small>
                            <strong>
                            <h4 style="font-size: 24px;" class="mt-2"><a>When will be the Mid Semester exams2?</a></h4>                                
                            </strong>
                            <div class="row mb-2">
                                <div class="col-md-12 pr-3 pb-4 pt-1">
                                    <button type="button" class="btn btn-default btn-lg btn-block pb-2 pt-2 mb-2"><i class="fa fa-mail-forward pull-left" aria-hidden="true"></i>Block level button</button>
                                    <button type="button" class="btn btn-light-blue btn-lg btn-block pb-2 pt-2"><i class="fa fa-mail-forward pull-left" aria-hidden="true"></i>Block level button</button>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                     <!--CARD 1 -->

                    <div class="card mb-3">
                        <div class="card-body pb-2">
                            <small>
                                <a href="">Shreeya Nagar</a> initiated discussion on 12:12:12
                                <i class="fa fa-eye float-right mr-2 ml-1" aria-hidden="true"> 18</i>
                                <a class="blue-text"><i class="fa fa-thumb-tack float-right blue-text mr-2" aria-hidden="true"></i></a>
                                <a class="blue-text"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
                            </small>
                            <h4 style="font-size: 24px;" class="mt-2"><a>When will be the Mid Semester exams?</a></h4>
                            <small class=""><strong>Description: </strong>Some quick example text to build on the card title and make up the bulk of the card's content. Some quick example text to build on the card title and make up the bulk of the card's content.
                            </small>
                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2">
                            <a><i class="fa fa-thumbs-o-up pl-4" aria-hidden="true"></i> 55</a>
                            <a><i class="fa fa-thumbs-o-down ml-4" aria-hidden="true"></i> 4</a>
                            <a onclick="showComments('second',this.id)" id='firsthide' class="float-right blue-text"><i class="fa fa-angle-double-down ml-4" aria-hidden="true"></i><small> more answers</small></a>
                            <a><i class="fa fa-angle-double-up float-right blue-text" aria-hidden="true" id="second" onclick="closeComments('second','secondhide')" style="display: none;"> less</i></a>                            
                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2 second" style="display: none;font-size: 15px;">
                            <div class="media d-block d-md-flex mt-2 ml-5">
                                <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (20).jpg" alt="Generic placeholder image">
                                <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                    <a class="mt-0 blue-text">Miley Steward</a>
                                    <a class="mt-0 blue-text pull-right"><i class="fa fa-reply" aria-hidden="true"></i></a>

                                    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
                                    sunt in culpa qui officia deserunt mollit anim id est laborum.

                                    <div class="media d-block d-md-flex mt-3">
                                        <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (27).jpg" alt="Generic placeholder image">
                                        <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                            <a class="mt-0 blue-text">Tommy Smith</a>
                                            Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo
                                            inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
                                        </div>
                                    </div>
                                    <div class="media d-block d-md-flex mt-3">
                                        <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (21).jpg" alt="Generic placeholder image">
                                        <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                            <a class="mt-0 blue-text">Sylvester theaat</a>
                                            Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt
                                            ut labore et dolore magnam aliquam quaerat voluptatem.
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="media d-block d-md-flex mt-2 ml-5 mb-3">
                                <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (30).jpg" alt="Generic placeholder image">
                                <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                    <a class="mt-0 blue-text">Caroline Horwaz</a>
                                    <a class="mt-0 blue-text pull-right"><i class="fa fa-reply" aria-hidden="true"></i></a>
                                    At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias
                                    excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.
                                </div>
                            </div>
                            <div class="form-group ml-5 mb-4">
                                <label for="replyFormComment">Your comment</label>
                                <textarea class="form-control" id="replyFormComment" rows="3"></textarea>
                            </div>
                        </div>
                    </div>
                    <!-- Card 1 ends-->

                    <div class="card mb-3">
                        <div class="card-body pb-2">
                            <small>
                                <a href="">Shreeya Nagar</a> created event on on 12:12:12
                                <i class="fa fa-eye float-right mr-2 ml-1" aria-hidden="true"> 18</i>
                                <a class="blue-text"><i class="fa fa-thumb-tack float-right blue-text mr-2" aria-hidden="true"></i></a>
                                <a class="blue-text"><i class="fa fa-bookmark float-right mr-3" aria-hidden="true"></i></a>
                            </small>
                            <h4 style="font-size: 24px;" class="mt-2"><a>Umang aa rha 25 ko</a></h4>
                            <small>
                                <strong>Description: </strong>Some quick example text to build on the card title and make up the bulk of the card's content. Some quick example text to build on the card title and make up the bulk of the card's content.
                            </small>
                            <div class="text-center" style='overflow:hidden; white-space:nowrap;'>
                                <strong class="pr-1 wow bounceInLeft" data-wow-delay="0.4s">21 Dec'18</strong>
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <hr style='display:inline-block; width:60%;vertical-align: middle;' />
                                <i class="fa fa-circle-o" aria-hidden="true" style="display: inline-block;vertical-align: middle;"></i>
                                <strong class="pr-1 wow bounceInRight" data-wow-delay="0.4s">21 Dec'18</strong>
                            </div>

                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2">
                            <a><i class="fa fa-thumbs-o-up pl-4" aria-hidden="true"></i> 55</a>
                            <a><i class="fa fa-thumbs-o-down ml-4" aria-hidden="true"></i> 4</a>
                            <a onclick="showComments('third',this.id)" id='firsthide' class="float-right blue-text"><i class="fa fa-angle-double-down ml-4" aria-hidden="true"></i><small> more answers</small></a>
                            <a><i class="fa fa-angle-double-up float-right blue-text" aria-hidden="true" id="third" onclick="closeComments('third','thirdhide')" style="display: none;"> less</i></a>                            
                        </div>
                        <div class="card-footer bg-transparent py-2 pl-2 first" style="display: none;font-size: 15px;">
                            <div class="media d-block d-md-flex mt-2 ml-5">
                                <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (20).jpg" alt="Generic placeholder image">
                                <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                    <a class="mt-0 blue-text">Miley Steward</a>
                                    <a class="mt-0 blue-text pull-right"><i class="fa fa-reply" aria-hidden="true"></i></a>

                                    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
                                    sunt in culpa qui officia deserunt mollit anim id est laborum.

                                    <div class="media d-block d-md-flex mt-3">
                                        <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (27).jpg" alt="Generic placeholder image">
                                        <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                            <a class="mt-0 blue-text">Tommy Smith</a>
                                            Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo
                                            inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
                                        </div>
                                    </div>
                                    <div class="media d-block d-md-flex mt-3">
                                        <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (21).jpg" alt="Generic placeholder image">
                                        <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                            <a class="mt-0 blue-text">Sylvester theaat</a>
                                            Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt
                                            ut labore et dolore magnam aliquam quaerat voluptatem.
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="media d-block d-md-flex mt-2 ml-5 mb-3">
                                <img class="d-flex mb-3 mx-auto avatar rounded-circle" src="https://mdbootstrap.com/img/Photos/Avatars/img (30).jpg" alt="Generic placeholder image">
                                <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                    <a class="mt-0 blue-text">Caroline Horwaz</a>
                                    <a class="mt-0 blue-text pull-right"><i class="fa fa-reply" aria-hidden="true"></i></a>
                                    At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias
                                    excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.
                                </div>
                            </div>
                            <div class="form-group ml-5 mb-4">
                                <label for="replyFormComment">Your comment</label>
                                <textarea class="form-control" id="replyFormComment" rows="3"></textarea>
                            </div>
                        </div>
                    </div>
                    <!-- Card 1 ends-->

                </div>
                <div class="col-md-3 mx-0 my-0 px-0 py-0">

                <ul class="list-group mt-4 ml-2 mb-4">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <h4 class="mb-0 pb-0"><strong>Pinned Posts</strong></h4>
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

        </div>
    </main>
    <!--Main layout-->
    <!-- SCRIPTS -->
    <!-- JQuery -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/kext/js/jquery-3.2.1.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/kext/js/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/kext/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/kext/js/mdb.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/kext/js/calendar.js"></script>
    <!-- Initializations -->
    <script type="text/javascript">
        $(document).ready(function() { document.getElementById("toggbt").click();});
        // Animations initialization
        new WOW().iinit();
        $('.carousel').carousel({
            interval: false
})
        // Tooltips Initialization
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
    </script>
    <script type="text/javascript">
        function showComments(postno,id) {
        var List=document.getElementsByClassName(postno);
        for (var i = 0; i <List.length; i++) {
           List[i].style.display="block";
        }
        document.getElementById(id).style.display="none";
        document.getElementById(postno).style.display="block";
        document.getElementById(postno).scrollIntoView(true);
        }
        function closeComments(postno,id) {
            var List=document.getElementsByClassName(postno);
            for (var i = 0; i <List.length; i++) {
               List[i].style.display="none";
            }
        document.getElementById(postno).style.display="none";
        document.getElementById(id).style.display="block";
        }
        function dropdown1(id1) {
    document.getElementById("dropdownMenu1").innerHTML = document.getElementById(id1).innerHTML;
}

    </script>
    <script type="text/javascript">
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

</body>

</html>