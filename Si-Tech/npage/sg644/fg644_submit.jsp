<%
  /*
   * ����: ��ͥ�ͻ���Ϣά��
   * �汾: 1.0
   * ����: 2013-4-29 15:00:26
   * ����: yansca
   * ��Ȩ: si-tech
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
	String masterPhone = WtcUtil.repNull(request.getParameter("masterPhone"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String masterCustName = WtcUtil.repNull(request.getParameter("masterCustName"));
	String masterIdType = WtcUtil.repNull(request.getParameter("masterIdType"));
	String masterIdIccid = WtcUtil.repNull(request.getParameter("masterIdIccid"));
	String masterIdAdress = WtcUtil.repNull(request.getParameter("masterIdAdress"));
	String masterIdDate = WtcUtil.repNull(request.getParameter("masterIdDate"));
	String postNo = WtcUtil.repNull(request.getParameter("postNo"));
	String contactName = WtcUtil.repNull(request.getParameter("contactName"));
	String contactPhone = WtcUtil.repNull(request.getParameter("contactPhone"));
	String faxNo = WtcUtil.repNull(request.getParameter("faxNo"));
	String email = WtcUtil.repNull(request.getParameter("email"));
	String masterCustId = WtcUtil.repNull(request.getParameter("masterCustId"));
	String masterUserId = WtcUtil.repNull(request.getParameter("masterUserId"));
	String custId = WtcUtil.repNull(request.getParameter("custId"));
	String createNote = "��ͥ�ͻ�����ά�����ͻ�ID["+custId+"]";
	String custPasswd = WtcUtil.repNull(request.getParameter("custPasswd"));
	String custStatus = WtcUtil.repNull(request.getParameter("custStatus"));
	String ownerGrade = WtcUtil.repNull(request.getParameter("ownerGrade"));
	String ownerType = WtcUtil.repNull(request.getParameter("ownerType"));
	String custAddress = WtcUtil.repNull(request.getParameter("custAddress"));
	String contactAddress = WtcUtil.repNull(request.getParameter("contactAddress"));
	String contactMailAddress = WtcUtil.repNull(request.getParameter("contactMailAddress"));	
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
	
	if ("".equals(postNo)) {
	     postNo = "��";
	}
	if ("".equals(faxNo)) {
	     faxNo = "��";
	}
	if ("".equals(email)) {
	     email = "��";
	}
%>
<wtc:service name="sG644Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	      <wtc:param value="<%=loginAccept%>"/>
	      <wtc:param value="01"/>
	      <wtc:param value="<%=opCode%>"/>
	      <wtc:param value="<%=workNo%>"/>
	      <wtc:param value="<%=password%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=custId%>"/>
		    <wtc:param value="<%=masterPhone%>"/>  
        <wtc:param value="0"/>  
        <wtc:param value="<%=custPasswd%>"/>  
        <wtc:param value="<%=masterCustName%>"/>   
        <wtc:param value="<%=masterIdType%>"/>  
        <wtc:param value="<%=masterIdIccid%>"/> 
        <wtc:param value="<%=masterIdAdress%>"/>  
        <wtc:param value="<%=masterIdDate%>"/>   
        <wtc:param value="<%=postNo%>"/>  
        <wtc:param value="<%=contactName%>"/>  
        <wtc:param value="<%=contactPhone%>"/>   
        <wtc:param value="<%=faxNo%>"/>  
        <wtc:param value="<%=email%>"/> 
        <wtc:param value="<%=regionCode%>"/>  
        <wtc:param value="<%=orgCode%>"/>  
        <wtc:param value="<%=groupId%>"/>  
        <wtc:param value="<%=orgId%>"/>   
        <wtc:param value="<%=createNote%>"/>    
        <wtc:param value="<%=masterCustId%>"/>   
        <wtc:param value="<%=masterUserId%>"/>      
        <wtc:param value="<%=custStatus%>"/>     
        <wtc:param value="<%=ownerGrade%>"/>     
        <wtc:param value="<%=ownerType%>"/>     
        <wtc:param value="<%=custAddress%>"/>     
        <wtc:param value="<%=contactAddress%>"/>     
        <wtc:param value="<%=contactMailAddress%>"/>         
</wtc:service>	
<%	
	if(retCode.equals("000000"))
    {
%>
      <script>
	      rdShowMessageDialog("��ͥ�ͻ�����ά���ɹ���",2);
          location="fg644_main.jsp?activePhone=<%=masterPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
	    </script>
<%
   }
   else
   {
%>
	   <script>
	     rdShowMessageDialog('����<%=retMsg%>�������²�����',0);
                  location="fg644_main.jsp?activePhone=<%=masterPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
	   </script>
<%
   }
%>		