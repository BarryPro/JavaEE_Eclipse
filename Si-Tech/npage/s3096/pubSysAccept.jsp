<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-15
********************/
%>

<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
 <%@ include file="/npage/include/public_title_ajax.jsp" %> 

<%
				String regionCode = (String)session.getAttribute("regCode");
        String ret_code  = "";				//������� 
        String ret_message  = "";      		//������Ϣ         
        String sysAccept = "000000";
	      String retType = request.getParameter("retType");
        try
        {
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" routerValue="<%=regionCode%>"  id="sysAcceptl_t" /> 

<%          
                sysAccept = sysAcceptl_t;
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
