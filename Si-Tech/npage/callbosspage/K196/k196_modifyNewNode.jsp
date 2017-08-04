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
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String nodeId   = WtcUtil.repNull(request.getParameter("nodeId"));
	String note     = WtcUtil.repNull(request.getParameter("note"));
	String workNo = (String)session.getAttribute("workNo");	// boss工号代码
	String ip = request.getRemoteAddr();
	
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2); 
	
	/**String sql_update="update SCALLSPECIALLIST t set t.funcname='"+nodeName+"', t.note='"+note+"'  where t.funcid= '"+nodeId+"'";
	*/
	String sql_update="update SCALLSPECIALLIST t set t.funcname= :v1, t.note= :v2  where t.funcid=  :v3";
	sql_update+="&&"+nodeName+"^"+note+"^"+nodeId;
 
	//批量操作
	List sqlList=new ArrayList();
	String[] sqlArr = new String[]{};
	sqlList.add(sql_update);
 
	sqlArr=(String[])sqlList.toArray(new String[0]);
	String outnum = String.valueOf(sqlArr.length + 1); 
	
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value=""/>
    <wtc:param value="dbchange"/>
    <wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("nodeName","<%=nodeName%>");
response.data.add("note","<%=note%>");
core.ajax.receivePacket(response);
