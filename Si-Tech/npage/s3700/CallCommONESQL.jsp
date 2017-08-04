 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-14 页面改造,修改样式
	********************/
%> 

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
	List al = null;
	//String[][] errCodeMsg = null;
	String[][] callData = null;
	boolean showFlag=false;	//showFlag表示是否有数据可供显示
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
	String regionCode = (String)session.getAttribute("regCode") ;	
	String errorCode="444444";
	String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
	String strArray="var arrMsg; ";  //must 
    
    	String verifyType = request.getParameter("verifyType");
	String insql = request.getParameter("sqlBuf");
	String recv_number = request.getParameter("recv_number");
	    String param = request.getParameter("params");
%>
	<wtc:service name="sCrmDefSqlSel" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="<%=recv_number%>">
		  <wtc:param value="<%=insql%>"/>
		  <wtc:param value="<%=param%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
	
<%
	for(int iii=0;iii<result1.length;iii++){
		for(int jjj=0;jjj<result1[iii].length;jjj++){
			System.out.println("------hejwa---------------result1["+iii+"]["+jjj+"]=-----------------"+result1[iii][jjj]);
		}
	}
   	//al = s5010.getCommONESQL(insql,Integer.parseInt(recv_number),0);
  	//错误代码和错误信息在此处统一处理.
   	if( result1 == null ){
		valid = 1;
	}else{
		//errCodeMsg = (String[][])al.get(0);		
		//errorCode=errCodeMsg[0][0];
		errorCode=retCode1;
		if( Integer.parseInt(errorCode) != 0 ){
			valid = 2;
			errorMsg= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode));
 		}else{
			valid = 0;
			//callData = (String[][])al.get(1);
			callData=result1;
			System.out.println("callData.length="+callData.length);
			strArray = WtcUtil.createArray("arrMsg",callData.length);
		}
	}
%>

<%=strArray%>

<% if( valid == 0 ){  %>
<%
for(int i = 0 ; i < callData.length ; i ++){
      for(int j = 0 ; j < callData[i].length ; j ++){

if(callData[i][j].trim().equals("") || callData[i][j] == null){
   callData[i][j] = "";
}
System.out.println("||----hejwa-----" + callData[i][j].trim() + "-------------||");
%>

	arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
  }
}
%>


<% } %>


	<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>
	var response = new AJAXPacket();
	response.data.add("verifyType","<%= verifyType %>");
	response.data.add("errorCode","<%= errorCode %>");
	response.data.add("errorMsg","<%= errorMsg %>");
	response.data.add("backArrMsg",arrMsg );
	core.ajax.receivePacket(response);


