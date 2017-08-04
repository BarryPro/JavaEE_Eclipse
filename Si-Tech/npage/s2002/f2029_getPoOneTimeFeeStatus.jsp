<%
/*关于跨省专线业务两级订单流改造的需求*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String retFlag = "11";
    String op_flag="";
    String PospecNumber =request.getParameter("PospecNumber");//商品规格编码 
    System.out.println("PospecNumber=="+PospecNumber);
    String[] inParamsStr = new String[2];
    String[] inParamsStr2 = new String[2];
    inParamsStr[0]="select a.field_code,a.field_name,a.field_type, "+
                    " to_char(a.field_length) as field_length,b.ctrl_info,b.field_defvalue "+
                    " from sUserFieldCode a,suserfieldfee b,sUserTypeGroup c,dPospecinfo d "+
                    " where a.field_code=b.field_code "+
                    " and b.user_type=d.external_code and d.pospec_number=:PospecNumber "+ 
                    " and b.user_type = c.user_type "+
                    " and b.field_grp_no = c.field_grp_no";
    inParamsStr[1] = "PospecNumber="+PospecNumber;
    inParamsStr2[0] = "select FIELD_CODE2 from dbvipadm.scommoncode where COMMON_CODE = '1010'"+
    " AND FIELD_CODE1 =:PospecNumber";
    inParamsStr2[1] = "PospecNumber="+PospecNumber;
    %>
    	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6">			
		<wtc:param value="<%=inParamsStr[0]%>"/>	
		<wtc:param value="<%=inParamsStr[1]%>"/>	
		</wtc:service>	
		<wtc:array id="result"  scope="end"/>

    <%
		int resultLen = result.length;
		//System.out.println("wuxy=================="+resultLen);
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
     	System.out.println("["+i+"]="+result[i][0]);
     }
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
		<wtc:param value="<%=inParamsStr2[0]%>"/>	
		<wtc:param value="<%=inParamsStr2[1]%>"/>	
		</wtc:service>	
		<wtc:array id="result11"  scope="end"/>
<%
	int result11Len = result11.length;
	System.out.println("asd--------------"+result11Len);
%>
var selSomeArr = new Array(<%= result11Len%>);

<%
     for(int j=0;j<result11Len;j++){
     %>
        selSomeArr[<%=j%>] = "<%=result11[j][0].trim()%>";
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
response.data.add("result11Len","<%=result11Len%>");
response.data.add("selSomeArr",selSomeArr);
core.ajax.receivePacket(response);

