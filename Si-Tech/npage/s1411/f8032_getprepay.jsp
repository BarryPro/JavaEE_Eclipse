<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.06
 ģ��:���ſͻ���ҵӦ������
********************/
%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%


	List al = null;
	String[][] errCodeMsg = null;
	String[][] callData = null;
	boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ
  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	
	String errorCode="444444";
	String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String strArray="var arrMsg; ";  //must 
    String retType = request.getParameter("retType");
	String agentCode = request.getParameter("agentCode");
	String phoneType = request.getParameter("phoneType");
	String saletype = request.getParameter("saletype");
	String regionCode = request.getParameter("regionCode");
	String salecode = request.getParameter("salecode");
	String phonemoney="",prepay_limit="";
	String insql="";
	String recv_number="4";
	insql ="select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_limit from sPhoneSalCfg a where a.region_code='" + regionCode + "' and brand_code= '"+ agentCode+ "' and type_code='"+ phoneType+"' and a.sale_type='4' and valid_flag='Y' ";
   	//al = s5010.getCommONESQL(insql,Integer.parseInt(recv_number),0);
%>
	 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
	 <wtc:sql><%=insql%></wtc:sql>
	 </wtc:pubselect>
	 <wtc:array id="callDataTemp" scope="end" />
<%
  //�������ʹ�����Ϣ�ڴ˴�ͳһ����.
   if( callDataTemp.length==0 ){
		valid = 1;
	}else{
		errorCode = retCode1;
		if(!errorCode.equals("000000")){
			valid = 2;
			errorMsg= errorMsg= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode));
 		}else{
			valid = 0;
			callData = callDataTemp;

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


var response = new AJAXPacket();

response.data.add("retType","<%= retType %>");
response.data.add("errorCode","<%= errorCode %>");
response.data.add("errorMsg","<%= errorMsg %>");
response.data.add("backArrMsg",arrMsg );
core.ajax.receivePacket(response);