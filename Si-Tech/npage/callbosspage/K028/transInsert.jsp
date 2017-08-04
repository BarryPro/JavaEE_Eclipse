<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		     /*midify by guozw 20091114 公共查询服务替换*/
		 String myParams="";
		 String org_code = (String)session.getAttribute("orgCode");
		 String regionCode = org_code.substring(0,2);

    String retType = WtcUtil.repNull(request.getParameter("retType"));
    String contactId = WtcUtil.repNull(request.getParameter("contactId"));
    String called = WtcUtil.repNull(request.getParameter("called"));
    String caller = WtcUtil.repNull(request.getParameter("caller"));
    String transagent = WtcUtil.repNull(request.getParameter("transagent"));
		String loginNo = (String)session.getAttribute("workNo");  //取login_no
	  String loginName = (String)session.getAttribute("workName"); //取login_name
		String transType = WtcUtil.repNull(request.getParameter("transType")); //transType
		String type1 = WtcUtil.repNull(request.getParameter("type1")); //is_success
    String transfer_kf_login_no = (String)session.getAttribute("kfWorkNo");  //取客服login_no	    
    String accept_kf_login_no="";
    String skillName = WtcUtil.repNull(request.getParameter("skillName"));
    System.out.println("===========================================");
    System.out.println("skillName = "+skillName)
		String temp = "select kf_login_no from dloginmsgrelation where boss_login_no=:transagent";
		myParams = "transagent="+transagent ;

%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
			<wtc:param value="<%=temp%>"/>
			<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="tempList"  scope="end"/>
	<%		
if(tempList.length>0){
  accept_kf_login_no=tempList[0][0];
}
%>
	<wtc:service name="sRK029Insert" outnum="2">
			<wtc:param value="<%=contactId%>"/>
			<wtc:param value="<%=contactId%>"/>
			<wtc:param value="<%=caller%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=transagent%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=transType%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=type1%>"/>			
			<wtc:param value="K028"/>		
			<wtc:param value="<%=transfer_kf_login_no%>"/>
			<wtc:param value="<%=accept_kf_login_no%>"/>				
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "保存关系失败";
	  }
	%>


	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);



