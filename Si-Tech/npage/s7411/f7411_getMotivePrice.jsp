<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
    Logger logger = Logger.getLogger("f7411_getMotivePrice.jsp");
    ArrayList retArray = new ArrayList();
    String regionCode = WtcUtil.repNull((String)request.getParameter("region_code"));
    String offerId = WtcUtil.repNull((String)request.getParameter("offerId"));
    String retType = WtcUtil.repNull((String)request.getParameter("retType"));
    System.out.println(" from f7411_getMotivePrice.jsp -> offerId = "+offerId);
    
    String retCode = "";
    String retMessage = "";
    String sqlStr = "";
    try{
        sqlStr = "select b.offer_id,b.offer_name from product_offer_detail a,product_offer b where a.offer_id="+offerId+" and rule_id=1 and element_type='10C' "
               + " and a.element_id=b.offer_id and b.offer_type=40 and b.exp_date>sysdate and b.offer_attr_type='JT' and b.eff_date<sysdate order by b.offer_id";
        %>
        <wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr1" scope="end"/>
        <%
            retCode = retCode1;
            retMessage = retMsg1;
        	String[][] colNameArr = retArr1;	
            String strArray = WtcUtil.createArray("colNameArr",colNameArr.length);
            System.out.println(strArray);
        %>
            <%=strArray%>
        <%
        for(int i = 0 ; i < colNameArr.length ; i ++){
            for(int j = 0 ; j < colNameArr[i].length; j ++){
                System.out.println(colNameArr[i][j].trim());
            %>
                colNameArr[<%=i%>][<%=j%>] = "<%=colNameArr[i][j].trim()%>";
            <%
            }
        }
        %>
    <%
    }catch(Exception e){
        e.printStackTrace();
        retCode = "999999";
        retMessage = "查询业务包费用折扣失败！";
        logger.error("Call sunView is Failed!");
    }
%>

var response = new AJAXPacket();
var retCode = "";
var retMessage = "";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";

response.data.add("retType","<%=retType%>");
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("backString",colNameArr);
core.ajax.receivePacket(response);







