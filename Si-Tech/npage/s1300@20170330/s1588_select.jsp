<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.16
 模块:神州行余额转帐
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*"%>


<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-神州行转余额转帐</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
	
<%
  String opCode = "1588";
  String opName = "神州行余额转帐";	
  
  String workno = (String)session.getAttribute("workNo");
  String workname = (String)session.getAttribute("workName");
  String[][] favInfo = (String[][])session.getAttribute("favInfo");           //读取优惠资费代码
  String org_code = (String)session.getAttribute("orgCode");
	
  String op = "1588";
  String contractno=request.getParameter("contractno");
  String phoneno = request.getParameter("phoneno"); 
  String thepassword = request.getParameter("i2");;        //获得传来的加密密码
  String pw_favor = "1";		                          //密码优惠权限标志位1:有 0:无
  String pw_flag = request.getParameter("pw_flag");;       //密码验证标志1:无 0:有
	
  String[] inParas = new String[3];
  inParas[0] = contractno;
  inParas[1] = org_code;
  inParas[2] = phoneno;
  int [] lens ={10,4};
%>

<%
  String pw="";
  String i3="";
  String[][] pwResult = new String[][]{};
  String [] pwResult1 = new String [2];
  String ret_code = "";
  String ret_msg = "";
  
//取出用户密码
try{
  //pwArray = callView.s1258InitProcess(workno,phoneno,op,org_code).getList();
%>
	<wtc:service name="s1258Init" routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode1" retmsg="retMsg1" outnum="25">			
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=phoneno%>"/>	
	<wtc:param value="<%=op%>"/>	
	<wtc:param value="<%=org_code%>"/>		
	</wtc:service>	
	<wtc:array id="result1" scope="end"/>
<%
  
   //callView.printRetValue();
  if(result1.length>0){
      pwResult= result1;                                //取出结果集
	  pw = pwResult[0][4];                              //用户密码 
	  i3 = pwResult[0][3];
	}        				  	 
	
    ret_code = retCode1;
    ret_msg  = retMsg1;
	if(ret_msg.equals("")){
		ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
		if( ret_msg.equals("null")){
		  ret_msg ="未知错误信息";
		}
	}
}
catch(Exception e){
  e.printStackTrace();
  System.out.println("Call s1258init services is Failed!");
}

%>

<%
	if(pw_favor.equals("0")){                          //"0"说明无密码优惠权限,需要输入密码,"1"有密码优惠权限则不判断
	   String passTrans=WtcUtil.repNull(thepassword);
	   String passFromPage=Encrypt.encrypt(passTrans);
	   if(i3==""){
%>
	   	<script language='jscript'>
	   	rdShowMessageDialog("用户未找到，请确定您的手机号码为可用！");
	   	history.go(-1);
	   	</script>
<%
	   }
		 if(0==Encrypt.checkpwd2(pw,passFromPage)){
%>
			  <script language='jscript'>
			  rdShowMessageDialog("用户 <%=i3%> 密码错误！",0);
			  history.go(-1);
			  </script>
	<%}}
	if(!ret_code.equals("000000")){
  %>
	  <script language='jscript'>
	    var ret_code = "<%=ret_code%>";
        var ret_msg = "<%=ret_msg%>";
        rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。",0);
        history.go(-1);
      </script>
	<%}	
  //验证密码,不输出页面下方结果
	if(pw_flag.equals("0")){
	   String passTrans=WtcUtil.repNull(thepassword);
	   String passFromPage=Encrypt.encrypt(passTrans); 
	   if(1==Encrypt.checkpwd2(pw,passFromPage)){
	%>
		 	 <script language='jscript'>
			   rdShowMessageDialog("用户 <%=i3%> 密码正确！",0);
			   history.go(-1);
			 </script>
  <%}}%>
  
<%
	String sysAccept = "";
	//CallRemoteResultValue  value = viewBean.callService("1", org_code.substring(0,2) , "s1373Init", "14" ,lens, inParas);
%>
	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneno%>"  id="seq"/>
	
	<wtc:service name="s1373Init" routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode2" retmsg="retMsg2" outnum="14">			
	<wtc:param value="<%=inParas[0]%>"/>	
	<wtc:param value="<%=inParas[1]%>"/>	
	<wtc:param value="<%=inParas[2]%>"/>	
	</wtc:service>	
	<wtc:array id="resultA"  start="0" length="10" scope="end"/>
	<wtc:array id="resultB"  start="10" length="4" scope="end"/>
