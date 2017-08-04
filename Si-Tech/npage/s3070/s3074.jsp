
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-13
********************/
%>

<%
  String opCode = "3074";
  String opName = "换卡";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.s1310.viewBean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String orgcode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");

	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String opcd = "3074"  ;

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" />
<HTML><HEAD><TITLE>黑龙江BOSS-过期卡换卡</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
<script language="JavaScript">
<!--


function doCommit()
{
	var count=parseInt(form.lines.value);
	var count1=parseInt(form.lines1.value);

	var str;
	var str1;
	var ret;
	if (count<=1)
	{
		str=document.form.card_no.value;
	}
	else
	{
		str ="";
		for (i=0;i<count-1;i++){
			str+=document.form.card_no[i].value+"|";
		}
		str+=document.form.card_no[count-1].value;
	}
	document.form.card_str.value = str;

	if (count1<=1)
	{
		str1=document.form.card_no1.value;
	}
	else
	{
		str1 ="";
		for (i=0;i<count1-1;i++){
			str1+=document.form.card_no1[i].value+"|";
		}
		str1+=document.form.card_no1[count1-1].value;
	}
	/* 20090325 liyan add */
	var sum_hand_fee = document.form.sum_hand_fee.value;
	if( sum_hand_fee=='')
    {
       rdShowMessageDialog("手续费不能为空，请重新输入 !");
       document.form.sum_hand_fee.focus();
       return false;
    }
	if(!dataValid( 'b' , sum_hand_fee))
    {
       rdShowMessageDialog("您输入的是  "+ sum_hand_fee +" , 请输入有效的手续费！");
       document.form.sum_hand_fee.focus();
       return false;
    }
	if ( sum_hand_fee.indexOf(".")!=-1)
	{
		var temp =  sum_hand_fee.substring(sum_hand_fee.indexOf(".")+1,sum_hand_fee.length);
		if ( temp.length > 2 )
		{
			rdShowMessageDialog("手续费小数点后只能输入2位！");
			document.form.sum_hand_fee.focus();
			return false;
		}
	}

    if(parseFloat(sum_hand_fee) < 0)
  	{
		rdShowMessageDialog(" 手续费不能为负数！");
        document.form.sum_hand_fee.focus();
        return false;
  	}

	/* 20090325 liyan end */


	document.form.card_str1.value = str1;
	form.action="s3074_2.jsp";


	 ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");

     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？')==1)
        {
		    form.submit();
        }


	    if(ret=="remark")
	    {
         if(rdShowConfirmDialog('确认要提交信息吗？')==1)
         {
		    form.submit();
         }
	   }
	 }
    else
    {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
		    form.submit();
       }
    }

    return true;
}


 function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框
     var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;

     var printStr = printInfo(printType);

     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
     var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
     var ret=window.showModalDialog(path,"",prop);
     return ret;
  }

  function printInfo(printType)
  {

    var retInfo = "";
	var count=parseInt(form.lines.value);
	var count1=parseInt(form.lines1.value);

	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	retInfo+=""+"|";
    retInfo+=""+"|";
    retInfo+=""+"|";
    retInfo+=""+"|";
    retInfo+=""+"|";
    retInfo+="旧卡卡号："+"|";
	if (count<=1)
	{
		    retInfo+=document.form.card_no.value+"|";
	}
	else
	{
		for (i=0;i<=count-1;i++){
		retInfo+=document.form.card_no[i].value+"|";	
		}
	}
    retInfo+="新卡卡号："+"|";
	if (count1<=1)
	{
		    retInfo+=document.form.card_no1.value+"|";
	}
	else
	{
		for (i=0;i<=count1-1;i++){
		retInfo+=document.form.card_no1[i].value+"|";	
		}
	}
	retInfo+=""+"|";
    retInfo+=""+"|";
	retInfo+=""+"|";
	retInfo+=""+"|";
	retInfo+=""+"|";

	return retInfo;
  }

function isKeyNumberdot(ifdot)
{
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if(s_keycode>=48 && s_keycode<=57)
			return true;
		else
			return false;
    else
    {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
		{
		      return true;
		}
		else if(s_keycode==45)
		{
		    rdShowMessageDialog('不允许输入负值,请重新输入!');
		    return false;
		}
		else
			  return false;
    }
}


function compsum()
{
	var count=parseInt(form.lines.value);
	var count1=parseInt(form.lines1.value);
	var i=0;
	var countmoney=0;
	var hand_fee = count*0;
	var newmoney=0;
	if(count<=1)
	{
		countmoney+=parseFloat(form.money.value);
	}
	else
	{
		for (i=0;i<count;i++){
			countmoney+=parseFloat(form.money[i].value);
		}
	}

	if(count1<=1)
	{
		newmoney+=parseFloat(form.money1.value);
	}
	else
	{
		for (i=0;i<count1;i++){
			newmoney+=parseFloat(form.money1[i].value);
		}
	}

	if (countmoney==newmoney){
		form.infilling_number.value=count;
		form.infilling_price.value=countmoney;
		form.sum_hand_fee.value=hand_fee;
		form.sure.disabled=false;
		return true;
	}else if (countmoney>newmoney){
		rdShowMessageDialog("过期卡总金额大于新卡金额，请核查！");
		return false;
	}else if (countmoney<newmoney){
		rdShowMessageDialog("过期卡总金额小于新卡金额，请核查！");
		return false;
	}
}


