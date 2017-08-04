   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-23
********************/
%>
   <%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>         
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String work_no = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	
	String phoneNo = request.getParameter("srv_no");//服务号码
  String opType = request.getParameter("opFlag");//操作信息
  String sysAcceptl = request.getParameter("sysAcceptl");//流水
  String iChnSource = "01";
  String op_code = request.getParameter("opCode");
  String iLoginPwd = "";
  String iUserPwd = "";
  System.out.println("------------sysAcceptl-----------"+sysAcceptl);
  String paraAray[] = new String[8];
	paraAray[0] = sysAcceptl; /*流水*/
	paraAray[1] = iChnSource; /*渠道标识*/
  paraAray[2] = op_code; /*操作代码*/ 
 	paraAray[3] = work_no ;/*工号*/
	paraAray[4] = iLoginPwd; /*工号密码*/
  paraAray[5] = phoneNo; /*手机号码*/
  paraAray[6] = iUserPwd ; /*号码密码*/
	paraAray[7] = opType;/*操作信息*/   
	//String[] ret = impl.callService("sHfxsOpr",paraAray,"2","phone",phoneNo);
	%>
	
    <wtc:service name="sHfxsOpr" outnum="5" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />	
			<wtc:param value="<%=paraAray[2]%>" />	
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />	
			<wtc:param value="<%=paraAray[5]%>" />	
			<wtc:param value="<%=paraAray[6]%>" />
			<wtc:param value="<%=paraAray[7]%>" />	
		</wtc:service>
	
	<%
	String errCode = code1;
	System.out.println("------------code1-----------"+code1);
	String errMsg = msg1;
	if (errCode.equals("000000") )
	{
	%>
<script language="JavaScript">
	rdShowMessageDialog("话费信使业务受理成功!",2);
	removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("话费信使业务受理失败!errCode: <%=errCode%>+errMsg: <%=errMsg%>+",0);
	history.go(-1);
</script>
<%}%>


<%
String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+sysAcceptl+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+msg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />
