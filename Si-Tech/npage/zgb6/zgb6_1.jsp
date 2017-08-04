<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 账户转账1364
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<%
	String opCode="zgb6";
	String opName="帐户转帐(非实名)";
	String phoneno = (String)request.getParameter("activePhone");
	String orgCode = (String)session.getAttribute("orgCode");
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");
	String[] favStr = new String[favInfo.length];
  for(int i=0;i<favStr.length;i++) {
       favStr[i]=favInfo[i][0].trim();
	}
	  boolean pwrf = false;
    if(WtcUtil.haveStr(favStr,"a272")){
	  	pwrf=true;
	  }
	String sql_reason="select reason_node,reason_code from Sreasoncode where op_code='1364' and reason_class='1'  ";
	Date date = new Date();//获取当前时间  
	Calendar calendar = Calendar.getInstance();  
	calendar.setTime(date);  
	calendar.add(Calendar.YEAR,0);//当前时间减去一年，即一年前的时间  
	calendar.add(Calendar.MONTH,0);//当前时间前去一个月，即一个月前的时间  
	calendar.getTime();//获取一年前的时间，或者一个月前的时间 
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(calendar.getTime());
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>帐户转帐(非实名)</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<!--
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
-->
<script language="JavaScript">
<!--
function loads()
{
	document.getElementById("groupId").style.display="none";
	document.getElementById("groupId").style.display="none";
	document.getElementById("reason_id").style.display="none";
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

function docheck()
{
	//xl add for 一二级原因
	var reason1 = document.all.reason1.value;
	var reason2 = document.all.reason2.value;
	var reason2_txt = document.all.otherReason.value;
	//alert("reason1 is "+reason1+" and reason2 is "+reason2+" and reason2_txt is "+reason2_txt);
	//xl add for 一二级原因
	var reason1 = document.all.reason1.value;
	var reason2 = document.all.reason2.value;
	var reason2_txt = document.all.otherReason.value;
	//alert("reason1 is "+reason1+" and reason2 is "+reason2);
	
	if(reason1=="0")
	{
		rdShowMessageDialog("请选择转账一级原因");
		return false;
	}	
	else if(reason2=="show" &&reason2_txt=="")
	{
		rdShowMessageDialog("请输入转账二级原因");
		return false;
	}
	else if(reason2=="show" &&reason2_txt.length>64)
	{
		rdShowMessageDialog("转账二级原因长度不可超过64！");
		return false;
	}
	 
	
	
	if(form.phoneno.value==""){
		rdShowMessageDialog("请输入手机号码 !!")
		document.form.phoneno.focus();
		return false;
	}else if(form.contractno.value=="") {
		rdShowMessageDialog("请输入帐号 !!")
		document.form.contractno.focus();
		return false;
	}		/*HARVEST  wangmei xiugai 当判断用户密码后没有进行处理因此进行修改 20060829*/


	else if (!checkPhone(form.phoneno.value) && form.contractno.value.length<5)
	{
		rdShowMessageDialog("<%=PhoneHeadErrMsg%>,或直接输入帐号 !");
		return false;
	}
	else if (!form.cus_pass.disabled) {
	   if( form.cus_pass.value.length<1 || isNumberString(form.cus_pass.value,"1234567890")!=1 ) {
			rdShowMessageDialog("请输入帐户密码!!")
			document.form.cus_pass.focus();
			return false;
	   }else{
	      //document.form.action="s1362_select.jsp?reason1="+reason1+"&reason2_txt="+reason2_txt;
			document.form.action="s1364_select.jsp?reason1="+reason1+"&reason2_txt="+reason2_txt;
			form.submit();
			return true;
	   }
	} else {
		  document.form.action="s1364_select.jsp?reason1="+reason1+"&reason2_txt="+reason2_txt;
		  form.submit();
		  return true;
	 }
}
function getcount()
{
	//xl add for 一二级原因
	/*
	var reason1 = document.all.reason1.value;
	var reason2 = document.all.reason2.value;
	var reason2_txt = document.all.otherReason.value;
	var reason1 = document.all.reason1.value;
	var reason2 = document.all.reason2.value;
	var reason2_txt = document.all.otherReason.value;
	 	
	if(reason1=="0")
	{
		rdShowMessageDialog("请选择转账一级原因");
		return false;
	}	
	else if(reason2=="show" &&reason2_txt=="")
	{
		rdShowMessageDialog("请输入转账二级原因");
		return false;
	}
	else if(reason2=="show" &&reason2_txt.length>64)
	{
		rdShowMessageDialog("转账二级原因长度不可超过64！");
		return false;
	}/**/
	if( form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1 ) {
		rdShowMessageDialog("请输入服务号码,长度为11位数字 !!")
		document.form.phoneno.focus();
		return false;
	}
	else if (parseInt(form.phoneno.value.substring(0,3),10)<134 || (parseInt(form.phoneno.value.substring(0,3),10)>139&&parseInt(form.phoneno.value.substring(0,2),10)!=15&&parseInt(form.phoneno.value.substring(0,2),10)!=18&&parseInt(form.phoneno.value.substring(0,2),10)!=14)){
		rdShowMessageDialog("请输入134-139或是15开头的服务号码 !!")
		document.form.phoneno.focus();
		return false;
	}
	else {
		var h=480;
		var w=850;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		var returnValue=window.showModalDialog('../zgb5/getCountdead.jsp?phoneNo='+document.form.phoneno.value,"",prop);
		//alert(returnValue);
		if( typeof(returnValue) != "undefined" ){
			if (parseInt(returnValue)==0){
		   		rdShowMessageDialog("没有找到对应的帐号！",0);
		   		document.form.phoneno.focus();
		   		return false;
			} else {
				document.form.contractno.value = returnValue.split(",")[0];
				document.form.user_passwd.value = returnValue.split(",")[1];
				document.form.s_id_no.value = returnValue.split(",")[2];
				document.form.khsj.value=returnValue.split(",")[3];
				document.form.cust_name.value=returnValue.split(",")[4];
				 

		   		checkSzm(document.form.user_passwd.value,document.form.s_id_no.value);
			}
			return true;
		}
		else
		{
			rdShowMessageDialog("查询信息不存在!");
			return false;
		}		
	}
}

function checkSzm(u_pass,id_no)
{
	
	var myPacket = new AJAXPacket("../zgb5/checkSMZ.jsp","正在提交，请稍候......");
	myPacket.data.add("u_pass",u_pass);
	myPacket.data.add("phoneno",document.all.phoneno.value);
	//document.all.cus_pass.value
	myPacket.data.add("in_pass",document.all.cus_pass.value);	//输入的密码
	myPacket.data.add("id_no",id_no);
	//alert("查询出来的u_pass is "+u_pass+" and id_no is "+id_no+" 输入的密码 in_pass is "+document.all.cus_pass.value);
	//alert("u_pass is "+u_pass+" and in_pass is "+document.all.cus_pass.value);
	core.ajax.sendPacket(myPacket,checkKd);
    myPacket=null;
}
function checkKd(packet)
{
	  var s_flag_mm=packet.data.findValueByName("s_flag_mm");//判断密码
	  var s_flag_smz = packet.data.findValueByName("s_flag_smz");//判断实名制
	 // alert("s_flag_mm1 is "+s_flag_mm+" and s_flag_smz is "+s_flag_smz);
	  //s_flag_smz="Y";
	  var phoneno = document.all.phoneno.value;
	  var contractno = document.all.contractno.value;
	  var begin_ym = document.all.begin_ym.value;//这个值要测 改成取小的值
	  var end_ym = document.all.end_ym.value;    //这个值要测 改成取小的值
	  if(s_flag_mm=="Y")
	  {
		  if(s_flag_smz=="Y")//还得加上密码校验通过
		  {
			 //跳转到新的jsp 展示入网时间、sim卡号、客户姓名、交费记录（第1点中的服务）、客户是否出具了交费发票几项。
			 //由营业员提示客户任选其中一项，用户输入对应项后，系统做校验，校验通过才可以进入受理页面
			 //document.form.action="zgb5_select.jsp";
			 //form.submit();
			 document.form.action="zgb6_check.jsp?phoneNo="+phoneno+"&contractNo="+contractno+"&begin_ym"+begin_ym+"&end_ym="+end_ym+"&rwsj="+document.form.khsj.value+"&id_no="+document.form.s_id_no.value+"&user_passwd="+document.form.user_passwd.value;
			 form.submit();
		  }
		  else
		  {
				rdShowMessageDialog("准实名和非实名用户才可以办理此功能!");
				return false;
		  }	
	  }	
	  else
	  {
		  rdShowMessageDialog("请输入正确的用户密码后才可以办理此功能!");
		  return false;
	  }	
	  
} 
function sel2()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "2";
 }
 
 	//  add liuxmc
	function getZZDate(){
    
		var path = "<%= request.getContextPath()%>/npage/s1300/s1364_selectZZ.jsp";
		window.showModelessDialog(path);
	}	
	
	//  end 
