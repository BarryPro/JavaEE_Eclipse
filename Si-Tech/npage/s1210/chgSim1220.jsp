<%
/********************
 version v2.0
开发商: si-tech
update:liutong@20080919
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

int  inputNumber = 8;
String outputNumber = "4";
String [] inputParam = new String[inputNumber];
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
inputParam[0] = request.getParameter("phoneNo");
inputParam[1] = request.getParameter("simOldNo");
inputParam[2] = request.getParameter("simNewNo");
inputParam[3] = request.getParameter("orgCode");
inputParam[4] = "1220";
inputParam[5] = request.getParameter("cardtype");
inputParam[6] = request.getParameter("cardsim_type");
inputParam[7] = request.getParameter("simTypeOne");

System.out.println("zhangyan~~~~~~~~~~~~~~~~"+inputParam[5]);
System.out.println("gaopengSeelog1220~~~~~~~~~~~~~~simTypeOne~~"+inputParam[7]);
//SPubCallSvrImpl s1210 = new SPubCallSvrImpl();
//String[] retStr = s1210.callService("s1220SimVer",inputParam,outputNumber,"phone",inputParam[0]);
//String errCode= String.valueOf(s1210.getErrCode());
//String errMsg= s1210.getErrMsg();
%>
<wtc:service name="s1220SimVer" routerKey="phone" routerValue="<%=inputParam[0]%>"  retcode="errCode" retmsg="errMsg"  outnum="6" >
			<wtc:param value="<%=inputParam[0]%>"/>
			<wtc:param value="<%=inputParam[1]%>"/>
			<wtc:param value="<%=inputParam[2]%>"/>
			<wtc:param value="<%=inputParam[3]%>"/>
			<wtc:param value="<%=inputParam[4]%>"/>
			<wtc:param value="<%=inputParam[5]%>"/>
			<wtc:param value="<%=inputParam[6]%>"/>
			<wtc:param value="<%=inputParam[7]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%
			String simFee="";
			String simType="";
			
 		if(errCode.equals("0")||errCode.equals("000000")){
          System.out.println("调用服务s1220SimVer in chgSim1220.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	if(result.length==0){
 	            }else{
 	        	    simFee=result[0][0]; 
  					simType=result[0][3];
  					System.out.println("simsimsimsimsimsimsimsimsim"+simType);
  					System.out.println(errCode+"    errCode");
 	     			System.out.println(errMsg+"    errMsg");
 	        	}
 	        	
 	     	}else{
 	         	System.out.println(errCode+"    errCode");
 	     		System.out.println(errMsg+"    errMsg");
 			System.out.println("调用服务s1220SimVer in chgSim1220.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 		
 			}









%>

<%
	/*liujian 2012-12-25 15:02:37 验证是否首次办理换卡变更*/
	String sql_select = "select a.change_type from wSimInterceptorTimeOpr a,dcustmsg b where a.id_no = b.id_no and b.phone_no=:phone_no";
	String sql_param = "phone_no=" + inputParam[0];
	String changeType = "";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=inputParam[0]%>"  retcode="ret_code" retmsg="ret_message" outnum="1">
		<wtc:param value="<%=sql_select%>"/>
		<wtc:param value="<%=sql_param%>"/>
	</wtc:service>
	<wtc:array id="resultStatus" scope="end" />
<%
	if((errCode.equals("0")||errCode.equals("000000")) && resultStatus.length > 0) {
		changeType = resultStatus[0][0];
	}else {
		System.out.println("ret_code=" + ret_code + "    ret_message=" + ret_message);
		System.out.println("调用select change_type from wSimInterceptorTimeOpr失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
	}
%>
var response = new AJAXPacket();
var errCode = "<%=errCode%>";
var errMsg = "<%=errMsg%>";
var simFee = "<%=simFee%>";
var simType = "<%=simType%>";

response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
response.data.add("simFee",simFee);

response.data.add("simType",simType);

response.data.add("changeType",'<%=changeType%>');

core.ajax.receivePacket(response);




