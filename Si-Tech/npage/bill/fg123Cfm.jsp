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
	String org_code = (String)session.getAttribute("orgCode");
	String regCode = (String)session.getAttribute("regCode"); 
	String opName = "家庭服务计划变更";
	
	String show_phone = (String)request.getParameter("show_phone");
	
	String paraAray[] = new String[12];

    paraAray[0] = request.getParameter("open_type");//卡类型
	paraAray[1] = request.getParameter("family_code");//家庭代码
    paraAray[2] = request.getParameter("home_no");//成员号码
	paraAray[3] = request.getParameter("phoneNo");//家长号码
	paraAray[4] = request.getParameter("new_rate_code");//资费代码
	paraAray[5] = work_no;//工号
	paraAray[6] = org_code;//机构编码
    paraAray[7] = request.getParameter("op_code");;//操作代码     
	paraAray[8] = request.getParameter("rate_name");//主套餐代码
	paraAray[9] = "0";//生效标志
 	paraAray[10] = request.getParameter("opNote");//操作备注
	paraAray[11] = request.getParameter("printAccept");//打印流水
 	
 	for(int ii=0;ii<paraAray.length;ii++)
 	System.out.println("# paraAray = "+paraAray[ii]);
	//String[] ret = impl.callService("s7123Cfm",paraAray,"2");
%>
	<wtc:service name="s7123CfmEx" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">			
	<wtc:param value="<%=paraAray[0]%>"/>	
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>	
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>	
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=paraAray[9]%>"/>	
	<wtc:param value="<%=paraAray[10]%>"/>
	<wtc:param value="<%=paraAray[11]%>"/>
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
<%
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+paraAray[7]+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[11]+"&pageActivePhone="+show_phone+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime+"&contactId="+show_phone+"&contactType=user"; 
	System.out.println("############################fg123Cfm->url->"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("家庭服务计划变更成功!",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("家庭服务计划变更失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
