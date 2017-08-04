<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-12
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%
  response.setDateHeader("Expires", 0);
%>
<%
  String opCode = "8046";
  String opName = "营销案取消";
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%

  String loginNo = (String)session.getAttribute("workNo");
  String loginName =  (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
  String printAccept = getMaxAccept();

%>
<%
  String retFlag="",retMsg="";//用于判断页面刚进入时的正确性

  String saleName = request.getParameter("saleName");

/****************由移动号码\营销案类型得到密码、机主姓名、 等信息 s804601Init***********************/
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[5];
  String saleType = request.getParameter("saleType");
  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";
  String yhje="";

  paraAray1[0] = phoneNo;		    /* 手机号码   */
  paraAray1[1] = loginNo; 	    /* 操作工号   */
  paraAray1[2] = orgCode;	      /* 归属代码   */
  paraAray1[3] = "8046";	      /* 操作代码   */
  paraAray1[4] = saleType;		  /* 营销案类型 */

  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s804601Init", paraAray1, "33","phone",phoneNo);
  String  bp_name="",sm_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",spec_prepay="",other_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="", order_code="", should_fee="",  consume_term="",  mon_base_fee="",  new_rate_code="",new_rate_name="",print_note="";
  String  breach_fee="",year_fee="";
  String  loginAccept = "";
  //String[][] tempArr= new String[][]{};
  %>
  
  	<wtc:service name="s804601Init" outnum="33" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray1[0]%>" />
			<wtc:param value="<%=paraAray1[1]%>" />
			<wtc:param value="<%=paraAray1[2]%>" />
			<wtc:param value="<%=paraAray1[3]%>" />
			<wtc:param value="<%=paraAray1[4]%>" />
		</wtc:service>
		
		<wtc:array id="retList" scope="end" />

  <%
  String errCode = code;
  String errMsg = msg;

  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s804601Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    	}    
  }else if(!(retList == null))
  {
	if (errCode.equals("000000") )
	{   bp_name = retList[0][3];//机主姓名
	    bp_add = retList[0][4];//客户地址
	    passwordFromSer = retList[0][2];//密码
	    sm_code = retList[0][11];//业务类别
	    sm_name = retList[0][12];//业务类别名称
	    hand_fee = retList[0][13];//手续费
	    favorcode = retList[0][14];//优惠代码
	    bigCust_flag = retList[0][9];//大客户标志
	    bigCust_name = retList[0][10];//大客户名称
	    spec_prepay = retList[0][15];//专款余额
	    other_prepay = retList[0][16];//可用现金余额
	    cardId_type = retList[0][17];//证件类型
	    cardId_no = retList[0][18];//证件号码
	    cust_id = retList[0][19];//客户id
	    cust_belong_code = retList[0][20];//客户归属id
	    group_type_code = retList[0][21];//集团客户类型
	    group_type_name = retList[0][22];//集团客户类型名称
	    imain_stream = retList[0][23];//当前资费开通流水
	    next_main_stream = retList[0][24];//预约资费开通流水
	    loginAccept = retList[0][25];//流水
	    System.out.println("loginAccept = " + loginAccept);
	    mon_base_fee = retList[0][26];//月底线消费
	    order_code = retList[0][27];//方案名称
	    consume_term = retList[0][30];//消费时限
	    print_note = retList[0][32];//工单广告词
	 	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s804601Init查询号码基本信息失败!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	     }
  }
if (saleType.equals("38"))
{
%>
	<wtc:service name="se720Select" outnum="2" 
			retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=phoneNo%>" />
	</wtc:service> 
	<wtc:array id="arrMoney" scope="end" />
	<%
	if(arrMoney.length == 0)
	{

		System.out.println("zhangyan~~~errCode~"+code1+"~~~~~~msg1~~"+msg1+"~~~~~~~~~~~~~~");
		 	%>
		rdShowMessageDialog("查询优惠金额为空!errCode: " +"<%=code1%>" + "errMsg:" + "<%=msg1%>" , 1);
	<%}   
	else
	{
		yhje=arrMoney[0][0];
	}
}
%>


	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>
	window.onload=function()
  {
  		if("<%=saleType%>"=="37") {
  			 $('#pay_phone_fee').addClass("InputGrey").attr('readonly','readonly');
  		}
  }

  function frmCfm()
  {
 	frm.submit();
	return true;
  }
  //***//校验
  function check()
  {
	with(document.frm)
	{
		if(!forMoney(pay_phone_fee)) return false;
		if(!forMoney(pay_product_fee)) return false;

		if((parseFloat(spec_prepay.value) + parseFloat(other_prepay.value)) < (parseFloat(pay_phone_fee.value) + parseFloat(pay_product_fee.value)))
		{
			rdShowMessageDialog("该用户的预存款不足,请先缴费后再办理!",0);
			return false;
		}
	}

	return true;
  }

