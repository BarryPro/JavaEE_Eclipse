<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-12-10
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
    Logger logger = Logger.getLogger("fgetBizLevel.jsp");
    ArrayList retArray = new ArrayList();
    String regionCode = (String)session.getAttribute("regCode");
    String iSmCode = WtcUtil.repNull((String)request.getParameter("sm_code"));
    String retType = WtcUtil.repNull((String)request.getParameter("retType"));
    System.out.println("# fgetBizLevel.jsp -> iSmCode = "+iSmCode);
    
    String retCode = "";
    String retMessage = "";
    String oBizLevel = "";
    
    String sqlStr = "";
    try{
        sqlStr = "select level_flag from sbusitypesmcode where sm_code = '"+iSmCode+"'";
        %>
        <wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr1" scope="end"/>
        <%
            retCode = retCode1;
            retMessage = retMsg1;
            System.out.println("# fgetBizLevel.jsp -> retCode = "+retCode);
            System.out.println("# fgetBizLevel.jsp -> retMsg  = "+retMessage);
            if("000000".equals(retCode)){
                if(retArr1.length>0){
                    oBizLevel = retArr1[0][0];
                }
            }
            System.out.println("# fgetBizLevel.jsp -> oBizLevel = "+oBizLevel);
    }catch(Exception e){
        e.printStackTrace();
        retCode = "999999";
        retMessage = "查询业务级别失败！";
        logger.error("Call sunView is Failed!");
    }
%>

var response = new AJAXPacket();
var retCode = "";
var retMessage = "";
var vBizLevel = "";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
vBizLevel = "<%=oBizLevel%>";

response.data.add("retType","<%=retType%>");
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("bizLevel",vBizLevel);
core.ajax.receivePacket(response);
