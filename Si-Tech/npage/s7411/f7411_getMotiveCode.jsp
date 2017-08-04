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
        Logger logger = Logger.getLogger("f7411_getMotiveCode.jsp");
        ArrayList retArray = new ArrayList();
        String[][] result = new String[][]{};
 		//S1100View callView = new S1100View();
	    //--------------------------
	    String retType = request.getParameter("retType");
        String region_code = request.getParameter("region_code"); 
        String newId = "";
        
        String retCode = "";      
        String retMessage = "";
        String sql="select  max(to_number(motive_code))+1  from SMOTIVEPRODCFG ";
        try{
%>
        <wtc:pubselect name="sPubSelect" outnum="1" retcode="spubGetMotiveCodeCode" retmsg="spubGetMotiveCodeMsg" >
						<wtc:sql>
							select  max(to_number(motive_code))+1  from SMOTIVEPRODCFG 
						</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="spubGetMotiveCode" scope="end"/>
<%
		System.out.println("wtellllllllllllllllllllllllll");
		System.out.println("89989="+result.length);
           result = spubGetMotiveCode;
            retCode = spubGetMotiveCodeCode;
            retMessage = spubGetMotiveCodeMsg;
        }catch(Exception e){
            logger.error("Call sunView is Failed!");
        }
        String retnewId = result[0][0];
        System.out.println("---------"+retMessage);
        System.out.println("----------"+retCode);
        System.out.println("-----"+retnewId);
        if(retnewId.trim().equals(""))
        retnewId="10000000";
    
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



