<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά�����칤�ź���->������ˮ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: zengzq
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
//����insert���
public String returnInsertSql(String strItemId,String strSerialNo,String strCreateLoginNo){
		String strInsert="insert into DqcCheckedSerialNos t (t.login_group_id,t.SerialNo,t.valid_flag,";
		strInsert+="t.crete_login_no,t.create_date)";
		strInsert+=" values('"+strItemId+"','"+strSerialNo+"','Y','"+strCreateLoginNo+"',sysdate)";
		return strInsert;
}

public String returnDeleteSql(String strItemId,String strSerialNo){
		String strDelete="delete DqcCheckedSerialNos t where t.login_group_id='"+strItemId+"' and t.SerialNo='"+strSerialNo+"'";
    return strDelete;
}

public String returnLogSQL(String op_code,String login_no,String org_code,String ip_addr,String op_note){
			String strLog="insert into dbcalladm.wloginopr t1 (t1.login_accept,t1.op_code,t1.op_time,t1.op_date,t1.login_no,t1.org_code,t1.ip_addr,t1.op_note,t1.flag)";
			strLog+=" values (SEQ_WLOGINOPR.NEXTVAL,'"+op_code+"',sysdate,to_char(sysdate,'yyyymmdd'),'"+login_no+"','"+org_code+"','"+ip_addr+"','"+op_note+"','I')";
			return strLog;

} 
%>
<%
//ɾ�����ʼ���͹��Ź�ϵ 
//��ȡ����
String workNo = (String)session.getAttribute("workNo");
String orgCode = (String)session.getAttribute("orgCode");
String ip_Addr = (String)session.getAttribute("ipAddr");
String strItemId = request.getParameter("selectedItemId");   			//���ʼ���ID
String strAddArr = request.getParameter("unCheckValue");          //׼����ӵ���ˮ�ţ����ŷָ�
String strDelArr = request.getParameter("groupCheckValue");       //ԭ��ѡ�У�����ȡ���Ĺ���
String strIP = (String)request.getRemoteAddr();  
List sqlList = new ArrayList();
String[] sqlArr = new String[]{};
String[] sqlArr2 = new String[]{};
List sqlList_temp = new ArrayList();
String [] tempAddArr = new String[0];
String [] tempDelArr = new String[0];
//����ʱ������ˮ�����Ѿ��������ݣ���ɾ���������ű��д��ڸñ��������ݣ�Ҳɾ������ͬһʱ�䣬����ˮ��ͱ��칤�ű���ֻ����һ�������м�¼ zengzq 20091104
String getCountSql = "select count(1) from DqcCheckedSerialNos where login_group_id='" + strItemId + "'";
String tmpCount = "0";
String getLoginNoCountSql = "select count(1) from DQCLOGINGROUPLOGIN where login_group_id='" + strItemId + "'";
String tmpLoginNoCount = "0";
//������ˮ�Ϸ���У��
String judgeIfExist = null;
String tmpIsExit = "0";
String dcallTableName = null;
int succ1 = 0;
int fail1 = 0;
StringBuffer notIsExitBuffer = new StringBuffer();
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=getCountSql%>"/>
	</wtc:service>
	<wtc:array id="getCount" scope="end"/>
<%
if(getCount.length>0){
  	tmpCount=getCount[0][0];
}

if(Integer.parseInt(tmpCount)>0){ 	
		String tmpDSql = "delete DqcCheckedSerialNos t where t.login_group_id='" + strItemId + "'";
		sqlList.add(tmpDSql);
}
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=getLoginNoCountSql%>"/>
	</wtc:service>
	<wtc:array id="getCount1" scope="end"/>
<%
if(getCount1.length>0){
  	tmpLoginNoCount=getCount1[0][0];
}
if(Integer.parseInt(tmpLoginNoCount)>0){ 	
		String tmpDSql = "delete DQCLOGINGROUPLOGIN t where t.login_group_id='" + strItemId + "'";
		sqlList.add(tmpDSql);
}

if(!"".equalsIgnoreCase(strAddArr)){
		tempAddArr=strAddArr.split(",");
		System.out.println(":---------------------------------------------------------");
		for(int i=0;i<tempAddArr.length;i++){
				tmpIsExit = "0";
				if(tempAddArr[i].length()>15){
						dcallTableName = "dcallcall" + tempAddArr[i].substring(0,6);
				}else{
						notIsExitBuffer.append(tempAddArr[i]);
						notIsExitBuffer.append(",");
						fail1 = fail1+1;
						System.out.println(tempAddArr[i]);
						continue;
				}
				//�ж���dcallcall�� �Ƿ��ж�Ӧ����ˮ��Ϣ��������Ϊ������ˮ��¼����ˮ��������һ����ˮ�ж�
				judgeIfExist = "select count(1) from " + dcallTableName + " where contact_id='" + tempAddArr[i]+"'";
		%>
				<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=judgeIfExist%>" />
						</wtc:service>
				<wtc:array id="isExitResult" scope="end"/>
			
		<%
				if(isExitResult.length>0){
						tmpIsExit = isExitResult[0][0];
				}
				if(Integer.parseInt(tmpIsExit) > 0){ 	
						sqlList.add(returnInsertSql(strItemId,tempAddArr[i],workNo));
						succ1 = succ1+1;
				}else{
						System.out.println(tempAddArr[i]);
						notIsExitBuffer.append(tempAddArr[i]);
						notIsExitBuffer.append(",");
						fail1 = fail1+1;
				}
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
			<wtc:service name="sPubModify"  outnum="<%=outnum%>">
			<wtc:params value="<%=sqlArr2%>"/>
			<wtc:param value="dbcall"/>	
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
		<wtc:service name="sPubModify"  outnum="<%=outnum%>">
		<wtc:params value="<%=sqlArr2%>"/>
		<wtc:param value="dbcall"/>	
		</wtc:service>
		<wtc:array id="retRows"  scope="end"/>
		<%
		break;
		}
}
%>
var response = new AJAXPacket();
		response.data.add("retCode","<%=retCode%>");
		response.data.add("notIsExitBuffer","<%=notIsExitBuffer%>");
		response.data.add("succ1","<%=succ1%>");
		response.data.add("fail1","<%=fail1%>");
		core.ajax.receivePacket(response);