/*--------------------------手续费校验函数--------------------------*/

function checknum(obj1,obj2)
{
    var num2 = parseFloat(obj2.value);
    var num1 = parseFloat(obj1.value);

    if(num2<num1)
    {
        var themsg = "'" + obj1.v_name + "'不得大于'" + obj2.value + "'请重新输入！";
        rdShowMessageDialog(themsg,0);
        obj1.focus();
        return false;
    }
    return true;
}

  function printCommit()
  {
	//校验
	setOpNote();//为备注赋值
	if(!check()) return false;
 //打印工单并提交表单
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
      {
	    frmCfm();
      }
	}
  }
  else
  {
     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
     {
	   frmCfm();
     }
  }
  return true;
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框

	var h=210;
	var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";



     var pType="subprint";                  // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =<%=printAccept%>;       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                    //资费代码
     var fav_code=null;                     //特服代码
     var area_code=null;                    //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = <%=activePhone%>;                            //客户电话
     /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
     /* ningtn */

    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.phoneNo.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
}
function printInfo(printType)
{
	var pay_phone_fee = document.frm.pay_phone_fee.value;//补手机款
	var pay_product_fee = document.frm.pay_product_fee.value;//补促销品款
	var pay_fee = (parseFloat(pay_phone_fee) + parseFloat(pay_product_fee)) + "";

		var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";


		cust_info+="手机号码："+<%=phoneNo%>+"|";
		cust_info+="客户姓名："+document.frm.bp_name.value+"|";
		cust_info+="证件号码："+"<%=cardId_no%>"+"|";
		cust_info+="客户地址："+'<%=bp_add%>'+"|";

		opr_info+="用户品牌："+"<%=sm_name%>"+"      "+"办理业务:"+"营销案取消"+"|";
		opr_info+="操作流水："+"<%=printAccept%>"+"|";
		if("<%=saleType%>"=="38") 
		{
			opr_info+="客户需交纳的补已优惠金额："+"<%=yhje%>"+"|";			
		}
		else
		{
			opr_info+="客户需交纳的补手机款、补促销品款合计："+pay_fee+"|";
		}
		/****************liujian 如果营销案是自备机合约计划的情况，设置其免填单 begin********************/

		if("<%=saleType%>"=="37") {
			note_info1+="您的预存话费在未消费完毕前，不能重复办理该业务，同时不能办理其他签约类终端营销案。本业务到期前若申请取消，按违约规定需要在预存款里扣除已赠送的话费，并按剩余预存款的30%交纳违约金。"+"|";
		}
		else if("<%=saleType%>"=="38") {
			note_info1+="在本业务到期前申请取消或办理销户，您需要退还营销案期间全部已经享受到的通信费用优惠，做为取消业务的违约金。"+"|";
		}	
		else if("<%=saleType%>"=="39") {

		}	
		else {
	note_info1+="您的预存话费在未消费完毕前，不能重复办理该业务，同时不能办理其他签约类终端营销案。本业务到期前若申请取消，按违约规定您以优惠价购买的手机将按手机原价补交差额，并按剩余预存款的30%交纳违约金。"+"|";
		}
		/****************liujian 如果营销案是自备机合约计划的情况，设置其免填单 end********************/
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

    return retInfo;


}


/******为备注赋值********/
  function setOpNote()
  {
	if(document.frm.opNote.value=="")
	{
	  	document.frm.opNote.value = "<%=saleName%>取消; 手机号码:<%=phoneNo%>";
	}
		return true;
  }

</script>


</head>


