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
	String nodeId = WtcUtil.repNull(request.getParameter("selectedItemId"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String message= WtcUtil.repNull(request.getParameter("message"));
	String font_bg_color = WtcUtil.repNull(request.getParameter("font_bg_color"));
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2); 
  /* add by yinzx 20091120 不定义变量 直接传 "" 出错 */
	String sqlMulKfCfm="";
	
	/**String sql_update="update SCALLSPECIALLIST t set t.bak1='"+message+"', t.bak2='"+font_bg_color+"'  where t.funcid= '"+nodeId+"'";
	*/
	String sql_update="update SCALLSPECIALLIST t set t.bak1= :v1, t.bak2= :v2  where t.funcid=  :v3";
	sql_update+="&&"+message+"^"+font_bg_color+"^"+nodeId;
	 
	List sqlList=new ArrayList();
	String[] sqlArr = new String[]{};
	sqlList.add(sql_update);
 
	sqlArr=(String[])sqlList.toArray(new String[0]);
	String outnum = String.valueOf(sqlArr.length + 1); 
%>

<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value="<%=sqlMulKfCfm %>"/>
    <wtc:param value="dbchange"/>
    <wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);
