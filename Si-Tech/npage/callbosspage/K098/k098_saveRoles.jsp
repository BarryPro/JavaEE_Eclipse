<%
  /*
   * ����: 098Ȩ�޽�ɫ����->���ܵ��Ӧ�Ľ�ɫ�б���(ҵ���߼�)
�� * �汾: 1.0.0
�� * ����: 2008/1/16
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!


public String returnInsertSql(String menuId,String roleId,String workNo){
	String str="merge into DCALLQUERYROLEMENU t1" +
	            " using(select :v1 as menu_id,:v2 as role_id from dual) t2" +
	            " on (t1.menu_id=t2.menu_id and t1.role_id=t2.role_id)" +
	            " when matched then" +
	            " update set t1.create_time=sysdate ,t1.create_login_no=:v3" +
	            " when not matched then" +
	            " insert(menu_id,role_id,create_time,create_login_no) values(:v4,:v5,sysdate,:v6)&&"+menuId+"^"+roleId+"^"+workNo+"^"+menuId+"^"+roleId+"^"+workNo;	
	return str;
}

public String returnDeleteSql(String menuId,String roleId){
	String str="delete from DCALLQUERYROLEMENU t where t.role_id=:v1 and t.menu_id=:v2&&"+roleId+"^"+menuId;
     return str;
}
public String returnLogSql(String op_code,String login_no,String ip_addr,String op_note){
	String strLog="insert into dbcalladm.wloginopr t1 (t1.login_accept,t1.op_code,t1.op_time,t1.op_date,t1.login_no,t1.ip_addr,t1.op_note,t1.flag)";
	strLog+=" values (SEQ_WLOGINOPR.NEXTVAL,:v1,sysdate,to_char(sysdate,'yyyymmdd'),:v2,:v3,:v4,'I')&&"+op_code+"^"+login_no+"^"+ip_addr+"^"+op_note;
	return strLog;
} 				

%>
<%
 //jiangbing 20091118 ���������滻
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
//��ȡ����
String workNo = (String)session.getAttribute("workNo");
String ip = request.getRemoteAddr();	
String selectedItemId = WtcUtil.repNull(request.getParameter("selectedItemId"));
String chkArr_Roles = "";
if(request.getParameter("chkedRolesArr")!=null)
	chkArr_Roles = (String)request.getParameter("chkedRolesArr");
String unchkArr_Roles = WtcUtil.repNull(request.getParameter("unChkedRolesArr"));
//System.out.println("============================================= =");
//System.out.println("selectedItemId ="+selectedItemId);
//System.out.println("chkArr_Roles ="+chkArr_Roles);
//System.out.println("unchkArr_Roles ="+unchkArr_Roles);
//
List sqlList=new ArrayList();
String[] sqlArr = new String[]{};

String[] chkArrRoles = new String[0];
String[] unchkArrRoles = new String[0];

%>

<%
//Ϊɾ������ʱ������Ч����
String sql_existRoleids="select t.role_id from DCALLQUERYROLEMENU t where t.menu_id=:selectedItemId ";
myParams = "selectedItemId="+selectedItemId ;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=sql_existRoleids%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="existRoles"  scope="end"/>	


<%

//����
if(chkArr_Roles.equalsIgnoreCase("")!=true){
//System.out.println("=========== checked is not null===========");
	chkArrRoles = chkArr_Roles.split(",");
	for(int i=0;i<chkArrRoles.length;i++){
		sqlList.add(returnInsertSql(selectedItemId,chkArrRoles[i],workNo));
		sqlList.add(returnLogSql("K098",workNo,ip,"��Ȩ��["+selectedItemId+"]�����ɫ["+chkArrRoles[i]+"]"));
	}
}else{
//System.out.println("=========== checked is null===========");
}
//ɾ��
if(unchkArr_Roles.equalsIgnoreCase("")!=true){
//System.out.println("=========== unchecked is not null===========");
	unchkArrRoles = unchkArr_Roles.split(",");
	for(int i=0;i<unchkArrRoles.length;i++){
		//���ڿ���ɾ��������ʱ��ִ��ɾ������
		if(existRoles.length>0){
		//System.out.println("=========== existRoles.length = "+existRoles.length);
			for(int j=0;j<existRoles.length;j++){
				//������Ч�Թ���(�����֧��ɾ�������ڵļ�¼)
				if(unchkArrRoles[i].equalsIgnoreCase(existRoles[j][0])){
					sqlList.add(returnDeleteSql(selectedItemId,unchkArrRoles[i]));
					sqlList.add(returnLogSql("K098",workNo,ip,"ȡ����ɫ["+unchkArrRoles[i]+"]��Ȩ��["+selectedItemId+"]"));
				}
			}		
		}
	}
}else{
//System.out.println("=========== unchecked is  null===========");
}

//ת��Ϊ�ַ�������
sqlArr = (String[])sqlList.toArray(new String[0]);
String outnum = String.valueOf(sqlArr.length + 1); 
//System.out.println("=========== 444444=========== "+sqlArr.length);
for(int i =0 ;i<sqlArr.length;i++){
	//System.out.println("sqlArr["+i+"]= ");
}
if(sqlArr.length>0){
%>

<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
<%
}else{
//System.out.println("=========== �������� =========== ");
}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);
