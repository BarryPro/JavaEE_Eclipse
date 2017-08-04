<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
update:liutong@2008.09.05
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
 
 
	   String offerId = request.getParameter("offerId");
     String regionCode = (String)session.getAttribute("regCode");
     
     		String[] inParamsss1 = new String[2];
	      inParamsss1[0] = "select count(1) from product_offer a, pricing_combine b, dbbillocs.t_pp_billprcplan_p c  where   ((c.query_flag_new = '1' And sysdate >= c.change_date)   Or   (  c.query_flag = '1' And sysdate < c.change_date))   and b.detail_code = c.billprcid   and b.detail_type='0'   and a.pricing_plan_id = b.pricing_plan_id  and a.offer_id =:vOfferId ";
	      inParamsss1[1] = "vOfferId="+offerId;
	      System.out.println("============="+inParamsss1[0]);
	      System.out.println("============="+inParamsss1[1]);
	  
%>
				
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
		</wtc:service>	
	  <wtc:array id="dcustarry" scope="end" />
<%
       String queryCount = "0";
       if(dcustarry.length>0){
       	queryCount = dcustarry[0][0];
       }
		System.out.println("----------------------queryCount----------------"+queryCount);
%>

var response = new AJAXPacket();
response.data.add("queryCount","<%=queryCount%>");
core.ajax.receivePacket(response);

