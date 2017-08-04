<%
  /*
   * 功能: 家庭成员管理
   * 版本: 1.0
   * 日期: 2013-4-26 19:58:43
   * 作者: yansca
   * 版权: si-tech
   * update:
  */
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%> 

 <%
  String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String orgCode  = (String)session.getAttribute("orgCode");
	String groupId  = (String)session.getAttribute("groupId");
	String orgId    = (String)session.getAttribute("orgId");
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String masterFlag = WtcUtil.repNull(request.getParameter("masterFlag"));
	String userId = WtcUtil.repNull(request.getParameter("userId"));
	String homeCustId = WtcUtil.repNull(request.getParameter("homeCustId"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<wtc:service name="sG645AddMem" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	      <wtc:param value="<%=loginAccept%>"/>
	      <wtc:param value="01"/>
	      <wtc:param value="<%=opCode%>"/>
	      <wtc:param value="<%=workNo%>"/>
	      <wtc:param value="<%=password%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=homeCustId%>"/>
		    <wtc:param value="<%=userId%>"/>  
        <wtc:param value="0"/>  
        <wtc:param value="<%=phoneNo%>"/>  
        <wtc:param value="0"/>   
</wtc:service>	
<%	
	if(retCode.equals("000000"))
    {
%>
      <script>
	      rdShowMessageDialog("家庭成员添加成功！",2);
               location="fg645_add.jsp?opCode=<%=opCode%>&custId=<%=homeCustId%>";
        window.opener.doRefresh('NULL');
	    </script>
<%
   }
   else
   {
%>
	   <script>
	     rdShowMessageDialog('错误<%=retMsg%>，请重新操作！',0);
                  location="fg645_add.jsp?opCode=<%=opCode%>&custId=<%=homeCustId%>";
	   </script>
<%
   }
%>		