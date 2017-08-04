<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>

<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>


<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<%
	String opCode = "8024";
	String opName = "集团客户预存赠机冲正";

  /*ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
  String[][] baseInfoSession = (String[][])arrSession.get(0);
  String[][] otherInfoSession = (String[][])arrSession.get(2);
  String[][] pass = (String[][])arrSession.get(4);

  String loginNo = baseInfoSession[0][2];
  String loginName = baseInfoSession[0][3];
  String powerCode= otherInfoSession[0][4];
  String orgCode = baseInfoSession[0][16];
  String ip_Addr = request.getRemoteAddr();
  String regionCode = orgCode.substring(0,2);
  String regionName = otherInfoSession[0][5];
  String loginNoPass = pass[0][0];
  String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
  String aftertrim = baseInfoSession[0][5].trim();*/


  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");


  String  retFlag="",retMsg="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="";
  String  gift_code="",gift_grade="",gift_name="";
  String  deposit_fee="",base_fee="",free_fee="";
  String  mark_subtract="",consume_term="",mon_base_fee="",prepay_fee="";
  
  /**** tianyang add for pos start ****/
  String  payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
  /**** tianyang add for pos end ****/
  
  String iPhoneNo = request.getParameter("srv_no");
  String iLoginNoAccept = request.getParameter("backaccept");
  //String iOrgCode = request.getParameter("iOrgCode");
  String iOpCode = request.getParameter("opcode");
  //String[][] retList[0][]= new String[][]{};
  //SPubCallSvrImpl co = new SPubCallSvrImpl();
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);

	//sunzx add at 20070904
  String sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+iPhoneNo+"'"+
		    " and login_accept="+iLoginNoAccept ;

  //ArrayList retArray = co.sPubSelect("1",sqlStr);
%>

<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="agentCodeErrCode" retmsg="agentCodeErrMsg" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	<wtc:param value="<%=iLoginNoAccept%>"/>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>

<%

  if(result.length > 0)
  {
	  String awardName = result[0][0];

	  System.out.println("awardName2="+awardName);
	  if(!awardName.equals("")){
%>
	  <script language="JavaScript" >

	  rdShowMessageDialog("此用户已在促销品统一付奖中进行<%=awardName%>领奖，请进行促销品统一付奖冲正，并确保奖品完好");
		location='f8044_login.jsp';
		</script>
<%
		}
  }
	//sunzx add end

  /*ArrayList retList = new ArrayList();
  retList = co.callFXService("s126iInit", inputParsm, "39","phone",iPhoneNo);
  int errCode = co.getErrCode();
  String errMsg = co.getErrMsg();

  co.printRetValue();*/
%>

<wtc:service name="s126iInit" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="errCode" retmsg="errMsg" outnum="44" >
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	<wtc:param value="<%=inputParsm[4]%>"/>
</wtc:service>
<wtc:array id="retList" scope="end"/>

