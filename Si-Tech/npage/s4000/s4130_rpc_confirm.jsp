<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ page import="java.text.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%! /**���������������ʽ�������Сд����**/ 
public static String formatNumber(String num, int zeroNum) 
{ 
	DecimalFormat form =(DecimalFormat)NumberFormat.getInstance(Locale.getDefault()); 
	StringBuffer patBuf = new StringBuffer("0"); 
	if(zeroNum > 0) 
	{ 
		patBuf.append("."); 
		for(int i = 0; i < zeroNum; i++) 
		{ 
			patBuf.append("0"); 
		}
	}
	form.applyPattern(patBuf.toString());
	return form.format(Double.parseDouble(num)).toString();
}
%>

<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>  

<%
  String chinaFee = "";
	String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String errorCode="444444";
	String[][] errCodeMsg = null;
	String[][] input_paras = new String[1][9];
	String[][] recv_num = new String[2][2];

	List al = null;
	boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ
 	int valid = 2;	//0:��ȷ��1��ϵͳ����2��ҵ�����

  String verifyType = request.getParameter("verifyType");
	String op_code = request.getParameter("opCode");


	String loginNo = request.getParameter("loginNo"); 	/* ��������   */ 
	String orgCode = request.getParameter("orgCode");	/* ��������   */	
	String opCode = request.getParameter("opCode");		/* ��������   */
	String totalDate = request.getParameter("totalDate");		
	String idType = request.getParameter("IDType");	 
	String idItemRange = request.getParameter("IDItemRange");	
	String accountNo=request.getParameter("accountNo");
	if(accountNo==null||accountNo.trim().equals("")){
		accountNo="0";
	}
	String xx_money = "";
	String payMoney = request.getParameter("payMoney");	
	String handFee = request.getParameter("handFee");
	String busyAccept = request.getParameter("busyAccept");	
	String opNote = request.getParameter("opNote");	
	String regionCode = request.getParameter("orgCode").substring(0,2);
	String test_flag = request.getParameter("test_flag");
	if(test_flag==null){test_flag="0";}
	String prepay_money = request.getParameter("prepay_money");
	xx_money=formatNumber(prepay_money,2);
%>
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
					<wtc:param value="<%=xx_money%>"/>
					</wtc:service>
					<wtc:array id="chinaFeeArr" scope="end"/>	
	<%
		 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
				chinaFee = chinaFeeArr[0][2];
			}
	%>
var arrMsg = new Array();

<% 
String errCodeGetOffer="0000";
String errMsgGetOffer="�ɹ�";
String[][] callData={{"700456713","800456713","900456713"}};
if( callData == null ){
 		System.out.println("======jsp3212:array is null!!===");
		valid = 1;
	}
if("success".equals(errMsgGetOffer)){
	errMsgGetOffer = "�ɷѳɹ�";
}
if("0000".equals(errCodeGetOffer)){
	valid = 0;
	errCodeGetOffer = "0000";
}
System.out.println("~~~~~~~~~~~~~~~~~~~~~~~valid="+valid+"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
if( valid == 0 ){  %>

	<%
	for(int i = 0 ; i < callData.length ; i ++){
	%>
	arrMsg["<%=i%>"]=new Array(); 
	<%
		for(int j = 0 ; j < callData[i].length ; j ++){
			if(callData[i][j] == null || callData[i][j].trim().equals("") ){
				callData[i][j] = "";
			}
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~callData[i][j]="+callData[i][j]+"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			%>
		
			arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
			<%
	  }
	}
}

%>


var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("verifyType","<%= verifyType %>");
response.data.add("errorCode","<%= errCodeGetOffer %>");
response.data.add("errorMsg","<%= errMsgGetOffer %>");
response.data.add("backArrMsg",arrMsg );
response.data.add("backArrMsg",arrMsg );
response.data.add("xx_money","<%= xx_money %>");
response.data.add("chinaFee","<%= chinaFee %>");
core.ajax.receivePacket(response);