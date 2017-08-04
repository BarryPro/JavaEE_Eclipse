<%
/*关于跨省专线业务两级订单流改造的需求*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	 String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String retFlag = "12";
    String SAFlag ="N";
    String Product_Spec_number =request.getParameter("producrOrderId");//产品规格编码 
    String[] inParamsStr = new String[2];
    inParamsStr[0] ="select count(*) "+
                    " from suserfieldcode a,sgrpsmfieldrela b,dpospecinfo d,dproductspecinfo c "+
                    " where a.field_code=b.field_code "+
                    " and b.user_type=to_char(d.external_code) "+
                    "  and c.productspec_number=:productspec_number "+ 
                    " and b.field_order=to_number(d.pospec_number) and d.pospec_number=c.pospec_number  and a.field_code='1006' "
                    ;
	inParamsStr[1] = "productspec_number="+Product_Spec_number;
    %>
    	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">			
		<wtc:param value="<%=inParamsStr[0]%>"/>	
		<wtc:param value="<%=inParamsStr[1]%>"/>	
		</wtc:service>	
		<wtc:array id="result"  scope="end"/>
    <%
		int resultLen = result.length;
    
        if(resultLen>0&&Integer.parseInt(result[0][0])>0){
             SAFlag="Y";
        } 
        //System.out.println("SAFlag="+SAFlag);    
     %>
       
     

var response = new AJAXPacket();
response.data.add("retFlag","<%=retFlag.trim()%>");
response.data.add("SAFlag","<%=SAFlag.trim()%>");
core.ajax.receivePacket(response);

