<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wangwg @ 20150511
 ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
        String login_no = (String)session.getAttribute("workNo");//工号
        String login_passwd = (String)session.getAttribute("password");//工号密码
        String phoneNo = WtcUtil.repNull(request.getParameter("phoneno"));
        String oprcode = WtcUtil.repNull(request.getParameter("oprcode"));
        String returnMessage="";
        String returnCode="";
        String [] inputParam = new String [11] ;
        inputParam[0]="0";
        inputParam[1]="08";
        inputParam[2]="J101";
        inputParam[3]=login_no;
        inputParam[4]=login_passwd;
        inputParam[5]=phoneNo;
        inputParam[6]="";
        inputParam[7]=oprcode;
        inputParam[8]=phoneNo;
        inputParam[9]="亲情圈户主";
        inputParam[10]="1";
%>

	<wtc:service name="sj101Cfm" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode" retmsg="retMsg" outnum="2" >
                <wtc:param value="<%=inputParam[0]%>"/>
                <wtc:param value="<%=inputParam[1]%>"/>
                <wtc:param value="<%=inputParam[2]%>"/>
                <wtc:param value="<%=inputParam[3]%>"/>
                <wtc:param value="<%=inputParam[4]%>"/>
                <wtc:param value="<%=inputParam[5]%>"/>
                <wtc:param value="<%=inputParam[6]%>"/>
                <wtc:param value="<%=inputParam[7]%>"/>
                <wtc:param value="<%=inputParam[8]%>"/>
                <wtc:param value="<%=inputParam[9]%>"/>
                <wtc:param value="<%=inputParam[10]%>"/>
	</wtc:service>
	<wtc:array id="retmsg" scope="end"/>
<%
	returnCode = retCode;
        returnMessage = retMsg;

        if(returnMessage==null){
                returnMessage = "";
        }
%>

var response = new AJAXPacket();
response.data.add("verifyType" ,"QQQ"           );
response.data.add("errorCode","<%=returnCode%>");
response.data.add("errorMsg","<%=returnMessage%>");
core.ajax.receivePacket(response);
