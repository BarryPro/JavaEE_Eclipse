<%
/********************
* 功能: 可选套餐包年 3250
* version v3.0
* 开发商: si-tech
* update by qidp @ 2008-11-25
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.io.*"%>

<%@ include file="/npage/include/public_title_name.jsp" %>



<%	
    String opCode = "3250";
    String opName = "可选套餐包年";
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	//String[][] baseInfo = (String[][])arr.get(0);
	//String[][] agentInfo = (String[][])arr.get(2);
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	//String[][] password1 = (String[][])arr.get(4);//读取工号密码 
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr"); 
	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("");
	String card_money=request.getParameter("");
	String paraAray[] = new String[8];
	String stream=request.getParameter("login_accept");
	String thework_no=work_no;
	String themob=request.getParameter("phoneNo");
	String theop_code=request.getParameter("iOpCode");
 %>
 <%   
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = request.getParameter("iOpCode");
    paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phoneNo");
    paraAray[4] = request.getParameter("modeType");
    paraAray[5] = request.getParameter("addModeCode");
	paraAray[6] = request.getParameter("do_note");
    paraAray[7] = ip_Addr;
 %>   	
	<wtc:service name="s3250Cfm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="2" retcode="s3250CfmCode" retmsg="s3250CfmMsg">
        <wtc:param value="<%=paraAray[0]%>"/>
        <wtc:param value="<%=paraAray[1]%>"/>
        <wtc:param value="<%=paraAray[2]%>"/>
        <wtc:param value="<%=paraAray[3]%>"/>
        <wtc:param value="<%=paraAray[4]%>"/>
        <wtc:param value="<%=paraAray[5]%>"/>
        <wtc:param value="<%=paraAray[6]%>"/>
        <wtc:param value="<%=paraAray[7]%>"/>
	</wtc:service>     
<%
	//String[] ret = impl.callService("s3250Cfm",paraAray,"2","region",org_code.substring(0,2));
	String errCode1 = s3250CfmCode;
	String errMsg1 = s3250CfmMsg;
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+s3250CfmCode+"&retMsgForCntt="+s3250CfmMsg+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[3]+"&opBeginTime="+opBeginTime+"&contactId="+paraAray[3]+"&contactType=user";
	if (errCode1.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("可选资费包年申请成功！",2);
   window.location="f3250_login.jsp?activePhone=<%=paraAray[3]%>&opCode=3250&opName=可选套餐包年";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("可选资费包年申请失败!(<%=errMsg1%>",0);
	window.location="f3250_login.jsp?activePhone=<%=paraAray[3]%>&opCode=3250&opName=可选套餐包年";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true" />