<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-14
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>

<%
    Logger logger = Logger.getLogger("fpubprodattr_qry.jsp");
	String orgCode = request.getParameter("orgCode");
	String smCode = request.getParameter("smCode");
	String regionCode = orgCode.substring(0,2);
	String []inputPara = new String[]{regionCode,smCode};
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
    String grpno = "";

    String returnCode = "000000";
    String retMessage = "查询成功！";

        //String []result = impl.callService("sGetGrpUserNo",inputPara,"1");
        %>
        <wtc:service name="sGetGrpUserNo" routerKey="region" routerValue="<%=regionCode%>" retcode="sGetGrpUserNoCode" retmsg="sGetGrpUserNoMsg" outnum="1" >
        	<wtc:param value="<%=regionCode%>"/>
        	<wtc:param value="<%=smCode%>"/> 
        </wtc:service>
        <wtc:array id="sGetGrpUserNoArr" scope="end"/>
        <%
        if(sGetGrpUserNoArr.length>0 && sGetGrpUserNoCode.equals("000000")){
            grpno = sGetGrpUserNoArr[0][0];
        }
        //grpno = result[0];
    	returnCode = sGetGrpUserNoCode;
        retMessage = sGetGrpUserNoMsg;
System.out.println("# from getGrpUserno.jsp -> returnCode = "+returnCode);
System.out.println("# from getGrpUserno.jsp -> retMessage = "+retMessage);
%>   
var response = new AJAXPacket();
var retType = '<%= request.getParameter("retType") %>';
var retCode = "<%=returnCode%>";
var retMessage = "<%=retMessage%>";
var grpno = "<%=grpno%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("GrpNo",grpno);
core.ajax.receivePacket(response);

