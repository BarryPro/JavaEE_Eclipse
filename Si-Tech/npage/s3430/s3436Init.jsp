<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
	System.out.println("------------------------------------------------s3436Init.jsp---------------------------------");
	String loginNo = baseInfo[0][2];
	String smCode = request.getParameter("smCode");
	String grpUserNo = request.getParameter("grpUserNo");
	String opCode = request.getParameter("opCode");
	String strArray="var arrMsg; ";  //must
	
	//String []inputPara = new String[]{loginNo,grpUserNo,opCode,smCode};
	ArrayList  inputParam = new ArrayList();
	inputParam.add(loginNo);
	inputParam.add(grpUserNo);
	inputParam.add(opCode);
	inputParam.add(smCode);
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retArray = new ArrayList();
	String [][]custInit=new String[][]{};
	String [][]apnInit=new String[][]{};
	//retArray = callView.callFXService("s1212Init",inputParam,"4",outList);
	String  outList[][] = new String [][]{{"0","8"}, {"8","6"}};
	retArray = impl.callFXService("s3436Init",inputParam,"4",outList);
	String returnCode = (new Integer(impl.getErrCode())).toString();
	String returnMsg = impl.getErrMsg();
	custInit=(String[][])retArray.get(0);
	apnInit=(String[][])retArray.get(1);
	strArray = CreatePlanerArray.createArray("arrMsg",apnInit.length);
%>   
<%=strArray%>
<%	if( returnCode.equals("0")){ %>
<%		for(int i = 0 ; i < apnInit.length ; i ++){
			for(int j = 0 ; j < apnInit[i].length ; j ++){
				if(apnInit[i][j].trim().equals("") || apnInit[i][j] == null){
					apnInit[i][j] = "";
				}
			//System.out.println("||---------" + apnInit[i][j].trim() + "-------------||");
%>
			arrMsg[<%=i%>][<%=j%>] = "<%=apnInit[i][j].trim()%>";
<%
			}
		}
%>
	alert("<%=returnCode%>");
	var response = new AJAXPacket();
	var retType = "";
	var retCode = "";
	var retMessage = "";
	var id_no        = '<%=custInit[0][0].trim()%>';                               
	var user_passwd     = '<%=custInit[0][1].trim()%>';                               
	var id_iccid        = '<%=custInit[0][2].trim()%>';                               
	var productCode     = '<%=custInit[0][3].trim()%>';                               
	var productName     = '<%=custInit[0][4].trim()%>';                               
	var contractNo      = '<%=custInit[0][5].trim()%>';                               
	var custName        = '<%=custInit[0][6].trim()%>';
	var custAddr        = '<%=custInit[0][7].trim()%>';  

	retType = "s3436Init";
	retCode = "<%=returnCode%>";
	retMessage = "<%=returnMsg%>";

	response.data.add("retType",retType);
	response.data.add("retCode",retCode);
	response.data.add("retMessage",retMessage);

	response.data.add("grpIdNo",id_no);
	response.data.add("user_passwd",user_passwd);
	response.data.add("id_iccid",id_iccid);
	response.data.add("custName",custName);
	response.data.add("custAddr",custAddr);
	response.data.add("productCode",productCode);
	response.data.add("productName",productName);
	response.data.add("contractNo",contractNo);
	response.data.add("backArrMsg",arrMsg );
	core.ajax.receivePacket(response);	
<%} else{%>
		var response = new AJAXPacket();
		var retType = "s3436Init";
		response.data.add("retCode","<%=returnCode%>");
		response.data.add("retType",retType);
		response.data.add("retMessage","<%=returnMsg%>");
		core.ajax.receivePacket(response);	
<%}%>

