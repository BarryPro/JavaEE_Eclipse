<%
  /*
   * 功能: 考评计划复制逻辑
　 * 版本: 1.0.0
　 * 日期: 2009/10/16
　 * 作者: zengzq
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
 
String sqlStr="select to_char(seq_qc_plan.nextval) from dual";

String plan_id = WtcUtil.repNull(request.getParameter("plan_id"));
String object_id = WtcUtil.repNull(request.getParameter("object_id"));
String content_id = WtcUtil.repNull(request.getParameter("content_id"));

List copyList = new ArrayList();
String[] copySql = new String[]{};
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList"  scope="end"/>	

<%

String dqcplanstr = "insert into  dqcplan"+
"(plan_id,object_id,content_id,plan_name,begin_date,end_date," +
"plan_time,min_time,max_time,check_type,check_kind,group_flag," +
"group_id,check_class,check_item,priority,max_item,min_item," +
"note,alert_days,alert_value,crete_login_no,create_date," +
"update_login_no,update_date,bak1,bak2,bak3,current_times) select " + 
":v1,object_id,content_id,'copy of '||plan_name,begin_date,end_date," +
"plan_time,min_time,max_time,check_type,check_kind,group_flag," +
"group_id,check_class,check_item,priority,max_item,min_item," +
"note,alert_days,alert_value,crete_login_no,create_date," +
"update_login_no,update_date,bak1,bak2,bak3,current_times from dqcplan where plan_id = " +
":v2 and object_id = "+
":v3 and content_id = :v4&&"+queryList[0][0]+"^"+plan_id.trim()+"^"+object_id.trim()+"^"+content_id.trim();

String dqcloginplanStr = "insert into DQCLOGINPLAN" +
"(plan_id,object_id,content_id,plan_name,begin_date,end_date,check_type," +
"check_kind,login_no,plan_time,min_time,max_time,real_time,group_flag," +
"group_id,check_class,note,alert_days,alert_value,alert_flag," +
"crete_login_no,create_date,update_login_no,update_date,bak1,bak2,bak3) select " + 
":v1,object_id,content_id,'copy of '||plan_name,begin_date,end_date,check_type," +
"check_kind,login_no,plan_time,min_time,max_time,real_time,group_flag," +
"group_id,check_class,note,alert_days,alert_value,alert_flag," +
"crete_login_no,create_date,update_login_no,update_date,bak1,bak2,bak3 from DQCLOGINPLAN where plan_id = " +
":v2 and object_id = "+
":v3 and content_id = :v4&&"+queryList[0][0]+"^"+plan_id.trim()+"^"+object_id.trim()+"^"+content_id.trim() ;

String dqccheckloginplanStr="insert into DQCCHECKLOGINPLAN " +
"(plan_id,check_login_no,crete_login_no,create_date," +
"update_login_no,update_date,bak1,bak2,bak3) select " + 
":v1,check_login_no,crete_login_no,create_date," +
"update_login_no,update_date,bak1,bak2,bak3 from DQCCHECKLOGINPLAN where plan_id = " +
":v2&&"+queryList[0][0]+"^"+plan_id.trim();

copyList.add(dqcplanstr);
copyList.add(dqcloginplanStr);
copyList.add(dqccheckloginplanStr);

copySql = (String[])copyList.toArray(new String[0]);
String outnum = String.valueOf(copySql.length + 1);
//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=copySql%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
			
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);
