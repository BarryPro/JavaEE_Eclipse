<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 奥运手机报短信版BOSS订购7191
   * 版本: 1.0
   * 日期: 2008/01/13
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String opCode="7191";
	String opName="奥运手机报短信版BOSS订购";
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String work_no = (String)session.getAttribute("workNo");			//工号
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
	String ip_Addr = (String)session.getAttribute("ipAddr");			//Ip地址
	
	String paraAray[] = new String[15];
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("opcode");
	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phone_no");
	paraAray[4] = request.getParameter("paper_code");
	paraAray[5] = request.getParameter("paper_money");
	paraAray[6] = request.getParameter("sp_code");
	paraAray[7] = request.getParameter("server_code");
	paraAray[8] = request.getParameter("oper_code");
	paraAray[9] = request.getParameter("award_code");
	paraAray[10] = request.getParameter("award_detailcode");
	paraAray[11] = request.getParameter("opNote");
	paraAray[12] = ip_Addr;
	paraAray[13] = request.getParameter("gift_code");
	paraAray[14] = request.getParameter("consume_term");

//  		String[] ret = impl.callService("s7191Cfm",paraAray,"2","region",org_code.substring(0,2));
%>
	<wtc:service name="s7191Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
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
		<wtc:param value="<%=paraAray[12]%>"/>
		<wtc:param value="<%=paraAray[13]%>"/>
		<wtc:param value="<%=paraAray[14]%>"/>		
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if(errCode.equals("000000")){
%>
		<script language="JavaScript">
				rdShowMessageDialog("确认成功！",2);
				window.location="f7191_login.jsp?activePhone=<%=paraAray[3]%>";
			</script>
	
<%}else{%>
				<script language="JavaScript">
						rdShowMessageDialog("确认失败!<%=errMsg%>",0);
						window.location="f7191_login.jsp?activePhone=<%=paraAray[3]%>";
				</script>
<%	
	}
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode
		+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="
		+paraAray[3]+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
<jsp:include page="<%=url%>" flush="true" />