//--> 
</script>
</HEAD>
<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=sql_reason%>"/>
 	
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<BODY  >
<FORM action="s1364_select.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="busy_type"  value="2">
<!--xl add 隐藏域 转账号码-->
<input type="hidden" name="phone2">
 <input type="hidden" name="s_id_no">
<input type="hidden" name="user_passwd">
<input type="hidden" name="cust_name"   >
<input type="hidden" name="khsj" >
<input type="hidden" name="end_ym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)">
<input type="hidden" name="begin_ym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)">
	
<table cellspacing="0">
    
	<tr>
		<th>用户类型</th>
		<th>
			 
			<input name="busyType" type="radio" onClick="sel2()" checked value="2">
				销户用户 </th>
		<th colspan="2">部门：<%=orgCode%></th>
	</tr>
	<tr>
		<td class="blue">服务号码</td>
		<td>
			<input type="text" name="phoneno" maxlength="11" onkeydown="if(event.keyCode==13)getcount()" onKeyPress="return isKeyNumberdot(0)">
			<input class="b_text" name=sure22 type=button value=查询帐号 onClick="getcount();">
		</td>
		<td class="blue">帐户号码</td>
		<td>
			<input type="text" class="button" maxlength="20" onKeyPress="return isKeyNumberdot(0)" onkeydown="if(event.keyCode==13)document.form.cus_pass.focus()" name="contractno">
		</td>
	</tr>
	
	<tr>
		<td class="blue">帐户密码</td>
		<td colspan="3">
			 
			<jsp:include page="/npage/common/pwd_one.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="cus_pass"  />
				<jsp:param name="pwd" value="12345"  />
			</jsp:include>
		</td>
	</tr>
	<!--  add liuxmc-->
	<!--xl add begin-->
	<tr id="tfyy">
		<td class="blue">退预存款原因：</td>
		<td class="blue" colspan="3">			
			<select name="reason" style= "width:135px;" onChange="checkReason(this,reason_name,reason_code)">
				<option value="1" selected>强关销户转账</option>
			</select>
		</td>
	</tr>
	 
	<!--xl add end-->
	<tr>
		<td colspan="4">
			<input class="b_text"  type=button value="查询当月账户转账信息" onClick="getZZDate();">
		</td>
	</tr>
	<!-- end
	<tr>
		<td align=center id="footer" colspan="4">
			<input class="b_foot" name=sure type=button value=确认 onclick="docheck()">
			&nbsp;
			<input class="b_foot" name=clear type=reset value=清除>
			&nbsp;
			<input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
			&nbsp;
		</td>
	</tr> -->
