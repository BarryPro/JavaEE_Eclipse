<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-16 页面改造,修改样式
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%	
	String opCode1 = "1449";	
	String opName5 = "全球通签约计划冲正";	//header.jsp需要的参数  
	String opCode = request.getParameter("opCode");
	String opName1="全球通签约计划";
	String loginAccept = request.getParameter("loginAccept");
	String phoneno = request.getParameter("phoneno");
	String backAccept = request.getParameter("backAccept");
	String remark = request.getParameter("remark");	
	String work_no = (String)session.getAttribute("workNo");	
	
	String paraAray[] = new String[6];   	
	paraAray[0] = loginAccept; //流水
	paraAray[1] = work_no;  //操作工号
	paraAray[2] = backAccept;	 //员时交易流水
	paraAray[3] = opCode;	//功能代码
	paraAray[4] = phoneno;	//用户号码
	paraAray[5] = remark;	//用户备注
	//String[] ret = impl.callService("s1449Cfm",paraAray,"1","phone",phoneno);
%>
	<wtc:service name="s1449Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>	
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>			
	</wtc:service>	
	<wtc:array id="ret"  scope="end"/><%
	String retCode= retCode1;
	String retMsg = retMsg1;
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);	
	String errMsg = retMsg1;
	
	if (ret != null && retCode.equals("000000")){
		loginAccept = ret[0][0];

%>

<script language="JavaScript">
	rdShowMessageDialog("全球通签约计划冲正成功！",2);
	removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("全球通签约计划冲正失败!(<%=errMsg%>",0);
	history.go(-1);
</script>
<%}
%>

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode1+"&retCodeForCntt="+retCode1+"&opName="+opName5+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />
