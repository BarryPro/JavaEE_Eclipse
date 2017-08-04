<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglm @ 20110225
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
    String loginNo = (String)session.getAttribute("workNo");
    System.out.println("=========================loginNo================================   "+loginNo);
    String regionCode=(String)session.getAttribute("regCode");
    System.out.println("=========================regionCode================================   "+regionCode);
    String passWord = (String)session.getAttribute("password");
    System.out.println("=========================passWord================================   "+passWord);
    String ip = request.getRemoteAddr();
    System.out.println("=========================ip================================   "+ip);
	String accs = request.getParameter("val");
	/* ningtn add start*/
	String auditPass = request.getParameter("auditPass");
	String auditCause = request.getParameter("auditCause");
	String printAccept = "";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
	printAccept = seq;
	/* end */
	System.out.println("==============accs=======   "+accs);
	System.out.println("==============auditPass=======   "+auditPass);
	System.out.println("==============auditCause=======   "+auditCause);
	String[] accsArr = accs.split(",");
	String[] auditPassArr = auditPass.split(",");
	String[] auditCauseArr = auditCause.split(",");
	System.out.println("=======accsArr.length======   "+accsArr.length + " | " + auditPassArr.length + " | " + auditCauseArr.length);
	if(auditCauseArr.length == 0){
		auditCauseArr = new String[]{""};
	}
%>     
<wtc:service name="sd347Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="Code" retmsg="Msg" outnum="2" >
				<wtc:param value="<%=printAccept%>"/>
				<wtc:param value="01"/>
				<wtc:param value="d347"/>
        <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="<%=passWord%>"/>
        <wtc:param value=" "/>
        <wtc:param value=" "/>
        <wtc:param value="<%=ip%>"/>
        <wtc:params value="<%=accsArr%>"/>
      	<wtc:params value="<%=auditPassArr%>"/>
      	<wtc:params value="<%=auditCauseArr%>"/>
</wtc:service>
<wtc:array id="result"  scope="end"/>
<%
System.out.println("=========================Code================================   "+Code);
String retcode = Code;
String retmsg = Msg;
   if(retcode.equals("000000")){
   %>
      <script language='javascript'>
      	  rdShowMessageDialog("操作成功！",2);
      	  window.location = "fd347.jsp";
      </script>
      <%
   }else{
      %>
      <script language='javascript'>
      	  rdShowMessageDialog("错误信息：<%=retmsg%><br>错误代码：<%=retcode%>", 0);
      	  window.location = "fd347.jsp";
      </script>
      <%	
   }
%>

                                                         

   	
