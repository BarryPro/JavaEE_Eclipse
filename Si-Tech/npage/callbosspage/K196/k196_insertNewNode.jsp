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
	String newNodeId = WtcUtil.repNull(request.getParameter("newNodeId"));
	String newNodeName = WtcUtil.repNull(request.getParameter("newNodeName"));
	String parNodeId = WtcUtil.repNull(request.getParameter("parNodeId"));
	String note = WtcUtil.repNull(request.getParameter("note"));
	String isleaf = WtcUtil.repNull(request.getParameter("isleaf"));
	/* add by yinzx 20091120 不定义变量 直接传 "" 出错 */
	String sqlMulKfCfm="";
	
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2); 
	
	String workNo = (String)session.getAttribute("workNo");	// boss工号代码
     String ip = request.getRemoteAddr();
     /**String sql_insert="insert into SCALLSPECIALLIST values('"+newNodeId+"','"+newNodeName+"','"+parNodeId+"','"+note+"','','','','','','"+isleaf+"','N','jscode')";
     */
     String sql_insert="insert into SCALLSPECIALLIST values( :v1, :v2, :v3, :v4,'','','','','', :v5,'N','jscode')";
     sql_insert+="&&"+newNodeId+"^"+newNodeName+"^"+parNodeId+"^"+note+"^"+isleaf;
	 
  
	//批量操作
	List sqlList=new ArrayList();
	String[] sqlArr = new String[]{};
	sqlList.add(sql_insert);
 
	sqlArr=(String[])sqlList.toArray(new String[0]);
	String outnum = String.valueOf(sqlArr.length + 1); 
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value="<%=sqlMulKfCfm%>"/>
    <wtc:param value="dbchange"/>
    <wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("newNodeId","<%=newNodeId%>");
response.data.add("newNodeName","<%=newNodeName%>");
response.data.add("parNodeId","<%=parNodeId%>");
response.data.add("note","<%=note%>");
response.data.add("isleaf","<%=isleaf%>");
core.ajax.receivePacket(response);
