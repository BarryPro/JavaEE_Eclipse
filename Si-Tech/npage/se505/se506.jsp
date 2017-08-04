<%
/********************
 version v2.0
 开发商: si-tech
 author: liujian at 2011.12.21
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String iLoginNoAccept = request.getParameter("backaccept");
	String iPhoneNo = activePhone;
	System.out.println("---------liujian-------iPhoneNo=" + iPhoneNo + "--------iLoginNoAccept=" + iLoginNoAccept);

  String loginNo = (String)session.getAttribute("workNo");
  String loginNoPass = (String)session.getAttribute("password");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
  
  /*begin diling add for 判断当前用户是否是网上终端销售用户@2012/7/6 */
  String regCode = (String)session.getAttribute("regCode");
  String isNetToFlag = WtcUtil.repNull((String)request.getParameter("isNetToFlag"));//网上终端销售跳转标识
  String isNetUser = "N";//网上终端销售用户标识
  System.out.println("------------------isNetToFlag="+isNetToFlag);
  String retnPage = "/npage/se505/se505_login.jsp?opCode="+opCode+"%26opName="+opName+"%26activePhone="+iPhoneNo;//跳转页面路径
  String  inParams [] = new String[2];
  inParams[0] = "SELECT count(1) FROM dWebTermSale WHERE update_accept =:acceptno AND phone_no =:phoneno";
  inParams[1] = "acceptno="+iLoginNoAccept+",phoneno="+iPhoneNo;
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCodeIsNetUser" retmsg="retMsgIsNetUser" outnum="3"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="isNetUserRet"  scope="end"/>
<%
  System.out.println("---------------------isNetUserRet.length="+isNetUserRet.length);
  System.out.println("---------------------isNetUserRet[0][0]="+isNetUserRet[0][0]);
  if("000000".equals(retCodeIsNetUser)){
    if(isNetUserRet.length>0){
      if(Integer.parseInt(isNetUserRet[0][0])>0){/*此用户是网上终端销售用户*/
        isNetUser = "Y";
        if(!"Y".equals(isNetToFlag)){/*并且不是从网上终端销售冲正（e969）跳转过来*/
          System.out.println("-------------------isNetToFlag="+isNetToFlag);
          System.out.println("------diling--------原来的跳转-----retnPage="+retnPage);
%>
          <SCRIPT language="JavaScript">
            rdShowMessageDialog("当前用户为网上终端销售用户,请从网上终端销售冲正模块（e969）进行冲正操作！",1);
            removeCurrentTab();
          </SCRIPT>
<%
        }else{
          retnPage = "/npage/se969/fe969_main.jsp?opCode=e969%26opName=网上终端销售冲正%26activePhone="+iPhoneNo;
          System.out.println("------diling--------冲正的跳转-----retnPage="+retnPage);
        }
      }
    }
  }else{
%>
          <SCRIPT language="JavaScript">
          	rdShowMessageDialog("错误代码：<%=retCodeIsNetUser%><br>错误信息：<%=retMsgIsNetUser%>",0);
  	        window.location.href="/npage/se969/fe969_main.jsp?opCode=e969&opName=网上终端销售冲正&activePhone=<%=iPhoneNo%>";
          </SCRIPT>
<%   
  }
   /*end diling add@2012/7/6 */
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
  /**********************************************liujian se606 参数开始********************************************/
  
  String  retFlag="",retMsg="";
  /**** tianyang add for pos start ****/
  String  payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
  String installmentNum = "";
  /**** tianyang add for pos end ****/
  
  String bp_name="",bp_add="",oldMode="",oldName="",group_type_code="",group_type_name="",sm_code="",sm_name="";
	String prepay_Fee="",id_name="",id_iccid="",cust_id="",belong_code="",imain_stream="",next_main_stream="",modeCode="";
	String modeName="",print_note="",next_rate_code="",next_rate_name="",handFee="",favorcode="",saleCode="",machPrice="";
	String resName="",prepayFee="",cashPay="",brandName="",baseFee="",prepay_Gift="",consumeTerm="",ativeTer="",sale_name="";
  	String feeMark="";
  /*
  // 测试数据
  String bp_name="123",bp_add="123",oldMode="123",oldName="123",group_type_code="123",group_type_name="123",sm_code="123",sm_name="123";
	String prepay_Fee="123",id_name="123",id_iccid="123",cust_id="123",belong_code="123",imain_stream="123",next_main_stream="123",modeCode="123";
	String modeName="123",print_note="123",next_rate_code="123",next_rate_name="123",handFee="123",favorcode="123",saleCode="123",machPrice="123";
	String resName="123",prepayFee="123",cashPay="123",brandName="123",baseFee="123",prepay_Gift="123",consumeTerm="123",ativeTer="123";
  	inputParsm[0]   流水
		inputParsm[1]   渠道标识(必须输入01-BOSS；02-网上营业厅；03-掌上营业厅；04-短信营业厅；05-多媒体查询机；06-10086)
		inputParsm[2]   操作代码	
		inputParsm[3]   工号
		inputParsm[4]   工号密码
		inputParsm[5]   移动号码
		inputParsm[6]   号码密码
		inputParsm[7]   申请时业务办理流水
  */
	String  inputParsm [] = new String[8];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = loginNo;
	inputParsm[4] = loginNoPass;
	inputParsm[5] = iPhoneNo;
	inputParsm[6] = "";
	inputParsm[7] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);
  /**********************************************liujian se606 参数结束********************************************/
  
   
