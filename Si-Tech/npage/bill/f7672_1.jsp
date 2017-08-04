<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 预存赠固话，话费可分享冲正 7672
   * 版本: 1.0
   * 日期: 2010/4/7
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
  	String opCode="7672";
	String opName="预存赠固话，话费可分享冲正";
	String loginNo = (String)session.getAttribute("workNo");					//操作工号
	String orgCode = (String)session.getAttribute("orgCode");					//归属代码
	String regionCode = (String)session.getAttribute("regCode");				//地市
	  /**** ningtn add for pos start ****/
	  String  payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
	  /**** ningtn add for pos end ****/
	/****得到打印流水****/
	String printAccept="";
	printAccept = getMaxAccept();
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<%
  	String  retFlag="",retMsg="";
	String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
	String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
	String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
	String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
	String  favorcode="",card_no="",print_note="";
	String  gift_code="",gift_grade="",gift_name="";
	String  base_fee="",free_fee="",active_term="";
	String  fixed_fee="",consume_term="",phone_fee="",prepay_fee="";
	String  oSecondPhone="",oSecondName="",oModeCodeSm="",oBlackCode="";

  	String iPhoneNo = request.getParameter("srv_no");
  	String iOldAccept = request.getParameter("backaccept");
  	String iOpCode = request.getParameter("opcode");

	String  inputParsm [] = new String[8];
	inputParsm[0] = printAccept;
	inputParsm[1] = "01";
	inputParsm[2] = iOpCode;
	inputParsm[3] = loginNo;
	inputParsm[4] = "";
	inputParsm[5] = iPhoneNo;
	inputParsm[6] = "";
	inputParsm[7] = iOldAccept;
%>
	<wtc:service name="s7672Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="45" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
		<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String errCode = retCode1;
	String errMsg = retMsg1;

  if(tempArr == null)
  {
	   retFlag = "1";
	   retMsg = "s7672Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000")&tempArr.length>0 ){
		    bp_name = tempArr[0][3];           			//机主姓名
		    bp_add = tempArr[0][4];            			//客户地址
		    sm_code = tempArr[0][11];         			//业务类别
		    sm_name = tempArr[0][12];        			//业务类别名称
		    hand_fee = tempArr[0][13];      			//手续费
		    favorcode = tempArr[0][14];     			//优惠代码
		    rate_code = tempArr[0][5];     				//资费代码
		    rate_name = tempArr[0][6];    				//资费名称
		    next_rate_code = tempArr[0][7];				//下月资费代码
		    next_rate_name = tempArr[0][8];				//下月资费名称
		    bigCust_flag = tempArr[0][9];				//大客户标志
		    bigCust_name = tempArr[0][10];				//大客户名称
		    lack_fee = tempArr[0][15];					//总欠费
		    total_prepay = tempArr[0][16];				//总预交
		    cardId_type = tempArr[0][17];				//证件类型
		    cardId_no = tempArr[0][18];					//证件号码
		    cust_id = tempArr[0][19];					//客户id
		    cust_belong_code = tempArr[0][20];			//客户归属id
		    group_type_code = tempArr[0][21];			//集团客户类型
	    	group_type_name = tempArr[0][22];			//集团客户类型名称
	    	imain_stream = tempArr[0][23];				//当前资费开通流水
	    	next_main_stream = tempArr[0][24];			//预约资费开通流水
	    	oSecondPhone = tempArr[0][25];				//手机卡号码
	    	gift_code = tempArr[0][26];					//营销代码
	    	gift_name = tempArr[0][27];					//机型名称
	    	oSecondName= tempArr[0][28];				//副卡名
	    	base_fee = tempArr[0][29];					//底线预存
	    	free_fee = tempArr[0][30];					//活动预存
	    	fixed_fee = tempArr[0][31];				    //固话款
	    	consume_term = tempArr[0][32];				//消费期限
	    	phone_fee = tempArr[0][33];				    //手机卡话费
	    	prepay_fee = tempArr[0][34];				//预存总金额
	    	active_term = tempArr[0][35];				//活动期限
	    	print_note = tempArr[0][36];				//广告词
	    	oBlackCode = tempArr[0][37];				//广告词
	    	oModeCodeSm = tempArr[0][38];				//广告词
	    	/*** ningtn add for pos start ***/	   	 
				payType       = tempArr[0][40];
				Response_time = tempArr[0][41];
				TerminalId    = tempArr[0][42];
				Rrn           = tempArr[0][43];
				Request_time  = tempArr[0][44];
				System.out.println("--------------------------payType-----------------"+payType);
				System.out.println("--------------------------Response_time-----------"+Response_time);
				System.out.println("--------------------------TerminalId--------------"+TerminalId);
				System.out.println("--------------------------Rrn---------------------"+Rrn);
				System.out.println("--------------------------Request_time------------"+Request_time);
			/*** ningtn add for pos end ***/
	 }
	  else{%>
	 <script language="JavaScript">
<!--
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
<%	 }
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>预存赠固话，话费可分享冲正</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
  //打印使用变量
  var modedxpay ="";
  var goodbz    ="";
  var bdbz      ="";
  var bdts      ="";
  var exeDate   ="";
  onload=function()
  {
  	document.all.phoneNo.focus();
   	self.status="";
   }

