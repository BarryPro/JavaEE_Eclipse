<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String poorder_id = WtcUtil.repNull((String)request.getParameter("poorder_id"));
    String productspec_number = WtcUtil.repNull((String)request.getParameter("productspec_number"));
    String sqlStr = "SELECT product_order_id FROM dproductorderdet WHERE poorder_id = '"+poorder_id+"' AND productspec_number = '"+productspec_number+"'";
    String product_order_id = "";
%>
<wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArr" scope="end"/>
<%
    if("000000".equals(retCode) && retArr.length>0){
        product_order_id = retArr[0][0];
    }
%>
<wtc:service name="s9102DetQry" outnum="14" routerKey="region" routerValue="<%=regionCode%>" retcode="s9102DetQryRetCode" retmsg="s9102DetQryRetMsg">
    <wtc:param value="<%=product_order_id%>"/>
    <wtc:param value=""/>
    <wtc:param value="7"/>
</wtc:service>
<wtc:array id="s9102DetQryArr" start="2" length="12" scope="end" />
<%
    String dataConsultTmp = "";
    if("000000".equals(s9102DetQryRetCode) && s9102DetQryArr.length>0){
        for(int i=0;i<s9102DetQryArr.length;i++){
            dataConsultTmp += s9102DetQryArr[i][1] + "^";
            dataConsultTmp += s9102DetQryArr[i][2] + "^";
            dataConsultTmp += s9102DetQryArr[i][3] + "^";
            dataConsultTmp += "411501"             + "^";
            if(i == s9102DetQryArr.length-1 ){
                dataConsultTmp += s9102DetQryArr[i][5];
            }else{
                dataConsultTmp += s9102DetQryArr[i][5] + "$";
            }
        }
        System.out.println("# dataConsultTmp = "+dataConsultTmp);
    }
%>

var response = new AJAXPacket();
var vDataConsult = "<%=dataConsultTmp%>";
response.data.add("dataConsultTmp",vDataConsult);
core.ajax.receivePacket(response);
