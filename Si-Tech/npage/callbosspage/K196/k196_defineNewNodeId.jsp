<%
  /*
   * 功能: 196特殊名单->新增
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
	String parId = WtcUtil.repNull(request.getParameter("selectItemId"));
	String sql="select t.funcid from SCALLSPECIALLIST t where t.parfuncid=:parId  and rownum=1 order by funcid desc";
  myParams="parId="+parId;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
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
