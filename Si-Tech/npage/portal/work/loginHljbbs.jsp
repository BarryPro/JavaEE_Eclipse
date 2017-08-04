<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%
     String workNo = (String)session.getAttribute("workNo");
     String org_code = (String)session.getAttribute("orgCode");
     String regionCode=org_code.substring(0,2);   
     String Login_name     ="";            // 营业员姓名        
     String group_name     ="";            // 营业员归属        
     String pass_time      ="";            // 营业员密码到期时间
%>                

<wtc:service name="sIndexloginMsg" outnum="10" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
	if(retCode.equals("000000")){
       if(result.length>0){
              Login_name      ="".equals(result[0][0])?"不详":result[0][0];
              group_name      ="".equals(result[0][1])?"不详":result[0][1];
              pass_time       ="".equals(result[0][2])?"不详":result[0][2];
       }  
}
%>
<html xmlns="http://www.w3.org/1999/xhtml">	
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
  <script type="text/javascript" src="/js/login/jquery.js"></script>
  <script type="text/javascript" src="/js/login/common.js"></script>
  <script>
   function loginbbs(url){
      var form = document.getElementById('loginHljbbs');
          form.action='http://10.110.0.125:35000/hljbbs/LoginPost.htm';
          form.submit();
   }
</script>  

</head>
<body>
  <form id="loginHljbbs" method='post' action='' target='_blank' style="display:none">
  	<input type="hidden" name="username" value="<%=workNo%>"/>
  	<input type="hidden" name="password" value="" />
  	<input type="hidden" name="ck" value="no" />
  </form>
    <img src="../../../nresources/default/images/arrow_link_blue.gif" alt="dot" width="3" height="5"> <a href="javascript:void(0);" onclick="return loginbbs();">自动登录BBS</a>  
    <script>
    	 $("#wait8").hide(); 
    </script>
  </body>
</html        