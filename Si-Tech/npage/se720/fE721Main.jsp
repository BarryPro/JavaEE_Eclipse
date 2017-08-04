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
	String opCode = "e721";
	String opName = request.getParameter("opName");
	String iLoginNoAccept = request.getParameter("backaccept");
	String iPhoneNo = activePhone;
	System.out.println("---------zhangyan-------iPhoneNo=" + iPhoneNo + "--------iLoginNoAccept=" + iLoginNoAccept);

  String loginNo = (String)session.getAttribute("workNo");
  String loginNoPass = (String)session.getAttribute("password");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
  /**********************************************liujian se529 参数开始********************************************/
  
  String  retFlag="",retMsg="";
  String  payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
 
  	String bp_name="",bp_add="",oldMode="",oldName="",group_type_code="",group_type_name="",sm_code="",sm_name="";
	String prepay_Fee="",id_name="",id_iccid="",cust_id="",belong_code="",imain_stream="",next_main_stream="",modeCode="";
	String modeName="",print_note="",next_rate_code="",next_rate_name="",handFee="",favorcode="",saleCode="",machPrice="";
	String resName="",prepayFee="",cashPay="",brandName="",baseFee="",prepay_Gift="",consumeTerm="",ativeTer="",sale_name="";
  
	String  inputParsm [] = new String[8];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = "e721";
	inputParsm[3] = loginNo;
	inputParsm[4] = loginNoPass;
	inputParsm[5] = iPhoneNo;
	inputParsm[6] = "";
	inputParsm[7] = iLoginNoAccept;
	for (int i=0;i<inputParsm.length;i++)
	{
		System.out.println("zhangyan ~~~ inputParsm[0]" +  inputParsm[i]);
	}

	System.out.println("phoneNO === "+ iPhoneNo);
	 
  /**********************************************liujian se529 参数结束********************************************/
