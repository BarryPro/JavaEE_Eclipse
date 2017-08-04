<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
    Logger logger = Logger.getLogger("f7411_getSubSmCode.jsp");
    ArrayList retArray = new ArrayList();
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String motiveExtCode = WtcUtil.repNull((String)request.getParameter("motiveExtCode"));
    String retType = WtcUtil.repNull((String)request.getParameter("retType"));
    System.out.println(" from f7411_getSubSmCode.jsp -> motiveExtCode = "+motiveExtCode);
    
    String retCode = "";
    String retMessage = "";
    String sqlStr = "";
    try{
        sqlStr = "select a.sm_code,a.sm_code||'-->'||b.sm_name "
               + " from sgrpsmcode a,ssmcode b, "
               + " SMOTIVEPRODSMCODECFG c "
               + " where a.sm_code=b.sm_code and b.region_code='"+regionCode+"' "
               + " and a.sm_code=c.sm_code and c.motive_type='"+motiveExtCode+"' order by a.sm_code ";

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
        retMessage = "查询子产品品牌失败！";
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







