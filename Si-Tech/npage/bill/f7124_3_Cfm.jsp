<%
/********************
 version v2.0
 开发商: si-tech
 模块: 家庭服务计划配置
 update zhaohaitao at 2009.1.6
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%	
	
	String opCode = request.getParameter("op_code");
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("main_card");
	String work_no = (String)session.getAttribute("workNo"); 
	String org_code = (String)session.getAttribute("orgCode"); 

	String paraAray[] = new String[8];
   
	paraAray[0] = request.getParameter("main_card");//家庭代码
    paraAray[1] = request.getParameter("home_no");//成员号码
	paraAray[2] = request.getParameter("limit_pay");//低限
	paraAray[3] = work_no;//工号
	paraAray[4] = org_code;//org_code
	paraAray[5] = request.getParameter("op_code");//op_code
	paraAray[6] = request.getParameter("opNote");//操作类型
	paraAray[7] = request.getParameter("printAccept");//操作流水
	
	System.out.println("paraAray[0]= "+paraAray[0]);
	System.out.println("paraAray[1]= "+paraAray[1]);
	System.out.println("paraAray[2]= "+paraAray[2]);
	System.out.println("paraAray[3]= "+paraAray[3]);
	System.out.println("paraAray[4]= "+paraAray[4]);
	System.out.println("paraAray[5]= "+paraAray[5]);
	System.out.println("paraAray[6]= "+paraAray[6]);
	System.out.println("paraAray[7]= "+paraAray[7]);
 	
	//String[] ret = impl.callService("s7129Cfm",paraAray,"2","phone",request.getParameter("main_card"));
%>
	<wtc:service name="s7129Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
	<wtc:param value="<%=paraAray[0]%>"/>	
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>	
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>	
	<wtc:param value="<%=paraAray[7]%>"/>
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
<%
	String cnttOpCode = WtcUtil.repNull(request.getParameter("cnttOpCode"))==""?opCode:WtcUtil.repNull(request.getParameter("cnttOpCode"));
	String cnttOpName = WtcUtil.repNull(request.getParameter("cnttOpName"))==""?opName:WtcUtil.repNull(request.getParameter("cnttOpName"));
	
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+cnttOpName+"&workNo="+work_no+"&loginAccept="+paraAray[7]+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime+"&contactId="+phoneNo+"&contactType=user"; 
	System.out.println("%%%%%%%%@@@@@@@@@@##############"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("家庭服务计划配置成功!",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("家庭服务计划配置失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	window.location="f7124.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
</script>
<%}%>
