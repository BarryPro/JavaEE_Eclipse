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
        //得到输入参数
        Logger logger = Logger.getLogger("fpubprodattr_qry.jsp");
        ArrayList retArray = new ArrayList();
        String[][] result = new String[][]{};
        //SPubCallSvrImpl callView = new SPubCallSvrImpl();
        String regionCode = (String)session.getAttribute("regCode");
        //--------------------------
        String retType = request.getParameter("retType");
        String sm_code = request.getParameter("sm_code");
        int vCount = 0;
        String product_attr = "";
        String retCode = "";
        String retMessage = "";
        String sqlStr = "";
        String [] paraIn = new String[2];
        
        try
        {
            sqlStr = "select a.product_attrcode, b.attr_name from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr and a.sm_code =:sm_code";
            
            paraIn[0] = sqlStr;    
            paraIn[1]="sm_code="+sm_code;
        %>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
            	<wtc:param value="<%=paraIn[0]%>"/>
            	<wtc:param value="<%=paraIn[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr1" scope="end"/>
        <%
            if(retArr1.length>0&&retCode1.equals("000000")){
                result = retArr1;
            }
                //retArray = callView.sPubSelect("2",sqlStr);
                //result = (String[][])retArray.get(0);
            vCount = result.length;
            if(result.length>0){
                product_attr = (result[0][0]).trim();
            }
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
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("retnums",retnums);
response.data.add("retname",retname);
core.ajax.receivePacket(response);