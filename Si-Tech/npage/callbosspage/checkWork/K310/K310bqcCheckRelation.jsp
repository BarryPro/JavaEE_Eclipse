<%
  /*
   * 功能: 校验质检权限
　 * 版本: 1.0.0
　 * 日期: 2008/12/12
　 * 作者: zengzq
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K310";
	//String opName = "检验权限";
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String flag = WtcUtil.repNull(request.getParameter("flag"));
	String checkGroupId = WtcUtil.repNull(request.getParameter("checkGroupId"));
	String checkedGroupIds = WtcUtil.repNull(request.getParameter("checkedGroupIds"));
	String[] checkedStr = null;
	String checkedNum = "0" ;
	if(checkedGroupIds!=null&&!("".equals(checkedGroupIds))){
		checkedStr = checkedGroupIds.split(",");

		checkedNum = String.valueOf(checkedStr.length);
		
	}

	String sqlStr ="";
	if("qc".equals(flag.trim())){
			sqlStr = "SELECT to_char(count(CHECK_GROUP_ID)) " +
			                "FROM DQCCHECKGRPGRP " +
			                "WHERE TRIM(CHECK_GROUP_ID) = :checkGroupId AND TRIM(CHECKED_GROUP_ID) IN("+checkedGroupIds+")";
   		myParams = "checkGroupId="+checkGroupId ;
   }
   if("bqc".equals(flag.trim())){
   		sqlStr = "SELECT  to_char(COUNT(CHECKED_GROUP_ID)) " +
			                "FROM DQCCHECKGRPGRP " +
			                "WHERE TRIM(CHECKED_GROUP_ID)= :checkGroupId AND TRIM(CHECK_GROUP_ID) IN("+checkedGroupIds+")";
			myParams = "checkGroupId="+checkGroupId ;
   }
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>	
<%
	String tmpNum = queryList[0][0];
%>
var response = new AJAXPacket();
response.data.add("retCode","000000");
response.data.add("retMsg","success");
response.data.add("tmpNum","<%=tmpNum%>");
response.data.add("chkGpId","<%=checkGroupId%>");
response.data.add("checkedNum","<%=checkedNum%>");
core.ajax.receivePacket(response);

