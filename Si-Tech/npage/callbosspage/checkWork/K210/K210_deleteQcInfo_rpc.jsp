<%
  /*
   * ����: ֪ͨ���ͼ�¼ɾ��
�� * �汾: 1.0
�� * ����: 2009/09/08
�� * ����: guozw
�� * ��Ȩ: sitech
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

//֪ͨ���ͼ�¼ɾ��
//��ȡ����
String workNo = (String)session.getAttribute("workNo");

String serialnum=request.getParameter("serialnum");

String getDCCContact_id = "select recordernum,objectid,contentid,plan_id,staffno,checkflag from dqcinfo where serialnum = :serialnum ";
myParams = "serialnum="+serialnum ;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="6">
	<wtc:param value="<%=getDCCContact_id%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
<wtc:array id="dCCContact_id" scope="end"/>
<%
String contact_id = "";
String objectid = "";   //��������id
String contentid = "";	//��������id
String plan_id = "";		//�ƻ�id
String staffno = "";		//���칤��
String checkflag = "";		//���˱�ʶ  0 Ϊ����ʱ�������ʼ��¼��-1Ϊ�����ʼ�����ļ�¼

if(dCCContact_id.length!=0){
					contact_id = dCCContact_id[0][0];
					objectid = dCCContact_id[0][1];
					contentid = dCCContact_id[0][2];
					plan_id = dCCContact_id[0][3];
					staffno = dCCContact_id[0][4];
					checkflag = dCCContact_id[0][5];

}		
		 
/**old sql : String strCheck = "update dqcinfo set isremarkflag = '00'  where serialnum = '" + serialnum + "' ";
*/
String strCheck = "update dqcinfo set isremarkflag = '00' where serialnum = :v1 ";
%>
    
<wtc:service name="sPubModifyKfCfm" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=strCheck%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=serialnum%>"/>
	</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);