<%
	//viewBean.printRetValue();
	String[][] result2=null;
	String[][] result=null;
	
	result2 = resultB;
	result = resultA;
	
	String return_code=result[0][0];
	String error_msg =result[0][1]; //SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
	
	String ipath=request.getContextPath();
	
	sysAccept = seq;
%>

<%
if (return_code.equals("136003")) {
%><script language="JavaScript">
	rdShowMessageDialog("该用户为欠费用户，无法转帐",0);
	history.go(-1);
</script>
<%}
if (!return_code.equals("000000")) {
	
%>
<script language="JavaScript">
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=error_msg%>'。",0);
	history.go(-1);
</script>
<%}
	String return_money = result[0][2];
	String cust_name =result[0][3];
	String cur_owe =result[0][4];
	String open_time =result[0][5];
	String flag_date =result[0][6];
	String deposit_fee =result[0][7];
	String hand_fee=result[0][8];
	String favorcode=result[0][9];
	System.out.println("favorcode:"+favorcode);
	
	return_money=return_money.trim();
	cust_name=cust_name.trim();
	cur_owe=cur_owe.trim();
	open_time=open_time.trim();
	flag_date=flag_date.trim();
	deposit_fee=deposit_fee.trim();
	hand_fee=hand_fee.trim();

if (result2.length==0)
{%>
<script language="JavaScript">
	rdShowMessageDialog("查询错误！无结果返回！",0);
	history.go(-1);
</script>
<%}

  //m=0 无手续费更改权限  m!=0 有手续费更改权限
  int m =0;
  for(int p = 0;p< favInfo.length;p++){//优惠代码
		for(int q = 0;q< favInfo[p].length;q++)
		{
		  if(favInfo[p][q].trim().equals(favorcode))
	  	{
				++m;
			}
		}
	}

%>

<script language="JavaScript">
<!--
function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
for (Count=0; Count < InString.length; Count++)  {
	TempChar= InString.substring (Count, Count+1);
	if (RefString.indexOf (TempChar, 0)==-1)  
	return (false);
}
return (true);
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

function form_load()
{
form.phoneno2.focus();
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
   var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
   var sysAccept="<%=sysAccept%>";                            // 流水号
   var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
   var mode_code=null;                                        //资费代码
   var fav_code=null;                                         //特服代码
   var area_code=null;                                        //小区代码
   var opCode="1588";                                         //操作代码
   var phoneNo=document.form.phoneno.value;                   //客户电话

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
}

function printInfo(printType)
{		
    var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4
    var retInfo = "";  //打印内容
	
	cust_info+="手机号码："+document.form.phoneno.value+"|";
	cust_info+="客户姓名："+document.form.contractno3.value+"|";

	opr_info+="帐户号码：" +document.form.contractno.value+"|";
	opr_info+="转存号码："+document.form.phoneno2.value+"|";
	opr_info+="转存帐户："+document.form.contractno2.value+"|";
	opr_info+="办理业务：神州行余额转帐"+"|";
    opr_info+="转存金额："+"<%=return_money%>"+"|";
    opr_info+="手续费："+document.form.hand_fee2.value+"|";
	
	note_info1+="备注："+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
}


