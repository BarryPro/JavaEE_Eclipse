<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%


//֪ͨ���ͼ�¼ɾ��
//��ȡ����
String msg_id=request.getParameter("msg_id");
//add by hucw,20100617
String serv_addr=request.getParameter("serv_addr");
/** old sql:String str="DELETE dcrmcallcfg WHERE agent_ip =  '"+msg_id+"' ";
*/
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
//modify by hucw,20100617,ͨ��bak2��agent_ip2���ֶβ���Ψһ��ʶdcrmcallcfg��
String str="DELETE from dcrmcallcfg WHERE agent_ip =   :v1 and bak2= :v2";
//String str="DELETE dcrmcallcfg WHERE agent_ip =   :v1 ";
%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=str%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=msg_id%>"/>
	<wtc:param value="<%=serv_addr%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);

