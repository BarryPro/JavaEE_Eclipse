<%
  /*
   * 功能: 098权限角色管理->维护权限功能->新增->校验用户输入的nodeId
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

	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String sql="select t.funcid from DCALLQUERYFUNCLIST t where t.funcid=:nodeId ";
	myParams = "nodeId="+nodeId ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />
<%
	if(rows.length>0){
		//nodeId已存在
		retCode="000001";
	}else{
		//nodeId通过验证
		retCode="000000";
	}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);