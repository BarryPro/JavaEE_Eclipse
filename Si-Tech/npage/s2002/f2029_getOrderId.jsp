<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String retFlag = "0";
    String ordernumber="";
    String idType =request.getParameter("idType");//EC集团客户编码
    //String querySql="select count(*) from dcustomerinfo where custmoter_ec_id ='"+CustomerNumber+"'"; 
    String querySql="select trim(to_char(sMaxOpenId_"+regionCode+".nextVal)) from dual ";
    System.out.println(querySql);  
%>

<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
<wtc:sql><%=querySql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%
			 ordernumber="";
System.out.println("2=="+result.length);			 
		     if(result.length==1){
		       retFlag ="0";
		       ordernumber=result[0][0];
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

