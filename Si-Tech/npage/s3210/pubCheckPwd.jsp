<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-13
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String iPhoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
    String iPasswd = WtcUtil.repNull((String)request.getParameter("password"));
    
    String retResult  = "false";
    String retCode="000000";
    String retMessage="密码校验成功！";
    try
    {
        String sqlStr = "";
        sqlStr = "select user_passwd from dCustMsg where phone_no = '" + iPhoneNo + "'";
        
%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result" scope="end" />
<%
        String oCustPwd = "";
        retCode = retCode2;
        retMessage = retMsg2;
        if(retCode2.equals("000000") && result.length > 0){
            oCustPwd = (result[0][0]).trim();
        }
       	iPasswd = Encrypt.encrypt(iPasswd);
       	iPasswd=iPasswd.trim();
        if (Encrypt.checkpwd2(oCustPwd,iPasswd) == 1){
            retResult = "true";
        }
        System.out.println("客户密码iPasswd=[" + iPasswd + "]oCustPwd=[" + oCustPwd + "]校验结果:" + retResult);
    }catch(Exception e){
        e.printStackTrace();
        retCode="999999";
        retMessage="密码校验失败！";
    }
%>
var response = new AJAXPacket();
var retMessage="<%=retMessage%>";
var retCode= "<%=retCode%>";
var retResult = "<%=retResult%>";

response.data.add("retResult",retResult);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
core.ajax.receivePacket(response);
