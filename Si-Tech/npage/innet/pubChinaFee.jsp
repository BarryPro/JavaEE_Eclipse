<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.03
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
/*

*/
        //得到输入参数 
       // Logger logger = Logger.getLogger("pubChinaFee.jsp");
      //  ArrayList retArray = new ArrayList();
        //String return_code,return_message;
      //  String[][] result = new String[][]{};
 		//S1100View callView = new S1100View();
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String inFee = request.getParameter("inFee");
        
         String orgCode = (String)session.getAttribute("orgCode");
         String regionCode = orgCode.substring(0,2);
	    
      //   String err_code  = "";
      //   String err_message  = "";
         String chinaFee = "";
        
%>
<wtc:service name="sToChinaFee" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="err_code" retmsg="err_message"  outnum="4" >
			<wtc:param value="<%=inFee%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%        
         if(err_code.equals("0")||err_code.equals("000000")){
          System.out.println("调用服务sToChinaFee in pubChinaFee.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	       	chinaFee=result[0][2];
 	        	
 	     	}else{
 			System.out.println("调用服务sToChinaFee in pubChinaFee.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}
       //     retArray = callView.view_sToChinaFee(inFee);
        //    result = (String[][])retArray.get(0);
       //     err_code  = result[0][0];
       //     err_message  = result[0][1];
           
       
		
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var chinaFee = "";
retType = "<%=retType%>";
retCode = "<%=err_code%>";
retMessage = "<%=err_message%>";
chinaFee = "<%=chinaFee%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("chinaFee",chinaFee);
core.ajax.receivePacket(response);

