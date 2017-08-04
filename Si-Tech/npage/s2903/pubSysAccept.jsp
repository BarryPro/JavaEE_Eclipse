<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<% request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>

<%
	String regionCode = (String)session.getAttribute("regCode");
//        ArrayList retArray = new ArrayList();
        String ret_code  = "";				//错误代码 
        String ret_message  = "";      		//错误消息         
        String sysAccept = "000000";
//        String[][] result = new String[][]{};
// 	    SPubCallSvrImpl callView = new SPubCallSvrImpl();
	    //--------------------------
	    String retType = request.getParameter("retType");
        try
        {
                String sqlStr ="select to_char(sMaxSysAccept.nextval) from dual";
  //              retArray = callView.sPubSelect("1",sqlStr);
  //              result = (String[][])retArray.get(0);
  %>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
                sysAccept = (result[0][0]).trim();
				System.out.println("sysAccept="+sysAccept);
                ret_code = "000000";           
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
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("sysAccept",sysAccept);
core.ajax.receivePacket(response);

