<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-15
********************/
%>


<% request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 


<%
				String regionCode = (String)session.getAttribute("regCode");

				
        String ret_code  = "";				//������� 
        String ret_message  = "";      		//������Ϣ         
        String sysAccept = "000000";
        String[][] retInfo = new String[][]{};
        String[][] result = new String[][]{};
	    //--------------------------
	    String retType = request.getParameter("retType");
        try
        {
                //String sqlStr ="select to_char(sMaxSysAccept.nextval) from dual";
                //retArray = callView.sPubSelect("1",sqlStr);
                
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" routerValue="<%=regionCode%>"  id="sysAcceptl_t" /> 

<%       
				//System.out.println("----------------------sysAcceptl_t=-------------"+sysAcceptl_t);         
                sysAccept = sysAcceptl_t;
				//System.out.println("----------------------sysAccept=-------------"+sysAccept);
                ret_code = "000000";           
        }catch(Exception e){
            ret_code = "000001";
            ret_message = "ȡϵͳ������ˮʧ�ܣ�";
        }
        
        System.out.println("-----------------OK------------------");
%>

var response = new AJAXPacket();
var retType = "";
var sysAccept = "";
retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
sysAccept = "<%=sysAccept%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("sysAccept",sysAccept);
core.ajax.receivePacket(response);