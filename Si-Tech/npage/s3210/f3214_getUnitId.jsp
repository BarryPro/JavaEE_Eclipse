 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-13 页面改造,修改样式
	********************/
%> 
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String regionCode = (String)session.getAttribute("regCode");   
	
	//List al = null;
	//String[][] errCodeMsg = null;
	String[][] callData = null;
	String[][] callData2 = null;
	//boolean showFlag=false;	//showFlag表示是否有数据可供显示
  	int valid = 1;				//0:正确，1：系统错误，2：业务错误
  	int valid2 = 1;				//0:正确，1：系统错误，2：业务错误
	
	String errorCode="444444";
	String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
	String strArray="var arrMsg; ";  //must 
	
	String errorCode2="444444";
	String errorMsg2="系统错误，请与系统管理员联系，谢谢!!";
	String strArray2="var arrMsg1; ";  //must 
    
    	String verifyType = request.getParameter("verifyType");
	String groupNo = request.getParameter("groupNo");
	
	String insql="select unit_id||'->'||unit_name from dbvipadm.dGrpCustMsg where unit_code not in (select unit_code from dbvipadm.d_unit_code_09)  and  boss_vpmn_code ='"+groupNo+"'";
	//String insql="select group_no||'->'||trim(group_name) from dVPMNGRPMSG where group_no = '"+groupNo+"'";
  //wuxy add 20090624 获取集团产品级资费是否有限制
  String insql2="select count(*) from dvpmngrpmsg a,svpmnlimitfeeindex b where a.interfee=b.feeindex and a.region_code=b.region_code and a.group_no='"+groupNo+"' ";
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=insql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />	
	<%

		System.out.println("insql:"+insql);
		/*try{
	   	al = s5010.getCommONESQL(insql,1,0);
		errorCode="0";
		}
		catch(Exception e){
			e.printStackTrace();
		}*/
  	//错误代码和错误信息在此处统一处理.
   if( result1 == null ){
		valid = 1;
	}else{
		//errCodeMsg = (String[][])al.get(0);
		errorCode=retCode1;
		if( Integer.parseInt(errorCode) != 0 ){
			valid = 2;
			errorMsg= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode));
 		}else{
			valid = 0;
			//callData = (String[][])al.get(1);
			callData = result1;
			System.out.println("callData.length="+callData.length);
			strArray = WtcUtil.createArray("arrMsg",callData.length);
		}
	}
	
	
	
	//获取产品级资费
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
	 <wtc:sql><%=insql2%></wtc:sql>
	 </wtc:pubselect>
	 <wtc:array id="result3" scope="end" />
	 	
<%
    if( result3 == null ){
			valid2 = 1;
		}else{
			//errCodeMsg1 = (String[][])a2.get(0);
			//errorCode1=errCodeMsg1[0][0];
			errorCode2=retCode3;
			if( Integer.parseInt(errorCode2) != 0 ){
				valid2 = 2;
				errorMsg2= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode2));
				//errorMsg2= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode2));
	 		}else{
				valid2 = 0;
				//callData1 = (String[][])a2.get(1);
	                        callData2=result3;
				//System.out.println("callData1.length="+callData2.length);
				strArray2 = WtcUtil.createArray("arrMsg1",callData2.length);
			}
		}
 
	

System.out.println("getUnitId.jsp1: valid="+valid);
System.out.println("getUnitId.jsp: errorCode="+errorCode);
System.out.println("getUnitId.jsp2: valid2="+valid2);
System.out.println("getUnitId.jsp: errorCode2="+errorCode2);
%>



<%=strArray%>
<%System.out.println(strArray);%>
<%=strArray2%>
<%System.out.println(strArray2);%>
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

<% if( valid2 == 0 ){  %>
<%
for(int i = 0 ; i < callData2.length ; i ++){
      for(int j = 0 ; j < callData2[i].length ; j ++){

if(callData2[i][j].trim().equals("") || callData2[i][j] == null){
   callData2[i][j] = "";
}
System.out.println("callData2["+i+"]["+j+"]"+"||---------" + callData2[i][j].trim() + "-------------||");
%>

arrMsg1[<%=i%>][<%=j%>] = "<%=callData2[i][j].trim()%>";
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
response.data.add("backArrMsg2",arrMsg1 );
core.ajax.receivePacket(response);