%>
	
	<wtc:service name="se506Qry" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeQry" retmsg="retMsgQry" outnum="44">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
		<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>
	
	
<%
 
  String errCode = retCodeQry;
  String errMsg = retMsgQry;
  System.out.println("----------lj---------");
  if(errCode.equals("000000"))
  {
  		
  		bp_name    		= tempArr[0][1];   //机主姓名
	    bp_add     		= tempArr[0][2];   //客户地址
	    oldMode    		= tempArr[0][3];   //当前资费代码
			oldName 	 		= tempArr[0][4]; 	 //当前资费名称
			group_type_code  = tempArr[0][5];//集团客户类型
	    group_type_name  = tempArr[0][6];//集团客户类型名称
	    sm_code 	 		= tempArr[0][7];   //业务类别代码
	    sm_name 	 		= tempArr[0][8];   //业务类别名称
			prepay_Fee 		= tempArr[0][10];  //可用预存
			id_name		 		= tempArr[0][11];  //证件类型
			id_iccid	 		= tempArr[0][12];  //证件号码
			cust_id       = tempArr[0][13];  //客户id 
			belong_code		= tempArr[0][14];  //归属
			imain_stream 	= tempArr[0][15];
			next_main_stream = tempArr[0][16];
	//		modeCode 				 = tempArr[0][17];
	//		modeName 				 = tempArr[0][18];
			print_note 			 = tempArr[0][19];
			next_rate_code   = tempArr[0][21];//下月资费代码
	    next_rate_name   = tempArr[0][22];//下月资费名称
			handFee 				 = tempArr[0][23]; //手续费
			favorcode				 = tempArr[0][24]; //优惠代码
			saleCode	 		= tempArr[0][30];  //销售代码
			machPrice  		= tempArr[0][31];  //购机款
			resName				= tempArr[0][32];  //机器型号  
			prepayFee 		= tempArr[0][33]; //购机预存
			cashPay       = tempArr[0][34];  //缴费合计 
			brandName			= tempArr[0][35];  //手机品牌
			resName   		= tempArr[0][36];  //手机型号
			baseFee       = tempArr[0][37];  //底线预存
			prepay_Gift 	= tempArr[0][38];  //活动预存
			consumeTerm  	= tempArr[0][39];//消费期限
			ativeTer 		  = tempArr[0][40];//拆包期限
			sale_name		  = tempArr[0][41];//阶段活动名称
			//liujian 2012-7-30 16:51:52 消费积分
			feeMark		  = tempArr[0][42];//消费积分
			/*
			prepay_Limit	= tempArr[0][20];  //月返费
			monBaseFee 		= tempArr[0][21];  //月底线消费
			vipGrade  		= tempArr[0][22];  //VIP级别
			runName   		= tempArr[0][23];  //运行状态
			imeiNo   			= tempArr[0][26];  //IMIE
			saleName 			= tempArr[0][27];  //营销案名称
			offerID  			= tempArr[0][28];  //附加资费代码
			next_main_stream = tempArr[0][36];//预约资费开通流水
   		print_note       = tempArr[0][37];//广告词
			favorcode        = tempArr[0][38];//优惠代码
			group_type_code  = tempArr[0][39];//集团客户类型
	    group_type_name  = tempArr[0][40];//集团客户类型名称
			bigCust_flag	   = tempArr[0][41]; //大客户标志
	    bigCust_name 	   = tempArr[0][42];//大客户名称
   	 */
     
     
     
		  payType       = tempArr[0][25].trim();
		  Response_time = tempArr[0][26].trim();
		  TerminalId    = tempArr[0][27].trim();
		  Rrn           = tempArr[0][28].trim();
		  Request_time  = tempArr[0][29].trim();
	 	  installmentNum = tempArr[0][43].trim();
		  System.out.println("--------------------------payType-----------------"+payType);
		  System.out.println("--------------------------Response_time-----------"+Response_time);
		  System.out.println("--------------------------TerminalId--------------"+TerminalId);
		  System.out.println("--------------------------Rrn---------------------"+Rrn);
		  System.out.println("--------------------------Request_time------------"+Request_time);
		  System.out.println("--------------------------installmentNum----------"+installmentNum);

	 }
	else{
	   if(("Y".equals(isNetUser))&&("Y".equals(isNetToFlag))){/*如此用户为网上销售终端用户*/
%>
	 <script language="JavaScript">
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  	window.location="/npage/se969/fe969_main.jsp?opCode=e969&opName=网上终端销售冲正&activePhone=<%=iPhoneNo%>";
  </script>
<% 
	  }else{ 
	%>
	 <script language="JavaScript">
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  		window.location="se505_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>";
  </script>
<%
	  }
	}
