<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 ����11�·ݼ��ſͻ���CRM��BOSS�;���ϵͳ����ĺ�-7-��ҵӦ��������BOSSϵͳ����
 * ������: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
		System.out.println("===gaopengSeeLog========= fGetIntegral.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		String offerId	=  (String)request.getParameter("offer_id");
		String[] inParamsss5 = new String[2];
    inParamsss5[0] = "SELECT count(1) FROM product_offer where band_id = 67 and offer_attr_type = 'YnKB' and offer_id = :bofferid"; 
    inParamsss5[1] = "bofferid="+offerId;
    String ifShowIntegFlag="";
    String retCode11 = "";
    String retMsg11 = "";
		
try{		
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">			
			<wtc:param value="<%=inParamsss5[0]%>"/>
			<wtc:param value="<%=inParamsss5[1]%>"/>
		</wtc:service>
		<wtc:array id="result5y" scope="end" />
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			System.out.println("============ fGetIntegral.jsp ==========" );
			if("1".equals(result5y[0][0])){
	 	
		 		ifShowIntegFlag = "yes";
		 		
		 	}else{
		 		ifShowIntegFlag = "false";
		 	}
		 	
		}else{
			System.out.println("============ fGetIntegral.jsp ʧ��==========");
		}
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "����δ����������������ϵ����Ա��";
			
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");
response.data.add("ifShowIntegFlag","<%=ifShowIntegFlag %>");

core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         