<%
  /*
   * ����: 098Ȩ�޽�ɫ����->��ѯ���ܵ��Ӧ�Ľ�ɫ,��Ϊ���ݻ����ṩ��ʶ
�� * �汾: 1.0.0
�� * ����: 2008/1/16
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update: yinzx 2009/07/16  �ͷ����ܵ���
   *													 1.�޸Ļ�ȡ��ɫsql ʹ�� select a.power_code, a.power_name, b.ROLETYPE_NAME,a.POWER_DESCRIBE, decode((select count(*) from sPowerCode where power_code like trim(a.power_code)||'%' and use_flag ='Y'),1,'Y','N')  from sPowerCode a, sRoleTypeCode b where power_code like '0110%' and length(trim(power_code)) = length('0110')+2 and   a.roletype_code = b.ROLETYPE_CODE and a.use_flag='Y' order by a.power_code 
�� *                             ��������Ҫȷ��
   *													 2.�޸� ��ѯ���� ��DCALLQUERYROLEMENU ���ڿͷ��⣬ȥ���ڶ�����ѯ����ĵڶ�������
   */

%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
    /*midify by yinzx 20091113 ������ѯ�����滻*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
String selectedItemId = WtcUtil.repNull(request.getParameter("selectedItemId"));
String workNo=(String)session.getAttribute("workNo");

String sql_getExistRoles="select t.role_id from DCALLQUERYROLEMENU t where t.menu_id=:selectedItemId ";
myParams="selectedItemId="+selectedItemId;
String sql_getRoles="select a.power_name, a.power_code "+
	                "  from sPowerCode a, sRoleTypeCode b "+
                     "  where   a.roletype_code='9' and a.roletype_code = b.ROLETYPE_CODE and a.use_flag = 'Y' union select 'ʡ�ͷ�����','0110' from dual";
 
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
	<wtc:param value="<%=sql_getExistRoles%>" />
	<wtc:param value="<%=myParams%>" />
</wtc:service>
<wtc:array id="existRoleList" scope="end"/>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
	<wtc:param value="<%=sql_getRoles%>" />
</wtc:service>
<wtc:array id="resultList" scope="end"/>

var nodes=new Array();
var hasRoleidFlag=new Array();
<%
	for(int i=0;i<resultList.length;i++){
	//System.out.println(">>>>>���е� role_id = "+resultList[i][1]);
			//Ĭ�Ͻ�ɫ�ǲ����ڵ�
		%>
			hasRoleidFlag[<%=i%>]=false;
		<%
		if(existRoleList.length>0){
			//System.out.println("existRoleList.length = "+existRoleList.length);
			for(int k=0;k<existRoleList.length;k++){
				//�ж��Ѿ�ӵ�е�roleid
				//System.out.println("���ڵ� role_id = "+existRoleList[k][0]);
				if(resultList[i][1].equalsIgnoreCase(existRoleList[k][0])){
				%>
					hasRoleidFlag[<%=i%>]=true;
				<%			
					break;	
				}				
			}		
		}
%>
          var tempArr=new Array();
	<%	
		for(int j=0;j<resultList[i].length;j++){
	%>
			tempArr[<%=j%>]='<%=resultList[i][j]%>';
	<%
		}
	%>
		nodes[<%=i%>]=tempArr;
<%
	}
%>

var response = new AJAXPacket();
response.data.add("nodes",nodes);
response.data.add("flag",hasRoleidFlag);
core.ajax.receivePacket(response);

