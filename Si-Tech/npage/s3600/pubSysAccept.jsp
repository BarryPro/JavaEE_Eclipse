<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-20
********************/
%>
<%
  String opCode = "3607";
  String opName = "BOSS侧VPMN批量成员管理";
%>
<% request.setCharacterEncoding("GB2312");%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=gb2312" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>

<%
				String regionCode = (String)session.getAttribute("regCode");

        String ret_code  = "";				//错误代码 
        String ret_message  = "";      		//错误消息         
        String sysAccept = "000000";
        String[][] retInfo = new String[][]{};
        String[][] result = new String[][]{};
	    //--------------------------
	    String retType = request.getParameter("retType");
        try
        {
                //String sqlStr ="select to_char(sMaxSysAccept.nextval) from dual";
%>

	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 

<%                
                sysAccept = sysAcceptl;
				System.out.println("sysAccept="+sysAccept);
                ret_code = "000000";           
        }catch(Exception e){
            ret_code = "000001";
            ret_message = "取系统操作流水失败！";
        }
        System.out.println("--------------OK----------------"+sysAccept);
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