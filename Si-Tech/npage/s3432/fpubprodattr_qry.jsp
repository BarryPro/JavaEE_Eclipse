<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="../common/errorpage.jsp" %>

<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>

<%
        //得到输入参数
        
        System.out.println("------------------fpubprodattr_qry.jsp---------------------");
        Logger logger = Logger.getLogger("fpubprodattr_qry.jsp");
        ArrayList retArray = new ArrayList();
        String[][] result = new String[][]{};
        SPubCallSvrImpl callView = new SPubCallSvrImpl();
        //--------------------------
        String retType = request.getParameter("retType");
        String sm_code = request.getParameter("sm_code");
        int vCount = 0;
        String product_attr = "";
        String retCode = "";
        String retMessage = "";
        String sqlStr = "";

        try
        {
            sqlStr = "select a.product_attrcode, b.attr_name from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr and a.sm_code = '" + sm_code + "'";

            retArray = callView.sPubSelect("2",sqlStr);
            result = (String[][])retArray.get(0);

            vCount = result.length;
            product_attr = (result[0][0]).trim();

            retCode = "000000";
            retMessage = "查询产品属性信息成功";

        }catch(Exception e){
            e.printStackTrace();
            retCode = "190201";
            logger.error("Call sunView is Failed!");
        }
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var retnums = "";
var retname = "";
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
retnums = "<%=vCount%>";
retname = "<%=product_attr%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("retnums",retnums);
response.data.add("retname",retname);
core.ajax.receivePacket(response);