function dotest(a){
	var h=480;
	var w=650;
	var str;
	var aa=parseInt(a.parentElement.parentElement.parentElement.rowIndex)-2;
	var bb=parseInt(form.lines.value);

	if(parseInt(bb) > 1)
	{
		if(document.form.card_no[aa].value.length<1){
			rdShowMessageDialog("请输入过期卡卡号！",0);
			document.form.card_no[aa].focus();
			return false;
		}
	}
	else
	{
		if(document.form.card_no.value.length<1){
			rdShowMessageDialog("请输入过期卡卡号！",0);
			document.form.card_no.focus();
			return false;
		}
	}

	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

	if(parseInt(bb) > 1)
		str=window.showModalDialog('getprice.jsp?card_no='+document.form.card_no[aa].value+'&card_type=1',"",prop);
	else
		str=window.showModalDialog('getprice.jsp?card_no='+document.form.card_no.value+'&card_type=1',"",prop);
	var tmp=str.substring(0,1);
	if( typeof(str) != "undefined" ){
		if (parseInt(tmp)==1){
				rdShowMessageDialog(str.substring(1,str.length-1),0);
				document.location.replace("s3074.jsp");
	   	}else{
	   		if (parseInt(bb) >1){
				document.form.money[aa].value = str.substring(1,str.indexOf("||"));
				document.form.stop_time[aa].value = str.substring(str.indexOf("||")+2);
			}else {
				document.form.money.value = str.substring(1,str.indexOf("||"));
				document.form.stop_time.value = str.substring(str.indexOf("||")+2);
			}
		}
	}
}
function dotest1(a){
	var h=480;
	var w=650;
	var str;
	var aa=parseInt(a.parentElement.parentElement.parentElement.rowIndex)-2;
	var bb=parseInt(form.lines1.value);

	if(parseInt(bb) > 1)
	{
		if(document.form.card_no1[aa].value.length<1){
			rdShowMessageDialog("请输入过期卡卡号！",0);
			document.form.card_no1[aa].focus();
			return false;
		}
	}
	else
	{
		if(document.form.card_no1.value.length<1){
			rdShowMessageDialog("请输入过期卡卡号！",0);
			document.form.card_no1.focus();
			return false;
		}
	}


	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

	if(parseInt(bb) > 1)
		str=window.showModalDialog('getprice.jsp?card_no='+document.form.card_no1[aa].value+'&card_type=2',"",prop);
	else
		str=window.showModalDialog('getprice.jsp?card_no='+document.form.card_no1.value+'&card_type=2',"",prop);
	var tmp=str.substring(0,1);
	if( typeof(str) != "undefined" ){
		if (parseInt(tmp)==1){
	   		rdShowMessageDialog(str.substring(1,str.length-1),0);
	   		document.location.replace("s3074.jsp");
	   	}else{
	   		if (parseInt(bb) >1){
				document.form.money1[aa].value = str.substring(1,str.indexOf("||"));
				document.form.stop_time1[aa].value = str.substring(str.indexOf("||")+2);
				}else {
				document.form.money1.value = str.substring(1,str.indexOf("||"));
				document.form.stop_time1.value = str.substring(str.indexOf("||")+2);
			}
		}
	}
}
/*function dotest1(){
	if(document.form.card_no1.length<1){
		rdShowMessageDialog("请输入新卡卡号！",0);
		document.form.card_no1.focus();
		return false;
	}
	var h=480;
	var w=650;
	var str;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	str=window.showModalDialog('getprice.jsp?card_no='+document.form.card_no1.value,"",prop);
	var tmp=str.substring(0,1);
	if( typeof(str) != "undefined" ){
		if (parseInt(tmp)==1)
	   		rdShowMessageDialog("该卡不存在！",0);
	   	else{
			document.form.money1.value = str.substring(1,str.indexOf("||"));
			document.form.stop_time1.value = str.substring(str.indexOf("||")+2);
		}
	}
}*/


function dynDelRow(){
	var bb=parseInt(form.lines.value);
	if( bb<=1)
	{
		rdShowMessageDialog("最后一行不许删除！！");
		return false;
	}
	else {
		dyntb.deleteRow();
		document.form.inp.disabled=false;
		document.form.lines.value=bb-1;
	}
}

