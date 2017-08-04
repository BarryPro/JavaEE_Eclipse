<%
/********************
     version v2.0
     开发商: si-tech
     写卡成功后的保存页面
     gaopeng 20130105 改为新版界面，与产品部qucc合作
     ********************/
%> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>

<%
		ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfoSession = (String[][])arrSession.get(0);
		String[][] otherInfoSession = (String[][])arrSession.get(2);
		String[][] pass = (String[][])arrSession.get(4);
		
		String loginNo = baseInfoSession[0][2];
		String loginName = baseInfoSession[0][3];
		String powerCode= otherInfoSession[0][4];
		String orgCode = baseInfoSession[0][16];
		String ip_Addr = request.getRemoteAddr();
		
		String regionCode = orgCode.substring(0,2);
		String regionName = otherInfoSession[0][5];
		String loginNoPass = pass[0][0];
		
		//得到输入参数      
		ArrayList retArray = new ArrayList();         
		String[][] result = new String[][]{};
		//--------------------------
		ArrayList arr = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfo = (String[][])arr.get(0);
		String workNo = baseInfo[0][2];
		String retType = request.getParameter("retType"); 
		String region_code = request.getParameter("region_code");
		String rsim_no= request.getParameter("sim_no");
		String card_no= request.getParameter("card_no");
		String phone_no= request.getParameter("phone_no");
		String op_code= request.getParameter("op_code");
		//返回值定义
		String retCode = "";
		String retMessage = "";
		String sim_no = "";
		
		
		int  inputNumber = 4;
		String outputNumber = "2";
		String [] inputParam = new String[inputNumber+2];
		inputParam[0]="4";
		inputParam[1]="2";		
		inputParam[2] = rsim_no;
		inputParam[3] = card_no;
		inputParam[4] = workNo;
		inputParam[5] = op_code;
		try{
		%>
		<wtc:service name="supobcarddata" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode1" retmsg="retMessage1" outnum="2">
				<wtc:param value="<%=inputParam[2]%>"/>
				<wtc:param value="<%=inputParam[3]%>"/>
				<wtc:param value="<%=inputParam[4]%>"/>
				<wtc:param value="<%=inputParam[5]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
		<%
				retCode=retCode1;
				retMessage=retMessage1;
		}
		catch(Exception e){
			retCode= "444444";
			retMessage= "系统异常："+e.getMessage();
		}
		%>
			

var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var sim_no="";

  
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";

  

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
core.ajax.receivePacket(response);