<body>
<form name="frm" action = "f8046Cfm.jsp" method="post"    >
<%@ include file="/npage/include/header.jsp" %> 
	<div class="title">
		<div id="title_zi">营销案取消</div>
	</div>
      <table cellspacing="0" >
		  <tr>
		    <td class="blue">手机号码</td>
            <td>
			  <input name="phoneNo" type="text"   id="phoneNo" value="<%=phoneNo%>"  Class="InputGrey" readonly>
			</td>
		    <td class="blue">机主姓名</td>
            <td>
			  <input name="bp_name" type="text"   id="bp_name" value="<%=bp_name%>"  Class="InputGrey" readonly>
			</td>
          </tr>
          <tr >
		    <td class="blue">业务品牌:</td>
            <td>
			  <input name="sm_name" type="text"   id="sm_name" value="<%=sm_code + "--" + sm_name%>"  Class="InputGrey" readonly>
			</td>
            <td class="blue">大客户标志</td>
            <td>
			<input name="bigCust_flag" type="text"   id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>"  Class="InputGrey" readonly>
			</td>
          </tr>
		  <tr >
		    <td class="blue">证件类型:</td>
            <td>
			  <input name="cardId_type" type="text"   id="cardId_type" value="<%=cardId_type%>"   Class="InputGrey" readonly>
			</td>
            <td class="blue">证件号码</td>
            <td>
			<input name="cardId_no" type="text"   id="cardId_no" value="<%=cardId_no%>"  Class="InputGrey" readonly>
			</td>
          </tr>
          <tr >
            <td class="blue">专款余额</td>
            <td>
			  <input name="spec_prepay" type="text"   id="spec_prepay" size="30" value="<%=spec_prepay%>"  Class="InputGrey" readonly>
			  <input name="rate_name" type="hidden"   id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>"  Class="InputGrey" readonly>
			  <input name="next_rate_name" type="hidden"   id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>"  Class="InputGrey" readonly>
			</td>
			<td class="blue">可用现金余额</td>
            <td>
			  <input name="other_prepay" type="text"   id="other_prepay" size="30"  value="<%=other_prepay%>"  Class="InputGrey" readonly>
			</td>
          </tr>
           <tr >
		    <td class="blue">补手机款</td>
            <td>
			   <input name="pay_phone_fee" type="text"    id="pay_phone_fee" value="0">
			</td>
			<td class="blue">补促销品款</td>
            <td>
			  <input name="pay_product_fee" type="text"    id="pay_product_fee" value="0">
			</td>
          </tr>
		  <tr >
		    <td class="blue">手机类型</td>
            <td>
			   <input name="phone_type" type="text"    id="phone_type" maxlength="60">
			</td>
			<td class="blue">礼品类型</td>
            <td>
			  <input name="product_type" type="text"   id="product_type" maxlength="60"><!--huangrong 修改 由于f8046Cfm.jsp获得不了礼品类型的值 2011-1-10-->
			</td>
          </tr>
          <tr  >
            <td class="blue">备注</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"   id="opNote" size="60" maxlength="60" value="" onFocus="setOpNote();">
            </td>
          </tr>
		  <tr >
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
            <td colspan="4" > <div align="center">
                &nbsp;
			       	<input name="next" id="next" type="button" class="b_foot"   value="确定&打印" onClick="printCommit()" >
                &nbsp;
                <input name="reset" type="reset" class="b_foot"  value="清除" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot"  value="返回">
                &nbsp;

				</div>
			</td>
          </tr>
      </table>

  <input type="hidden" name="iOpCode" value="<%=paraAray1[3]%>">
  <input type="hidden" name="iAddStr">
  <input type="hidden" name="belong_code">
  <input type="hidden" name="i2">
  <input type="hidden" name="i16">
  <input type="hidden" name="ip">
  <input type="hidden" name="i1">
  <input type="hidden" name="i4">
  <input type="hidden" name="i5">
  <input type="hidden" name="i6">
  <input type="hidden" name="i7">
  <input type="hidden" name="ipassword">
  <input type="hidden" name="group_type">
  <input type="hidden" name="ibig_cust">
  <input type="hidden" name="i18">
  <input type="hidden" name="i19">
  <input type="hidden" name="i20">
  <input type="hidden" name="i8">
  <input type="hidden" name="do_note">
  <input type="hidden" name="favorcode">
  <input type="hidden" name="maincash_no">
  <input type="hidden" name="imain_stream">
  <input type="hidden" name="next_main_stream">
  <input type="hidden" name="beforeOpCode">
  <input type="hidden" name="pay_type">
  <input type="hidden" name="smcode_xyz">
  <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
  <input type="hidden" name="saleType" value="<%=saleType%>">

  <input type="hidden" name="print_note" value="<%=print_note%>"><!--打印工单广告-->
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>

<script language="javascript">

</script>
