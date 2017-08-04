<%
  /*
   * 功能: 098权限角色管理->维护权限功能->修改->获得节点jscode
　 * 版本: 1.0.0
　 * 日期: 2008/1/16
　 * 作者: fangyuan
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String nodeId = WtcUtil.repNull(request.getParameter("selectItemId"));
	String sql="select t.js_code from DCALLQUERYFUNCLIST  t where t.funcid=:nodeId ";
	myParams = "nodeId="+nodeId ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("jsCode","<%=rows[0][0]%>");
core.ajax.receivePacket(response);
