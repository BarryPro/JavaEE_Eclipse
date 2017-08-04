<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String retFlag = "0";
    String attached="";
    String ProductSpecNumber =request.getParameter("ProductSpecNumber");//产品规格代码
    String POSpecNumber=request.getParameter("POSpecNumber");//商品规格代码
    String querySql="select productspec_number from dProductrelationInfo where";
    querySql+=" Pospec_Number="+POSpecNumber+" and productrelation_id="+ProductSpecNumber;
    System.out.println(querySql);  
%>

<wtc:pubselect name="sPubSelect" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
<wtc:sql><%=querySql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%
			
		System.out.println(result.length);			 
		if(result.length==0){
		   retFlag ="9";
		}else{
			retFlag = "10";
			for(int i=0;i<result.length;i++){
				attached=attached+result[i][0]+"|";
			}
			attached=attached+ProductSpecNumber;
    }
    System.out.println(attached);
%>
var response = new AJAXPacket();
response.data.add("retFlag","<%=retFlag.trim()%>");
response.data.add("attached","<%=attached%>");
core.ajax.receivePacket(response);

