<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String retFlag = "11";
    String op_flag="";
    String pro_order_id =request.getParameter("producrOrderId");//ÒµÎñ´úÂë 
    //String querySql="select op_flag from sproductopflag where product_order_id='"+pro_order_id+"'";
    String querySql="select a.field_code,a.field_name,a.field_type, "+
                    " to_char(a.field_length) as field_length,b.ctrl_info,b.field_defvalue "+
                    " from sUserFieldCode a,suserfieldfee b,sUserTypeGroup c,dproductspecinfo d "+
                    " where a.field_code=b.field_code "+
                    " and b.user_type=d.external_code and d.productspec_number='"+pro_order_id+"' "+ 
                    " and b.user_type = c.user_type "+
                    " and b.field_grp_no = c.field_grp_no";
    System.out.println(querySql);
    %>
        <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
        <wtc:sql><%=querySql%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="result" scope="end"/>
    <%
		int resultLen = result.length;
    %>
        var fieldCodeArr = new Array(<%=resultLen%>);
        var fieldNameArr = new Array(<%=resultLen%>);
        var fieldTypeArr = new Array(<%=resultLen%>);
        var fieldLengthArr = new Array(<%=resultLen%>);
        var ctrlInfoArr = new Array(<%=resultLen%>);
        var fieldDefValueArr = new Array(<%=resultLen%>);
     <%
     for(int i=0;i<resultLen;i++){
     %>
        fieldCodeArr[<%=i%>] = "<%=result[i][0].trim()%>";
        fieldNameArr[<%=i%>] = "<%=result[i][1].trim()%>";
        fieldTypeArr[<%=i%>] = "<%=result[i][2].trim()%>";
        fieldLengthArr[<%=i%>] = "<%=result[i][3].trim()%>";
        ctrlInfoArr[<%=i%>] = "<%=result[i][4].trim()%>";
        fieldDefValueArr[<%=i%>] = "<%=result[i][5].trim()%>";
     <%
     }
%>
var response = new AJAXPacket();
response.data.add("retFlag","<%=retFlag.trim()%>");
response.data.add("resultLen","<%=resultLen%>");
response.data.add("fieldCodeArr",fieldCodeArr);
response.data.add("fieldNameArr",fieldNameArr);
response.data.add("fieldTypeArr",fieldTypeArr);
response.data.add("fieldLengthArr",fieldLengthArr);
response.data.add("ctrlInfoArr",ctrlInfoArr);
response.data.add("fieldDefValueArr",fieldDefValueArr);
core.ajax.receivePacket(response);

