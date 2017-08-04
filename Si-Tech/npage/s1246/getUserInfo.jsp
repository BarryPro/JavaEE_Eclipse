<%
  /*
   * 功能: 全球通开户冲正1121
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String workNo = request.getParameter("workNo");							//工号
	String phoneNo = request.getParameter("phoneNo");								//手机号
	String opCode = request.getParameter("opCode");									//操作代码
//	ArrayList arr = F1256Wrapper.callF1256Init(workNo,phoneNo,opCode);
%>
	<wtc:service name="s1256InitEx" routerKey="phone" routerValue="<%=phoneNo%>" outnum="31" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=opCode%>"/>
	</wtc:service>
	<wtc:array id="userInfo" scope="end"/>	
<%	
	if(retMsg.equals("")){
		retMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(retCode));
		if( retMsg.equals("null")){
			retMsg ="未知错误信息";
		}
	} 
	if(userInfo.length==0){
%>
		var response = new AJAXPacket();
		response.data.add("backString","");
		response.data.add("flag","9");
		response.data.add("errCode","<%=retCode%>");
		response.data.add("errMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);
<%
	}else{
		
		String strArray = WtcUtil.createArray("userInfo",userInfo.length);

%>
		<%=strArray%>
	<%
		for(int i = 0 ; i < userInfo.length ; i ++){
	    	for(int j = 0 ; j < userInfo[i].length ; j ++){
	%>
				userInfo[<%=i%>][<%=j%>] = "<%=userInfo[i][j].trim()%>";
	<%
			}
		}
	%>
		
		var response = new AJAXPacket();
		response.data.add("backString",userInfo);
		response.data.add("errCode","<%=retCode%>");
		response.data.add("errMsg","<%=retMsg%>");
		response.data.add("flag","0");
		core.ajax.receivePacket(response);
	<%}%>
