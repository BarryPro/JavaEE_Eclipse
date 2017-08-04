<%
/********************
 version v2.0
 开发商: si-tech
 模块：陈帐.死帐回收
 update zhaohaitao at 2008.12.29
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
 
<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	
    String phoneNo = request.getParameter("phoneNo");
	//phoneNo="2021234567";
    String busyType = request.getParameter("busyType");
    String idno  = request.getParameter("idno").trim();
  
    String workno = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String nopass = (String)session.getAttribute("password");
	

	// xl add for 发票号码 begin
	String check_seq="";
	String s_flag="";
	String result_check[][]=new String[][]{};
	String[] inParam2 = new String[2];
	inParam2[0]="select to_char(S_INVOICE_NUMBER),flag from WLOGININVOICE where LOGIN_NO = :workNo";
	inParam2[1]="workNo="+workno;
	%>
	<wtc:service name="TlsPubSelCrm"  outnum="2" >
		<wtc:param value="<%=inParam2[0]%>"/>
		<wtc:param value="<%=inParam2[1]%>"/>
	</wtc:service>
	<wtc:array id="retList" scope="end" />
<%
	result_check = retList;
	if(retList.length != 0)
	{
		check_seq=result_check[0][0];
		s_flag=result_check[0][1];
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAa check_seq is "+check_seq);
	}
	// xl add for 发票号码 end

	//优惠信息
    String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
      
    //解析营业员优惠权限
    String Delay_Favourable = "readonly";        //a042  滞纳金费优惠
    String Predel_Favourable = "readonly";       //a041  补收月租费优惠
    String Should_Favourable = "readonly";       //a047  本金优惠
	//xl add for jiyu 202号码金额可改 其他金额是固定的
	String s_money_readonly="";
	if(phoneNo.substring(0,3)=="202" || phoneNo.substring(0,3).equals("202"))
	{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaa 202号码");
	}
	else
	{
		System.out.println("bbbbbbbbbbbbbbbbbbbbbbbb not 202");
		s_money_readonly="readonly";
	}
    int infoLen = favInfo.length;
    String tempStr = "";
    for(int i=0;i<infoLen;i++)
    {
        tempStr = (favInfo[i][0]).trim();
       
        if(tempStr.compareTo("a042") == 0)
        {
             Delay_Favourable = "";
        }
        if(tempStr.compareTo("a041") == 0)
        { 
            Predel_Favourable = ""; 
        }   
        if(tempStr.compareTo("a047") == 0)
        { 
            Should_Favourable = ""; 
        }   
 	}
 	
 	String op_code = null;
 	String busyName=null;
	if ( busyType.equals("1") )
	{
		op_code="1354";
		busyName="陈帐回收";
	}
	else
	{
		op_code="1358";
		busyName="死帐回收";
	}

		String[] inParas = new String[6];
		inParas[0] = phoneNo;
        inParas[1] = idno;
        inParas[2] = org_code;
        inParas[3] = op_code;
        inParas[4] = workno;
        inParas[5] = nopass;
  
	    //int [] lens ={13,7};
        //CallRemoteResultValue  value  = viewBean.callService("2", phoneNo,  "s1354Query", "20"  ,   lens , inParas , map) ;
%>
		<wtc:service name="s1354Query" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="20">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
		</wtc:service>
		<wtc:array id="result" start="0" length="13" scope="end"/>
		<wtc:array id="result2" start="13" length="7" scope="end"/>
<%  
		String return_code = retCode1;
		String return_msg = retMsg1;
		
		String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
		System.out.println("------------------------------result1---length------------------------------"+result.length);
 		if (result.length!=0){
 			for(int i=0; i<13;i++){
 				 System.out.println(i+"------------------------------result1[i][0]---------------------------------"+result[0][i]);
 			}
 		}
 		System.out.println("------------------------------result2--length-------------------------------"+result2.length);
 		if (result2.length!=0){
 			for(int i=0; i<7;i++){
 				 System.out.println(i+"------------------------------result2[i][0]---------------------------------"+result2[0][i]);
 			}
 		}
       if (return_code.equals("000000"))
       {
			if (result2.length!=0)
	       {
 System.out.println("------------------------------result2[][]---------------------------------"+result2[0][0]);
				double sDeservedFee = 0;      //合计应收
				double sOweFee = 0;             //欠费
				double sPayMoney =0;          //缴费
			 
				double sum_delayfee=0.00;
				double sum_usefee=0.00;

 				double sPrePayFee=Double.parseDouble(result[0][6]);

				 double  sPredelFee =   Double.parseDouble(result[0][8]);

				for (int i=0; i < result2.length;i++)
				{
					sum_usefee = sum_usefee + Double.parseDouble(result2[i][1]);
					sum_delayfee = sum_delayfee + Double.parseDouble(result2[i][2]);
				}



			     sOweFee = sum_usefee+sum_delayfee ;

				if (sOweFee<=sPrePayFee)
			       sDeservedFee=0; 
				else 
                   sDeservedFee=sOweFee-sPrePayFee;

				sDeservedFee = (double) Math.round(sDeservedFee*100)/100;  //四舍五入
				sPayMoney = sDeservedFee;   

				
				
				String TBigFlag = null;
				String TGroupFlag = null;

				String userType = result[0][3];
				
				if (userType.substring(0,2).equals("01") )
				{
					TBigFlag = "钻石卡客户";
				}
				else if (userType.substring(0,2).equals("02") )
				{
					TBigFlag = "金卡客户";
				}
				else if (userType.substring(0,2).equals("03") )
				{
					TBigFlag = "银卡客户";
				}
				else if (userType.substring(0,2).equals("04") )
				{
					TBigFlag = "贵宾卡客户";
				}
				else if (userType.substring(0,2).equals("05") )
				{
					TBigFlag = "大客户";
				}
				else
				{
					TBigFlag = "普通客户";
				}
				if ( userType.substring(2,3).equals("0"))
				{
					TGroupFlag = "非集团客户";
				}
				else if (userType.substring(2,3).equals("1"))
				{
					TGroupFlag = "集团普通客户";
				}
				else if (userType.substring(2,3).equals("2"))
				{
					TGroupFlag = "集团中高价值客户";
				}
				else if (userType.substring(2,3).equals("3"))
				{
					TGroupFlag = "集团中的大客户";
				}
          %>

<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
 
<title>黑龙江BOSS-陈帐.死帐回收</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function init()
{
     document.frm.payMoney.select();
	 
	 if(document.all.s_phone_no.value.substr(0,3)=="202")
	 {
		// alert("202");ssje
		 //document.getElementById("jsid").style.display="block";
		 document.getElementById("ssje").style.display="none";
	 }	
	 else
	 {
		// alert("not 202");
		// document.getElementById("jsid").style.display="none";
		document.getElementById("ssje").style.display="block";
	 }	
}
			   //-->
</SCRIPT>
<BODY onload="init()">
<FORM action="" method="post" name="frm">
	<%@ include file="/npage/include/header.jsp" %>  
	
	<div class="title">
		<div id="title_zi">客户信息</div>
	</div>
<INPUT TYPE="hidden" name="unitCode" value="<%=org_code%>">
<INPUT TYPE="hidden" name="opCode" value="<%=op_code%>">
<INPUT TYPE="hidden" name="opCodeAll" value="<%=opCode%>">
<INPUT TYPE="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="sumusefee"  value="<%=sum_usefee%>">
<input type="hidden" name="busyType"  value="<%=busyType%>">
<input type="hidden" name="sumdelayfee"   value="<%=sum_delayfee%>">
<input type="hidden" name="s_phone_no"   value="<%=phoneNo%>">
<input type="hidden" name="id_no"  value="<%=idno%>">

<table cellspacing="0">
	<tr> 
	    <td class="blue">操作类型</td>
	    <td colspan="3"><%=busyName%></td>
	</tr> 
	<tr> 
		<td class="blue">服务号码</td>
		<td> 
		  	<input type="text" readonly class="InputGrey" name="phoneNo" value=<%=phoneNo%>  onKeyPress="return isKeyNumberdot(0)">
		</td>
		<td class="blue">客户名称</td>
		<td> 
		  	<input type="text" name="custName" readonly class="InputGrey" value=<%=result[0][2]%>>
		</td>
	</tr>
	<tr> 
		<td class="blue">付费帐户</td>
		<td> 
		  	<input type="text" readonly class="InputGrey"  name="contractno" value=<%=result[0][5]%>>
		</td>
		<td class="blue">归属地区</td>
		<td> 
		  	<input type="text" class="InputGrey"  readonly name="regionName" value=<%=result[0][10]%>>
		</td>
	</tr>
	<tr> 
		<td class="blue">大客户标志</td>
		<td> 
		  	<input type="text"  class="InputGrey" name="custType" readonly value="<%=TBigFlag%>">
		</td>
		<td class="blue">集团标志</td>
		<td> 
		  	<input type="text"  class="InputGrey" name="creditStand" readonly value="<%=TGroupFlag%>">
		</td>
	</tr>
	<tr class="blue"> 
		<td>预存款</td>
		<td> 
		  	<input type="text"  readonly class="InputGrey" name="prepayFee" value=<%=sPrePayFee%>>
		</td>
		<td class="blue">补收月租</td>
		<td> 
		  	<input type="text"  readonly class="InputGrey" name="predelFee" value="<%=sPredelFee%>" >
		</td>
	</tr>
	<tr class="blue"> 
		<td class="blue">拆机时间</td>
		<td colspan="3"> 
		  	<input type="text"  readonly class="InputGrey" name="removeTime" value=<%=result[0][11]%>>
		</td>
	</tr>
</table>
</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">欠费信息</div>
</div>
	
<table cellspacing="0">
	<tr> 
    <th nowrap> 
      <div align="center">欠费月</div>
    </th>
    <th nowrap> 
      <div align="center">欠费金额</div>
    </th>
    <th nowrap> 
      <div align="center">滞纳金</div>
    </th>
    <th nowrap> 
      <div align="center">应收金额</div>
    </th>
    <th nowrap> 
      <div align="center">优惠金额</div>
    </th>
    <th nowrap> 
      <div align="center">预存划拨</div>
    </th>
    <th nowrap> 
      <div align="center">新缴款</div>
    </th>
  </tr>
  
<%
	String tdClass="";
  for (int i=0;i<result2.length;i++){
	if (i%2==1) {
		tdClass="";
%>
        <tr>
<%
  	}else {
  		tdClass="Grey";
%>
        <tr>
<%
  	}
%>
    	  <td class="<%=tdClass%>">
          	<div align="center"><%=result2[i][0]%></div>
          </td>
          <td class="<%=tdClass%>">
            <div align="center"><%=result2[i][1]%></div>
          </td>
          <td class="<%=tdClass%>">
            <div align="center"><%=result2[i][2]%></div>
          </td>
          <td class="<%=tdClass%>">
            <div align="center"><%=result2[i][3]%></div>
          </td>
          <td class="<%=tdClass%>">
            <div align="center"><%=result2[i][4]%></div>
          </td>
          <td class="<%=tdClass%>">
            <div align="center"><%=result2[i][5]%></div>
          </td>
          <td class="<%=tdClass%>">
            <div align="center"><%=result2[i][6]%></div>
          </td>

  </tr>
  <%}%>
</table>
</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">操作信息</div>
</div>      
<table cellspacing="0">
	<tr> 
		<td class="blue">合计应收</td>
		<td> 
		  	<input type="text"  class="InputGrey" name="deservedFee" readonly value=<%=sDeservedFee%>>
		</td>
		<td class="blue">滞纳金优惠率</td>
		<td> 
		  	<input type="text" name="delayRate" value="0" onBlur="CheckRate(this, '滞纳金优惠率')"  onKeyPress="return isKeyNumberdot(1)" <%=Delay_Favourable%>>
		</td>
		<td class="blue">补收月租优惠率</td>
		<td> 
		  	<input type="text"  name="remonthRate" onBlur="CheckRate(this, '补收月租优惠率')"  onKeyPress="return isKeyNumberdot(1)" value="0" <%=Predel_Favourable%>>
		</td>
	</tr>
	<tr> 
		<td class="blue">缴费方式</td>
		<td> 
			<select name="moneyType" onclick="selType()">
				<option value="0">现金缴费</option>
				<option value="9">支票缴费</option>
			</select>
		</td>
		<td class="blue">缴费金额</td>
		<td> 
		  	<input type="text" name="payMoney" value="<%=sPayMoney%>" onKeyPress="return isKeyNumberdot(1)" onkeydown="if(event.keyCode==13) DoCheck();" <%=s_money_readonly%>>
	<!--
			<input type="button" id="jsid" name="docount" value="计算" onclick="dojisuan()">
	-->
		</td>
		<td class="blue">本金优惠</td>
		<td> 
		  	<input type="text" name="payMoneyShort"  value="0" onBlur="accountFactMoney()" onKeyPress="return isKeyNumberdot(2)" <%=Should_Favourable%>>
		</td>
	</tr>
	<tr id="CheckId" style="display:none" > 
		<td class="blue" nowrap>银行代码</td>
		<td nowrap> 
			<input name="BankCode" size="10" readOnly>
			<input name="BankName" onkeydown="if(event.keyCode==13) getBankCode();" size="10">
			<input name="bank1CodeQuery" type=button class="b_text" id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value=查询>
		</td>
		<td class="blue" nowrap>支票号码</td>
		<td nowrap> 
			<input type="text" name="checkNo" value="" size="10" onKeyDown="if(event.keyCode==13)getcheckfee();" onChange="document.frm.currentMoney.value=''">
			<input name=checkfeequery type=button class="b_text" style="cursor:hand" onClick="getcheckfee()" value=查询>
		</td>
		<td class="blue">可用金额</td>
		<td> 
		  	<input type="text" class="InputGrey" name="currentMoney" readonly>
		</td>
	</tr>
	<tr id="ssje"> 
		<td class="blue">实收金额</td>
		<td colspan="5">
			<input type="text" value="<%=sPayMoney%>" class="button" name="factMoney" readonly>		   
		</td>
	</tr> 
	<tr> 
		<td class="blue">用户备注</td>
		<td colspan="5"> 
			<input type="text" name="payNote" class="InputGrey" onFocus="setOpNote();" size="30" readOnly>
		</td>
	</tr>
	<tr> 
		<td id="footer" colspan="6"> 
		<div align="center"> 
			<input type="button" name="print" class="b_foot" value="确认&打印" onclick="return doprint();">
			<input type="button" name="return1" class="b_foot" value="返回" onClick="javascript:window.history.go(-1);">
			<input type="button" name="close1" class="b_foot" value="关闭" onClick="removeCurrentTab()">
		</div>
		</td>
	</tr>
</table>
        <%@ include file="/npage/include/footer.jsp" %>
</form>
<SCRIPT LANGUAGE="JavaScript">
<!--
function accountFactMoney() {   
   var payMoney = parseFloat(document.frm.payMoney.value);
   var payMoneyShort = parseFloat(document.frm.payMoneyShort.value);
   var factMoney = payMoney + payMoneyShort;
   
   document.frm.factMoney.value = formatAsMoney(factMoney);
}
/******为备注赋值********/
function setOpNote(){
	if(document.frm.payNote.value=="")
	{
	  document.frm.payNote.value = "陈账.死帐回收;号码:"+document.frm.phoneNo.value; 
	}
	return true;
}

