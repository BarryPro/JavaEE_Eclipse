<%
  /*
   * 功能: 质检权限管理->维护质检员和组->删除质检组和工号关系
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: 
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
public String returnInsertSql(String strItemId,String strLoginNo,String strCreateLoginNo){
/**String strInsert="insert into dqccheckgrouplogin t (t.check_group_id,t.check_login_no,t.valid_flag,";
       strInsert+="t.create_login_no,t.create_date)";
       strInsert+=" values('"+strItemId+"','"+strLoginNo+"','Y','"+strCreateLoginNo+"',sysdate)";
*/
String strInsert="insert into dqccheckgrouplogin t (t.check_group_id,t.check_login_no,t.valid_flag,";
strInsert+="t.create_login_no,t.create_date)";
strInsert+=" values( :v1, :v2,'Y', :v3,sysdate)";
strInsert+="&&"+strItemId+"^"+strLoginNo+"^"+strCreateLoginNo;
       return strInsert;

}
public String returnDeleteSql(String strItemId,String strLoginNo){
/**String strDelete="delete dqccheckgrouplogin t where t.check_group_id='"+strItemId+"' and t.check_login_no='"+strLoginNo+"'";
*/
String strDelete="delete dqccheckgrouplogin t where t.check_group_id= :v1 and t.check_login_no= :v2";
	strDelete+="&&"+strItemId+"^"+strLoginNo;
       return strDelete;
}
public String returnLogSql(String op_code,String login_no,String org_code,String ip_addr,String op_note){
/**			String strLog="insert into dbcalladm.wloginopr t1 (t1.login_accept,t1.op_code,t1.op_time,t1.op_date,t1.login_no,t1.org_code,t1.ip_addr,t1.op_note,t1.flag)";
			strLog+=" values (SEQ_WLOGINOPR.NEXTVAL,'"+op_code+"',sysdate,to_char(sysdate,'yyyymmdd'),'"+login_no+"','"+org_code+"','"+ip_addr+"','"+op_note+"','I')";
*/
String strLog="insert into dbcalladm.wloginopr t1 (t1.login_accept,t1.op_code,t1.op_time,t1.op_date,t1.login_no,t1.org_code,t1.ip_addr,t1.op_note,t1.flag)";
strLog+=" values (SEQ_WLOGINOPR.NEXTVAL, :v1,sysdate,to_char(sysdate,'yyyymmdd'), :v2, :v3, :v4, :v5,'I')";
strLog+="&&"+op_code+"^"+login_no+"^"+org_code+"^"+ip_addr+"^"+op_note;
			return strLog;
} 
%>
<%

//删除质检组和质检工号关系 
//获取参数
String workNo = (String)session.getAttribute("workNo");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2); 

String ip_Addr = (String)session.getAttribute("ipAddr");
String strItemId=request.getParameter("selectedItemId");
String strAddArr=request.getParameter("unCheckValue");
String strDelArr=request.getParameter("groupCheckValue");
String strIP=(String)request.getRemoteAddr();  
String strsql="";
List sqlList=new ArrayList();
String[] sqlArr = new String[]{};
String[] sqlArr2 = new String[]{};
List sqlList_temp = new ArrayList();
String [] tempAddArr = new String[0];
String [] tempDelArr = new String[0];
if(!"".equalsIgnoreCase(strAddArr)){
tempAddArr=strAddArr.split(",");
for(int i=0;i<tempAddArr.length;i++){
sqlList.add(returnInsertSql(strItemId,tempAddArr[i],workNo));
//sqlList.add(returnLogSql("RK290",workNo,orgCode,strIP,"新增质检组->"+strItemId+"与工号->"+tempAddArr[i]+"对应关系"));
}
}
if(!"".equalsIgnoreCase(strDelArr)){
tempDelArr=strDelArr.split(",");
for(int i=0;i<tempDelArr.length;i++){
sqlList.add(returnDeleteSql(strItemId,tempDelArr[i]));
//sqlList.add(returnLogSql("RK290",workNo,orgCode,strIP,"新增质检组->"+strItemId+"与工号->"+tempDelArr[i]+"对应关系"));
 }
}

sqlArr = (String[])sqlList.toArray(new String[0]);
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

<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value=""/>
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
		
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value=""/>
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