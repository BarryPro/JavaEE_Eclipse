<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String retCode = "";
	String retMsg  = "";
	String regionCode = (String)session.getAttribute("regCode");
	String apkName 	 	= request.getParameter("apkName").trim();
	String opCode  	 	= request.getParameter("opCode");
	String versionId 	= request.getParameter("versionId");
  String bak_dir 	 	= request.getRealPath("/npage/androidFile")+"/";
	String filedownload = bak_dir+apkName;//�������ص��ļ������·��
	
	File f = new File(filedownload);
  try{
		f.delete();
  }catch(Exception e){
      e.printStackTrace();
  } 
	//���÷���
		String paraAray[] = new String[8];
		
		paraAray[0] = "";  																			//��ˮ
		paraAray[1] = "01";                                     //��������
		paraAray[2] = opCode;                                   //��������
		paraAray[3] = (String)session.getAttribute("workNo");   //����
		paraAray[4] = (String)session.getAttribute("password"); //��������
		paraAray[5] = "";          															//�û�����
		paraAray[6] = "";                                       //�û�����
		paraAray[7] = versionId;                                //�汾��
		
try{		
%>
	<wtc:service name="sm016Del" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
 		<wtc:param value="<%=paraAray[1]%>" />
 		<wtc:param value="<%=paraAray[2]%>" />
 		<wtc:param value="<%=paraAray[3]%>" />
 		<wtc:param value="<%=paraAray[4]%>" />
 		<wtc:param value="<%=paraAray[5]%>" />					
 		<wtc:param value="<%=paraAray[6]%>" />	
 		<wtc:param value="<%=paraAray[7]%>" />	
	</wtc:service>
<%
	retCode = code;
	retMsg  = msg;
}catch(Exception ex){
 	ex.printStackTrace();
	retCode = "40404";
	retMsg = "���÷���ϵͳ��������ϵ����Ա";
}
%>
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);	