function docheck()
{
	getAfterPrompt();
   var v_fee = document.form.return_money.value;  
   var pay_message="转帐金额不能小于0!"; 
   var null_message="转帐金额不能为空!"; 
   var NaN_message="转帐金额应为数字型!";
   var larger_message="转帐金额不能大于帐户剩余金额!";
   var pos;
/*
   if(v_fee == null || v_fee == "") 
   {        
	    rdShowMessageDialog(null_message); 
	    document.form.return_money.select(); 
		return false; 
   } 
   if(v_fee><%=return_money%>) 
   {        
	    rdShowMessageDialog(larger_message); 
	    document.form.return_money.select(); 
		return false; 
   } 
   if(parseFloat(v_fee) <= 0) 
   {        
	    rdShowMessageDialog(pay_message); 
	    document.form.return_money.select(); 
		return false; 
   }        
   if(isNaN(parseFloat(v_fee)))   
   {        
		rdShowMessageDialog(NaN_message); 
	    document.form.return_money.select(); 
	    return false; 
   }
   if(v_fee>9999999999.99)
   {
		rdShowMessageDialog("转帐金额不能大于9999999999.99");
		document.form.return_money.select(); 
		return false;
   }
   
   
   pos=v_fee.indexOf(".");
   if(pos!=-1)
   {
		if(pos>10)
		{
			rdShowMessageDialog("转帐金额小数点前不能大于10位！");
			document.form.return_money.select(); 
			return false;
		}
		if(v_fee.length-pos>3)
		{
			rdShowMessageDialog("转帐金额小数点后不能大于2位！");
			document.form.return_money.select(); 
			return false;
		}
   }
   else
   {
		if(v_fee.length>10)
		{
			rdShowMessageDialog("转帐金额小数点前不能大于10位！");
			document.form.return_money.select(); 
			return false;
		}
   }
*/
if(form.contractno.value.length<5&&( form.phoneno2.value.length<11 || isNumberString(form.phoneno2.value,"1234567890")!=1)) {
	rdShowMessageDialog("请输入服务号码,长度为11位数字,或直接输入帐号 !!")
	document.form.phoneno2.focus();
	return false;
}
else if ((form.contractno.value.length<5)&&(parseInt(form.phoneno2.value.substring(0,3),10)<134 || parseInt(form.phoneno2.value.substring(0,3),10)>139) && (parseInt(form.phoneno2.value.substring(0,2),10) != 15)&& (parseInt(form.phoneno2.value.substring(0,2),10) != 14)&& (parseInt(form.phoneno2.value.substring(0,2),10) != 18)){
	rdShowMessageDialog("请输入134-139开头的服务号码,或1直接输入帐号 !!")
	document.form.phoneno2.focus();
	return false;
}
else if (parseInt(form.contractno2.value.length<5)){
	rdShowMessageDialog("请输入或查询帐户号码 !!")
	document.form.contractno2.focus();
	return false;
}
else if (form.contractno.value==form.contractno2.value)
{
	rdShowMessageDialog("转存帐户不能与原帐户号码一致！");
	document.form.contractno2.select(); 
	//history.go(-1);
	return false;
}
document.form.sure.disabled=true;
document.form.clear.disabled=true;
document.form.reset.disabled=true;
if (document.all.contractno2.value==""){
	rdShowMessageDialog("转存帐户不能为空,请填写!");
				//history.go(-1);
	return false;
}
var ff=rdShowConfirmDialog("该业务不允许冲正,转出号码是: "+document.all.phoneno.value+",  转入号码是: "+document.all.phoneno2.value);
if (ff==false){ return false;}
else{ 
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
  	if(typeof(ret)!="undefined"){
        if((ret=="confirm"))
        {
          if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
          {
	          document.form.submit();
          }
	     }
      if(ret=="continueSub")
      {
	      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	      {
	          document.form.submit();
	      }
      }
   }
   else
   {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
	       document.form.submit();
       }
    }	
	return true; 	    
}
}

function getcount()
{
if( form.phoneno2.value.length<11 || isNumberString(form.phoneno2.value,"1234567890")!=1 ) {
rdShowMessageDialog("请输入服务号码,长度为11位数字 !!")
document.form.phoneno2.focus();
return false;
}
else if ((parseInt(form.phoneno2.value.substring(0,3),10)<134 || parseInt(form.phoneno2.value.substring(0,3),10)>139) && parseInt(form.phoneno2.value.substring(0,2),10) != 15&& parseInt(form.phoneno2.value.substring(0,2),10) != 14&& parseInt(form.phoneno2.value.substring(0,2),10) != 18){
rdShowMessageDialog("请输入134-139开头的服务号码 !!")
document.form.phoneno2.focus();
return false;
}
else {
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	var str=window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneno2.value,"",prop);

	if( typeof(str) != "undefined" ){
		if (parseInt(str)==0){
	   		rdShowMessageDialog("没有找到对应的帐号！",0);
	   		document.form.phoneno2.focus();
	   		return false;}
	   	else {
	   		document.form.contractno2.value=str;
	   		//document.form.return_money.focus();
	   		return true;}
	return true;
}
else{
	rdShowMessageDialog("没有找到对应的帐号！",0);
	   		document.form.phoneno2.focus();
	   		return false;
}
}
}