function dynAddRow(){
	form.lines.value=parseInt(form.lines.value)+1;
	var tr1=dyntb.insertRow();
    tr1.id="tr";

//  sunzx 20070514 屏蔽
//    tr1.insertCell().innerHTML = '<td height="25" ><div align=center><input type=button name=del_line size=4 value=× onClick="dynDelRow()"></div></td>';
    tr1.insertCell().innerHTML = '<td height="25" ><div align=center><input type=text name=card_no size=20 class=button  onKeyPress="return isKeyNumberdot(1)"></div></td>';
    tr1.insertCell().innerHTML = '<td><div align=center><input type=button class=b_text name=test value=验证 onClick="dotest(this)"></div></td>';
    tr1.insertCell().innerHTML = '<td><div align=center><input type=text readonly name=money size=20 class=button maxlength=20></div></td>';
    tr1.insertCell().innerHTML = '<td><div align=center><input type=text readonly name=stop_time size=20 class=button maxlength=20></div></td><td>';  		//document.form.inp.disabled=true;
}

function dynAddRow1(){

	form.lines1.value=parseInt(form.lines1.value)+1;
	var tr2=dyntb1.insertRow();
    tr2.id="tr";

//    sunzx 20070514 屏蔽
//    tr2.insertCell().innerHTML = '<td  width="6%"  height="25" ><div align="center"><input type=button name=del_line1 size=4 value=× ></div></td>';
    tr2.insertCell().innerHTML = '<td width="30%" height="25" ><div align="center"><input type="text" name="card_no1" maxlength="20"  onkeydown="if(event.keyCode==13)document.form.passwd.focus()" onKeyPress="return isKeyNumberdot(0)"></div></td>';
    tr2.insertCell().innerHTML = '<td width="19%" ><div align="center"><input  name="test1" type=button value=验证  class=b_text onClick="dotest1(this);"></div></td>';
    tr2.insertCell().innerHTML = '<td  width="19%" ><div align="center"><input type=text readonly name="money1" size=20 class=button maxlength=20></div></td>';
    tr2.insertCell().innerHTML = '<td  width="26%" ><div align="center"><input type=text readonly name="stop_time1" size=20 class=button maxlength=20></div></td>';  		//document.form.inp.disabled=true;
}


function form_load1()
{
	form.sure.disabled=true;

	<%System.out.println("ljx222");%>

	dynAddRow();
	dynAddRow1();
}

function gohome()
{
	document.location.replace("s3074.jsp");
}

function doclear()
{
	document.location.replace("s3074.jsp");
}
// -->
</script>
</HEAD>
<BODY onLoad="form_load1()">
<FORM action="s3074_2.jsp" method=post name="form">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">过期卡换卡</div>
	</div>

<input type="hidden" name="lines" value="0">
<input type="hidden" name="lines1" value="0">
<INPUT TYPE="hidden" name="card_str" value="">
<INPUT TYPE="hidden" name="card_str1" value="">
<input type="hidden" name="billdate" value="<%=dateStr%>">
<input type="hidden" name="op_code" value="<%=opcd%>">
<input type="hidden" name="org_code" value="<%=orgcode%>">
<input type="hidden" name="optype" value="1">
<input type="hidden" name="sysAccept" value="<%=sysAcceptl%>"> <!--liyan add 20090325 -->
	           <table id="dyntb"  cellspacing="0">

              <tr width="6%">

                <td width="30%" height="25"  class="blue">
                  <div align="center">过期卡号</div>
                </td>
                <td  width="19%" class="blue" >
                  <div align="center" >验证</div>
                </td>
                <td width="19%"  class="blue">
                  <div align="center">面值</div>
                </td>
                <td  width="26%"  class="blue">
                  <div align="center">有效期</div>
                </td>
              </tr>
            </table>

			<table id="dyntb1" cellspacing="0" >

			   <tr>

                <td  width="30%" height="25"  class="blue">
                  <div align="center">新卡卡号</div>
                </td>
                <td  width="19%"  class="blue">
                  <div align="center">验证</div>
                </td>
                <td width="19%"  class="blue">
                  <div align="center">面值</div>
                </td>
                <td  width="26%" class="blue">
                  <div align="center" >有效期</div>
                </td>
              </tr>
            </table>
              <table cellspacing="0">
      					<tr>
                  <td width="36%" class="blue">
                    <div align="center">过期卡总张数
                      <input type="text" readonly name="infilling_number" size="14" >
                    </div>
                  </td>
                  <td width="38%" class="blue">
                    <div align="center">过期卡总面值
                      <input type="text" readonly name="infilling_price" size="14" >
                    </div>
                  </td>
                  <td width="26%" class="blue">
                    <div align="center">手续费
                      <input type="text" name="sum_hand_fee" size="14">
                    </div>
                  </td>
                </tr>
              </table>
            <table cellspacing="0">
              <tbody>
              <tr >
                <td align=center width="98%" id="footer">
                  <input  name="comp" type=button value=计算 onclick="if(compsum());" class="b_foot">
				  &nbsp;
				  <input  name="clear" type=reset value=清除 onclick="doclear()" class="b_foot">
				  &nbsp;
                  <input  name="sure" type=button value=确认  onclick="doCommit();" class="b_foot">
                  &nbsp;
				  <input  name="reset" type=button value=返回 onClick="gohome()" class="b_foot">
				  &nbsp;
                </td>
              </tr>
              </tbody>
            </table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