%>
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
	$(function() {
		var sale_name = '<%=sale_name%>';
		if(sale_name != null && sale_name != "") {
				$('#sale_name_span').text(sale_name + '--');
				$('#e505_sale_name').val(sale_name + '--');
			}
	})
  function frmCfm(){
     if(!checkElement(document.all.phoneNo)) return;
     	/*
     		冲正流水｜营销代码|品牌名称|品牌型号｜用户缴费合计｜底线预存｜消费期限｜活动预存｜拆包期限｜购机款｜传0｜imei码｜
				iOldAccept|iSaleCode|iBrandName|iTypeName|iSalePrice|iBaseFee|iConsumeTerm|iFreeFee|iActiveTerm|iPrice|iMarketPrice|iImeiNo|
				109774294520|10165615|M-;M-*M-NM-*|F561|240|240|12|0|0|0|0|868597000046173|
     	*/
     	//不这么拼串了，效率低，用数组
    	var arr = [];
    	arr.push('<%=iLoginNoAccept%>');
    	arr.push('|');
    	arr.push('<%=saleCode%>');
    	arr.push('|');
    	arr.push('<%=brandName%>');
    	arr.push('|');
    	arr.push('<%=resName%>');
    	arr.push('|');
    	arr.push('<%=cashPay%>');
    	arr.push('|');    	
    	arr.push('<%=baseFee%>');
    	arr.push('|');
    	arr.push('<%=consumeTerm%>');
    	arr.push('|');
    	arr.push('<%=prepay_Gift%>');
    	arr.push('|');
    	arr.push('<%=ativeTer%>');
    	arr.push('|');
    	arr.push('<%=machPrice%>');
    	arr.push('|');
    	arr.push('0');
    	arr.push('|');
    	arr.push('0');
    	arr.push('|');
    	//liujian 2012-7-30 16:55:14 消费积分
    	arr.push('<%=feeMark%>');
    	arr.push('|');
      $('input[name="iAddStr"]').val(arr.join(''));
      frm.submit();
}
</script>

</head>

