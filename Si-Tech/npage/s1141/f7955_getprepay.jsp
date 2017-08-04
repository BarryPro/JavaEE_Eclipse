<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>



<%


	List al = null;
	String[][] errCodeMsg = null;
	String[][] callData = null;
	boolean showFlag=false;	//showFlag表示是否有数据可供显示
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
			String errorCode="000000";
	String errorMsg="成功";

	String strArray="var arrMsg; ";  //must 
    String retType = request.getParameter("retType");
	String agentCode = request.getParameter("agentCode");
	String phoneType = request.getParameter("phoneType");
	String saletype = request.getParameter("saletype");
	String regionCode = request.getParameter("regionCode");
	String salecode = request.getParameter("salecode");
	String phonemoney="",prepay_limit="";
	String insql="";
	String recv_number="12"; //huangrong update 8-->12
	System.out.println(agentCode+"-------------"+phoneType+"-----------------"+saletype+"-----------------------"+regionCode);
	insql ="select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_gift,nvl(consume_term,0),trim(op_note),prepay_limit*active_term,nvl(active_term,0.0),mon_base_fee*free_fee,nvl(free_fee, 0.0), base_fee*all_gift_price,nvl(all_gift_price, 0.0) from sPhoneSalCfg a where a.region_code='" + regionCode + "' and brand_code= '"+ agentCode+ "' and type_code='"+ phoneType+"' and a.sale_type='"+ saletype+"' and valid_flag='Y' ";
      
   //	al = s5010.getCommONESQL(insql,Integer.parseInt(recv_number),0);
  %>
   	
   	  <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="<%=recv_number%>">
	<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result_t" scope="end" />
  
   <%	
   System.out.println(RetCode1+"|||||||||||||||||||||||||"+RetMsg1);
 	if(RetCode1.equals("000000") || RetCode1.equals("0")) {

	callData = result_t;
	if(callData.length!=0){
				valid = 0;
	}else{
				valid = 2;
				errorCode="44444444";
	}
				strArray = WtcUtil.createArray("arrMsg",callData.length);
	}
  else {
		valid = 1;
	System.out.println(RetCode1+"|||||||||||---------------||||||||||||||"+RetMsg1);

	 errorCode=RetCode1;
	 errorMsg=RetMsg1;
	}
  //错误代码和错误信息在此处统一处理.
 /* if( result_t == null ){
		valid = 1;
	}else{

		errorCode=RetCode1;
		if(!errorCode.equals("000000")){
			valid = 2;
			errorMsg= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode));
 		}else{
			valid = 0;
			System.out.println("callData.length="+result_t[0].length);
			strArray = CreatePlanerArray.createArray("arrMsg",result_t[0].length);
		}
	}*/
	

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


<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+errorCode+"------------"+RetMsg1);%>
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType","<%= retType %>");
response.data.add("errorCode","<%= errorCode %>");
response.data.add("errorMsg","<%= RetMsg1 %>");
response.data.add("backArrMsg",arrMsg );
core.ajax.receivePacket(response);

