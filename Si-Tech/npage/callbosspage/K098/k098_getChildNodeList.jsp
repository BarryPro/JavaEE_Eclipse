<%
  /*
   * 功能: 098权限角色管理->权限树->查询子节点
　 * 版本: 1.0.0
　 * 日期: 2008/1/16
　 * 作者: fangyuan
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String nodeId = request.getParameter("nodeId");
	String sqlStr = "select t.funcid , t.parfuncid , t.funcname , t.is_leaf , t.note  from DCALLQUERYFUNCLIST t where t.is_del='N' AND t.parfuncid = :nodeId ORDER BY t.funcid";
	myParams = "nodeId="+nodeId ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="6">
	<wtc:param value="<%=sqlStr%>" />
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="6">

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
var response = new AJAXPacket();
response.data.add("nodes",nodes);
response.data.add("nodeId","<%=nodeId%>");
core.ajax.receivePacket(response);
</wtc:array>