</table>
<input type="hidden" name="reason1" value="1">
<input type="hidden" name="reason2">
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>

</HTML>
<script language="javascript">
//定义全局变量
  var reason_name = new Array();
  var reason_code = new Array();//where条件 是 projectCode 要查询显示的是 fee
<%
	System.out.println("qweqwe1888888888888888888888888888881111111111111");
	if(ret_val.length >0){
		for(int m=0;m<ret_val.length;m++)
		  {
			out.println("reason_name["+m+"]='"+ret_val[m][0]+"';\n");
			out.println("reason_code["+m+" ]='"+ret_val[m][1]+"';\n");
		  }
	}
	else{
	System.out.println("qweqwe9888800000000000000000111");
	}

%> 
function checkReason(choose,NameArray,CodeArray)
{
	if(choose.value=="0")
	{
		rdShowMessageDialog("请选择退费原因");
		return false;
	}
	document.all.otherReason.value="";
	//alert("1 "+choose+" 2 "+NameArray+" 3 "+CodeArray);
	for ( x = 0 ; x < CodeArray.length  ; x++ )
    {
	  //alert("CodeArray[x] is "+CodeArray[x]+" and choose.value is "+choose.value);
	  if ( CodeArray[x] == choose.value &&choose.value=="1009" )
	  {
		 document.getElementById("reason_id").style.display="block";
		 document.all.reason1.value=choose.value;
		 document.all.reason2.value="show";
	  }
	  else
	  {
		  document.getElementById("reason_id").style.display="none";
		  document.all.reason1.value=choose.value;
		  document.all.reason2.value="none";
	  }	
    }
	
}
</script>