//我感觉 这个js得改 应该用输入的值算金额
function dojisuan()
{
	alert("改实收金额的值");
	if(document.all.payMoney.value<document.all.deservedFee.value)
	{
		document.all.factMoney.value=formatAsMoney(parseFloat(document.all.payMoney.value)  +    parseFloat(document.all.sumdelayfee.value)*(1-parseFloat(document.all.delayRate.value)) - parseFloat(document.all.prepayFee.value));
	}
	
}
function countPayMoney()
{
   var paymoney ;
 
   with(document.frm)	
	{
	    paymoney = parseFloat(sumusefee.value)  +    parseFloat(sumdelayfee.value)*(1-parseFloat(delayRate.value)) - parseFloat(prepayFee.value);
        if(paymoney<0)   paymoney = 0;
        deservedFee.value=formatAsMoney(paymoney);
	    payMoney.value = formatAsMoney( paymoney );
	   
    }
}

 function CheckRate(obj , msg)
 {
     var i , j=0;
	 var derate = 0;
 
 
			if(!dataValid( 'b' , obj.value))
		   {
               rdShowMessageDialog("请输入有效的"+msg);
 	           obj.value = 0;
               countPayMoney();
  	           obj.focus();
 	           return false;
		    }
		    derate= parseFloat(obj.value);
 
			if (  derate < 0  ||  derate > 1  )
			{
               rdShowMessageDialog(msg + "只能在0和1之间！");
 	           obj.value = 0;
               countPayMoney();
 	           obj.focus();
 	           return false;
			}
        countPayMoney()	;	
		return true;
 
}


