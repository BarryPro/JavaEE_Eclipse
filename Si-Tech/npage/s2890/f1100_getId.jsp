<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.19
 模块:EC产品订购
********************/
%>


<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
        //得到输入参数
        String[][] result = new String[][]{};
	    //--------------------------
	    String retType = request.getParameter("retType");
        String region_code = request.getParameter("region_code"); 
        String idType = request.getParameter("idType");
        String oldId = request.getParameter("oldId"); 
        String newId = "";
        System.out.println("idType======"+idType);
        try
        {
            //retArray = callView.view_sPubgetId(region_code,idType,oldId);
 %>
 			<wtc:service name="spubGetId" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="3">			
			<wtc:param value="<%=region_code%>"/>
			<wtc:param value="<%=idType%>"/>	
			<wtc:param value="<%=oldId%>"/>	
			</wtc:service>	
			<wtc:array id="resultTemp"  scope="end"/>
 <%
            result = resultTemp;
        }catch(Exception e){
            System.out.println("spubGetId server exception!");
        }

        String retCode = result[0][0];      
        String retMessage = result[0][1];
        String retnewId = result[0][2];
        System.out.println("retMessage============"+retMessage);
        System.out.println("retCode============"+retCode);
        System.out.println("retnewId============"+retnewId);
		

		
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
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("retnewId",retnewId);
core.ajax.receivePacket(response);