<%
  if(retList == null)
  {
	   retFlag = "1";
	   retMsg = "s126bInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("0")||errCode.equals("000000")){
	  //retList[0][] = (String[][])retList.get(3);
	  if(!(retList[0][3]==null)){
	    bp_name = retList[0][3];           //机主姓名
	  }

	  //retList[0][] = (String[][])retList.get(4);
	  if(!(retList[0][4]==null)){
	    bp_add = retList[0][4];            //客户地址
	  }

	  //retList[0][] = (String[][])retList.get(11);
	  if(!(retList[0][11]==null)){
	    sm_code = retList[0][11];         //业务类别
	  }

	  //retList[0][] = (String[][])retList.get(12);
	  if(!(retList[0][12]==null)){
	    sm_name = retList[0][12];        //业务类别名称
	  }

	  //retList[0][] = (String[][])retList.get(13);
	  if(!(retList[0][13]==null)){
	    hand_fee = retList[0][13];      //手续费
	  }

	  //retList[0][] = (String[][])retList.get(14);
	  if(!(retList[0][14]==null)){
	    favorcode = retList[0][14];     //优惠代码
	  }

	  //retList[0][] = (String[][])retList.get(5);
	  if(!(retList[0][5]==null)){
	    rate_code = retList[0][5];     //资费代码
	  }

	  //retList[0][] = (String[][])retList.get(6);
	  if(!(retList[0][6]==null)){
	    rate_name = retList[0][6];    //资费名称
	  }

	  //retList[0][] = (String[][])retList.get(7);
	  if(!(retList[0][7]==null)){
	    next_rate_code = retList[0][7];//下月资费代码
	  }

	  //retList[0][] = (String[][])retList.get(8);
	  if(!(retList[0][8]==null)){
	    next_rate_name = retList[0][8];//下月资费名称
	  }

	  //retList[0][] = (String[][])retList.get(9);
	  if(!(retList[0][9]==null)){
	    bigCust_flag = retList[0][9];//大客户标志
	  }

	  //retList[0][] = (String[][])retList.get(10);
	  if(!(retList[0][10]==null)){
	    bigCust_name = retList[0][10];//大客户名称
	  }

	  //retList[0][] = (String[][])retList.get(15);
	  if(!(retList[0][15]==null)){
	    lack_fee = retList[0][15];//总欠费
	  }

	  //retList[0][] = (String[][])retList.get(16);
	  if(!(retList[0][16]==null)){
	    total_prepay = retList[0][16];//总预交
	  }

	  //retList[0][] = (String[][])retList.get(17);
	  if(!(retList[0][17]==null)){
	    cardId_type = retList[0][17];//证件类型
	  }

	  //retList[0][] = (String[][])retList.get(18);
	  if(!(retList[0][18]==null)){
	    cardId_no = retList[0][18];//证件号码
	  }

	  //retList[0][] = (String[][])retList.get(19);
	  if(!(retList[0][19]==null)){
	    cust_id = retList[0][19];//客户id
	  }

	  //retList[0][] = (String[][])retList.get(20);
	  if(!(retList[0][20]==null)){
	    cust_belong_code = retList[0][20];//客户归属id
	  }

	  //retList[0][] = (String[][])retList.get(21);
	  if(!(retList[0][21]==null)){
	    group_type_code = retList[0][21];//集团客户类型
	  }

	  //retList[0][] = (String[][])retList.get(22);
	  if(!(retList[0][22]==null)){
	    group_type_name = retList[0][22];//集团客户类型名称
	  }

	  //retList[0][] = (String[][])retList.get(23);
	  if(!(retList[0][23]==null)){
	    imain_stream = retList[0][23];//当前资费开通流水
	  }

	  //retList[0][] = (String[][])retList.get(24);
	  if(!(retList[0][24]==null)){
	    next_main_stream = retList[0][24];//预约资费开通流水
	  }

	  //retList[0][] = (String[][])retList.get(25);
	  if(!(retList[0][25]==null)){
	    gift_grade = retList[0][25];//礼品等级
	  }

	  //retList[0][] = (String[][])retList.get(26);
	  if(!(retList[0][26]==null)){
	    gift_code = retList[0][26];//礼品代码
	  }

	  //retList[0][] = (String[][])retList.get(27);
	  if(!(retList[0][27]==null)){
	    gift_name = retList[0][27];//礼品名称
	  }

	  //retList[0][] = (String[][])retList.get(28);
	  if(!(retList[0][28]==null)){
	    deposit_fee = retList[0][28];//抵押预存
	  }

	  //retList[0][] = (String[][])retList.get(29);
	  if(!(retList[0][29]==null)){
	    base_fee = retList[0][29];//底线预存
	  }

	  //retList[0][] = (String[][])retList.get(30);
	  if(!(retList[0][30]==null)){
	    free_fee = retList[0][30];//活动预存
	  }

	  //retList[0][] = (String[][])retList.get(31);
	  if(!(retList[0][31]==null)){
	    mark_subtract = retList[0][31];//扣减积分
	  }

	  //retList[0][] = (String[][])retList.get(32);
	  if(!(retList[0][32]==null)){
	    consume_term = retList[0][32];//消费期限
	  }

	  //retList[0][] = (String[][])retList.get(33);
	  if(!(retList[0][33]==null)){
	    mon_base_fee = retList[0][33];//月底线
	  }

	  //retList[0][] = (String[][])retList.get(34);
	  if(!(retList[0][34]==null)){
	    prepay_fee = retList[0][34];//预存总金额
	  }

	  //retList[0][] = (String[][])retList.get(37);
	  if(!(retList[0][37]==null)){
	    print_note = retList[0][37];//广告词
	  }
	  
	  
		/*** tianyang add for pos start ***/	   	 
		payType       = retList[0][39].trim();
		Response_time = retList[0][40].trim();
		TerminalId    = retList[0][41].trim();
		Rrn           = retList[0][42].trim();
		Request_time  = retList[0][43].trim();
		System.out.println("--------------------------payType-----------------"+payType);
		System.out.println("--------------------------Response_time-----------"+Response_time);
		System.out.println("--------------------------TerminalId--------------"+TerminalId);
		System.out.println("--------------------------Rrn---------------------"+Rrn);
		System.out.println("--------------------------Request_time------------"+Request_time);
		/*** tianyang add for pos end ***/
	  
	  
	  
	  
	 }
	  else{%>
	 <script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			history.go(-1);
   </script>
<%	 }
	}
%>

<head>
<title>集团客户预存赠机冲正</title>


<script language="JavaScript">
<!--
  onload=function()
  {
  	document.all.phoneNo.focus();
   	//core.rpc.onreceive = doProcess;
   	self.status="";
   }

