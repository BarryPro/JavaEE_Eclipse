<%
  /*
   * 功能: 质检权限管理->维护被检工号和组
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: 
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
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String nodeId = request.getParameter("nodeId");
	String sqlStr = "SELECT login_group_id,parent_group_id,login_group_name,is_leaf,object_id,note FROM dqclogingroup WHERE IS_DEL='N' AND parent_group_id = :nodeId ORDER BY login_group_id";
	myParams = "nodeId="+nodeId ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="7">
	<wtc:param value="<%=sqlStr%>" />
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="7">

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