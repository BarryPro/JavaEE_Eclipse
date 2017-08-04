 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
<%
		
    String opName = "话费余额查询";
    String opCode = WtcUtil.repNull(request.getParameter("opCode"));
    String custName = WtcUtil.repNull(request.getParameter("custName"));
    String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
    String workNo = (String)session.getAttribute("workNo");
 		String regionCode = (String)session.getAttribute("regCode");
 		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
	  Calendar c = Calendar.getInstance();
    String start_date = sdf.format(c.getTime());
    String opcode="KK56";
    String sqlUpdDcallcall = "insert into DCALLOPR"+start_date+" (OP_CODE,BOSS_NO,OP_DATE,OP_NAME,PHONE_NO) values (:v1,:v2,sysdate,:v3,:v4)";
	//add by lipf for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");
    
%>
			<wtc:service name="sPubModifyKfCfm" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
				<wtc:param value="<%=sqlUpdDcallcall%>"/>
				<wtc:param value="dbchange"/>
				<wtc:param value="<%=opcode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="话费余额"/>
				<wtc:param value="<%=phoneNo%>"/>
			</wtc:service>	

		<wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code141" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="141" />	
		</wtc:service>
		<wtc:array id="result_t141" scope="end" />
			
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code12" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="12" />	
		</wtc:service>
		<wtc:array id="result_t12" scope="end" />
				
			
<%
		String deposit = "";
 		if(code141.equals("000000")&&result_t141.length>0){
		 	deposit = result_t141[0][2];
		 } 
		 
		
		String xeFee = "";
 		if(code12.equals("000000")&&result_t12.length>0){
		 	xeFee = result_t12[0][2];
		 } 
		 
		 String getIdnoSql = "select id_no from dcustmsg where phone_no='"+phoneNo+"'";
%>			
 		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=getIdnoSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
	 	
<%
String idNo = "";

if(code.equals("000000")&&result_t.length>0){
	idNo = result_t[0][0];
}

%>	 	

	<wtc:service name="s1500_fee1"  retcode="feeRetCode" retmsg="feeRetMsg" outnum="10">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=idNo%>"/>
	</wtc:service>
	<wtc:array id="s1500FeeArr" scope="end"/>
		
	<wtc:service name="s1500_feeVW" routerKey="region" routerValue="<%=regionCode%>" retcode="feeRetCode" retmsg="feeRetMsg" outnum="8">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=idNo%>"/>
	</wtc:service>
	<wtc:array id="s1500FeeArrVW" scope="end"/>
	<%
	String nobillpay = "";
	nobillpay = s1500FeeArrVW[0][4]; //未出账话费
	%>
	
	

	<wtc:service name="sPhoneDefMsgVW"  retcode="feeRetCode1" retmsg="feeRetMsg1" outnum="16">
	<wtc:param value="<%=phoneNo%>"/>
  </wtc:service>
	<wtc:array id="s1500FeeArr2" scope="end"/>
<%

String show_fee = "";
String prepayFee = "";

String now_prepayFee = "";
String  pu_spe_prepayFee="";
String expire="";
String wang_fee="";
String spe_prepayFee="";
String yue="";
	if(Integer.parseInt(feeRetCode)==0&&Integer.parseInt(feeRetCode1)==0){
		if(s1500FeeArr.length>0){
			show_fee = s1500FeeArr2[0][10]; //当前预存;
			prepayFee = s1500FeeArr[0][3];//当前可划拨预存
			
		
			spe_prepayFee = s1500FeeArr2[0][2];//专款
	    pu_spe_prepayFee=s1500FeeArr2[0][3];//普通
	    now_prepayFee=String.valueOf(((Double.parseDouble(spe_prepayFee) + Double.parseDouble(pu_spe_prepayFee))*100)/100);//当前可用预存
	    wang_fee = s1500FeeArr2[0][8];//往月欠费
	    expire=s1500FeeArr[0][9];//有效期
	    yue= s1500FeeArr2[0][15];//余额
		}
	}
	
	show_fee = show_fee.trim();
%>
	<!--update by lipf 20120717 服务加固begin-->
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
		
	<wtc:service name="s1500Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="1500"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=idNo%>"/>
	</wtc:service>
	<wtc:array id="mainQryArr" scope="end"/>	
	<!--update by lipf 20120717 服务加固end-->
