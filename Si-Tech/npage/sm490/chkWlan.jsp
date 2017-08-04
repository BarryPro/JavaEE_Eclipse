<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
 
<%
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String offerId = WtcUtil.repNull(request.getParameter("offerId"));
String serId = WtcUtil.repNull(request.getParameter("serId"));
String retCodeMy="";
String retMsgMy="";
String offerIds [] = offerId.split(",");
String sql_offerId = "";

for ( int i = 0 ; i < offerIds.length; i ++ )
{
	sql_offerId+="'"+offerIds[i]+"',";
}
sql_offerId = sql_offerId.substring( 0,sql_offerId.length() -1 );

String[] inParamsss1 = new String[2];
inParamsss1[0] = "select offer_attr_type from "
	+"product_offer where offer_id  in ("+sql_offerId+")";
inParamsss1[1] = "vOfferId="+offerId;

%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
	retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>
<wtc:array id="resultAttrType" scope="end" />
<%
if("000000".equals(retCode1) && resultAttrType.length > 0)
{
	String Offer_Attr_Type = resultAttrType[0][0];

	/*如果正在办理*/
	for ( int i = 0 ; i < resultAttrType.length ; i ++ )
	{
		Offer_Attr_Type = resultAttrType[i][0];
			
		if(Offer_Attr_Type.equals("YnW1"))
		{
			//获取用户id_no的最后一位
			String serIdend = serId.substring(serId.length()-1, serId.length());
			String[] inParamsss2 = new String[2];
			inParamsss2[0] = "select count(*) from ddsmpordermsg"+serIdend
				+"  where serv_code='02' and bizcode='WLAN0101' and valid_flag='1' "
				+" and sysdate between eff_time and end_time and id_no = to_number(:v1)";
			inParamsss2[1] = "v1="+serId;	
			%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">			
				<wtc:param value="<%=inParamsss2[0]%>"/>
				<wtc:param value="<%=inParamsss2[1]%>"/>	
				</wtc:service>
		
			<wtc:array id="resultWlanCount" scope="end" />
			<%
			if("000000".equals(retCode2) && resultWlanCount.length > 0)
			{
				int wlanCount = Integer.parseInt(resultWlanCount[0][0]);
				System.out.println("gaopeng009--wlanCount:"+wlanCount);
				/*如果已经办理了wlan，则不用调用*/
				if(wlanCount > 0)
				{
					retCodeMy="000001";
					retMsgMy="已开通wlan";
				}
				else
				{
					retCodeMy="000000";
					retMsgMy="未开通wlan";
				}
			}
			break;
		}
		else
		{
			retCodeMy="000002";
			retMsgMy="资费类型不是YnW1";
		}				
	}
}
else
{
	retCodeMy="000003";
	retMsgMy="查询资费类型失败";
}

%>

var response = new AJAXPacket();
response.data.add("retCodeMy","<%=retCodeMy %>");
response.data.add("retMsgMy","<%=retMsgMy %>");
core.ajax.receivePacket(response);