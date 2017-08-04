<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-15
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>

<%
        String orgCode = (String)session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0,2);
        
        ArrayList retArray = new ArrayList();
        String ret_code  = "";				//错误代码 
        String ret_message  = "";      		//错误消息         
        String sysAccept = "000000";
        String[][] retInfo = new String[][]{};
        String[][] result = new String[][]{};
 	    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
	    //--------------------------
	    String retType = request.getParameter("verifyType");
        try
        {
                //String sqlStr ="select to_char(sMaxSysAccept.nextval) from dual";
                //retArray = callView.sPubSelect("1",sqlStr);
                //result = (String[][])retArray.get(0);
                //sysAccept = (result[0][0]).trim();
            %>
                <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
            <%
                sysAccept = seq;
				System.out.println("sysAccept="+sysAccept);
                ret_code = "0";           
        }catch(Exception e){
            ret_code = "000001";
            ret_message = "取系统操作流水失败！";
        }
%>

var response = new AJAXPacket();
var retType = "";
var sysAccept = "";
retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
sysAccept = "<%=sysAccept%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("verifyType",retType);
response.data.add("errorCode",retCode);
response.data.add("errorMsg",retMessage);
response.data.add("sysAccept",sysAccept);
core.ajax.receivePacket(response);
