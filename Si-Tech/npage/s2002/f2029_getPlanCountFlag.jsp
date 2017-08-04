<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String retFlag = (String)request.getParameter("retFlag");
    String iSpecNumber =request.getParameter("productSpecNumber");//产品规格编号
    String PlanCount="";
    
    String querySql1="select count(*) from dproductrateplanInfo where productspec_number='"+iSpecNumber+"'";
    System.out.println(querySql1);

%>
<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
        <wtc:sql><%=querySql1%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result" scope="end"/>
<%
    System.out.println("# f2029_productBiz.jsp -> retCode = "+retCode);
    System.out.println("# f2029_productBiz.jsp -> result.length = "+result.length);
    if(result.length == 1){
        PlanCount = "1";
        String bizCodeTmp1 = result[0][0].trim();
        if("0".equals(bizCodeTmp1) || "NULL".equals(bizCodeTmp1)){
            PlanCount = "0";
        }else{
            PlanCount = bizCodeTmp1;
        }
    }else{
        PlanCount = "1";
    }
    System.out.println("# f2029_productBiz.jsp -> PlanCount = "+PlanCount);

%>



var response = new AJAXPacket();
response.data.add("retFlag","<%=retFlag.trim()%>");
response.data.add("PlanCount","<%=PlanCount.trim()%>");
core.ajax.receivePacket(response);

