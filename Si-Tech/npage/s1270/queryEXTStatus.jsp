<%
  /*
   * 功能: 查询客户名称
   * 版本: 1.0
   * 日期: 20130610
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	      String regCode = (String)session.getAttribute("regCode");	
        String loginNo = (String)session.getAttribute("workNo");
        String loginNoPass = (String)session.getAttribute("password");
        String ipAddrss = (String)session.getAttribute("ipAddr");
        String offer_ids = request.getParameter("offer_ids");

        String efftypes="";
        String efftypestr="";


		String[] inParamsss1 = new String[2];
	  inParamsss1[0] = "select eff_type from product_offer where offer_id=:offerids";
	  inParamsss1[1] = "offerids="+offer_ids;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
		</wtc:service>	
	  <wtc:array id="dcustarry" scope="end" />   
<%

		if(dcustarry.length>0) {
			efftypes=dcustarry[0][0];
		}
		
		 System.out.println("efftypes==================="+efftypes);
		 
		
	 String str[]={"星期日","星期一","星期二","星期三","星期四","星期五","星期六"};
        Calendar rightNow=Calendar.getInstance();  
        int day=rightNow.get(rightNow.DAY_OF_WEEK);
        System.out.println("今天是"+str[day-1]);
        
        if("5".equals(efftypes))	{     
          if(str[day-1].equals("星期一") || str[day-1].equals("星期二") || str[day-1].equals("星期三") || str[day-1].equals("星期四") || str[day-1].equals("星期五")) {
          	efftypestr="本周六生效";        
          }else {
        		efftypestr="24小时内生效";
        	}
        
        }
			System.out.println("efftypestr==================="+efftypestr);
    
  

%>
var response = new AJAXPacket();
response.data.add("errCode","<%=retCode1ss%>");
response.data.add("errMsg","<%=retMsg1ss%>");
response.data.add("isextflags","<%=efftypes%>");
response.data.add("isextstrs","<%=efftypestr%>");
core.ajax.receivePacket(response);
 