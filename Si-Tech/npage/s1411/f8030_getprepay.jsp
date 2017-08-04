<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-6
********************/
%>

	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%@ page import="com.sitech.boss.pub.config.INIT_DATA"%>


<%

	String errCodeMsg = null;
String[][] callData = new String[][]{};
	boolean showFlag=false;	//showFlag表示是否有数据可供显示
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
	
	String errorCode="444444";
	String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
	String strArray="var arrMsg; ";  //must 
  String retType = request.getParameter("retType");
	String agentCode = request.getParameter("agentCode");
	String phoneType = request.getParameter("phoneType");
	String saletype = request.getParameter("saletype");
	String regionCode = request.getParameter("regionCode");
	String salecode = request.getParameter("salecode");
	String phonemoney="",prepay_limit="";
	String insql="";
	insql ="select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_limit from sPhoneSalCfg a where a.region_code='" + regionCode + "' and brand_code= '"+ agentCode+ "' and type_code='"+ phoneType+"' and a.sale_type='5' and valid_flag='Y' ";
      
%>

		<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=insql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%   	//al = s5010.getCommONESQL(insql,Integer.parseInt(recv_number),0);
	if(code2.equals("000000"))
	callData = result_t;

  //错误代码和错误信息在此处统一处理.
   if( result_t == null ){
		valid = 1;
	}else{
		errCodeMsg = msg2;
		errorCode= code2;
		if( !errorCode.equals("000000")){
			valid = 2;
			errorMsg= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode));
 		}else{
			valid = 0;
			System.out.println("callData.length="+result_t[0].length);
			strArray = CreatePlanerArray.createArray("arrMsg",result_t[0].length);
		}
	}
	

System.out.println("CallCommONESQL.jsp1: valid="+valid);
System.out.println("CallCommONESQL.jsp: errorCode="+errorCode);
%>



<%=strArray%>

<% if( valid == 0 ){  %>

<%
for(int i = 0 ; i < callData.length ; i ++){
      for(int j = 0 ; j < callData[i].length ; j ++){

if(callData[i][j].trim().equals("") || callData[i][j] == null){
   callData[i][j] = "";
}
System.out.println("||---------" + callData[i][j].trim() + "-------------||");
%>

arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
  }
}
%>


<% } %>


<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>
var response = new AJAXPacket();

response.data.add("retType","<%= retType %>");
response.data.add("errorCode","<%= errorCode %>");
response.data.add("errorMsg","<%= errorMsg %>");
response.data.add("backArrMsg",arrMsg );
core.ajax.receivePacket(response);