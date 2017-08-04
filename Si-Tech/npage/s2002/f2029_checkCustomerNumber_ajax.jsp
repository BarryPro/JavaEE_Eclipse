<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String retFlag = "0";
    String ordernumber="";
    String CustomerNumber =request.getParameter("sCustomerNumber");//EC集团客户编码
    String querySql="select count(*) from dcustomerinfo a,dgrpcustmsg b,dcustdoc c where "+
                    " trim(a.customer_id)=to_char(b.unit_id) and b.cust_id=c.cust_id and  c.owner_type='04' and "+
                    " c.region_code='"+regionCode+"' and  a.custmoter_ec_id ='"+CustomerNumber+"'";
    System.out.println(querySql);    
%>

<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
<wtc:sql><%=querySql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%
				 ordernumber="";
		     if(result.length==1&result[0][0].equals("1")){
		       retFlag = "0";
		     }else if(result.length==0){
		     	 System.out.println("rows.length1:"+result.length);
         	 retFlag = "1";
         }else{
         	 System.out.println("rows.length2:"+result.length);
		   		 retFlag = "2";
		     }
%>
var response = new AJAXPacket();
response.data.add("retFlag","<%=retFlag.trim()%>");
response.data.add("ordernumber","<%=ordernumber.trim()%>");
core.ajax.receivePacket(response);
