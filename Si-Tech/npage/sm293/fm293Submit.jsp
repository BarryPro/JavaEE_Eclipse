<%
   /*
   * 功能: 
   * 版本: 1.0
   * 日期: 2015/07/28 R_CMI_HLJ_guanjg_2015_2350528@关于哈分公司为第二批社会渠道申请开通身份证扫描仪使用权限的请示
   * 作者: gejing
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	System.out.println("===requestInto========= fm293Submit.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String iOpNote = request.getParameter("iOpNote");
		String iGroupId =  request.getParameter("iGroupId");
		
		String  inputParsm [] = new String[9];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iOpNote;
		inputParsm[8] = iGroupId;
%>
<wtc:service name="sm293Add" routerKey="region" routerValue="<%=regionCode%>" retcode="sRetCode" retmsg="sRetMsg" outnum="2" >
	      <wtc:param value="<%=inputParsm[0]%>"/>
	      <wtc:param value="<%=inputParsm[1]%>"/>
	      <wtc:param value="<%=inputParsm[2]%>"/>
	      <wtc:param value="<%=inputParsm[3]%>"/>
	      <wtc:param value="<%=inputParsm[4]%>"/>
	      <wtc:param value="<%=inputParsm[5]%>"/>
	      <wtc:param value="<%=inputParsm[6]%>"/>
	      <wtc:param value="<%=inputParsm[7]%>"/>
		  <wtc:param value="<%=inputParsm[8]%>"/>  
</wtc:service>	

var response = new AJAXPacket();
response.data.add("retCode","<%=sRetCode%>");
response.data.add("retMsg","<%=sRetMsg%>");
core.ajax.receivePacket(response);