<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.1.8 
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
  response.setDateHeader("Expires", 0);
%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%		

	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
%>
<%
  String retFlag="",retMsg="";//用于判断页面刚进入时的正确性
/****************由移动号码得到密码、机主姓名、 等信息 s125cInit***********************/
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = loginNo; 	    /* 操作工号   */
  paraAray1[2] = orgCode;	    /* 归属代码   */
  paraAray1[3] = "125c";	    /* 操作代码   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s125cInit", paraAray1, "31","phone",phoneNo);
%>
	<wtc:service name="s125cInit" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="31">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>	
	<wtc:param value="<%=paraAray1[2]%>"/>	
	<wtc:param value="<%=paraAray1[3]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr"  scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",  should_fee="",  consume_term="",  new_rate_code="",new_rate_name="",print_note="";
  String errCode = retCode1;
  String errMsg = retMsg1;
  if(tempArr.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s125cInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(errCode.equals("000000") && tempArr.length>0)
  {
	
	    bp_name = tempArr[0][3];//机主姓名
	
	    bp_add = tempArr[0][4];//客户地址
	 
	    passwordFromSer = tempArr[0][2];//密码
	 
	    sm_code = tempArr[0][11];//业务类别
	 
	    sm_name = tempArr[0][12];//业务类别名称
	 
	    hand_fee = tempArr[0][13];//手续费
	 
	    favorcode = tempArr[0][14];//优惠代码
	 
	    rate_code = tempArr[0][5];//资费代码
	 
	    rate_name = tempArr[0][6];//资费名称
	 
	    next_rate_code = tempArr[0][7];//下月资费代码
	 
	    next_rate_name = tempArr[0][8];//下月资费名称
	
	    bigCust_flag = tempArr[0][9];//大客户标志
	 
	    bigCust_name = tempArr[0][10];//大客户名称
	 
	    lack_fee = tempArr[0][15];//总欠费
	 
	    prepay_fee = tempArr[0][16];//总预交
	 
	    cardId_type = tempArr[0][17];//证件类型
	 
	    cardId_no = tempArr[0][18];//证件号码
	 
	    cust_id = tempArr[0][19];//客户id
	 
	    cust_belong_code = tempArr[0][20];//客户归属id
	  
	    group_type_code = tempArr[0][21];//集团客户类型
	 
	    group_type_name = tempArr[0][22];//集团客户类型名称
	 
	    imain_stream = tempArr[0][23];//当前资费开通流水
	
	    next_main_stream = tempArr[0][24];//预约资费开通流水
	 
	    should_fee = tempArr[0][25];//预存款金额
	  
	    new_rate_code = tempArr[0][26];//新套餐代码
	 
	    new_rate_name = tempArr[0][27];//新套餐名称
	 
	    consume_term = tempArr[0][28];//消费时限
	 
	    print_note = tempArr[0][29];//工单广告词
	

	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s125cInit查询号码基本信息失败!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}


  
%>
<head>
<title>动感地带月租包年冲正</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

 
<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>

<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";	 	//根据营业系统定义而修改

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

   onload=function()
  {		
  } 
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//校验
  function check(){
	var now_rate_code = "<%=rate_code%>";
    var next_rate_code = "<%=next_rate_code%>";
	var new_rate_code = document.frm.new_rate_code.value;
    if(now_rate_code==next_rate_code && now_rate_code==new_rate_code){
	  rdShowMessageDialog("当前资费、下月资费、新资费三者不能完全相同，请确认!");
	  return false;
	}

	return true;
  }

  //点击下一步按钮时,为下一个页面组织参数
  function setParaForNext(){ 
    var iOpCode = "125c";//iOpCode
	//iAddStr格式 包年预存 消费期限
	var iAddStr =  document.frm.should_fee.value + "|" + document.frm.consume_term.value + "|" ; //iAddStr
	var belong_code = "<%=cust_belong_code%>"; //belong_code 
    var i2 =  "<%=cust_id%>"  ; //客户ID
    var i16 = "<%=rate_code+"--"+rate_name%>";//现主套餐代码（老）
    var ip = document.frm.new_rate_code.value;//申请主套餐代码(新)
    var i1 = document.frm.phoneNo.value;//  手机号码
    var i4 = "<%=bp_name%>";//  客户名称
    var i5 = "<%=bp_add%>";//  客户地址
    var i6 = "<%=cardId_type%>";//   证件类型
    var i7 = "<%=cardId_no%>";//  证件号码
    var ipassword = ""; // 密码
    var group_type = "<%=group_type_code+"--"+group_type_name%>";//集团客户类别
    var ibig_cust = "<%=bigCust_flag+"--"+bigCust_name%>";// 大客户类别：
    var i18 =  "<%=next_rate_code + "--" + next_rate_name%>"; //下月主套餐：
    var i19 =  "<%=hand_fee%>";//   手续费
    var i20 =  "<%=hand_fee%>";  // 最高手续费
    var i8 =   "<%=sm_code+"--"+sm_name%>";  //   业务品牌
    var do_note = document.frm.opNote.value;// 用户备注：
    var favorcode =  "<%=favorcode%>";  // 手续费优惠权限
    var maincash_no = "<%=rate_code%>";//现主套餐代码（老）
    var imain_stream = "<%=imain_stream%>"; //当前主资费开通流水
    var next_main_stream = "<%=next_main_stream%>";//预约主资费开通流水	
	var beforeOpCode = "125b";//冲正时传送对应申请业务的opCode

	/*var str = "iOpCode="+iOpCode+
		                              "&iAddStr="+iAddStr + 
				                      "&belong_code="+belong_code +
				                      "&i2="+i2 +
				                      "&i16="+i16 +
				                      "&ip="+ip +
				                      "&i1="+i1 +
				                      "&i4="+i4 +
				                      "&i5="+i5 +
				                      "&i6="+i6 +
				                      "&i7="+i7 +
				                      "&ipassword="+ipassword +
				                      "&group_type="+group_type +
				                      "&ibig_cust="+ibig_cust +
				                      "&i18="+i18 +
				                      "&i19="+i19 +
				                      "&i20="+i20 +
				                      "&i8="+i8 +
				                      "&do_note="+do_note +
				                      "&favorcode="+favorcode +
				                      "&maincash_no="+maincash_no +
				                      "&imain_stream="+imain_stream +
		                              "&beforeOpCode="+beforeOpCode +
				                      "&next_main_stream="+next_main_stream;
	
	alert(str);*/
	document.frm.iOpCode.value = iOpCode;
	document.frm.iAddStr.value = iAddStr;
	document.frm.belong_code.value = belong_code;
	document.frm.i2.value = i2;
	document.frm.i16.value = i16;
	document.frm.ip.value = ip;
	document.frm.i1.value = i1;
	document.frm.i4.value = i4;
	document.frm.i5.value = i5;
	document.frm.i6.value = i6;
	document.frm.i7.value = i7;
	document.frm.ipassword.value = ipassword;
	document.frm.group_type.value = group_type;
	document.frm.ibig_cust.value = ibig_cust;
	document.frm.i18.value = i18;
	document.frm.i19.value = i19;
	document.frm.i20.value = i20;
	document.frm.i8.value = i8;
	document.frm.do_note.value = do_note;
	document.frm.favorcode.value = favorcode;
    document.frm.maincash_no.value = maincash_no;
	document.frm.imain_stream.value = imain_stream;
	document.frm.next_main_stream.value = next_main_stream;
	document.frm.beforeOpCode.value = beforeOpCode;
	frm.action = "f1270_3.jsp";
  }

  function printCommit(subButton){
  	getAfterPrompt();
	controlButt(subButton);//延时控制按钮的可用性
	//校验
	if(!check()) return false;
	setOpNote();//为备注赋值
	//为下一个页面组织传递参数
	setParaForNext();
    //提交表单
    frmCfm();	
	return true;
  }