<body>
	<form name="frm" method="post" action="../bill/f1270_3.jsp?activePhone=<%=iPhoneNo%>" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>
		<input type="hidden" name="opName" value="<%=opName%>">
		<div class="title">
			<div id="title_zi"><span id="sale_name_span"></span><%=opName%></div>
		</div>

	<table cellspacing="0">
		<tr>
			<td class="blue">手机号码</td>
      <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
			</td>
			<td class="blue">机主姓名</td>
			<td>
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">业务品牌</td>
      <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
      <td class="blue">资费名称</td>
      <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=oldName%>" readonly>
			</td>
		</tr>
		<tr>	
			<td class="blue">手机品牌</td>
      <td>
				<input name="brandName" type="text" class="InputGrey" id="brandName" value="<%=brandName%>" readonly>
			</td>
			<td class="blue">手机型号</td>
      <td>
				<input name="resName" type="text" class="InputGrey" id="resName" value="<%=resName%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">购机款</td>
      <td>
				<input name="machPrice" type="text" class="InputGrey" id="machPrice" value="<%=machPrice%>" readonly>
			</td>
			<td class="blue">活动预存</td>
      <td>
				<input name="prepay_Gift" type="text" class="InputGrey" id="prepay_Gift" value="<%=prepay_Gift%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">话费消费期限</td>
      <td>
				<input name="consumeTerm" type="text" class="InputGrey" id="consumeTerm" value="<%=consumeTerm%>" readonly>
			</td>

			<td class="blue">底线预存</td>
      <td>
				<input name="baseFee" type="text" class="InputGrey" id="baseFee" value="<%=baseFee%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">缴费合计</td>
      <td colspan="3">
				<input name="cashPay" type="text" class="InputGrey" id="cashPay" value="<%=cashPay%>" readonly>
			</td>
		</tr>
		<tr>  	
		<tr>
			<td colspan="4" id="footer">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="下一步" onClick="frmCfm();">
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>

			<input type="hidden" name="iOpCode" value="<%=opCode%>">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<input type="hidden" name="e505_sale_name" id="e505_sale_name">
	    <!--以下部分是为调f1270_3.jsp所定义的参数
			i2:客户ID
			i16:当前主套餐代码
			ip:申请主套餐代码
			belong_code:belong_code
			print_note:工单广告词

			i1:手机号码
			i5:客户地址
			i6:证件类型
			i7:证件号码
			i8:业务品牌

			ipassword:密码
			group_type:集团客户类别
			ibig_cust:大客户类别
			do_note:用户备注
			favorcode:手续费优惠权限
			maincash_no:现主套餐代码（老）
			imain_stream:当前主资费开通流水
			next_main_stream:预约主资费开通流水

			i18:下月主套餐
			i19:手续费
			i20:最高手续费

			beforeOpCode:原业务办理的op_code
			-->
			<input type="hidden" name="i2" value="<%=cust_id%>"> 
			<input type="hidden" name="i16"  value="<%=oldMode%>"> 
			<input type="hidden" name="ip" 	value="<%=next_rate_code%>"> 

			<input type="hidden" name="belong_code" value="<%=belong_code%>">  
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="<%=iPhoneNo%>">  
			<input type="hidden" name="i4" value="<%=bp_name%>">  
			<input type="hidden" name="i5" value="<%=bp_add%>">    
			<input type="hidden" name="i6" value="<%=id_name%>"> 
			<input type="hidden" name="i7" value="<%=id_iccid%>"> 
			<input type="hidden" name="i8" value="<%=sm_code+"--"+sm_name%>">	

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>"+"--"+"<%=group_type_name%>">  
			<input type="hidden" name="ibig_cust" value="<%=group_type_code%>"+"--"+"<%=group_type_name%>">        
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>--<%=opName%>">                           
			<input type="hidden" name="favorcode" value="<%=favorcode%>"> 
			<input type="hidden" name="maincash_no" value="<%=oldMode%>"> 
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>"> 

			<input type="hidden" name="i18" value="<%=next_rate_code%>"+"--"+"<%=next_rate_name%>">  
			<input type="hidden" name="i19" value="0">  
			<input type="hidden" name="i20" value="0">  


			<input type="hidden" name="beforeOpCode" value="<%=opCode%>">
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>"> 
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">

			<input type="hidden" name="return_page" id="return_page" value="<%=retnPage%>">
			<input type="hidden" name="ipAddr" value="<%=(String)session.getAttribute("ipAddr")%>" >		
			
			<!-- tianyang add at 20100201 for POS缴费需求*****start*****-->
			<input type="hidden" name="payType" value="<%=payType%>" >
			<input type="hidden" name="Response_time" value="<%=Response_time%>" >
			<input type="hidden" name="TerminalId" value="<%=TerminalId%>" >
			<input type="hidden" name="Rrn" value="<%=Rrn%>" >
			<input type="hidden" name="Request_time" value="<%=Request_time%>" >
			<input type="hidden" name="installmentList" value="<%=installmentNum%>" >
			
			<!-- tianyang add at 20100201 for POS缴费需求*****end*****-->
			
			<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
