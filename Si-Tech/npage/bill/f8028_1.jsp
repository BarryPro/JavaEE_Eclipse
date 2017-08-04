<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-14
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
  String opCode = "8028";
  String opName = "买手机、送话费冲正";
%>
<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<%


  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  /*
  comImpl co1 = new comImpl();
  String paraStr[]=new String[1];
  String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
  paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
  */
%>

 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode" routerValue="<%=regionCode%>"  id="paraStr" />

<%
  String  retFlag="",retMsg="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",vInv_Note = "";
  String  SaleCode="";
  String  preparefee="",PayMoney="",PhoneName="",Mach_Fee="",Cash_Fee="" ;
  String  deposit_fee="",base_fee="",free_fee="";
  String  mark_subtract="",consume_term="",mon_base_fee="",prepay_fee="";

  String iPhoneNo = request.getParameter("srv_no");
  String iLoginNoAccept = request.getParameter("backaccept");
  //String iOrgCode = request.getParameter("iOrgCode");
  String iOpCode = request.getParameter("opcode");
  //String[][] tempArr= new String[][]{};
  //SPubCallSvrImpl co = new SPubCallSvrImpl();
  
  /* liujian 安全加固修改 2012-4-6 16:18:13 begin */
	String op_strong_pwd = (String) session.getAttribute("password");
	/* liujian 安全加固修改 2012-4-6 16:18:13 end */
  
     String goodbz="";
	String phone_good=iPhoneNo;
	String modedxpay="";
	String sqlStrgood = "select mode_dxpay "+
  						 "from dgoodphoneres a, sGoodBillCfg b "+
 						 "where a.bill_code = b.mode_code "+
   						 " and b.region_code = '"+regionCode+"'"+
   						 " and a.phone_no = '"+phone_good+"' and b.valid_flag='Y' and a.bak_field='1' and end_time>sysdate and b.mode_dxpay>0";
  System.out.println("############################f1270_3->sqlStrgood->"+sqlStrgood);
	System.out.println("###################zhanghongzhanghong16################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
		<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode1111" retmsg="retMsg1111">
		<wtc:sql><%=sqlStrgood%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultx" scope="end" />
<%
		System.out.println("###################zhanghongzhanghong17################System.currentTimeMillis()->"+System.currentTimeMillis());
		if(resultx!=null&&resultx.length>0){
			if(resultx[0][0].equals(""))
			{
				goodbz="N";
			}else{
				goodbz="Y";
				modedxpay = resultx[0][0];
				System.out.println("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
				System.out.println(modedxpay);
			}
		} 
  

	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);


%>	
	
    <wtc:service name="s8028Init" outnum="34" retmsg="msg1" retcode="code1" routerKey="phone" routerValue="<%=iPhoneNo%>">
			<wtc:param value="<%=iLoginNoAccept%>" />
			<wtc:param value="01"/>
			<wtc:param value="<%=iOpCode%>" />
			<wtc:param value="<%=loginNo%>"/>	
			<wtc:param value="<%=op_strong_pwd%>" />
			<wtc:param value="<%=iPhoneNo%>" />
			<wtc:param value="" />
			<wtc:param value="<%=orgCode%>" />
			
		</wtc:service>
		<wtc:array id="retList" scope="end"  />

<%

  String errCode = code1;
  String errMsg = msg1;

  if(retList == null)
  {
	   retFlag = "1";
	   retMsg = "s8028Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000")){

	    bp_name = retList[0][3];           //机主姓名
	    bp_add = retList[0][4];            //客户地址
	    sm_code = retList[0][11];         //业务类别
	    sm_name = retList[0][12];        //业务类别名称
	    hand_fee = retList[0][13];      //手续费
	    favorcode = retList[0][14];     //优惠代码
	    rate_code = retList[0][5];     //资费代码
	    rate_name = retList[0][6];    //资费名称
	    next_rate_code = retList[0][7];//下月资费代码
	    next_rate_name = retList[0][8];//下月资费名称
	    bigCust_flag = retList[0][9];//大客户标志
	    bigCust_name = retList[0][10];//大客户名称
	    lack_fee = retList[0][15];//总欠费
	    total_prepay = retList[0][16];//总预交
	    cardId_type = retList[0][17];//证件类型
	    cardId_no = retList[0][18];//证件号码
	    cust_id = retList[0][19];//客户id
	    cust_belong_code = retList[0][20];//客户归属id
	    group_type_code = retList[0][21];//集团客户类型
	    group_type_name = retList[0][22];//集团客户类型名称
	    imain_stream = retList[0][23];//当前资费开通流水
	    next_main_stream = retList[0][24];//预约资费开通流水
	    SaleCode = retList[0][25];//营销代码
	    PhoneName = retList[0][26];//机型
	    preparefee = retList[0][27];//赠送预存
	    Mach_Fee = retList[0][28];//机器款
	    Cash_Fee = retList[0][29];//全部金额
	    print_note = retList[0][30];//广告词
	    vInv_Note = retList[0][31];//SpCode
	 }
	  else{%>
	 <script language="JavaScript">
<!--
  	rdShowMessageDialog("错误代码<%=errCode%>错误信息<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
<%	 }
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>买手机、送话费冲正</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
  onload=function()
  {

  	document.all.phoneNo.focus();
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

		document.all.do_note.value = document.all.phoneNo.value+"买手机、送话费冲正";
		//alert(document.all.do_note.value);
	   document.frm.iAddStr.value=document.frm.backaccept.value+"|"+document.frm.SaleCode.value+"|"+document.frm.PhoneName.value+"|"+document.frm.preparefee.value+"|"+document.frm.PayMoney.value+"|";
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
  function printCommit()
 { 
  //校验
  //if(!check(frm)) return false;
  
 //打印工单并提交表单
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
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
	   frm.submit();
     }
  }
  return true;
}

  function frmCfm()
  {
         //if(!checkElement('phoneNo')) return;
        // 原流水|营销代码|机型名称|预存话|收费|
         document.frm.iAddStr.value=document.frm.backaccept.value+"|"+document.frm.SaleCode.value+"|"+document.frm.PhoneName.value+"|"+document.frm.preparefee.value+"|"+document.frm.PayMoney.value+"|";
	//打印工单并提交表单
	       if((document.all.tonote.value.trim())=="")  {
       	document.all.tonote.value="于"+<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>+"办理买手机，送话费冲正";//系统备注
       }  
		    printCommit();

  }

