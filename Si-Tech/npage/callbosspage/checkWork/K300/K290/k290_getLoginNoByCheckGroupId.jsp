<%
  /**
   * 功能: 质检权限管理->分配质检权限->质检组树点击后返回质检工号组对应的工号
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String myParams1="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String sqlStr = " select t.check_login_no from dqccheckgrouplogin t ";
	       sqlStr += " where t.valid_flag='Y' and  t.check_group_id = :nodeId";
	myParams = "nodeId="+nodeId ;
	String sqlGroupStr="select t.checked_group_id from dqccheckgrpgrp  t where t.check_group_id = :nodeId";    
	myParams1 = "nodeId="+nodeId ;
System.out.println("=====================");
System.out.println(sqlStr);
System.out.println("=====================");
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=sqlStr%>" />
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="1">
var nodes = new Array();
<%
	for (int i = 0; i < resultList.length; i++) {
%>
    var tmpArr = new Array();
	<%
		for (int j = 0; j < resultList[i].length; j++) {
	%>
		tmpArr[<%=j%>] = '<%=resultList[i][j]%>';
	<%
		}
	%>
	nodes[<%=i%>] = tmpArr;
<%
	}
%>
</wtc:array>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=sqlGroupStr%>" />
	<wtc:param value="<%=myParams1%>"/>
</wtc:service>
<wtc:array id="resultList1" start="0" length="1">
var groupNodes = new Array();
<%
	for (int k = 0; k < resultList1.length; k++) {
%>
    var tmpArr2 = new Array();
	<%
		for (int s = 0; s < resultList1[k].length; s++) {
	%>
		tmpArr2[<%=s%>] = '<%=resultList1[k][s]%>';
	<%
		}
	%>
	groupNodes[<%=k%>] = tmpArr2;
<%
	}
%>
</wtc:array>
var response = new AJAXPacket();
response.data.add("loginNoList",nodes);
response.data.add("checkedGroupList",groupNodes);
core.ajax.receivePacket(response);
