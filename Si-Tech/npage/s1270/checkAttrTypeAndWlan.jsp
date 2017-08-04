<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
 
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
 	String offerId = WtcUtil.repNull(request.getParameter("offerId"));
 	String serId = WtcUtil.repNull(request.getParameter("serId"));
 	String retCodeMy="";
 	String retMsgMy="";
 
 	String[] inParamsss1 = new String[2];
	inParamsss1[0] = "select offer_attr_type from product_offer where offer_id = :vOfferId";
	inParamsss1[1] = "vOfferId="+offerId;
	
	//��ȡ�û�id_no�����һλ
	String serIdend = serId.substring(serId.length()-1, serId.length());
	
	
	String[] inParamsss2 = new String[2];
	inParamsss2[0] = "select count(*) from ddsmpordermsg"+serIdend+"  where serv_code='02' and bizcode='WLAN0101' and valid_flag='1' and sysdate between eff_time and end_time and id_no = to_number(:v1)";
	inParamsss2[1] = "v1="+serId;

 
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
		</wtc:service>

<wtc:array id="resultAttrType" scope="end" />
<%
	if("000000".equals(retCode1) && resultAttrType.length > 0){
		String offer_attr_type = resultAttrType[0][0];
		System.out.println("gaopeng009--offer_attr_type:"+offer_attr_type);
		/*������ڰ���*/
		if(offer_attr_type.equals("YnW3")){
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">			
		<wtc:param value="<%=inParamsss2[0]%>"/>
		<wtc:param value="<%=inParamsss2[1]%>"/>	
		</wtc:service>

	<wtc:array id="resultWlanCount" scope="end" />
<%
		if("000000".equals(retCode2) && resultWlanCount.length > 0){
				int wlanCount = Integer.parseInt(resultWlanCount[0][0]);
				System.out.println("gaopeng009--wlanCount:"+wlanCount);
				/*����Ѿ�������wlan�����õ���*/
				if(wlanCount > 0){
						retCodeMy="000001";
 						retMsgMy="�ѿ�ͨwlan";
				}
				else{
					retCodeMy="000000";
 					retMsgMy="δ��ͨwlan";
				}
		}
		}else{
			retCodeMy="000002";
 			retMsgMy="�ʷ����Ͳ���YnW3";
		}
	
	}
	else{
		retCodeMy="000003";
 		retMsgMy="��ѯ�ʷ�����ʧ��";
	}

%>

var response = new AJAXPacket();
response.data.add("retCodeMy","<%=retCodeMy %>");
response.data.add("retMsgMy","<%=retMsgMy %>");
core.ajax.receivePacket(response);