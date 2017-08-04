<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String retFlag = "0";
    String billtype="";
    String bizCode =request.getParameter("bizCode");//ÒµÎñ´úÂë 
    //String querySql="select billingtype from sbillspcode where bizcodeadd='"+bizCode+"'";
    String querySql="select a.billingtype from sbillspcode a,dparteroperation b where a.product_code=b.oper_id and b.status='02' and b.check_status='08' and a.bizcodeadd='"+bizCode+"'";
    System.out.println(querySql);  
%>

<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
<wtc:sql><%=querySql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%
			 billtype="";
System.out.println("2=="+result.length);			 
		     if(result.length==1){
		       retFlag ="7";
		       billtype=result[0][0];
		     }else{
		     	 System.out.println("rows.length1:"+result.length);
         	 retFlag = "8";
         }
%>
var response = new AJAXPacket();
response.data.add("retFlag","<%=retFlag.trim()%>");
response.data.add("billtype","<%=billtype.trim()%>");
core.ajax.receivePacket(response);

