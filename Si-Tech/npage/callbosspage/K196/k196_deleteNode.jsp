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
	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String par_Id= WtcUtil.repNull(request.getParameter("par_Id"));
	String workNo = (String)session.getAttribute("workNo");	// boss工号代码
     String ip = request.getRemoteAddr();	
	
     String orgCode = (String)session.getAttribute("orgCode");
     String regionCode = orgCode.substring(0,2); 
     
	//迭代删除该节点及其子节点
	//String sql_del="delete from SCALLSPECIALLIST t where t.funcid='"+nodeId+"' or t.parfuncid='"+nodeId+"'";
	/**String sql_del="update SCALLSPECIALLIST t set t.is_del='Y' where t.funcid='"+nodeId+"' or t.parfuncid='"+nodeId+"'";
	*/
	String sql_del="update SCALLSPECIALLIST t set t.is_del='Y' where t.funcid= :v1 or t.parfuncid= :v2";
	sql_del += "&&"+nodeId+"^"+nodeId;
	 
	List sqlList=new ArrayList();
	String[] sqlArr = new String[]{};
	sqlList.add(sql_del);
 
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
response.data.add("par_Id","<%=par_Id%>");
core.ajax.receivePacket(response);
