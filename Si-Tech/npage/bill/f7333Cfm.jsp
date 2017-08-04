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
	String returnPage = WtcUtil.repNull(request.getParameter("return_page"));
	String show_phone = (String)request.getParameter("main_card");
	String opType = (String)request.getParameter("op_type");
	String paraAray[] = new String[17];
String loginPwd    = (String)session.getAttribute("password");
    paraAray[7] = request.getParameter("op_type");//卡类型
    paraAray[8] = request.getParameter("main_card"); //家长号码
    paraAray[9] = request.getParameter("fam_prod_id");//家庭产品编码
	paraAray[3] = work_no;//工号
	paraAray[10] = org_code;//机构编码
    paraAray[2] = request.getParameter("op_code");;//操作代码     
 	paraAray[11] = request.getParameter("opNote");//操作备注
	paraAray[12] = request.getParameter("printAccept");//打印流水
	paraAray[13] = request.getParameter("friend_no"); //亲情号码
 	paraAray[14] = request.getParameter("new_friend_no"); //新亲情号码
 	paraAray[15] = request.getParameter("pay_fee"); //变更手续费
 	paraAray[16] = request.getParameter("village"); //小区代码
	//String[] ret = impl.callService("s7333Cfm",paraAray,"2");
%>
	<wtc:service name="s7333Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11">			
	<wtc:param value="<%=paraAray[0]%>"/>	
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>	
	<wtc:param value="<%=loginPwd%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>	
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=paraAray[9]%>"/>
	<wtc:param value="<%=paraAray[10]%>"/>	
	<wtc:param value="<%=paraAray[11]%>"/>	
	<wtc:param value="<%=paraAray[12]%>"/>	
	<wtc:param value="<%=paraAray[13]%>"/>	
	<wtc:param value="<%=paraAray[14]%>"/>	
	<wtc:param value="<%=paraAray[15]%>"/>
	<wtc:param value="<%=paraAray[16]%>"/>	
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
<%
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+paraAray[5]+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[7]+"&pageActivePhone="+show_phone+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime+"&contactId="+show_phone+"&contactType=user"; 
	System.out.println("############################f7123Cfm->url->"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">	
	   rdShowMessageDialog("家庭产品管理变更成功!",2);
	   location="<%=returnPage%>";
   //removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("家庭服产品管理变更失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	window.location = "f7333_login.jsp?activePhone=<%=show_phone%>&opCode=<%=paraAray[2]%>&opName=畅聊家庭产品管理";
</script>
<%}%>
