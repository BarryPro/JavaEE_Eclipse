<%
  /*
   * 功能: 考评计划添加逻辑
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: tancf
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

//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
String sqlStr = "select to_char(seq_qc_plan.nextval) from dual";
String workNo = (String)session.getAttribute("workNo");
String[] bqc = new String[]{};
String[] qc = new String[]{};
String[] content_id = new String[]{};
String[] object_id = new String[]{};
bqc = (String[])request.getParameterValues("bqcArray");
qc = (String[])request.getParameterValues("qcArray");
content_id = (String[])request.getParameterValues("content_id");
object_id = (String[])request.getParameterValues("object_id");
String[] sqlArr = new String[]{};
List sqlList = new ArrayList();
String CHECK_TYPE = request.getParameter("CHECK_TYPE");
String CHECK_CLASS = request.getParameter("CHECK_CLASS");
String MIN_TIME = request.getParameter("MIN_TIME");
String CHECK_KIND = request.getParameter("CHECK_KIND");
String start_date = request.getParameter("start_date");
String MAX_TIME = request.getParameter("MAX_TIME");
String PLAN_NAME = request.getParameter("PLAN_NAME");
String end_date = request.getParameter("end_date");
String PRIORITY = request.getParameter("PRIORITY");
String GROUP_FLAG = request.getParameter("GROUP_FLAG");
String PLAN_TIME = request.getParameter("PLAN_TIME");
String bqcgroupType = request.getParameter("bqc_no_ser_Type");

for(int i=0;i<content_id.length;i++){
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList"  scope="end"/>	


<%

String strDeldqcplanTemp="insert into  dqcplan"+
"(plan_id,object_id,content_id,plan_name,begin_date,end_date,"+
"plan_time,min_time,max_time,check_type,check_kind,group_flag,"+
"group_id,check_class,check_item,priority,max_item,min_item,"+
"note,alert_days,alert_value,crete_login_no,create_date,"+
"update_login_no,update_date,bak1,bak2,bak3,current_times,BQCGROUPTYPE)values(:v1,";

String strDelDQCLOGINPLANTemp="insert into DQCLOGINPLAN"+
"(plan_id,object_id,content_id,plan_name,begin_date,end_date,check_type,"+
"check_kind,login_no,plan_time,min_time,max_time,real_time,group_flag,"+
"group_id,check_class,note,alert_days,alert_value,alert_flag,"+
"crete_login_no,create_date,update_login_no,update_date,bak1,bak2,bak3)values(:v1,";

String strDelDQCCHECKLOGINPLANTemp="insert into DQCCHECKLOGINPLAN "+
"(plan_id,check_login_no,crete_login_no,create_date,"+
"update_login_no,update_date,bak1,bak2,bak3)values(:v1,";




int totalLength= bqc.length+qc.length+content_id.length;
String sSql="";
sSql=strDeldqcplanTemp+":v2,:v3,:v4,to_date(:v5,'yyyyMMdd hh24:mi:ss'),to_date(:v6,'yyyyMMdd hh24:mi:ss'),"+
":v7,:v8,:v9,:v10,:v11,:v12,"+
"'',:v13,'',:v14,'','','"+
"','','',:v15,sysdate,'"+
"',null,'','','','0',:v16)&&"+queryList[0][0]+"^"+object_id[i]+"^"+content_id[i]+"^"+PLAN_NAME+"^"+start_date+"^"+end_date+"^"+PLAN_TIME
+"^"+MIN_TIME+"^"+MAX_TIME+"^"+CHECK_TYPE+"^"+CHECK_KIND+"^"+GROUP_FLAG+"^"+CHECK_CLASS+"^"+PRIORITY+"^"+workNo+"^"+bqcgroupType;

sqlList.add(sSql);



	for(int j=0;j<bqc.length;j++)
	{
		String tempSql="";
		tempSql=strDelDQCLOGINPLANTemp+":v2,:v3,:v4,to_date(:v5,'yyyyMMdd hh24:mi:ss'),to_date(:v6,'yyyyMMdd hh24:mi:ss'),:v7,"+
		":v8,:v9,:v10,:v11,:v12,'',:v13,'"+
		"',:v14,'','','','',:v15"+
		",sysdate,'',null,'','','')&&"+queryList[0][0]+"^"+object_id[i]+"^"+content_id[i]+"^"+PLAN_NAME+"^"+start_date+"^"+end_date+"^"+CHECK_TYPE+"^"+CHECK_KIND+"^"+bqc[j]
		+"^"+PLAN_TIME+"^"+MIN_TIME+"^"+MAX_TIME+"^"+GROUP_FLAG+"^"+CHECK_CLASS+"^"+workNo;
		sqlList.add(tempSql);

	}



	for(int j=0;j<qc.length;j++)
	{
		String tempSql="";
		tempSql=strDelDQCCHECKLOGINPLANTemp+":v2,:v3,sysdate,'"+
		"',null,'','','')&&"+queryList[0][0]+"^"+qc[j]+"^"+workNo;
		sqlList.add(tempSql);

	}
}

sqlArr = (String[])sqlList.toArray(new String[0]);
List sqlList_temp = new ArrayList();
String[] sqlArr2 = new String[]{};
String outnum = String.valueOf(sqlArr.length + 1); 
%>
<%
for(int i = 0; i < sqlArr.length; i++){   
int m = i%20;
if(m==0) {
if(i!=0){
sqlArr2 = (String[])sqlList_temp.toArray(new String[0]);
outnum = String.valueOf(sqlArr2.length + 1);
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr2%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
<%
sqlList_temp = new ArrayList();
}
}
sqlList_temp.add(sqlArr[i]);
if(i==sqlArr.length-1){
sqlArr2 = (String[])sqlList_temp.toArray(new String[0]);
outnum = String.valueOf(sqlArr2.length + 1);
		%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr2%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>		
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);	
		<%
break;
}
}
%>
