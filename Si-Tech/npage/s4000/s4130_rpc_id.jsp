<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>  

<%
	String[][] errCodeMsg = null;

	
	boolean showFlag=false;	//showFlag表示是否有数据可供显示
	int valid = 1;	//0:正确，1：系统错误，2：业务错误
  	
	String verifyType = request.getParameter("verifyType");
	String loginNo = request.getParameter("loginNo"); 	/* 操作工号   */ 
	String orgCode = request.getParameter("orgCode");	/* 归属代码   */	
	String opCode = request.getParameter("opCode");		/* 操作代码   */	
	String idType = request.getParameter("IDType");	 
	String idItemRange = request.getParameter("IDItemRange");	
	String regionCode = request.getParameter("orgCode").substring(0,2);
	System.out.println("loginNo------------>"+loginNo);
	System.out.println("orgCode------------>"+orgCode);
	System.out.println("opCode------------>"+opCode);
	System.out.println("idType------------>"+idType);
	System.out.println("idItemRange------------>"+loginNo);

%>

var arrMsg = new Array();
var arrMsg1 = new Array();

<%
String errCodeGetOffer="0000";
String errMsgGetOffer="成功";
System.out.println("error_code----------------------<>"+errCodeGetOffer);
System.out.println("error_msg----------------------<>"+errMsgGetOffer);

String[][] callData={{"800456710","王广利","123","0"}};
if(callData!=null&&callData.length>0)
{
	for(int i = 0 ; i < callData.length ; i ++){
%>
		arrMsg["<%=i%>"]=new Array(); 
<%
		for(int j=0;j < callData[i].length ; j ++){
		if( callData[i][j] == null||callData[i][j].trim().equals("")){
   			callData[i][j] = "";
   		}
%>
		arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
		}	
	}
}
%>

<%
String[][] callData1={{"10000","王立","0","0"}};
if(callData1!=null){
		for(int i = 0 ; i < callData1.length ; i ++){
%>
				arrMsg1["<%=i%>"]=new Array(); 
<%			
      		for(int j = 0 ; j < callData1[i].length ; j ++){
						if(callData1[i][j] == null || callData1[i][j].trim().equals("") ){
	   				callData1[i][j] = "";
				}
%>
				arrMsg1[<%=i%>][<%=j%>] = "<%=callData1[i][j]%>";
<%
  		}
		}
	}
%>
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("verifyType","phoneno");
response.data.add("errorCode","<%=errCodeGetOffer%>");
response.data.add("errorMsg","<%=errMsgGetOffer%>");
response.data.add("backArrMsg",arrMsg );
response.data.add("backArrMsg1",arrMsg1 );
core.ajax.receivePacket(response);