//-->

		function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   //var printStr = printInfo();
   /*
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
   */
   	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
		var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
		var sysAccept =<%=printAccept%>;             			//流水号
		var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
		var mode_code=null;           							//资费代码
		var fav_code=null;                				 		//特服代码
		var area_code=null;             				 		//小区代码
		var opCode="8028" ;                   			 		//操作代码
		var phoneNo="<%=iPhoneNo%>";                  	 		//客户电话
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
		path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,"",prop);
		return ret;
}
	function oneTokSelf(str,tok,loc)
  {
    var temStr=str;
    //if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
    //if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

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

  /***其他函数中要用到的过滤函数**/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
function printInfo(printType)
{
	  //得到该业务工单需要的参数
	var tempStr = document.frm.iAddStr.value;
	  //iAddStr格式 原流水|营销代码|机型名称|赠送话费|购机款|
	var backaccept = oneTokSelf(tempStr,"|",1);     //原流水
    var SaleCode = oneTokSelf(tempStr,"|",2);      //营销代码
	var PhoneName = oneTokSelf(tempStr,"|",3);     //机型名称
	var preparefee= oneTokSelf(tempStr,"|",4); //赠送话费
	var PayMoney= oneTokSelf(tempStr,"|",5); //购机款



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	    /********基本信息类**********/
       cust_info+="客户姓名：" +document.all.i4.value+"|";
       cust_info+="手机号码："+document.all.i1.value+"|";
       cust_info+="客户地址："+document.all.i5.value+"|";
       cust_info+="证件号码："+document.all.i7.value+"|";

     /********受理类**********/
      opr_info+="业务类型：买手机，送话费冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="手机型号："+PhoneName+"|";
      opr_info+="退款合计："+PayMoney+"元、赠送话费："+preparefee+"元"+"|";
      /*******备注类**********/

	  	note_info1+=" "+"|";
	  	
	  /**********描述类*********/

      note_info1+=" "+"|";
      
      <%if(goodbz.equals("Y")){%>
			//note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
      //retInfo+="备注：欢迎您参加“建设新农村、手机乐成家”活动，您的话费预存款按月返还，月返还金额为"+formatFloat(prepay_fee/6, 2)+"元，在六个月以内不能变更资费套餐。"+"|";
      //retInfo+="参与手机销售活动所获赠的话费未消费完，客户不能办理消户业务。"+"|";

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
</script>

</head>

<body>
	<form name="frm" method="post" action="f8028Cfm.jsp" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>
		<input name="oSmCode" type="hidden"  id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden"  id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr%>">
	<div class="title">
		<div id="title_zi">买手机、送话费冲正</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">手机号码</td>
            <td>
				<input   type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" v_name="手机号码"  maxlength=11 index="3" value="<%=iPhoneNo%>" readonly   Class="InputGrey" >
			<!--	<input  type="button" name="qryId_No" value="查询" onClick="chkPass()">-->
			</td>
			<td class="blue">机主姓名</td>
			<td>
				<input name="oCustName" type="text"  id="oCustName" value="<%=bp_name%>" readonly  Class="InputGrey">
			</td>
		</tr>
		<tr >
			<td class="blue">业务品牌</td>
            <td  >
				<input name="oSmName" type="text"  id="oSmName" value="<%=sm_name%>" readonly  Class="InputGrey">
			</td>
    
			  <td class="blue">
            	营销代码
            </td>
            <td>
            			<input type="text"  name="SaleCode" value="<%=SaleCode%>" readonly  Class="InputGrey">
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
				赠送预存
			</td>
            <td>
				<input name="preparefee" type="text"  id="preparefee" readonly value="<%=preparefee%>"  Class="InputGrey">
			</td>
		</tr>

		<tr>


            <td class="blue">
            	机型
            </td>
            <td>
				<input name="PhoneName" type="text"  id="PhoneName" value="<%=PhoneName%>" readonly  Class="InputGrey">
			</td>
		  <td class="blue">
            	应退金额
            </td>
            <td>
            	<input name="PayMoney" type="text"  id="PayMoney"  value="<%=Mach_Fee%>" readonly  Class="InputGrey">
			</td>
		</tr>
		<tr>

		</tr>
							 
						  
		<tr>
			 <tr style="display:block">
						     <td class="blue">用户备注</td>
							 <td  colspan="4">
								<input name="tonote" id="tonote" size="40" maxlength="60" value="" >
							 </td>
						
						  </tr>
			<td colspan="4"  id="footer">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="确定&打印" onClick="frmCfm();">
                &nbsp;
                <input name="reset" type="reset"  class="b_foot" value="清除" >
                &nbsp;
                <input name="close"  onClick="removeCurrentTab()"  class="b_foot" type="button"  value="关闭">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>

			<input type="hidden" name="iOpCode" value="8028">
			<input type="hidden" name="opName" value="<%=opName%>">
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
			<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>买手机、送话费冲正">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=iLoginNoAccept%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">

			<input type="hidden" name="beforeOpCode" value="8027">
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<input type="hidden" name="return_page" value="/npage/bill/f126i_1.jsp">
			<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