%>
	
	<wtc:service name="se506Qry" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeQry" retmsg="retMsgQry" outnum="42">
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
			print_note 			 = tempArr[0][19];
			next_rate_code   = tempArr[0][21];//下月资费代码
	    next_rate_name   = tempArr[0][22];//下月资费名称
			handFee 				 = tempArr[0][23]; //手续费
			favorcode				 = tempArr[0][24]; //优惠代码
			saleCode	 		= tempArr[0][30];  //销售代码
			machPrice  		= tempArr[0][31];  //优惠比例
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
     
     
     
		  payType       = tempArr[0][25].trim();
		  Response_time = tempArr[0][26].trim();
		  TerminalId    = tempArr[0][27].trim();
		  Rrn           = tempArr[0][28].trim();
		  Request_time  = tempArr[0][29].trim();
	 	 
		  System.out.println("---------zhangyan-----------------tempArr[0][41]~~~~~~~"+tempArr[0][41]);
		  System.out.println("--------------------------Response_time-----------"+Response_time);
		  System.out.println("--------------------------TerminalId--------------"+TerminalId);
		  System.out.println("--------------------------Rrn---------------------"+Rrn);
		  System.out.println("--------------------------Request_time------------"+Request_time);

	 }
	else{%>
	 <script language="JavaScript">
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  		window.location="fE720Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>";
  </script>
<%
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
				$('#sale_name_span').text(sale_name );
				$('#sale_name').val(sale_name );
			}
	})
  function frmCfm(){
     if(!checkElement(document.all.phoneNo)) return;
     	/*
			冲正流水｜iSaleCode|iBrandName|iTypeName｜缴费金额｜iBaseFee｜
			优惠期限｜优惠总金额｜拆包期限｜优惠比例｜绑定人号码｜imei码｜  
				*/
     	//不这么拼串了，效率低，用数组
    	var arr = [];
    	arr.push('<%=iLoginNoAccept%>');/*冲正流水*/
    	arr.push('|');
    	arr.push('<%=saleCode%>');/*iSaleCode*/
    	arr.push('|');
    	arr.push('<%=brandName%>');
    	arr.push('|');
    	arr.push('<%=resName%>');
    	arr.push('|');
    	arr.push('<%=cashPay%>');
    	arr.push('|');    	
    	arr.push('0');/*iBaseFee*/
    	
    	arr.push('|');
    	arr.push('<%=consumeTerm%>');/*优惠期限*/
    	arr.push('|');
    	arr.push('<%=prepayFee%>');/*优惠总金额*/
    	arr.push('|');
    	arr.push('<%=ativeTer%>');/*拆包期限*/
    	arr.push('|');
    	arr.push('<%=machPrice%>');/*优惠比例*/
    	arr.push('|');
    	arr.push('0');
    	arr.push('|');
    	arr.push('0');
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
			<div id="title_zi"><span id="sale_name_plan"></span><%=sale_name%></div>
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
				<input name="oSmName" type="text" class="InputGrey" 
					id="oSmName" value="<%=sm_name%>" readonly>
			</td>
      <td class="blue">资费名称</td>
      <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" 
					value="<%=oldName%>" readonly>
			</td>
		</tr>
		
	<tr>
		<td class="blue">帐号预存</td>
		<td>		
			<input	class="InputGrey"	type="text"	name="oPrepayFee"
				id="oPrepayFee"	value="<%=prepay_Fee%>"	readonly />		
		</td>
		<td class="blue">合约期限</td>
		<td>
			<input class="InputGrey" type="text" id="consumeTerm" 
				name="consumeTerm" value = "<%=consumeTerm%>" readonly />		
		</td>
	
	</tr>	
			
		<tr>	
			<td class="blue">手机品牌</td>
      <td>
				<input name="brandName" type="text" class="InputGrey" id="brandName" value="<%=brandName%>" readonly>
			</td>
			<td class="blue">手机类型</td>
      <td>
				<input name="resName" type="text" class="InputGrey" id="resName" value="<%=resName%>" readonly>
			</td>
		</tr>
		
	<tr> 
		<td class="blue">营销方案</td>
		<td> 
			<input name="sale_name" type="text" class="InputGrey" id="sale_name" 
				value="<%=sale_name%>" readonly>
		</td>
		<td class="blue">新主资费 </td>
		<td> 
			<input name="oldMode" type="text" class="InputGrey" id="oldMode" 
				value="<%=oldMode%>" readonly>
		</td>
	</tr> 	
	
	
	<tr>
		<td class="blue">拆包期限</td>
		<td> 
			<input name="ativeTer" type="text" class="InputGrey" id="ativeTer" 
				value="<%=ativeTer%>" readonly>
		</td>	
		<td class="blue">现金预存</td>	
			<td> 
				<input name="baseFee" type="text" class="InputGrey" id="baseFee" 
					value="<%=cashPay%>" readonly>
			</td>	

					

	</tr>		
	<tr>
		<td class="blue">总优惠额度</td>
		<td>		
			<input class="InputGrey" type="text" id="prepayFee" 
				name="prepayFee" value = "<%=prepayFee%>" readonly />	
		</td>
		<td class="blue">优惠比例</td>
		<td>		
			<input class="InputGrey" type="text" id="machPrice" 
				name="machPrice" value="<%=machPrice%>" readonly />	
		</td>
	</tr>	
	<tr>	
		<td class="blue">退款合计</td>
		<td  colspan="3">
			<input name="cashPay" type="text" class="InputGrey" id="cashPay" value="<%=cashPay%>" readonly>
		</td>
	</tr>					
		<tr>
			<td class="blue">操作备注</td>
			<td colspan="3">
				<input name="op_note" type="text" size="80" v_maxlength=60 id="op_note" 
					value="购机入网-让利计划冲正" />
			</td>
		</tr>	

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
			<input type="hidden" name="sale_name" id="sale_name">
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
			<input type="hidden" name="group_type" value="<%=group_type_code+"--"+group_type_name%>">  
			<input type="hidden" name="ibig_cust" value="<%=group_type_code+"--"+group_type_name%>">        
			<input type="hidden" name="do_note" value="<%=iPhoneNo+"--"+opName%>">                           
			<input type="hidden" name="favorcode" value="<%=favorcode%>"> 
			<input type="hidden" name="maincash_no" value="<%=oldMode%>"> 
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>"> 

			<input type="hidden" name="i18" value="<%=next_rate_code+"--"+next_rate_name%>">  
			<input type="hidden" name="i19" value="0">  
			<input type="hidden" name="i20" value="0">  


			<input type="hidden" name="beforeOpCode" value="<%=opCode%>">
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>"> 
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">

			<input type="hidden" name="return_page" value="/npage/se720/fE720Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>">
			<input type="hidden" name="ipAddr" value="<%=(String)session.getAttribute("ipAddr")%>" >		
			
			<!-- tianyang add at 20100201 for POS缴费需求*****start*****-->
			<input type="hidden" name="payType" value="<%=payType%>" >
			<input type="hidden" name="Response_time" value="<%=Response_time%>" >
			<input type="hidden" name="TerminalId" value="<%=TerminalId%>" >
			<input type="hidden" name="Rrn" value="<%=Rrn%>" >
			<input type="hidden" name="Request_time" value="<%=Request_time%>" >
			<!-- tianyang add at 20100201 for POS缴费需求*****end*****-->
			
			<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
