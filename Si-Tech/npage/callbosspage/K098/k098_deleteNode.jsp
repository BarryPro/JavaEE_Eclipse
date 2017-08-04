<%
  /*
   * 功能: 098权限角色管理->维护权限功能->删除
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
	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String par_Id= WtcUtil.repNull(request.getParameter("par_Id"));
	String workNo = (String)session.getAttribute("workNo");	// boss工号代码
     String ip = request.getRemoteAddr();	

	//迭代删除该节点及其子节点
	//String sql_del="delete from DCALLQUERYFUNCLIST t where t.funcid='"+nodeId+"' or t.parfuncid='"+nodeId+"'";
	String sql_del="update DCALLQUERYFUNCLIST t set t.is_del='Y' where t.funcid=:v1 or t.parfuncid=:v2&&"+nodeId+"^"+nodeId;
	String sql_log="insert into dbcalladm.wloginopr values(seq_wloginopr.nextval,'K098',sysdate,to_char(sysdate,'yyyymmdd'),:v1,'','',:v2,:v3,'I','','','')&&"+workNo+"^"+ip+"^删除权限["+nodeId+"]及其子所有权限:该权限名称-->"+nodeName;
	//批量操作
	List sqlList=new ArrayList();
	String[] sqlArr = new String[]{};
	sqlList.add(sql_del);
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
response.data.add("par_Id","<%=par_Id%>");
core.ajax.receivePacket(response);
