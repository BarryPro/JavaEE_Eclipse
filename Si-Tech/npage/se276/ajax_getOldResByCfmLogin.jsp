 <%@ page contentType="text/html; charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
String cfmLogin = request.getParameter("cfmLogin")==null?"":request.getParameter("cfmLogin");
String iMsg="FIELDCHNAME= �˻����,FIELDENNAME=accountCode,FIELDCONTENT="+cfmLogin;
%>

<wtc:service name="sGetOldRes"   retcode="retCode" retmsg="retMsg"  outnum="8" >                                                                                               
	<wtc:param value="<%=iMsg%>"/>                                                                                           
</wtc:service>                                                
<wtc:array id="result" scope="end" /> 
	<%
	System.out.println("retCode====="+retCode);
	System.out.println("retMsg====="+retMsg);
	
	/*retCode="000000";
  retMsg="�ɹ�";
  result[0][0]="fieldChName=�豸����%�豸����%�ͺ�%����%IP��ַ%�豸��װ��ַ%�˿ڱ��%�˿�����%���žֱ���,fieldEnName=deviceType%deviceCode%model%factory%ipAddress%deviceInAddress%portCode%portType%icctCcode,fieldContent=ONU%NN608A-GPON01-ONU004-HW-HG850%HG850%��Ϊ%%��������̨�Ӳ����ز�����԰����·��̨���ƶ���˾%NN608A-GPON01-ONU007-HW-HG850-04%���%002";
	 */
	 if(retCode.equals("000000")){
	%>
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMessage","<%=retMsg%>");
	response.data.add("retContent","<%=result[0][0]%>");
	core.ajax.receivePacket(response);
	<%}else{%>
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMessage","<%=retMsg%>");
	core.ajax.receivePacket(response);
	<%}%>


 
