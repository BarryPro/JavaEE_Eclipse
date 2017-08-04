<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String retFlag = "5";
    String ProductSpecNumber =request.getParameter("ProductSpecNumber");//产品规格代码
    String POSpecNumber=request.getParameter("POSpecNumber");//商品规格代码
    String oBizCode = "";
    String oBizFlag = "N";
    String PlanCount="";
    
    /* modify by qidp @ 2009-12-16
    String querySql="select sm_code from sproductspecprodrela where";
    querySql+=" Pospec_Number="+POSpecNumber+" and productspec_number="+ProductSpecNumber+" and rownum<2";
    */
    // wuxy alter 20100203 因为全网MAS彩信要求业务代码必空,所以修改原则
    String querySql = "select nvl(productcharacter_value,'NULL') from dproductcharacterinfo a,sprodcharactercode b,dproductcharactervalueinfo c "+
       " where substr(trim(a.productcharacter_num),length(trim(a.productcharacter_num))-3,4) =trim(b.character_number_end4) "+
       " and b.field_code='YWDM0' and a.productspec_number='"+ProductSpecNumber+"'  and substr(a.character_attr_code,1,1)!='2' "+
       " and a.productcharacter_num=c.productcharacter_num(+) and rownum<2"; 
    System.out.println(querySql);
    
    String querySql1="select count(*) from dproductrateplanInfo where productspec_number='"+ProductSpecNumber+"'";
    System.out.println(querySql1);
%>
    <wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
        <wtc:sql><%=querySql%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result" scope="end"/>
<%
    System.out.println("# f2029_productBiz.jsp -> retCode = "+retCode);
    System.out.println("# f2029_productBiz.jsp -> result.length = "+result.length);
    if(result.length == 1){
        oBizFlag = "Y";
        String bizCodeTmp = result[0][0].trim();
        if("NULL".equals(bizCodeTmp)){
            oBizCode = "";
        }else{
            oBizCode = bizCodeTmp;
        }
    }else{
        oBizFlag = "N";
        oBizCode = "";
    }
    System.out.println("# f2029_productBiz.jsp -> oBizFlag = "+oBizFlag);
    System.out.println("# f2029_productBiz.jsp -> oBizCode = "+oBizCode);
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
response.data.add("bizFlag","<%=oBizFlag.trim()%>");
response.data.add("bizCode","<%=oBizCode.trim()%>");
response.data.add("PlanCount","<%=PlanCount.trim()%>");
core.ajax.receivePacket(response);