/******为备注赋值********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "动感月租包年冲正;号码:"+document.frm.phoneNo.value; 
	}
	return true;
}
//-->
</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
		  <tr>
		    <td class="blue">手机号码</td>
            <td>
			  <input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=phoneNo%>" readonly> 
			</td> 
		    <td class="blue">机主姓名</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>			  
			</td>           
          </tr>
          <tr> 
		    <td class="blue">业务品牌</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
			</td>
            <td class="blue">大客户标志</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>            
          </tr>
		  <tr> 
		    <td class="blue">证件类型</td>
            <td>
			  <input name="cardId_type" type="text" class="InputGrey" id="cardId_type" value="<%=cardId_type%>" readonly>
			</td>
            <td class="blue">证件号码</td>
            <td>
			<input name="cardId_no" type="text" class="InputGrey" id="cardId_no" value="<%=cardId_no%>" readonly>
			</td>            
          </tr>
          <tr> 
            <td class="blue">当前主套餐</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">下月主套餐</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>             
          </tr>
		  <tr> 
            <td class="blue">未出帐话费</td>
            <td>
			  <input name="lack_fee" type="text" class="InputGrey" id="lack_fee" value="<%=lack_fee%>" readonly >
            </td>
            <td class="blue">可用预存</td>
            <td>
			  <input name="prepay_fee" type="text" class="InputGrey" id="prepay_fee" value="<%=prepay_fee%>" readonly>
			</td>
          </tr>
		  <tr>
		    <td class="blue">预存款</td>
            <td>
			   <input name="should_fee" type="text" class="InputGrey" id="should_fee" value="<%=should_fee%>" readonly>
			</td>
			<td>消费期限：</td>
            <td>
			  <input name="consume_term" type="text" class="InputGrey" id="consume_term" value="<%=consume_term%>" readonly>
			</td>  
          </tr>
		  <tr>
		    <td class="blue">新套餐代码</td>
            <td colspan="3">
			  <input name="new_rate_code_1" type="text" class="InputGrey" id="new_rate_code_1" size="30" value="<%=new_rate_code + "--" + new_rate_name%>"   readonly>
			</td> 
          </tr>
          <tr> 
            <td class="blue">备注</td>
            <td colspan="3">
             <input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="" onFocus="setOpNote();"> 
            </td>
          </tr>
		  <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                &nbsp; 
				<input name="next" id="next" type="button" class="b_foot"   value="下一步" onClick="printCommit(this)" >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp; 
				
				</div>
			</td>
          </tr>
      </table>
 
  <input type="hidden" name="iOpCode">
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
  <input type="hidden" name="new_rate_code" value="<%=new_rate_code%>">
  <input type="hidden" name="pay_type">

  <input type="hidden" name="print_note" value="<%=print_note%>"><!--打印工单广告-->
  <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
