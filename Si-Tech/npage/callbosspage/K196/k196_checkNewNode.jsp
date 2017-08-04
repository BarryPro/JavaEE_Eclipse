<%
  /*
   * 功能: 196特殊名单 
　 * 版本: 1.0.0
　 * 日期: 2009/11/04
　 * 作者: yinzx
　 * 版权: sitech
　 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String sql="select t.funcid from SCALLSPECIALLIST t where t.funcid=:nodeId ";
	myParams="nodeId="+nodeId;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
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