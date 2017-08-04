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
        //得到输入参数      
       // Logger logger = Logger.getLogger("fjysimtyp_1104.jsp");
        //ArrayList retArray = new ArrayList();         
        //String[][] result = new String[][]{};
 	//	comImpl co=new comImpl();
	    //--------------------------
	    String retType = request.getParameter("retType"); 
	    String phone_no = request.getParameter("phone_no"); 
 	    String region_code = request.getParameter("region_code");
 	    String sim_type = request.getParameter("sim_type");
 	    String rsim_no= request.getParameter("sim_no");
	    
	    //返回值定义
      //  String retCode = "";
       // String retMessage = "";
		String sim_no = "";
		
		int  inputNumber = 4;
		String outputNumber = "2";
		String [] inputParam = new String[inputNumber];
		inputParam[0] = request.getParameter("phone_no");
		inputParam[1] = request.getParameter("region_code");
		inputParam[2] = request.getParameter("sim_type");
		inputParam[3] = request.getParameter("sim_no");
		System.out.println("inputParam[0]      ____________________________________ "+ inputParam[0]);
		System.out.println("inputParam[0]       ____________________________________ "+ inputParam[1]);
		System.out.println("inputParam[0]      ____________________________________  "+ inputParam[2]);
		System.out.println("inputParam[0]      ____________________________________  "+ inputParam[3]);
		//SPubCallSvrImpl s1210 = new SPubCallSvrImpl();
		//String[] retStr = s1210.callService("scardver",inputParam,outputNumber,"phone",inputParam[0]);
		//String errCode= String.valueOf(s1210.getErrCode());
		//String errMsg= s1210.getErrMsg();
%>
<wtc:service name="scardver" routerKey="regionCode" routerValue="<%=region_code%>"  retcode="retCode" retmsg="retMessage"  outnum="2" >
			        <wtc:params value="<%=inputParam%>"/>
			        <wtc:param value="<%=outputNumber%>"/>
			         <wtc:param value="phone"/>
			        <wtc:param value="<%=inputParam[0]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%    
System.out.println(retCode+"     retCode in fjysimtyp_1104.jsp_______________________________");    	
if(retCode.equals("0")||retCode.equals("000000")){
System.out.println("retcode=0 in fjysimtyp_1104.jsp");
 			   retCode="000000";
 			}
System.out.println(retType+"     retType in fjysimtyp_1104.jsp__________________________________");

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