//-->
</script>
</HEAD>
<BODY onLoad="form_load();">
<FORM action="s1588_2.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">账户信息</div>
		</div>

              <table cellspacing="0">
                <tr> 
                  <td class="blue">服务号码</td>
                  <td> 
                    <input type="text" name="phoneno" maxlength="11" class="InputGrey" readonly value="<%=phoneno%>">
                  </td>
                  <td class="blue">帐户号码</td>
                  <td> 
                    <input type="text" class="InputGrey" readonly name="contractno" value="<%=contractno%>">
                  </td>
                </tr>
                <tr> 
                  <td class="blue">用户姓名</td>
                  <td> 
                    <input type="text" readonly name="contractno3" class="InputGrey" value="<%=cust_name%>">
                  </td>
                  <td class="blue">可退预存款</td>
                  <td><input type="text" readonly name="return_money" class="InputGrey" value="<%=return_money%>"></td>
                </tr>
                <tr> 
                  <td class="blue">欠费</td>
                  <td> 
                    <input type="text" name="cur_owe" maxlength="11" class="InputGrey" readonly value="<%=cur_owe%>">
                  </td>
                  <td class="blue">开户时间</td>
                  <td>
                  <input type="text" name="cur_owe1" maxlength="11" class="InputGrey" readonly value="<%=open_time%>">
                  </td>
                </tr>
                <tr> 
                  <td class="blue">有效期</td>
                  <td> 
                     <input type="text" name="flag_date" maxlength="11" class="InputGrey" readonly value="<%=flag_date%>">
                  </td>
                  <td class="blue">预存款</td>
                  <td>
                 <input type="text" name="deposit_fee" maxlength="11" class="InputGrey" readonly value="<%=deposit_fee%>">
                  </td>
                </tr>
              </table>
         </div>

		<div id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">预存科目</div>
		</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <th> 
                    <div align="center">预存类型</div>
                  </th>
                  <th> 
                    <div align="center">预存金额</div>
                  </th>
                  <th> 
                    <div align="center">顺序</div>
                  </th>
                  <th> 
                    <div align="center">是否可退</div>
                  </th>
                </tr>
				<%
	  for(int y=0;y<result2.length;y++){
if ((y%2)==1) %>

  		<tr>
<%else %>
  		<tr> 
<%  
      for(int j=0;j<result2[0].length;j++){
%>
		<td><div align="center"><%= result2[y][j]%></div></td>
<%	  }
%>
		</tr>
<%
    }
%>
                </tbody> 
              </table>
           </div>

		<div id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">操作信息</div>
		</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue">转存号码</td>
                  <td> 
                    <input type="text" name="phoneno2" maxlength="11" onkeydown="if(event.keyCode==13)getcount()" onKeyPress="return isKeyNumberdot(0)">
                    <input class="b_text" name=sure22 type=button value=查询帐号 onClick="getcount();">
                  </td>
                  <td class="blue">转存帐户</td>
                  <td> 
                    <input type="text" name="contractno2" class="button" onKeyPress="return isKeyNumberdot(0)" onkeydown="if(event.keyCode==13)document.form.return_money.focus()" readOnly>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">可转存金额</td>
                  <td> 
                    <input class="InputGrey" name=remark2 value="<%=return_money%>" readOnly>
                  </td>
                  <td class="blue">转存金额</td>
                  <td> 
                    <input class="InputGrey" name=return_money value="<%=return_money%>" readOnly>
                  </td>
                </tr>
                <tr>
                  <td class="blue">手续费</td>
                	<td colspan=3> 
                	<%if(m==0){%>
                	<input class="InputGrey" name="hand_fee2" value="<%=hand_fee%>" readOnly>
                	<%}else{%>
                	<input class="button" name="hand_fee2" value="<%=hand_fee%>">
                	<%}%>
                	</td>
                </tr>
                <tr style="display:none"> 
                  <td class="blue" >用户备注</td>
                  <td colspan=3> 
                    <input class="button" name=remark value=" 神州行用户余额转帐" size=60 maxlength="60" readOnly>
                  </td>
                </tr>
                </tbody> 
              </table>
            <table cellspacing="0">
              <tbody> 
              <tr> 
                <td id="footer"> 
                  <input class="b_foot" name=sure type=button value=确认&打印 onclick="docheck()">
				  &nbsp;
				  <input class="b_foot" name=clear type=reset value=清除>
				  &nbsp;
                  <input class="b_foot" name=reset type=reset value=返回 onClick="window.history.go(-1)">
                  &nbsp; </td>
              </tr>
              </tbody> 
            </table>
           <%@ include file="/npage/include/footer.jsp" %>      
  <input type="hidden" name="hand_fee" value="<%=hand_fee%>">　<!--手续费优惠标志 0为无优惠 -->
  <input type="hidden" name="favorcode" value="<%=favorcode%>" >　<!--手续费验证标志 0为验正-->
  <input type="hidden" name="sysAccept" value="<%=sysAccept%>" >
 
</FORM>
</BODY>

