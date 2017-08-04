<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 老帅带新兵
   * 版本: 2.0
   * 日期: 2010/07/26
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String opCode = request.getParameter("opCode");
	String oldPhone = request.getParameter("oldPhone");			//老帅手机号
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String iChnSource = "01";
	String[] inParams = new String[5];
	String opName = "老帅带新兵冲正";
	String loginAcceptNew = request.getParameter("reverse_accept");
	inParams[0] = workNo;
	inParams[1] = opCode;
	inParams[2] = oldPhone;
	inParams[3] = loginAcceptNew;
	inParams[4] = iChnSource;
%>
<wtc:service name="sB063Cancle" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
	<wtc:param value="<%=inParams[3]%>" />
	<wtc:param value="<%=inParams[1]%>" />
	<wtc:param value="<%=inParams[0]%>" />
	<wtc:param value="<%=inParams[2]%>" />
	<wtc:param value="<%=inParams[4]%>" />
</wtc:service>
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务sB063Cancle in fb063_reverse.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("办理老帅带新兵冲正业务成功！");
		history.go(-1);
	</script>
<%
	}else{
		System.out.println("调用服务sB063Cancle in fb063_reverse.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		history.go(-1);
	</script>
<%
	}
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+ opCode +"&retCodeForCntt="+errCode+
			"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAcceptNew+
			"&pageActivePhone="+oldPhone+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
		<jsp:include page="<%=url%>" flush="true" />


