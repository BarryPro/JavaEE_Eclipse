<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 亲情通（原邦尼老年人服务解决方案）业务
   * 版本: 2.0
   * 日期: 2011/1/5
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	/*===========获取参数============*/
	/*String loginAccept	    = "";	//流水*/
	String chnSource		= "10";	//渠道标识          													                                                        
	String opCode			= request.getParameter("opCode");	//操作代码 
	String orgCode 			= (String)session.getAttribute("orgCode");
	String opName			= request.getParameter("opName");
	String regionCode 	    = orgCode.substring(0,2);         													                                                        
	String loginNo			= (String)session.getAttribute("workNo");	//操作工号          													                                                        
	String loginPwd			= (String)session.getAttribute("password");	//工号密码          													                                                        
	String phoneNo			= request.getParameter("phoneNo");			//手机号码          													                                                        
	String userPwd			= "";	//号码密码          													                                                        
													                                                        
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<wtc:service name="sD078Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=loginAccept%>" />
		<wtc:param value="<%=chnSource%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=loginPwd%>" />
		<wtc:param value="<%=phoneNo%>" />
		<wtc:param value="<%=userPwd%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务sD078Cfm in fd078Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("亲情通业务销户成功！");
		window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
	}else{
		System.out.println("调用服务sD078Cfm in fd078Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
	}
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+ opCode +"&retCodeForCntt="+errCode+
			"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+
			"&pageActivePhone="+phoneNo+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
		<jsp:include page="<%=url%>" flush="true" />
