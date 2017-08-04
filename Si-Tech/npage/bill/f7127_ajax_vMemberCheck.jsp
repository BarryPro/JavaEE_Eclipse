<%
    /*************************************
    * 功  能: 校验“新增亲情号码”中是否有用户办理了集团V网业务 7127
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-6-19
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String mainPhoneNo = WtcUtil.repStr(request.getParameter("mainPhoneNo"), "");
	String newPhoneNos = WtcUtil.repStr(request.getParameter("newPhoneNos"), "");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String vMemberCount = "";
	String vMemberPhoneNos = "";
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=mainPhoneNo%>" id="printAccept"/>

	<wtc:service name="sVMemberCheck" routerKey="phone" routerValue="<%=mainPhoneNo%>" retcode="retCode" retmsg="retMsg" outnum="4">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value="<%=mainPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=newPhoneNos%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
 System.out.println("---7127----retCode="+retCode);
  System.out.println("---7127----ret.length="+ret.length);
   System.out.println("---7127----ret[0][0]="+ret[0][0]);
    System.out.println("---7127----ret[0][1]="+ret[0][1]);
     System.out.println("---7127----ret[0][2]="+ret[0][2]);
     System.out.println("---7127----ret[0][3]="+ret[0][3]);
  if("000000".equals(retCode)){
    if(ret.length>0){
      vMemberPhoneNos = ret[0][2];
      vMemberCount = ret[0][3];
    }
  }
  
  System.out.println("---7127----vMemberPhoneNos="+vMemberPhoneNos);
  System.out.println("---7127----vMemberCount="+vMemberCount);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
response.data.add("vMemberCount","<%=vMemberCount%>");
response.data.add("vMemberPhoneNos","<%=vMemberPhoneNos%>");
core.ajax.receivePacket(response);
 
	    