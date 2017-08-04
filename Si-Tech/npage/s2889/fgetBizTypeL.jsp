<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-12
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
    Logger logger = Logger.getLogger("fgetBizTypeL.jsp");
    ArrayList retArray = new ArrayList();
    String regionCode = (String)session.getAttribute("regCode");
    String iBizMode = WtcUtil.repNull((String)request.getParameter("bizMode"));
    
    String retCode = "";
    String retMessage = "";
    String sqlStr = "";
    try{
        if(("M".equals(iBizMode))||("1".equals(iBizMode))){
            sqlStr = "select distinct main_type,main_type||'->'||main_name from sbiztypecode where sm_code='ML'";
        }else{
            sqlStr = "select distinct main_type,main_type||'->'||main_name from sbiztypecode where sm_code='AD'";
        }
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
        retMessage = "查询业务大类失败！";
        logger.error("Call sunView is Failed!");
    }
%>

var response = new AJAXPacket();
var retCode = "";
var retMessage = "";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("backString",colNameArr);
core.ajax.receivePacket(response);
