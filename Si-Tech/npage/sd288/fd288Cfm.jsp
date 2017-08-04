<%
	 /*
   * 功能: 提醒短信审批
　 * 版本: v2.0
　 * 日期: 2011/3/31
　 * 作者: ningtn
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
	<%@ page contentType= "text/html;charset=gb2312" %>
	<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
		/**来自session的固定数据**/
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		String opCode = "d288";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%
		String systemNote = "无";
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		String sAuditAccept = WtcUtil.repNull(request.getParameter("sAuditAccept"));
		String sIsAuditPass = WtcUtil.repNull(request.getParameter("sIsAuditPass"));
		String sAuditSuggestion = WtcUtil.repNull(request.getParameter("sAuditSuggestion"));
		String loginAccept = sLoginAccept;
		
		String [] inParas = new String[10];
		inParas[0] = loginAccept;
		inParas[1] = opCode;
		inParas[2] = workNo;
		inParas[3] = pass;
		inParas[4] = systemNote;
		inParas[5] = opNote;
		inParas[6] = ipAddr;
		inParas[7] = sAuditAccept;
		inParas[8] = sIsAuditPass;
		inParas[9] = sAuditSuggestion;
%>
		<wtc:service name="sd288Cfm" routerKey="region" routerValue="<%=regionCode%>" 
				 retcode="retCode1" retmsg="retMsg1" outnum="1" >
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
			<wtc:param value="<%=inParas[2]%>"/>
			<wtc:param value="<%=inParas[3]%>"/>
			<wtc:param value="<%=inParas[4]%>"/>
			<wtc:param value="<%=inParas[5]%>"/>
			<wtc:param value="<%=inParas[6]%>"/>
			<wtc:param value="<%=inParas[7]%>"/>
			<wtc:param value="<%=inParas[8]%>"/>
			<wtc:param value="<%=inParas[9]%>"/>
		</wtc:service>
		<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode1.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("提醒短信审批成功!",2);
			window.location.href = "fd288.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("提醒短信审批未能成功!服务代码:<%=retCode1%><br/>服务信息:<%=retMsg1%>");
			window.location.href = "fd288.jsp";
		</script>		
<%			
	}
%>