<%
  /*
   * 功能: 098权限角色管理->维护权限功能->修改(业务逻辑)
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
//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String nodeId   = WtcUtil.repNull(request.getParameter("nodeId"));
	String note     = WtcUtil.repNull(request.getParameter("note"));
	String workNo = (String)session.getAttribute("workNo");	// boss工号代码
	String ip = request.getRemoteAddr();
	String sql_update="update DCALLQUERYFUNCLIST t set t.funcname=:v1, t.note=:v2  where t.funcid= :v3&&"+nodeName+"^"+note+"^"+nodeId;
	String sql_log="insert into dbcalladm.wloginopr values(seq_wloginopr.nextval,'K098',sysdate,to_char(sysdate,'yyyymmdd'),:v1,'','',:v2,:v3,'I','','','')&&"+workNo+"^"+ip+"^修改权限["+nodeId+"]:名称-->"+nodeName+", 描述-->"+note;
	//批量操作
	List sqlList=new ArrayList();
	String[] sqlArr = new String[]{};
	sqlList.add(sql_update);
	sqlList.add(sql_log);
	sqlArr=(String[])sqlList.toArray(new String[0]);
	String outnum = String.valueOf(sqlArr.length + 1); 
	
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("nodeName","<%=nodeName%>");
response.data.add("note","<%=note%>");
core.ajax.receivePacket(response);
