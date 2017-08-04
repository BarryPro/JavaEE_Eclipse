<%
  /*
   * 功能: "农信通"赠礼营销活动7164
   * 版本: 1.0
   * 日期: 2009/1/13
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String opCode=request.getParameter("opCode");	
	String opName=request.getParameter("opName");	
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String work_no = (String)session.getAttribute("workNo");			//工号
	String ip_Addr = (String)session.getAttribute("ipAddr");			//Ip地址 
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
	String phoneNo=(String)request.getParameter("phone_no");
	String page_name=""; 
	
	String paraAray[] = new String[10];
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("opcode");
  	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phone_no");
  	paraAray[4] = request.getParameter("paper_code");
  	paraAray[5] = request.getParameter("opNote");
  	paraAray[6] = ip_Addr;
  	paraAray[7] = request.getParameter("gift_code");
  	if(paraAray[1].equals("7164")){
		paraAray[8] = request.getParameter("op_type");
		page_name="f7164_login.jsp";
	}else{
		paraAray[8] = request.getParameter("op_type_7176");
		page_name="f7176_login.jsp";
	}
	
// 	String[] ret = impl.callService("s7164Cfm",paraAray,"2","region",org_code.substring(0,2));
%>
	<wtc:service name="s7164Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if(errCode.equals("000000")&result.length>0){
%>
	<script language="JavaScript">
		rdShowMessageDialog("确认成功！",2);
		window.location='<%=page_name%>?activePhone=<%=phoneNo%>';
	</script>
<%
%>   
	
<%}else{%>
	<script language="JavaScript">
		rdShowMessageDialog("确认失败!",0);
		window.location='<%=page_name%>?activePhone=<%=phoneNo%>';
	</script>
<%	
	}
String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode
		+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="
		+paraAray[3]+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
<jsp:include page="<%=url%>" flush="true" />
