<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%System.out.println("----------------------------ajaxGetEPf.jsp--------�Ѵ��������ַ���������۽ӻ�ȥ----------------------------");  %>

<%
	String tempNote_info2v = WtcUtil.repNull(request.getParameter("tempNote_info2v"));
	String erPCode = "";
	String erPDesc = "";
	String regionCode = (String)session.getAttribute("regCode");
	
	System.out.println("tempNote_info2v|"+tempNote_info2v);
	String workNo = (String)session.getAttribute("workNo");
	String retResultStr = "";
			
%>

    <wtc:service name="sGetDetailCode" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=tempNote_info2v%>" />
			<wtc:param value="<%=workNo%>" />	
			<wtc:param value="q001" />	
		</wtc:service>
		<wtc:array id="result_t33" scope="end"   />

<%
	System.out.println("<<------------result_t33.length----------->>"+result_t33.length);
		if(code.equals("000000") && result_t33.length > 0){
			for(int j=0;j<result_t33.length;j++){
				retResultStr = retResultStr+" �������۴��룺"+result_t33[j][2];
				retResultStr = retResultStr+" ��������������"+result_t33[j][3];
				retResultStr = retResultStr+" ���ں�OfferId��"+result_t33[j][4];
				retResultStr = retResultStr+" ���ں�������룺"+result_t33[j][5];
				retResultStr = retResultStr+" ���ں��ʷ����ƣ�"+result_t33[j][6];
				retResultStr = retResultStr+" ���ں��ʷ�������"+result_t33[j][7];
			}
		}
	retResultStr = retResultStr+"|";
	System.out.println("---------------retResultStr--------------");
	System.out.println(retResultStr);
	System.out.println("---------------retResultStr--------------");
%>
var response = new AJAXPacket();
response.data.add("retResultStr","<%=retResultStr%>");
core.ajax.receivePacket(response);

