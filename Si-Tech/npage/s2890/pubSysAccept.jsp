<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.19
 ģ��:EC��Ʒ����
********************/
%>


<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
        String ret_code  = "";				//������� 
        String ret_message  = "";      		//������Ϣ         
        String sysAccept = "000000";
	    //--------------------------
	    String retType = request.getParameter("retType");
        try
        {
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=%>"  id="seq"/>
<%
            sysAccept = seq;
			System.out.println("sysAccept="+sysAccept);
            ret_code = "000000";           
        }catch(Exception e){
            ret_code = "000001";
            ret_message = "ȡϵͳ������ˮʧ�ܣ�";
        }
%>

var response = new AJAXPacket();
var retType = "";
var sysAccept = "";
retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
sysAccept = "<%=sysAccept%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("sysAccept",sysAccept);
core.ajax.receivePacket(response);