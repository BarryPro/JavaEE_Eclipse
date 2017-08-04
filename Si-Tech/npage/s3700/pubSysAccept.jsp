<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-16
********************/
%>

<% request.setCharacterEncoding("GBK");%>
 <%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%@ page contentType= "text/html;charset=GBK" %>


<%
				String regionCode = (String)session.getAttribute("regCode");
        String ret_code  = "";				//错误代码 
        String ret_message  = "";      		//错误消息         
        String sysAccept = "000000";
        String[][] retInfo = new String[][]{};
        String[][] result = new String[][]{};
	    String retType = request.getParameter("retType");
        try
        {
%>

	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" routerValue="<%=regionCode%>"  id="sysAcceptl_t" /> 


<%              
				System.out.println("sysAccept="+sysAcceptl_t);
				sysAccept=sysAcceptl_t;
                ret_code = "000000";           
        }catch(Exception e){
            ret_code = "000001";
            ret_message = "取系统操作流水失败！";
        }
        
        //System.out.println("---------------------OK-----------------------");
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
