<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.26
********************/
%>

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
/*
返回参数：
    错误代码
    错误消息
    担保数量
    最大担保数量
    担保人姓名
    担保人电话
    担保人地址

*/

        //得到输入参数
        //Logger logger = Logger.getLogger("f1104_3.jsp");
        //ArrayList retArray = new ArrayList();
        //String return_code,return_message;
        //String[][] result = new String[][]{};
 		//S1100View callView = new S1100View();
	    //--------------------------
	    String retType = request.getParameter("retType"); 
	    String iccType = request.getParameter("iccType"); 
	    String iccId = request.getParameter("iccId"); 
	    String sIn_Belong_code = request.getParameter("sIn_Belong_code");
	    String regioncode = request.getParameter("regioncode");
	    
	    //返回值定义
        //String retCode = "";
        //String retMessage = "";
        String assuNum = "";
        String assuMaxNum = "";
        String assuName = "";
        String assuPhone = "";
        String assuAddr = "";
        String assuZip = "";
      /** 
       try
        {
            retArray = callView.view_sGetAssuMsg(iccType,iccId,sIn_Belong_code);
            result = (String[][])retArray.get(0);
           
            retCode = result[0][0];
            retMessage = result[0][1];
            assuNum = result[0][2];
            assuMaxNum = result[0][3]; 
            assuName = result[0][4];
            assuPhone = result[0][5];
            assuAddr = result[0][6]; 
            assuZip = result[0][7];           
        }catch(Exception e){
            logger.error("Call sunView is Failed!");
        }
        **/
%>
	<wtc:service name="sGetAssuMsg" routerKey="regionCode" routerValue="<%=regioncode%>"  retcode="retCode" retmsg="retMessage"  outnum="10" >
	        <wtc:param value="<%=iccType%>"/>
	        <wtc:param value="<%=iccId%>"/>
	        <wtc:param value="<%=sIn_Belong_code%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />


<%
       if(retCode.equals("0")||retCode.equals("000000")){
          if(result.length!=0){
           
             retCode="000000";
 			  assuNum = result[0][2];
            assuMaxNum = result[0][3]; 
            assuName = result[0][4];
            assuPhone = result[0][5];
            assuAddr = result[0][6]; 
            assuZip = result[0][7];   
          
          }
 			
 			}
		
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var assuNum = "";
var assuMaxNum = "";
var assuName = "";
var assuPhone = "";
var assuAddr = "";
var assuZip = "";
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
assuNum = "<%=assuNum%>";
assuMaxNum = "<%=assuMaxNum%>";
assuName = "<%=assuName%>";
assuPhone = "<%=assuPhone%>";
assuAddr = "<%=assuAddr%>";
assuZip = "<%=assuZip%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("assuNum",assuNum);
response.data.add("assuMaxNum",assuMaxNum);
response.data.add("assuName",assuName);
response.data.add("assuPhone",assuPhone);
response.data.add("assuAddr",assuAddr);
response.data.add("assuZip",assuZip);
core.ajax.receivePacket(response);

