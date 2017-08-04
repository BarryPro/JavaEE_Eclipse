<div class="drop-navigation drop-navigation">
  <ul class="nav nav-sidebar">
    <li class="active"><a href="#"></a></li>
    <li class="active"><a href="#"></a></li>
    <li class="active"><a href="index.jsp" class="home-icon"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>Home</a></li>
    <li><a href="shows.jsp" class="user-icon"><span class="glyphicon glyphicon-home glyphicon-blackboard" aria-hidden="true"></span>TV Shows</a></li>
    <li><a href="history.jsp" class="sub-icon"><span class="glyphicon glyphicon-home glyphicon-hourglass" aria-hidden="true"></span>History</a></li>
    <li><a href="#" class="menu1"><span class="glyphicon glyphicon-film" aria-hidden="true"></span>Movies<span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span></a></li>
    <ul class="cl-effect-2">
      <li><a href="movies.jsp">English</a></li>
      <li><a href="movies.jsp">Chinese</a></li>
      <li><a href="movies.jsp">Hindi</a></li>
    </ul>
    <!-- script-for-menu -->
    <script>
      $( "li a.menu1" ).click(function() {
        $( "ul.cl-effect-2" ).slideToggle( 300, function() {
          // Animation complete.
        });
      });
    </script>
    <li><a href="#" class="menu"><span class="glyphicon glyphicon-film glyphicon-king" aria-hidden="true"></span>Sports<span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span></a></li>
    <ul class="cl-effect-1">
      <li><a href="sports.jsp">Football</a></li>
      <li><a href="sports.jsp">Cricket</a></li>
      <li><a href="sports.jsp">Tennis</a></li>
      <li><a href="sports.jsp">Shattil</a></li>
    </ul>
    <!-- script-for-menu -->
    <script>
      $( "li a.menu" ).click(function() {
        $( "ul.cl-effect-1" ).slideToggle( 300, function() {
          // Animation complete.
        });
      });
    </script>
    <li><a href="movies.jsp" class="song-icon"><span class="glyphicon glyphicon-music" aria-hidden="true"></span>Songs</a></li>
    <li><a href="news.jsp" class="news-icon"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>News</a></li>
  </ul>
  <!-- script-for-menu -->
  <script>
    $( ".top-navigation" ).click(function() {
      $( ".drop-navigation" ).slideToggle( 300, function() {
        // Animation complete.
      });
    });
  </script>
  <div class="side-bottom">
    <div class="side-bottom-icons">
      <ul class="nav2">
        <li><a href="#" class="facebook"> </a></li>
        <li><a href="#" class="facebook twitter"> </a></li>
        <li><a href="#" class="facebook chrome"> </a></li>
        <li><a href="#" class="facebook dribbble"> </a></li>
      </ul>
    </div>
    <div class="copyright">
      <p>Copyright &copy; 2015.Company name All rights reserved.More Templates <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a></p>
    </div>
  </div>
</div>
</div>