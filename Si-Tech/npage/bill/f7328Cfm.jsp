<%
/********************
 version v2.0
 开发商: si-tech
 模块: 家庭服务计划变更
 update zhaohaitao at 2009.1.6
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>


<%
	String work_no = (String)session.getAttribute("workNo");
	String loginPwd = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regCode = (String)session.getAttribute("regCode");
	String returnPage = WtcUtil.repNull(request.getParameter("return_page"));
	String opName = "家庭服务计划变更";
	String op_flag = request.getParameter("open_type");//操作类型
	String show_phone = (String)request.getParameter("show_phone");

	String paraAray[] = new String[13];

    paraAray[0] = request.getParameter("open_type");	//卡类型
	paraAray[1] = request.getParameter("family_code");	//家庭代码
    if(op_flag.equals("1") || op_flag.equals("4"))
    {
    paraAray[2] = request.getParameter("home_no"); 	//加入家庭的成员号码
	}
	else if(op_flag.equals("2"))
	{
		paraAray[2] = request.getParameter("show_phone");	//退出家庭的成员号码
	}
	paraAray[3] = request.getParameter("phoneNo");	//家长号码
	paraAray[4] = work_no;	//工号
	paraAray[5] = org_code;	//机构编码
  paraAray[6] = request.getParameter("op_code");	//操作代码
 	paraAray[7] = request.getParameter("opNote");	//操作备注
	paraAray[8] = request.getParameter("printAccept");	//打印流水
	paraAray[12] = loginPwd;	//工号密码

	//String[] ret = impl.callService("s7328Cfm",paraAray,"2");
%>
	<wtc:service name="s7328Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="01"/>	
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[12]%>"/>	
	<wtc:param value="<%=paraAray[2]%>"/>		
	<wtc:param value=""/>							
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>		
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>

	</wtc:service>
	<wtc:array id="result"  scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraAray[6]+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[8]+"&pageActivePhone="+show_phone+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime+"&contactId="+show_phone+"&contactType=user";
	System.out.println("############################f7328Cfm->url->"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("业务办理成功!",2);
   if(("<%=returnPage%>"!="")&&("<%=op_flag%>"=="2"))
   {
   		removeCurrentTab();
   	}
   	else if(("<%=returnPage%>"!="")&&(("<%=op_flag%>"=="0")||("<%=op_flag%>"=="1")||("<%=op_flag%>"=="3")||("<%=op_flag%>"=="4")   ))
	{
  		location="<%=returnPage%>";
	}
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("业务办理失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
