 <%
	/********************
	 version v2.0
	开发商: si-tech
	********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	//String opCode = "9911";
	//String opName = "手机邮箱5元版商用申请";	//header.jsp需要的参数
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
	//String[][] result = new String[][]{};
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();	
	//ArrayList retArray = new ArrayList();
	String login_accept=request.getParameter("login_accept");//取得流水号
	
	String work_no = (String)session.getAttribute("workNo");    //工号 		   
	String regionCode = (String)session.getAttribute("regCode"); 
	String loginPwd    = (String)session.getAttribute("password");
	String phone_no    = request.getParameter("phone_no");
	String paraAray[] = new String[4];
	paraAray[0] = request.getParameter("phone_no");
	//paraAray[1] = request.getParameter("qx_level");
	paraAray[1] = request.getParameter("cur_level_hidden");//订购级别
  paraAray[2] = work_no;
  paraAray[3] = request.getParameter("orderWayStatus");
	//String[] ret = impl.callService("s9911Cfm",paraAray,"2","region",org_code.substring(0,2));
%>
	<wtc:service name="s9911Cfm"   routerKey="region" routerValue=" <%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">

		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="01" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=paraAray[2]%>"/>	
		<wtc:param value="<%=loginPwd%>" />
		<wtc:param value="<%=paraAray[0]%>"/>	
		<wtc:param value=" " />	
		<wtc:param value="<%=paraAray[1]%>"/>	
		<wtc:param value="01" />
		<wtc:param value="<%=paraAray[3]%>"/>	
	</wtc:service>	
<%
	//int errCode = impl.getErrCode();
	//String errMsg = impl.getErrMsg();
	String errCode=	retCode1;
	String errMsg=	retMsg1;
	if (errCode.equals("000000")){
%>
		<script language="JavaScript">
			   rdShowMessageDialog("提交成功!",2);
			  //history.go(-2);
			  //window.location.href="f9911_a.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=paraAray[0]%>";
			  removeCurrentTab();
		</script>
<%
	}else{
%>   		<script language="JavaScript">
			rdShowMessageDialog("处理失败：<%=errMsg%>",0);
			//history.go(-2);
			//window.location.href="f9911_a.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=paraAray[0]%>";
			removeCurrentTab();
		</script>
<%	}
%>

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+login_accept+"&pageActivePhone="+paraAray[0]+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />
