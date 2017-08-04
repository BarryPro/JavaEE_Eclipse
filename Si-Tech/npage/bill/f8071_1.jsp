
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-10
********************/
%>

<%
  String opCode = "8070";
  String opName = "致富信息机营销案";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>

<%

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");

  //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	//paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" />

<%
  String printAccept=sysAcceptl;
  String  retFlag="",retMsg="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="";
  String  gift_code="",SaleCode="",GiftName="";
  String SpFee="",preparefee="",PayMoney="",mach_fee="",sum_pay="",SpCode="";
  String  deposit_fee="",base_fee="",free_fee="";
  String  mark_subtract="",consume_term="",mon_base_fee="",prepay_fee="";
  String vUnitId="",vUnitName="",vproduct_name="",vUnitAddr="",imei_no="";

  String iPhoneNo = request.getParameter("srv_no");
  String iLoginNoAccept = request.getParameter("backaccept");
  //String iOrgCode = request.getParameter("iOrgCode");
  String iOpCode = request.getParameter("opcode");
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);

 // retList = co.callFXService("s8071InitEx", inputParsm, "39","phone",iPhoneNo);
%>

    <wtc:service name="s8071Init" outnum="39" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inputParsm[0]%>" />
			<wtc:param value="<%=inputParsm[1]%>" />
			<wtc:param value="<%=inputParsm[2]%>" />
			<wtc:param value="<%=inputParsm[3]%>" />
			<wtc:param value="<%=inputParsm[4]%>" />
		</wtc:service>
		<wtc:array id="result_t1" scope="end" />


<%
  String errCode = code1;
  String errMsg = msg1;

  if(result_t1 == null)
  {
	   retFlag = "1";
	   retMsg = "s8071Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000")){
	    bp_name = result_t1[0][3];           //机主姓名
	    bp_add = result_t1[0][4];            //客户地址
	    sm_code = result_t1[0][11];         //业务类别
	    sm_name = result_t1[0][12];        //业务类别名称
	    hand_fee = result_t1[0][13];      //手续费
	    favorcode = result_t1[0][14];     //优惠代码
	    rate_code = result_t1[0][5];     //资费代码
	    rate_name = result_t1[0][6];    //资费名称
	    next_rate_code = result_t1[0][7];//下月资费代码
	    next_rate_name = result_t1[0][8];//下月资费名称
	    bigCust_flag = result_t1[0][9];//大客户标志
	    bigCust_name = result_t1[0][10];//大客户名称
	    lack_fee = result_t1[0][15];//总欠费
	    total_prepay = result_t1[0][16];//总预交
	    cardId_type = result_t1[0][17];//证件类型
	    cardId_no = result_t1[0][18];//证件号码
	    cust_id = result_t1[0][19];//客户id
	    cust_belong_code = result_t1[0][20];//客户归属id
	    group_type_code = result_t1[0][21];//集团客户类型
	    group_type_name = result_t1[0][22];//集团客户类型名称
	    imain_stream = result_t1[0][23];//当前资费开通流水
	    next_main_stream = result_t1[0][24];//预约资费开通流水
	    SaleCode = result_t1[0][25];//营销代码
	    sum_pay = result_t1[0][26];//机型
	    preparefee = result_t1[0][27];//赠送预存
	    SpFee = result_t1[0][28];//农情包费
	    mach_fee = result_t1[0][29];//礼品名称
	    PayMoney = result_t1[0][30];//应收金额
	    print_note = result_t1[0][32];//广告词
	    SpCode = result_t1[0][33];//SpCode
	    vUnitId = result_t1[0][34];//集团编号
	    vUnitName = result_t1[0][35].trim();//集团名称
	    vproduct_name = result_t1[0][36];//产品名称
	    vUnitAddr = result_t1[0][37].trim();//集团地址
	    imei_no = result_t1[0][38].trim();//集团地址
	 }
	  else{%>
	 <script language="JavaScript">
<!--
  	alert("错误代码<%=errCode%>错误信息<%=errMsg%>");
  	 history.go(-1);
  	//-->
  </script>
<%	 }
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>致富信息机营销案冲正</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>



<script language="JavaScript">
<!--
  onload=function()
  {
   	self.status="";
   }

//--------1---------doProcess函数----------------

  function doProcess(packet)
  {
    var vRetPage=packet.data.findValueByName("rpc_page");
    
    if(vRetPage == "qryCus_s126iInit")
    {
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");

    var bp_name        = packet.data.findValueByName("bp_name"        );
    var sm_code         = packet.data.findValueByName("sm_code"        );
    var family_code     = packet.data.findValueByName("family_code"    );
    var rate_code       = packet.data.findValueByName("rate_code"      );
    var bigCust_flag    = packet.data.findValueByName("bigCust_flag"   );
    var sm_name         = packet.data.findValueByName("sm_name"        );
    var rate_name       = packet.data.findValueByName("rate_name"      );
    var bigCust_name    = packet.data.findValueByName("bigCust_name"   );
    var next_rate_code  = packet.data.findValueByName("next_rate_code" );
    var next_rate_name  = packet.data.findValueByName("next_rate_name" );
    var lack_fee        = packet.data.findValueByName("lack_fee"       );
    var total_prepay    = packet.data.findValueByName("total_prepay"   );
    var bp_add          = packet.data.findValueByName("bp_add"         );
    var cardId_type     = packet.data.findValueByName("cardId_type"    );
    var cardId_no       = packet.data.findValueByName("cardId_no"      );
    var cust_id         = packet.data.findValueByName("cust_id"        );
    var cust_belong_code= packet.data.findValueByName("cust_belong_code");
    var group_type_code = packet.data.findValueByName("group_type_code");
    var group_type_name = packet.data.findValueByName("group_type_name");
    var imain_stream    = packet.data.findValueByName("imain_stream"   );
    var next_main_stream= packet.data.findValueByName("next_main_stream");
    var hand_fee        = packet.data.findValueByName("hand_fee"       );
    var favorcode       = packet.data.findValueByName("favorcode"      );
    var card_no         = packet.data.findValueByName("card_no"        );
    var print_note      = packet.data.findValueByName("print_note"     );

    var gift_grade      = packet.data.findValueByName("gift_grade"     );
    var gift_code       = packet.data.findValueByName("gift_code"      );
    var gift_name       = packet.data.findValueByName("gift_name"      );
    var deposit_fee     = packet.data.findValueByName("deposit_fee"    );
    var base_fee        = packet.data.findValueByName("base_fee"       );
    var free_fee        = packet.data.findValueByName("free_fee"       );
    var mark_subtract   = packet.data.findValueByName("mark_subtract"  );
    var consume_term    = packet.data.findValueByName("consume_term"   );
    var mon_base_fee    = packet.data.findValueByName("mon_base_fee"   );
    var prepay_fee      = packet.data.findValueByName("prepay_fee"     );

		if(retCode == 000000)
		{
		document.all.i1.value = document.all.phoneNo.value;
		document.all.i2.value = cust_id;
		document.all.i16.value = rate_code;
    document.frm.ip.value= next_rate_code;
		document.all.belong_code.value = cust_belong_code;
		document.all.print_note.value = print_note;

		document.all.i4.value = bp_name;
		document.all.i5.value = bp_add;
		document.all.i6.value = cardId_type;
		document.all.i7.value = cardId_no;
		document.all.i8.value = sm_code+"--"+sm_name;

		document.all.ipassword.value = "";
		document.all.group_type.value = group_type_code+"--"+group_type_name;
		document.all.ibig_cust.value =  bigCust_flag+"--"+bigCust_name;

		document.all.favorcode.value = favorcode;
		document.all.maincash_no.value = rate_code;
		document.all.imain_stream.value =  imain_stream;
		document.all.next_main_stream.value =  next_main_stream;

		document.all.i18.value = next_rate_code+"--"+next_rate_name;
		document.all.i19.value = hand_fee;
		document.all.i20.value = hand_fee;

		document.all.oCustName.value = bp_name;
		document.all.oSmCode.value = sm_code;
		document.all.oSmName.value = sm_name;
		document.all.oModeCode.value = rate_code;
		document.all.oModeName.value = rate_name;
		document.all.oPrepayFee.value = total_prepay;
		//document.all.oMarkPoint.value = "0";

		document.all.Gift_Grade.value = gift_grade;
		document.all.Gift_Code.value = gift_code;
		document.all.Gift_Name.value = gift_name;
		document.all.Deposit_Fee.value = deposit_fee;
		document.all.Free_Fee.value = free_fee;
		document.all.Base_Fee.value = base_fee;
		document.all.Mark_Subtract.value = mark_subtract;
		document.all.Consume_Term.value = consume_term;
		document.all.Mon_Base_Fee.value = mon_base_fee;
		document.all.Prepay_Fee.value = prepay_fee;
		document.all.Consume_Term.value = consume_term;

		document.all.do_note.value = document.all.phoneNo.value+"建设新农村、手机乐万家冲正";
		//alert(document.all.do_note.value);
	  document.frm.iAddStr.value=document.frm.backaccept.value+"|"+document.frm.Gift_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+
	                        document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+document.frm.Deposit_Fee.value+"|"+
	                        document.frm.Mark_Subtract.value+"|"+document.frm.Consume_Term.value+"|"+document.frm.Mon_Base_Fee.value+"|"+
	                        document.frm.Gift_Name.value+"|";
		}else
			{
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
				return;
			}
  	}

 }

  //--------2---------验证按钮专用函数-------------

  function chkPass()
  {
  var myPacket = new AJAXPacket("qryCus_s126iInit.jsp","正在查询客户，请稍候......");
	myPacket.data.add("iPhoneNo",(document.all.phoneNo.value).trim());
	myPacket.data.add("iLoginNo",(document.all.loginNo.value).trim());
	myPacket.data.add("iOrgCode",(document.all.orgCode.value).trim());
	myPacket.data.add("iOpCode",(document.all.iOpCode.value).trim());

	core.ajax.sendPacket(myPacket);
	myPacket = null;
  }

  function frmCfm()
  {
         if(!checkElement(document.frm.phoneNo)) return;
        // 原流水|预存话费|农情包费用|收费|SP代码|imei|集团ID|集团名称|营销代码|购机款|
         document.frm.iAddStr.value=document.frm.backaccept.value+"|"+
	                        document.frm.preparefee.value+"|"+document.frm.SpFee.value+"|"+document.frm.PayMoney.value+"|"+
	                        document.frm.SpCode.value+"|"+document.frm.imei_no.value+"|"+document.frm.vUnitId.value+"|"+document.frm.vUnitName.value+"|"+document.frm.SaleCode.value+"|"+document.frm.mach_fee.value+"|";
	 //alert(document.frm.iAddStr.value);
		    frm.submit();

  }
    function oneTokSelf(str,tok,loc)
  {
	    var temStr=str;
		var temLoc;
		var temLen;
	    for(ii=0;ii<loc-1;ii++)
		{
			temLen=temStr.length;
			temLoc=temStr.indexOf(tok);
			temStr=temStr.substring(temLoc+1,temLen);
	 	}
		if(temStr.indexOf(tok)==-1)
		  	return temStr;
		else
	      	return temStr.substring(0,temStr.indexOf(tok));
  }
