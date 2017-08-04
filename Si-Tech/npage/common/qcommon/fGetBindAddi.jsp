<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.05
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
System.out.println("---------------fGrtBindAddi.jsp---------------------");
/*
 输入参数：
      手机号码  
 输出参数： 
      错误代码
      错误消息
      是否预开通标志   Y  预开通 , N  非预开通
      SIM卡号码
      SIM卡类型 
*/

        //得到输入参数 
      //  Logger logger = Logger.getLogger("fGetBindAddi.jsp");
      //  ArrayList retArray = new ArrayList();
      //  String return_code,return_message;
       // String[][] result = new String[][]{};
 	//	S1210Impl callView = new S1210Impl();
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String Phone_no = request.getParameter("Phone_no");
		String Sm_code = request.getParameter("Sm_code");
		String org_code=request.getParameter("org_code");
		String regionCode=org_code.substring(0,2);
		String payCode=WtcUtil.repStr(request.getParameter("payCode"),"");
       //  String err_code = "";
        // String err_message = "";
         String bindModeCode = "";
		 String bindModeName = "";
		 System.out.println("-------Phone_no-------------"+Phone_no);
		 System.out.println("-------Sm_code--------------"+Sm_code);
			System.out.println("-------org_code-------------"+org_code);
	     System.out.println("-------payCode--------------"+payCode); 
		 String[] inPara={Phone_no,org_code,Sm_code,payCode};

        
           /** String[] retAtr = callView.srvCall("sGetOpenMode",inPara,"4","phone",Phone_no);
            err_code  = retAtr[0];
            err_message  = retAtr[1];
            bindModeCode = retAtr[2];
            bindModeName  = retAtr[3];
            **/
%>
<wtc:service name="sGetOpenMode" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="err_code" retmsg="err_message"  outnum="4" >
			<wtc:params value="<%=inPara%>"/>
			</wtc:service>
			<wtc:array id="retAtr" scope="end" />
<%
           if(err_code.equals("0")||err_code.equals("000000")){
           err_code="000000";
            System.out.println("调用服务sGetOpenMode in fGetBindAddi.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	if(retAtr.length==0){
 	        	
 	            }else{
		 	        	 bindModeCode = retAtr[0][2];
		               bindModeName  = retAtr[0][3];
 	        	   
 	        	}
 	        	
 	     	}else{
 			System.out.println("调用服务sGetOpenMode in fGetBindAddi.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}
		
		
		System.out.println("-------------------------------bindModeCode------------------------"+bindModeCode);
		System.out.println("-------------------------------bindModeName------------------------"+bindModeName);
%>

var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var bindModeCode = "";
var bindModeName = "";
retType = "<%=retType%>";
retCode = "<%=err_code%>";
retMessage = "<%=err_message%>";
bindModeCode = "<%=bindModeCode%>";
bindModeName = "<%=bindModeName%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("bindModeCode",bindModeCode);
response.data.add("bindModeName",bindModeName);
core.ajax.receivePacket(response);