function doCheck()
{
	 var paymoney;
	 var temp ;

     with(document.frm)
     {
 			 paymoney = payMoney.value;

   			if( paymoney=='')
		   {
               rdShowMessageDialog("缴费金额不能为空，请重新输入 !");
   	           payMoney.focus();
 	           return false;
		    }
			if(!dataValid( 'b' , paymoney))
		   {
               rdShowMessageDialog("您输入的是  "+ paymoney +" , 请输入有效的缴费金额！");
   	           payMoney.focus();
 	           return false;
		    }

			if ( paymoney.indexOf(".")!=-1)
			{
				temp =  paymoney.substring(paymoney.indexOf(".")+1,paymoney.length);
 				if ( temp.length > 2 )
				{
					rdShowMessageDialog("缴费金额小数点后只能输入2位！");
					payMoney.focus();
					return false;
				}
			}

            if(parseFloat(paymoney)==0)
		  	{
				rdShowMessageDialog(" 缴费金额应大于0！");
                payMoney.focus();
                return false;
          	}
			//xl add for jiyu 20开头的可以部分缴费
			if(document.all.s_phone_no.value.substr(0,3)!="202")
			{
				if( parseFloat(paymoney) < parseFloat(deservedFee.value) )
				{
					rdShowMessageDialog(" 此笔缴费小于欠费！");
					countPayMoney();
					return false;
				}

			}
       		
			if (moneyType.value=="9")
			{
				
				if(currentMoney.value=="")
				{
					rdShowMessageDialog("请校验支票号码！");
				   document.all.checkNo.focus();
				    return false;

				}
				if (parseFloat(currentMoney.value)<parseFloat(paymoney))
				{
					rdShowMessageDialog("请注意，支票金额不足！");
				   document.all.checkNo.focus();
				   return false;
				}
			}

          payMoney.value = formatAsMoney(paymoney);
          
		  if (payMoneyShort.value > 0) {
		      rdShowMessageDialog("请注意，本金优惠必须为负数！");
			  document.all.payMoneyShort.focus();
			  return false;
		  } else if (payMoneyShort.value < 0) {
		      if (payMoney.value < deservedFee.value) {
		         rdShowMessageDialog("请注意，缴费金额必须大于等于合计应收！");
			     document.all.deservedFee.focus();
			     return false; 
			  }
		  }

		  if (Math.abs(payMoneyShort.value) > deservedFee.value) {
		      rdShowMessageDialog("请注意，本金优惠不能大于合计应收！");
			  document.all.payMoneyShort.focus();
			  return false; 
		  }
            
		  return true;
	 }

}
function doprint()
{
	getAfterPrompt();
	 if(doCheck()==false)
		 return false;
 
	 /*var h=150;
     var w=350;
	 var t=screen.availHeight/2-h/2;
	 var l=screen.availWidth/2-w/2;

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var str=window.showModalDialog('s1300_pre.jsp?phoneNo='+document.frm.phoneNo.value+'&contractno='+document.frm.contractno.value+'&payMoney='+document.frm.payMoney.value+'&countName='+document.frm.custName.value,"",prop);
	if( str!=null)
	{*/
	 
	//var	prtFlag = rdShowConfirmDialog("是否确定缴费？");
	/*
	if(rdShowConfirmDialog==1)
	*/
	 //  var prtFlag=rdShowConfirmDialog("当前发票号码是"+"<%=check_seq%>"+",是否打印发票?");
	 //xl add jiyu 20开头的可以部分缴费 提示缴费金额
	 var payMoney = document.all.payMoney.value;
	 var prtFlag=rdShowConfirmDialog("本次缴费金额"+payMoney+"元,是否确定缴费？");
	   if (prtFlag==1)
	   {
   			setOpNote();
			document.frm.return1.disabled=true;
			document.frm.close1.disabled=true;
			document.frm.print.disabled=true;
			frm.action="PayOldCfm.jsp?check_seq="+"<%=check_seq%>"+"&s_flag="+"<%=s_flag%>"; 
			frm.submit();
	 }
 	    
}

 function selType()
 {
      with(document.frm)
     {
        if ( moneyType.value=="9" )
			CheckId.style.display="block";
		else
 			CheckId.style.display = "none";
	 }
 
 }
