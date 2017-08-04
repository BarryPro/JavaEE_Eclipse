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
        //得到输入参数      
       // Logger logger = Logger.getLogger("fsavecard_1104.jsp");
       // ArrayList retArray = new ArrayList();         
       // String[][] result = new String[][]{};
 		//comImpl co=new comImpl();
	    //--------------------------
	    //ArrayList arr = (ArrayList)session.getAttribute("allArr");
		//String[][] baseInfo = (String[][])arr.get(0);
		//String workNo = baseInfo[0][2];
		String workNo = (String)session.getAttribute("workNo");
	    String retType = request.getParameter("retType"); 
 	    String region_code = request.getParameter("region_code");
 	    String rsim_no= request.getParameter("sim_no");
 	    String card_no= request.getParameter("card_no");
 	    String phone_no= request.getParameter("phone_no");
 	    String op_code= request.getParameter("op_code");
 	    String sim_type= request.getParameter("sim_type");
	    System.out.println("lcmlcmlcmlcmlmclphone_no="+phone_no);
	    //返回值定义
      //  String retCode = "";
      //  String retMessage = "";
		String sim_no = "";
		
		int  inputNumber = 5;
		String outputNumber = "2";
		String [] inputParam = new String[inputNumber];
		inputParam[0] = request.getParameter("sim_no");
		inputParam[1] = request.getParameter("card_no");
		inputParam[2] = workNo;
		inputParam[3] = op_code;
		inputParam[4] = sim_type;
		
	//	SPubCallSvrImpl s1210 = new SPubCallSvrImpl();
	//	String[] retStr = s1210.callService("supdatecard",inputParam,outputNumber,"phone",phone_no);
	//	String errCode= String.valueOf(s1210.getErrCode());
	//	String errMsg= s1210.getErrMsg();
%>
          <wtc:service name="supdatecard" routerKey="regioncode" routerValue="<%=region_code%>"  retcode="errCode" retmsg="errMsg"  outnum="<%=outputNumber%>" >
			    <wtc:params value="<%=inputParam%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />



<%
	     	if(errCode.equals("0")||errCode.equals("000000")){
                 System.out.println("调用服务supdatecard in fsavecard.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	
 	        	
 	     	}else{
 		       	System.out.println("调用服务supdatecard in fsavecard.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}

%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var sim_no="";

  
retType = "<%=retType%>";
retCode = "<%=errCode%>";
retMessage = "<%=errMsg%>";

  
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);

core.ajax.receivePacket(response);