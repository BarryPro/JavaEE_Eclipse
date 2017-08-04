<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

public String returnInsertSql(String checkGroupId,String loginGroupId,String strCreateLoginNo){
/**String strInsert="insert into dqccheckgrpgrp t(t.check_group_id,t.CHECKED_GROUP_ID,t.crete_login_no,t.create_date)";
       strInsert+=" values('"+checkGroupId+"','"+loginGroupId+"','"+strCreateLoginNo+"',sysdate)";
*/
String strInsert="insert into dqccheckgrpgrp t(t.check_group_id,t.CHECKED_GROUP_ID,t.crete_login_no,t.create_date)";
strInsert+=" values( :v1, :v2, :v3,sysdate)";
strInsert+="&&"+checkGroupId+"^"+loginGroupId+"^"+strCreateLoginNo;
       return strInsert;
}
public String returnDeleteSql(String checkGroupId){
/**String strDelete="delete dqccheckgrpgrp t where t.check_group_id='"+checkGroupId+"'";
*/
String strDelete="delete dqccheckgrpgrp t where t.check_group_id= :v1";
strDelete+="&&"+checkGroupId;
       return strDelete;
}
public String returnCountSql(String checkGroupId){
				String strDelete="select to_char(nvl(count(1),0)) from dqccheckgrpgrp  t where t.check_group_id = :checkGroupId and rownum<2";
				myParams = "checkGroupId="+checkGroupId ;
       return strDelete;
}
public String returnLogSQL(String op_code,String login_no,String org_code,String ip_addr,String op_note){
/***String strLog="insert into dbcalladm.wloginopr t1 (t1.login_accept,t1.op_code,t1.op_time,t1.op_date,t1.login_no,t1.org_code,t1.ip_addr,t1.op_note,t1.flag)";
			strLog+=" values (SEQ_WLOGINOPR.NEXTVAL,'"+op_code+"',sysdate,to_char(sysdate,'yyyymmdd'),'"+login_no+"','"+org_code+"','"+ip_addr+"','"+op_note+"','I')";
*/
String strLog="insert into dbcalladm.wloginopr t1 (t1.login_accept,t1.op_code,t1.op_time,t1.op_date,t1.login_no,t1.org_code,t1.ip_addr,t1.op_note,t1.flag)";
strLog+=" values (SEQ_WLOGINOPR.NEXTVAL, :v1,sysdate,to_char(sysdate,'yyyymmdd'), :v2, :v3, :v4, :v5,'I')";
strLog+="&&"+op_code+"^"+login_no+"^"+org_code+"^"+ip_addr+"^"+op_note;
			return strLog;
} 
%>
<%
//删除被质检组和工号关系 
//获取参数
String workNo = (String)session.getAttribute("workNo");
String orgCode = (String)session.getAttribute("orgCode");
String ip_Addr = (String)session.getAttribute("ipAddr");
String checkGroupId=request.getParameter("checkGroupId");
String strAddArr=request.getParameter("loginGroupIdArr");
String strIP=(String)request.getRemoteAddr(); 
String strSql= returnCountSql(checkGroupId);
List sqlList=new ArrayList();
String[] sqlArr = new String[]{};
int countInt=0;
String [] tempAddArr = new String[0];
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=strSql%>" />
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:row id="row"   start="0"  length="1">
<%
countInt =Integer.valueOf(row [0]).intValue();%>
</wtc:row>	
<%  
if(!"".equalsIgnoreCase(strAddArr)){
	tempAddArr=strAddArr.split(",");
	if(countInt>0){
	  sqlList.add(returnDeleteSql(checkGroupId));
	  }
		for(int i=0;i<tempAddArr.length;i++){
			sqlList.add(returnInsertSql(checkGroupId,tempAddArr[i],workNo));
			sqlList.add(returnLogSQL("K300",workNo,orgCode,strIP,"新增质检组->"+checkGroupId+"与被检组->"+tempAddArr[i]+"对应关系"));
		}
	
}

sqlArr = (String[])sqlList.toArray(new String[0]);
String outnum = String.valueOf(sqlArr.length + 1);   
%>

<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value="<%=""%>"/>
    <wtc:param value="dbchange"/>
    <wtc:params value="<%=sqlArr%>"/>
</wtc:service>

<wtc:array id="retRows"  scope="end"/>	

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);