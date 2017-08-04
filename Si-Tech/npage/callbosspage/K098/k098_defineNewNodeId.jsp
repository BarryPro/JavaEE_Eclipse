<%
  /*
   * 功能: 098权限角色管理->维护权限功能->新增->系统生成节点ID
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

	String parId = WtcUtil.repNull(request.getParameter("selectItemId"));
	String sql="select t.funcid from DCALLQUERYFUNCLIST t where t.parfuncid=:parId and rownum=1 order by funcid desc";
	myParams = "parId="+parId ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

<%	
	String newNodeId;
	if(rows.length>0){
		String brotherId = rows[0][0];
		char suffix=brotherId.charAt(brotherId.length()-1);
		newNodeId=parId+(char)(suffix+1);
	}else{
		newNodeId=parId+"A"	;
	}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("newNodeId","<%=newNodeId%>");
core.ajax.receivePacket(response);
