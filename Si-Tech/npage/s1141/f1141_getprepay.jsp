<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.04
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%


	//List al = null;
	//String[][] errCodeMsg = null;
	//String[][] callData = null;
	boolean showFlag=false;	//showFlag表示是否有数据可供显示
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
	
	//String errorCode="444444";
	
	//String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
	String strArray="var arrMsg; ";  //must 
    String retType = request.getParameter("retType");// 从上级页面得到的
	String agentCode = request.getParameter("agentCode");//--sql
	String phoneType = request.getParameter("phoneType");//--sql
	String saletype = request.getParameter("saletype");//没用到
	String regionCode = request.getParameter("regionCode");//--sql + 路由
	String salecode = request.getParameter("salecode");//---没用到
	String phonemoney="",prepay_limit="";
	String insql="";
	String recv_number="4";
	insql ="select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_limit,mon_base_fee*to_number(nvl(mode_code,'0')),nvl(mode_code,'0') from sPhoneSalCfg a where a.region_code='" + regionCode + "' and brand_code= '"+ agentCode+ "' and type_code='"+ phoneType+"' and a.sale_type='1' and valid_flag='Y' ";
      
   	//al = s5010.getCommONESQL(insql,Integer.parseInt(recv_number),0);
  //错误代码和错误信息在此处统一处理.
  System.out.println("diaoyongqian((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((");
 %>
		 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="errorCode" retmsg="errorMsg" outnum="6">
		 <wtc:sql><%=insql%></wtc:sql>
		 
		 </wtc:pubselect>
		 <wtc:array id="callData" scope="end" />

 <%

									
          if(errorCode.equals("0")||errorCode.equals("000000")){
          System.out.println("调用服务sPubSelect in f1141_getprepay.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        						
								if(callData.length!=0){
								   valid = 0;
					     		}else{
								   valid = 2;
								}	
						
									System.out.println("callData.length="+callData.length);
									strArray = WtcUtil.createArray("arrMsg",callData.length);
 	        	
 	     	}else{
 	     		valid = 1;
 				System.out.println("调用服务sPubSelect in f1141_getprepay.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}

  
  
  
 /**  if( al == null ){
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
**/

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

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType","<%= retType %>");
response.data.add("errorCode","<%= errorCode %>");
response.data.add("errorMsg","<%= errorMsg %>");
response.data.add("backArrMsg",arrMsg );
core.ajax.receivePacket(response);