//--------1---------doProcess函数----------------
   //打印使用变量
  var modedxpay ="";
  var goodbz    ="";
  var bdbz      ="";
  var bdts      ="";
  var exeDate   ="";
  function doProcess(packet)
  {
    var vRetPage=packet.data.findValueByName("rpc_page");
    var verifyType = packet.data.findValueByName("verifyType");
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

		document.all.do_note.value = document.all.phoneNo.value+"集团客户预存赠机冲正冲正，礼品等级："+document.all.Gift_Grade.value+"，礼品代码："+document.all.Gift_Code.value;
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
	myPacket.data.add("iPhoneNo",jtrim(document.all.phoneNo.value));
	myPacket.data.add("iLoginNo",jtrim(document.all.loginNo.value));
	myPacket.data.add("iOrgCode",jtrim(document.all.orgCode.value));
	myPacket.data.add("iOpCode",jtrim(document.all.iOpCode.value));

	core.ajax.sendPacket(myPacket);
	myPacket = null;
  }

  function frmCfm()
  {
         if(!checkElement(document.all.phoneNo)) return;
         document.frm.iAddStr.value=document.frm.backaccept.value+"|"+document.frm.Gift_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+
	                        document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+document.frm.Deposit_Fee.value+"|"+
	                        document.frm.Mark_Subtract.value+"|"+document.frm.Consume_Term.value+"|"+document.frm.Mon_Base_Fee.value+"|"+
	                        document.frm.Gift_Name.value+"|";
	/*var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	if(typeof(ret)!="undefined")
	{
	  if((ret=="confirm"))
	  {
		    if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
		    {
		     frm.submit();
		    }
		}
		if(ret=="continueSub")
		{
		    if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		    {
		     frm.submit();
		    }
		}
	}
	else
	{
	   if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	   {
	   	 
	   }
	}*/
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

<body>
	<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">客户信息</div>
	</div>
	<table cellspacing="0">
	<tr >
		<td class="blue">手机号码</td>
		<td >
		<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" v_name="手机号码" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
		</td>
		<td class="blue">机主姓名</td>
		<td >
		<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
		</td>
	</tr>
	<tr >
	<td class="blue">业务品牌</td>
		<td>
		<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
		</td>
		<td class="blue">资费名称</td>
		<td>
		<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
		</td>
	</tr>
	<tr >
		<td class="blue">帐号预存</td>
		<td>
		<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=total_prepay%>" readonly>
		</td>
		<td class="blue">营销代码</td>
		<td>
		<input type="text" name="Gift_Code" value="<%=gift_code%>"  readonly>
		<input name="oMarkPoint" type="hidden" class="InputGrey" id="oMarkPoint" value="" readonly>
		</td>
	</tr>
	<tr >
		<input name="Gift_Grade" type="hidden" class="InputGrey" id="Gift_Grade" value="<%=gift_grade%>" readonly >
		<td class="blue">机型</td>
		<td>
		<input name="Gift_Name" type="text" class="InputGrey" id="Gift_Name" value="<%=gift_name%>" readonly>
		</td>
		<td class="blue">底线预存</td>
		<td>
		<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly value="<%=base_fee%>">
		</td>
	</tr>
	<input name="Deposit_Fee" type="hidden" class="InputGrey" id="Deposit_Fee" readonly value="<%=deposit_fee%>">
	<tr >
		<td class="blue">活动预存</td>
		<td>
		<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"  value="<%=free_fee%>" readonly>
		</td>
		<td class="blue">扣减积分</td>
		<td>
		<input name="Mark_Subtract" type="text" class="InputGrey" id="Mark_Subtract"  value="<%=mark_subtract%>" readonly>
		</td>
	</tr>
	<tr >
		<td class="blue">消费期限</td>
		<td>
		<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"  value="<%=consume_term%>" readonly>
		</td>
		<td class="blue">月底线</td>
		<td>
		<input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" value="<%=mon_base_fee%>" readonly>
		</td>
	</tr>
	<tr >
		<td class="blue">预存总金额</td>
		<td colspan="3">
		<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee" value="<%=prepay_fee%>"  readonly>
		</td>
	</tr>
	<tr >
		<td colspan="4" id="footer">
		<div align="center">
		&nbsp;
		<input name="commit" id="commit" type="button" class="b_foot"   value="下一步" onClick="frmCfm();">
		&nbsp;
		<input name="reset" type="reset" class="b_foot" value="清除" >
		&nbsp;
		<input name="close" onClick="parent.removeTab('<%=8024%>');" type="button" class="b_foot" value="关闭">
		&nbsp;
		</div>
	</td>
	</tr>
	</table>




		<input name="oSmCode" type="hidden" class="InputGrey" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="InputGrey" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=printAccept%>">


			<input type="hidden" name="iOpCode" value="8024">
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

			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="<%=iPhoneNo%>">
			<input type="hidden" name="i4" value="<%=bp_name%>">			
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code+"--"+sm_name%>">			

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code+"--"+group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag+"--"+bigCust_name%>">
			<input type="hidden" name="do_note" value="<%=iPhoneNo+"集团客户预存赠机冲正冲正"%>">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code+"--"+next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">

			<input type="hidden" name="beforeOpCode" value="8023">
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<input type="hidden" name="return_page" value="/npage/bill/f8024_1.jsp">
			
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
