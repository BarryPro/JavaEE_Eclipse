<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-14
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.log4j.Logger"%>


<%
        //得到输入参数
        Logger logger = Logger.getLogger("f1100_getId.jsp");
        ArrayList retArray = new ArrayList();
        String[][] result = new String[][]{};
 		//S1100View callView = new S1100View();
	    //--------------------------
	    String retType = request.getParameter("retType");
        String region_code = request.getParameter("region_code"); 
        String idType = request.getParameter("idType");
        String oldId = request.getParameter("oldId"); 
        String newId = "";
        
        String retCode = "";      
        String retMessage = "";
        try
        {
            //retArray = callView.view_sPubgetId(region_code,idType,oldId);
            %>
            <wtc:service name="spubGetId" routerKey="region" routerValue="<%=region_code%>" retcode="spubGetIdCode" retmsg="spubGetIdMsg" outnum="3" >
            	<wtc:param value="<%=region_code%>"/>
            	<wtc:param value="<%=idType%>"/> 
                <wtc:param value="<%=oldId%>"/> 
            </wtc:service>
            <wtc:array id="spubGetIdArr" scope="end"/>
            <%
            //result = (String[][])retArray.get(0);
            result = spubGetIdArr;
            retCode = spubGetIdCode;
            retMessage = spubGetIdMsg;
        }catch(Exception e){
            logger.error("Call sunView is Failed!");
        }

        String retnewId = result[0][2];
        System.out.println("---------"+retMessage);
        System.out.println("----------"+retCode);
        System.out.println("-----"+retnewId);
		

		
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = ""
var retnewId = "";
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
retnewId = "<%=retnewId%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("retnewId",retnewId);
core.ajax.receivePacket(response);




