<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="../common/error.jsp" %>
<%@ page import="com.sitech.boss.s5010.viewBean.*"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%@ page import="com.sitech.boss.pub.config.INIT_DATA"%>
<jsp:useBean id="s5010" class="com.sitech.boss.s5010.viewBean.S5010Impl" />


<%


	List al = null;
	String[][] errCodeMsg = null;
	String[][] callData = null;
	boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ
  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	
	String errorCode="444444";
	String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String strArray="var arrMsg; ";  //must 
    
    String verifyType = request.getParameter("verifyType");
	String insql = request.getParameter("sqlBuf");
	String recv_number = request.getParameter("recv_number");

//System.out.println(insql);	
   	al = s5010.getCommONESQL(insql,Integer.parseInt(recv_number),0);
  //�������ʹ�����Ϣ�ڴ˴�ͳһ����.
   if( al == null ){
		valid = 1;
	}else{
		errCodeMsg = (String[][])al.get(0);
		errorCode=errCodeMsg[0][0];
		if( Integer.parseInt(errorCode) != 0 ){
			valid = 2;
			errorMsg= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode));
 		}else{
			valid = 0;
			callData = (String[][])al.get(1);

			System.out.println("callData.length="+callData.length);
			strArray = CreatePlanerArray.createArray("arrMsg",callData.length);
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
var response = new RPCPacket();

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("verifyType","<%= verifyType %>");
response.data.add("errorCode","<%= errorCode %>");
response.data.add("errorMsg","<%= errorMsg %>");
response.data.add("backArrMsg",arrMsg );
core.rpc.receivePacket(response);


