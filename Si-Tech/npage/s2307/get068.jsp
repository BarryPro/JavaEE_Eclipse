<%
  /*
   * ����: �û������޸�1256
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opName = "�û������޸�";
	String loginAccept = request.getParameter("loginAccept");						//
	String opCode= request.getParameter("opCode");									//��������
	String workNo= (String)session.getAttribute("workNo");							//����
	String noPass = (String)session.getAttribute("password");						//��������
	String orgCode= (String)session.getAttribute("orgCode");						//��������
	String phoneNo= request.getParameter("phoneNo");								//�ֻ�����

	String sql_init = "select * from wcreditcfgopr where phone_no = '?' ";
%>
	<wtc:pubselect name="TlsPubSelBoss"  routerKey="phone" routerValue="<%=phoneNo%>" outnum="7" retcode="sCreditCode" retmsg="sCreditMsg">
		<wtc:sql><%=sql_init%></wtc:sql>
		<wtc:param value="<%=phoneNo%>"/>
	</wtc:pubselect>
	<wtc:array id="sCredit" scope="end" />	
<%	                                   
//	String[][] backInfo = (String[][])arr.get(0);
//	String[][] errInfo = (String[][])arr.get(1);
	String creditId="";
	if(sCredit.length>0){
			creditId = sCredit[0][0];
		
	String strArray = WtcUtil.createArray("sCredit",sCredit.length);
%>
<%=strArray%>
<%
	for(int i = 0 ; i < sCredit.length ; i ++){
    	for(int j = 0 ; j < sCredit[i].length ; j ++){
%>
			sCredit[<%=i%>][<%=j%>] = "<%=sCredit[i][j].trim()%>";
<%
		}
	}
%>
	var response = new AJAXPacket();
	
	response.data.add("sCreditInit",sCredit);
	response.data.add("flagInit","0");
 
	
	core.ajax.receivePacket(response);
<%
}
else{
	%>
	var response = new AJAXPacket();
	
	response.data.add("flagInit","9");
 
	
	core.ajax.receivePacket(response);
	<%
}
%>