function getcheckfee() 
{
	var bankcode = document.all.BankCode.value;
	var checkno = document.all.checkNo.value;
	if (bankcode=="")
	{
		rdShowMessageDialog("请输入或查询银行!");
 	    return false;
	}
	if ((checkno).trim()=="")
	{
		rdShowMessageDialog("请输入支票号码!");
		document.all.checkNo.value="";
	    document.all.checkNo.focus();
	     return false;
    }
 	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	var str=window.showModalDialog('getcheckfee.jsp?bankcode='+bankcode+'&checkno='+checkno,"",prop);
	if( str==null )
		{
 	   		rdShowMessageDialog("没有找到该支票的余额！",0);
		    document.frm.currentMoney.value = "";
	   		document.frm.checkNo.focus();
	   		return false;
		}
 
		document.frm.currentMoney.value = str;
 		document.all.print.focus();
	    return true;
 }

function getBankCode()
{
 		 var h=480;
		 var w=650;
		 var t=screen.availHeight/2-h/2;
		 var l=screen.availWidth/2-w/2;

	      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
          var returnValue=window.showModalDialog('getBankCode.jsp?region_code=<%=org_code.substring(0,2)%>&district_code=<%=org_code.substring(2,4)%>&bank_name='+frm.BankName.value+'&bank_code='+frm.BankCode.value,"",prop);

          document.frm.currentMoney.value='';		 
 		  if(returnValue==null)
	     {
             rdShowMessageDialog("你输入的条件没有查到相应的银行！");
			document.frm.BankCode.value="";
			document.frm.BankName.value="";
             return false;
		  }

 		  if(returnValue=="")
	     {
             rdShowMessageDialog("您没有选择银行！");
			document.frm.BankCode.value="";
			document.frm.BankName.value="";
             return false;
		  }
		 else
		 {			
			 var chPos_str = returnValue.indexOf(",");
			 document.frm.BankCode.value=returnValue.substring(0,chPos_str);
			 document.frm.BankName.value=returnValue.substring(chPos_str+1);
   		 }
}

function dataValid(flag,v,p1){
	switch(flag){
		case 'a':
			re = /^\s*$/;
			return re.test(v);
			break;
		case 'b':
			re = /^(-|\+)?\d+(\.\d+)?$/;
			return re.test(v);
			break;
		case 'c':
			re = /^\d+(\.\d+)?$/;
			return re.test(v);
			break;
		case 'd':
			re = /^(-|\+)?\d+$/;
			return re.test(v);
			break;
		case 'e':
			re = /^\d+$/;
			return re.test(v);
			break;
		case 'f':
			return getISOLength(v) > p1 ? true : false;
			break;
	}
	return false;
}
 //-->
</SCRIPT>

</body>
</html>
<%  }
          else
			{	System.out.println("------------------------------else!!!---------------------------------"+result2.length);
				%>
				<script language="JavaScript">
					  rdShowMessageDialog("该用户没有需要回收的<%=busyName.substring(0,2)%>。",0);
					  history.go(-1);
				</script>
		  <%
		    }
}
else
{	%>
		<script language="JavaScript">
			 rdShowMessageDialog("查询错误! <br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=return_msg%>'。",0);
			 history.go(-1);
		</script>
<%
}
%>
