<%
/********************
 *开发商: si-tech
 *create by wanghfa @ 20110725
 ********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	request.setCharacterEncoding("GBK");
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	System.out.println("yanpx publiEInvCancel" );

	String retCode = "000000";
	String retMsg1="";
	String billhao="";
	String billdai="";
	String yzaccept="";

	String s_old_number="";	//原发票号码
	String s_old_code="";	//原发票代码
	String s_old_status="";	//原发票状态 0-未开具 1-纸质 2-自助终端 6-预占 e-电子发票 r-收据 z-专票
	String s_old_accept="";	//原电子发票流水
	String ei_flag = "false";//正业务是否为电子发票打印
	
	String j_retCode = "";
	String j_retMsge = "";
			
try{	
String loginNo = (String)session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String ipAddrss = (String)session.getAttribute("ipAddr");
String groupId = (String)session.getAttribute("groupId");

	String payaccept = WtcUtil.repNull(request.getParameter("liushui"));
	String z_loginAccept = WtcUtil.repNull(request.getParameter("z_loginAccept"));
	
	
	String op_code= WtcUtil.repNull(request.getParameter("opCode"));
	String phone_no= WtcUtil.repNull(request.getParameter("workno"));
	String old_ym= WtcUtil.repNull(request.getParameter("old_ym"));
	String jiner= WtcUtil.repNull(request.getParameter("jiner"));
	String shuilv= WtcUtil.repNull(request.getParameter("shuilv"));
	String[] inPara_sj = new String[6];
	inPara_sj[0]=z_loginAccept;
	inPara_sj[1]=op_code;
	inPara_sj[2]=loginNo;
	inPara_sj[3]=old_ym;
	inPara_sj[4]=jiner;
	inPara_sj[5]=shuilv;
	
	for(int i=0;i<inPara_sj.length;i++){
		System.out.println("-------billnew---------inPara_sj["+i+"]--------getOldNumber.jsp-------->"+inPara_sj[i]);
	}	
%>
        
<wtc:service name="sInvAcceptQry" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="5"  >
	<wtc:param value="<%=inPara_sj[0]%>"/> 
	<wtc:param value="<%=inPara_sj[1]%>"/>
	<wtc:param value="<%=inPara_sj[2]%>"/> 
	<wtc:param value="<%=inPara_sj[3]%>"/> 
	<wtc:param value="<%=inPara_sj[4]%>"/>
	<wtc:param value="<%=inPara_sj[5]%>"/> 		
</wtc:service> 
	
	<wtc:array id="result_t1" scope="end" start="0"  length="1"  />
	<wtc:array id="result_t2" scope="end" start="1"  length="4" />
			
<%

 

	for(int iii=0;iii<result_t2.length;iii++){
		for(int jjj=0;jjj<result_t2[iii].length;jjj++){
			System.out.println("----billnew-----------------result_t2["+iii+"]["+jjj+"]=-----------------"+result_t2[iii][jjj]);
		}
	}
	

	for(int i=0;i<result_t2.length;i++){
		if("e".equals(result_t2[i][2])){
			ei_flag = "true";// 有电子发票
			s_old_code=result_t2[i][0]==null?"":result_t2[i][0];
			s_old_number=result_t2[i][1]==null?"":result_t2[i][1];
			s_old_status=result_t2[i][2]==null?"":result_t2[i][2];
			s_old_accept=result_t2[i][3]==null?"":result_t2[i][3];
			break;
		}			
	}
	
	if("false".equals(ei_flag)){
		if(result_t2.length>0){
			s_old_code=result_t2[0][0]==null?"":result_t2[0][0];
			s_old_number=result_t2[0][1]==null?"":result_t2[0][1];
			s_old_status=result_t2[0][2]==null?"":result_t2[0][2];
			s_old_accept=result_t2[0][3]==null?"":result_t2[0][3];
		}
	}

j_retCode = errCode;
j_retMsge = errMsg;

System.out.println("-------billnew----sInvAcceptQry--------errCode------------------>"+errCode);
System.out.println("-------billnew----sInvAcceptQry--------errMsg------------------>"+errMsg);


System.out.println("-------billnew------------ei_flag------------------>"+ei_flag);
	
System.out.println("-------billnew------------s_old_code--------------->"+s_old_code);	
System.out.println("-------billnew------------s_old_number------------->"+s_old_number);	
System.out.println("-------billnew------------s_old_status------------->"+s_old_status);
System.out.println("-------billnew------------s_old_accept------------->"+s_old_accept);

}catch(Exception e){
	e.printStackTrace();
	j_retCode = "BILL006";
}		
%>
	


var response = new AJAXPacket();
response.data.add("retCode", "<%=j_retCode%>");
response.data.add("retMsge", "<%=j_retMsge%>");
response.data.add("s_old_number", "<%=s_old_number%>");
response.data.add("s_old_code", "<%=s_old_code%>");
response.data.add("s_old_status", "<%=s_old_status%>");
response.data.add("s_old_accept", "<%=s_old_accept%>");
response.data.add("ei_flag", "<%=ei_flag%>");

core.ajax.receivePacket(response);
