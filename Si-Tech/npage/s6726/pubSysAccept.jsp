<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-13
********************/
%>

<% request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%
				String regionCode=(String)session.getAttribute("regCode");
        String ret_code  = "";				//������� 
        String ret_message  = "";      		//������Ϣ        
        String sysAccept="";
         
	      String retType = request.getParameter("retType");
        try
        {
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 

<%       
         sysAccept=sysAcceptl;
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

