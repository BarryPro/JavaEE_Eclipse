<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="../common/error.jsp" %>
<%@ page import="com.sitech.boss.s5010.viewBean.*"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%@ page import="com.sitech.boss.pub.config.INIT_DATA"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
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
	//xl add
	String s_region = request.getParameter("s_region");
	String s_date1 = request.getParameter("s_date1");
	String s_date2 = request.getParameter("s_date2");
	String dealType = request.getParameter("dealType");
	String recv_number = request.getParameter("recv_number");

      System.out.println("444444444444444444444444444444444"+verifyType);
      System.out.println("4444444444444444444444444444444444"+insql);
      System.out.println("5555555555555555555555555555555555 s_region is "+s_region);	
  // 	al = s5010.getCommONESQL(insql,Integer.parseInt(recv_number),0);
  String[] inParams = new String[2];
  inParams[0]=insql;
  inParams[1]="s_region="+s_region+",s_deal="+dealType+",s_date1="+s_date1+",s_date2="+s_date2;
	%>
<wtc:service name="sBossDefSqlSel" retcode="retCode"  outnum="<%=recv_number%>">
	  <wtc:param value="<%=inParams[0]%>"/>
	  <wtc:param value="<%=inParams[1]%>"/>
</wtc:service>
<wtc:array id="retList"   scope="end" />
<%
  //�������ʹ�����Ϣ�ڴ˴�ͳһ����.
   if( retList == null ){
		valid = 1;
	}else{
		//errCodeMsg = (String[][])al.get(0);
		errorCode=retCode;
		if( Integer.parseInt(errorCode) != 0 ){
			valid = 2;
			errorMsg= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode));
 		}else{
			valid = 0;
			//callData = (String[][])al.get(1);
      callData =retList;
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


