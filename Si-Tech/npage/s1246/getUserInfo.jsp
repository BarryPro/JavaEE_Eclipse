<%
  /*
   * ����: ȫ��ͨ��������1121
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String workNo = request.getParameter("workNo");							//����
	String phoneNo = request.getParameter("phoneNo");								//�ֻ���
	String opCode = request.getParameter("opCode");									//��������
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
			retMsg ="δ֪������Ϣ";
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