<%
System.out.println("lipf   showFeeInfo.jsp    ================= ->retCode1->       "+retCode1+"  ==phoneNo== "+phoneNo +"  ==idNo=== " + idNo);
String f17951ee= "此用户没有17951充值信息";
try{
%>		
	 	<wtc:service name="s17951IpFee" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=workNo%>" />	
			<wtc:param value="<%=phoneNo%>" />
		</wtc:service>
		<wtc:array id="result_17951" scope="end" />		
<%
if(code2.equals("000000")&&result_17951.length>0){
	f17951ee = result_17951[0][0] ;
}
}catch(Exception ex){
%>
<script language="javaScript">
	alert("服务s17951IpFee调用出错",0);
	window.close();
</script>
<%
}



 System.out.println("----------f17951ee----------"+f17951ee);
		
  ArrayList arlist = new ArrayList();
	StringTokenizer resToken = null;
  for(int i = 0; i<mainQryArr.length; i++){
  	for(int j=0;j<mainQryArr[i].length;j++){
  		String value;
      for(resToken = new StringTokenizer(mainQryArr[i][j], "|"); resToken.hasMoreElements(); arlist.add(value)){
          value = (String)resToken.nextElement();
      }
  	}
  }
  System.out.println("--------(String)arlist.get(59)-------------"+(String)arlist.get(59));
  
  String payType = "";
  if(arlist!=null&&arlist.size()>58){
  	payType = (String)arlist.get(59);
  }
  if(payType==null) payType = "";
%>	
<%
	String userEndDate = "";

	%>
		<wtc:service name="sDelUserDate" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=phoneNo%>"/>
			</wtc:service>
		<wtc:array id="delUserList" scope="end"/>
	<%
		if("000000".equals(retCode))
		{
			userEndDate = delUserList[0][0];
		}else{
			userEndDate = retMsg;
			}
	
%>
<html>
<head>
<title> 话费余额查询</title>
</head>


<body>
<form name="form1">
<%@ include file="/npage/include/header.jsp" %>
<div class="title"><div id="title_zi">话费余额查询</div></div>
   <table  cellspacing="0">
   		<tr>
   	   	<td class="blue">用户名称</td>
   	   	<td><input type="text" name="custName"  id="custName" readOnly value="<%=custName%>"></td>
   	  </tr> 
   	   
   	  
   	  <tr>
   	   	<td class="blue">当前预存款</td>
   	   	<td><input type="text" name="ycFee"  id="ycFee"  readOnly value="<%=show_fee%>"></td>
   	  </tr> 
   	  
   	   
   	  
   	  <tr>
   	   	<td class="blue">未出帐话费</td>
   	   	<td><input type="text" name="wczFee"  id="wczFee"  readOnly value="<%=nobillpay.trim()%>"></td>
   	  </tr> 
   	  
   	  <tr>
   	   	<td class="blue">当月可用预存款总额</td>
   	   	<td><input type="text" name="yuFee"  id="yuFee"  readOnly value="<%=now_prepayFee.trim()%>"></td>
   	  </tr> 
   	  
   	  <tr>
   	   	<td class="blue">普通预存款</td>
   	   	<td><input type="text" name="yuFee"  id="puyuFee"  readOnly value="<%=pu_spe_prepayFee.trim()%>"></td>
   	  </tr> 
   	   
   	  <tr>
   	   	<td class="blue">专用预存款</td>
   	   	<td><input type="text" name="yuFee"  id="speyuFee"  readOnly value="<%=spe_prepayFee.trim()%>"></td>
   	  </tr> 
   	  <tr>
   	   	<td class="blue">有效期截止至</td>
   	   	<td><input type="text" name="expire"  id="expire"  readOnly value="<%=expire.trim()%>"></td>
   	  </tr> 
   	  <tr>
   	   	<td class="blue">往月欠费总额</td>
   	   	<td><input type="text" name="yuFee"  id="wang_Fee"  readOnly value="<%=wang_fee.trim()%>"></td>
   	  </tr> 
   	   <tr>
   	   	<td class="blue">当前余额</td>
   	   	<td><input type="text" name="yue"  id="yue"  readOnly value="<%=yue.trim()%>"></td>
   	  </tr> 

   	  
   	  <tr>
   	   	<td class="blue">缴费方式名称</td>
   	   	<td><input type="text"  name="feeTypeName"  id="feeTypeName" readOnly value="<%=payType%>"></td>
   	  </tr> 
   <!--	  
   	  <tr>
   	   	<td class="blue">用户限额</td>
   	   	<td><input type="text"  name="custXe"  id="custXe" readOnly value="<%=xeFee%>"></td>
   	  </tr> 
   	  -->
   	  <tr>
   	   	<td class="blue">17951IP充值卡余额</td>
   	   	<td><input type="text"   name="17951Fee"  id="17951Fee" readOnly value="<%=f17951ee%>"></td>
   	  </tr> 
   	  
   	  <tr>
   	   	<td class="blue">局拆时间</td>
   	   	<td><input type="text"   name="userEndinfo"  id="17951Fee" readOnly value="<%=userEndDate%>"></td>
   	  </tr> 
   	  
   	  
   	   <tr>
   	   	<td id="footer" colspan="2">
   	   		<input  type="button" class="b_text" value="关闭" onclick="window.close()">
   	   	</td>
   	  </tr>
   </table>
<%@ include file="/npage/include/footer.jsp" %>   
 </form>
</body>

</html>