//-->
</script>

</head>

<body >
	<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">致富信息机营销案冲正</div>
	</div>

		<input name="oSmCode" type="hidden"  id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden"  id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=sysAcceptl%>">

	<table  cellspacing="0" >
		<tr>
			<td class="blue">
				集团ID
			</td>
            <td>
				<input name="vUnitId" type="text"  id="vUnitId" value="<%=vUnitId%>" readonly   Class="InputGrey">
			</td>
            <td class="blue">
            	集团名称
            </td>
            <td>
				<input name="vUnitName" type="text"  id="vUnitName" value="<%=vUnitName%>" readonly  Class="InputGrey">
			</td>
		</tr>
		<tr>
			<td class="blue">
				集团产品
			</td>
            <td>
				<input name="vproduct_name" type="text"  id="vproduct_name" value="<%=vproduct_name%>" readonly  Class="InputGrey">
			</td>
            <td class="blue">
            	集团地址
            </td>
            <td>
				<input name="vUnitAddr" type="text"  id="vUnitAddr" value="<%=vUnitAddr%>" readonly  Class="InputGrey">
			</td>
		</tr>
		<tr>
			<td width="11%" class="blue">手机号码</td>
            <td width="39%">
				<input   type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" v_name="手机号码" onBlur="if(this.value!=''){if(checkElement('phoneNo')==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly   Class="InputGrey">
			<!--	<input  type="button" name="qryId_No" value="查询" onClick="chkPass()">-->
			</td>
			<td width="11%" class="blue">机主姓名:</td>
			<td width="39%">
				<input name="oCustName" type="text"  id="oCustName" value="<%=bp_name%>" readonly  Class="InputGrey">
			</td>
		</tr>
		<tr>
			<td class="blue">业务品牌</td>
            <td>
				<input name="oSmName" type="text"  id="oSmName" value="<%=sm_name%>" readonly  Class="InputGrey">
			</td>
            <td class="blue">资费名称</td>
            <td>
				<input name="oModeName" type="text"  id="oModeName" value="<%=rate_name%>" readonly  Class="InputGrey">
			</td>
		</tr>
		<tr>
			<td class="blue">
				帐号预存
			</td>
            <td>
				<input name="oPrepayFee" type="text"  id="oPrepayFee" value="<%=total_prepay%>" readonly  Class="InputGrey">
			</td>
            <td class="blue">
            	营销代码
            </td>
            <td>
            			<input type="text"  name="SaleCode" value="<%=SaleCode%>" readonly   Class="InputGrey">
			</td>
		</tr>

		<tr>


            <td class="blue">
            	IMEI号码
            </td>
            <td>
				<input name="imei_no" type="text"  id="imei_no" value="<%=imei_no%>" readonly  Class="InputGrey">
			</td>
			<td class="blue">
				预存要求
			</td>
            <td>
				<input name="preparefee" type="text"  id="preparefee" readonly   Class="InputGrey" value="<%=preparefee%>">
			</td>
		</tr>


		<tr>
		<td class="blue">
				购机款
			</td>
            <td>
				<input name="sum_pay" type="text"  id="sum_pay"  value="<%=sum_pay%>" readonly  Class="InputGrey">
			</td>
            <td class="blue">
            	应收金额
            </td>
            <td>
            			<input name="PayMoney" type="text"  id="PayMoney"  value="<%=PayMoney%>" readonly  Class="InputGrey">
				<input name="SpFee" type="hidden"  id="SpFee"  value="<%=SpFee%>" readonly  Class="InputGrey">
				<input name="SpCode" type="hidden"  id="SpCode"  value="<%=SpCode%>" readonly  Class="InputGrey">
				<input name="mach_fee" type="hidden"  id="mach_fee"  value="<%=mach_fee%>" readonly  Class="InputGrey">
			</td>

		</tr>
		<tr>
            <td>

            </td>
            <td>

			</td>
			<td>

			</td>
            <td>
			</td>
		</tr>

		<tr>
			<td colspan="4">
				<div align="center" id="footer">
                &nbsp;
				<input name="commit" id="commit" type="button"    value="下一步" onClick="frmCfm();" class="b_foot">
                &nbsp;
                <input name="reset" type="reset"  value="清除"  class="b_foot">
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button"  value="关闭" class="b_foot">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>

			<input type="hidden" name="iOpCode" value="8071">
			<input type="hidden" name="opCode" value="8071">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
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
			<input type="hidden" name="opName" value="<%=opName%>">
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
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>致富信息机营销案冲正">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=iLoginNoAccept%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<input type="hidden" name="beforeOpCode" value="8070">
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">

			<input type="hidden" name="return_page" value="/npage/bill/f126i_1.jsp">
			<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