function frmCfm()
{
	if(!checkElement(document.all.phoneNo)) return;
	document.frm.iAddStr.value=document.frm.backaccept.value+"|"+document.frm.Gift_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+
	                           document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+document.frm.Fixed_Fee.value+"|"+
	                           document.frm.Consume_Term.value+"|"+document.frm.Phone_Fee.value+"|"+document.frm.Gift_Name.value+"|"+
	                           document.frm.oSecondPhone.value+"|"+document.frm.Active_Term.value+"|"+document.frm.omodecode_sm.value+"|";
	// alert(document.frm.iAddStr.value);
	frm.submit();
}
//-->
</script>

</head>

<body>
	<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<div class="title">
		<div id="title_zi">业务明细</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">固话卡号码</td>
            <td>
				<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
			</td>
			<td class="blue">机主姓名</td>
			<td width="39%">
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
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" size="30" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">帐号预存</td>
            <td>
				<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=total_prepay%>" readonly>
			</td>
            <td class="blue">营销代码</td>
            <td>
            	<input type="text" name="Gift_Code" value="<%=gift_code%>" readonly class="InputGrey" >
			</td>
		</tr>
		<tr>
			<td class="blue">手机卡号码</td>
            <td>
				<input name="oSecondPhone" type="text"   id="oSecondPhone" value="<%=oSecondPhone%>" readonly  class="InputGrey" >
			</td>
            <td class="blue">手机卡姓名</td>
            <td>
            	<input type="text" name="oSecondName" value="<%=oSecondName%>"  readonly  class="InputGrey"  >
			</td>
		</tr>
		<tr>
			<input name="Gift_Grade" type="hidden" class="InputGrey" id="Gift_Grade" value="<%=gift_grade%>" readonly >
            <td class="blue">品牌机型</td>
            <td>
				<input name="Gift_Name" type="text" class="InputGrey" id="Gift_Name" value="<%=gift_name%>" readonly>
			</td>
			<td class="blue">固话卡款</td>
            <td>
				<input name="Fixed_Fee" type="text" class="InputGrey" id="Fixed_Fee" readonly value="<%=fixed_fee%>">
			</td>
		</tr>
		<tr>
			<td class="blue">底限预存</td>
            <td>
				<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly value="<%=base_fee%>">
			</td>
            <td class="blue">活动预存</td>
            <td>
				<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"  value="<%=free_fee%>" readonly>
			</td>
		</tr>
		<tr>
            <td class="blue">固话卡消费期限</td>
            <td>
            	<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"  value="<%=consume_term%>" readonly>
			</td>
			<td class="blue">赠手机卡话费</td>
            <td>
				<input name="Phone_Fee" type="text" class="InputGrey" id="Phone_Fee" value="<%=phone_fee%>" readonly>
			</td>
		</tr>
		<tr>
			 <td class="blue">手机卡话费消费期限</td>
			 <td>
            	<input name="Active_Term" type="text" class="InputGrey" id="Active_Term" value="<%=active_term%>" readonly>
			</td>
            <td class="blue">预存总金额</td>
            <td>
            	<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee" value="<%=prepay_fee%>" readonly>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" id="footer">&nbsp;
				<input name="commit" id="commit" type="button" class="b_foot" value="下一步" onClick="frmCfm();">&nbsp;
                <input name="reset" type="reset" class="b_foot" value="清除" >&nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭">&nbsp;
			</td>
		</tr>
	</table>

			<input type="hidden" name="iOpCode" value="7672">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<input type="hidden" name="opName" value="<%=opName%>">
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
			<input type="hidden" name="i16"  value="<%=rate_code%>">
			<input type="hidden" name="ip" 	value="<%=next_rate_code%>">

			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="<%=iPhoneNo%>">
			<input type="hidden" name="i4" value="<%=bp_name%>">			
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>预存赠固话，话费可分享冲正">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=iOldAccept%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">

			<input type="hidden" name="beforeOpCode" value="7671">
			<input type="hidden" name="backaccept" value="<%=iOldAccept%>">
			<input type="hidden" name="oblack_code" value="<%=oBlackCode%>">
			<input type="hidden" name="omodecode_sm" value="<%=oModeCodeSm%>">
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<input type="hidden" name="returnPage" value="/npage/bill/f7672_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>">
			<!-- ningtn add at  for POS缴费需求*****start*****-->
			<input type="hidden" name="payType" value="<%=payType%>" >
			<input type="hidden" name="Response_time" value="<%=Response_time%>" >
			<input type="hidden" name="TerminalId" value="<%=TerminalId%>" >
			<input type="hidden" name="Rrn" value="<%=Rrn%>" >
			<input type="hidden" name="Request_time" value="<%=Request_time%>" >
			<!-- ningtn add at  for POS缴费需求*****end*****-->	
			<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
