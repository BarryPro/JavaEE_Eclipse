<%
  /*
   * ����: ������֤->������֤�����dMantoIvr��check��֤�ֶ�
�� * �汾: 1.0.0
�� * ����: 2008/3/2
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String contactId = WtcUtil.repNull(request.getParameter("contactId"));
	String result   = WtcUtil.repNull(request.getParameter("result"));
	String sql="update dmantoivr t ";
	String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
	if(result.equalsIgnoreCase("0")){
		//������֤
		sql+=" set t.checkflag='Y' where t.contact_id=:v1";
	}else{
		sql+=" set t.checkflag='N' where t.contact_id=:v1";
	}
	System.out.println("============$$$$$$$$$$$$================");
	System.out.println("===========$$$$$$$$$$$$$$$$==============================");
	System.out.println("======================================================");
	System.out.println("======================================================");
	System.out.println("sql=  "+sql);
	System.out.println("======================================================");
	System.out.println("======================================================");
	System.out.println("======================================================");
	System.out.println("======================================================");
%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
<wtc:param value="<%=sql%>"/>
<wtc:param value="dbchange"/>
<wtc:param value="<%=contactId%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
