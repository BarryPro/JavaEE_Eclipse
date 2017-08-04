<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 关于11月份集团客户部CRM、BOSS和经分系统需求的函-7-行业应用流量卡BOSS系统需求
 * 开发商: si-tech
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
			System.out.println("============ fGetIntegral.jsp 失败==========");
		}
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "服务未启动或不正常，请联系管理员！";
			
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");
response.data.add("ifShowIntegFlag","<%=ifShowIntegFlag %>");

core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         