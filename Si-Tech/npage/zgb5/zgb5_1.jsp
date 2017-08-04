<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 退预存款1362
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
	
<%
 	String opCode="zgb5";
	String opName=request.getParameter("opName");
	String flag="";
	String flag1="";
	if(opCode.equals("zgb5")){
		flag="checked";
	}else{
		flag1="checked";
	}
	String phoneNo = (String)request.getParameter("activePhone");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
  	//String pwrf1="Y";
    String pwrf1="";
    /*
	Date date = new Date();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMM");
    java.util.Date sourceDate = sdf.parse(dateStr);
	
	Calendar cal = Calendar.getInstance();
	cal.setTime(sourceDate);
	cal.add(Calendar.YEAR,addYear);
	cal.add(Calendar.MONTH, addMonth);
	cal.add(Calendar.DATE, addDate); 
	java.text.SimpleDateFormat returnSdf = new java.text.SimpleDateFormat("yyyyMM");
	String dateTmp = returnSdf.format(calendar.getTime());
	java.util.Date returnDate = returnSdf.parse(dateTmp);*/

	/*
	DateFormat df = new SimpleDateFormat("yyyyMMdd");   
	String now = df.format(date);
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	*/
	Date date = new Date();//获取当前时间  
	Calendar calendar = Calendar.getInstance();  
	calendar.setTime(date);  
	calendar.add(Calendar.YEAR,0);//当前时间减去一年，即一年前的时间  
	calendar.add(Calendar.MONTH,0);//当前时间前去一个月，即一个月前的时间  
	calendar.getTime();//获取一年前的时间，或者一个月前的时间 
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(calendar.getTime());
	//前一年
	Calendar calendar1 = Calendar.getInstance();  
	calendar1.setTime(date);  
	calendar1.add(Calendar.YEAR, -1);//当前时间减去一年，即一年前的时间  
	calendar1.add(Calendar.MONTH,0);//当前时间前去一个月，即一个月前的时间  
	calendar1.getTime();//获取一年前的时间，或者一个月前的时间 
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMM").format(calendar1.getTime());
	
%>
 
	<jsp:param name="opCode" value="zgb5"  />
	<jsp:param name="opName" value="退预存款(非实名)"  />
	</jsp:include>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>黑龙江BOSS-退预存款</title>
	<META content="text/html; charset=gbk" http-equiv=Content-Type>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
</head>
 
<body onLoad="form_load();">
<form action="" method="post" name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="busy_type"  value="2">
	<input type="hidden" name="cust_name"   >
	<div class="title">
		<div id="title_zi">选择用户类型</div>
	</div>
<table cellspacing="0" >
	 
	<tr> 
		<th>操作类型</th>
		<th>
			<input name="busytype" type="radio" onClick="sel1()" value="2" <%=flag%>>
			离网用户退预存
			 
		</th>
		<th colspan="2">部门：<%=orgCode%> </th>
	</tr>
	<tr> 
		<td class="blue">服务号码</td>
		<td> 
			<input type="text" name="phoneno"   onKeyDown="if(event.keyCode==13)docheck()" onKeyPress="return isKeyNumberdot(0)">
		</td>
		<td class="blue">用户密码</td>
		<td>
			<jsp:include page="/npage/common/pwd_one.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="cus_pass"  />
				<jsp:param name="pwd" value="12345"  />
			</jsp:include>
			<input class="b_text" type=button value="查询" onClick="docheck();">
		</td>
	</tr>
	<tr> 
		<td class="blue">帐户号码</td>
		<td> 
			<input type="text" name="contractno" maxlength="20" class="button"  onkeydown="if(event.keyCode==13)docheck()" onKeyPress="return isKeyNumberdot(0)">
		</td>
		<td class="blue">开户时间</td>
		<td>
			<input type="text" name="khsj" class="InputGrey" readonly>
		</td>
	</tr>
	<!--
	<tr> 
		<td class="blue">现有预存金额 </td>
		<td> 
			<input type="text" name="textfield3" class="InputGrey" readonly>
		</td>
		<td class="blue">总欠费 </td>
		<td> 
			<input type="text" name="textfield2" class="InputGrey" readonly>
		</td>
	</tr>
	-->
	<input type="hidden" name="end_ym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)">
	<input type="hidden" name="begin_ym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)">
	<!--	
	<tr> 
		<td class="blue"> 查询缴费记录开始年月(YYYYMM)</td>

		<td>
			</td>
		<td class="blue">查询缴费记录结束年月(YYYYMM)</td>
		<td> 
			
		</td>
	</tr> 
	-->
</table>
<input type="hidden" name="ifKdNo" value="N">
<input type="hidden" name="reason1" value="0">
<input type="hidden" name="reason2">
<input type="hidden" name="s_id_no">
<input type="hidden" name="user_passwd">
	<%@ include file="/npage/include/footer_simple.jsp" %>
	<%@ include file="../../npage/common/pwd_comm.jsp" %>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
</form>
</body>
 <script language="JavaScript">  
 

 
<!--
function form_load(){
	sel1();
}
function sel1()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "2";
 	document.all.opCode.value ="zgb5";
 	document.all.opName.value ="退预存款(非实名)";
 }
 
 
 
 


function docheck()
{
	
	
	//checkSMZ();//判断实名制信息 这个需要id_no 放到后面去校验
	var busy_type=document.all.busy_type.value;
	//alert(busy_type);
	if(form.phoneno.value.length<11 )
	{
		rdShowMessageDialog("请输入服务号码,长度为11位数字 !!")
		document.form.phoneno.focus();
		return false;
	}
  /*
   if ((parseInt(form.phoneno.value.substring(0,3),10)<134) || (parseInt(form.phoneno.value.substring(0,3),10)>139 && parseInt(form.phoneno.value.substring(0,2),10)!=15))
	{
		rdShowMessageDialog("请输入134-139或15X开头的服务号码 !!")
		document.form.phoneno.focus();
		return false;
	 }
	 */
	//密码 非空校验
	if(document.all.cus_pass.value=="")
	{
		rdShowMessageDialog("请输入用户密码!")
		document.form.cus_pass.focus();
		return false;
	}	

	var returnValue;
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
     
	returnValue =window.showModalDialog('getCountdead.jsp?phoneNo='+document.form.phoneno.value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf1%>',"",prop);
	//alert("returnValue is "+returnValue);
	
	if(returnValue=="undefined")
	{
		rdShowMessageDialog("请选择账号信息!");
		document.form.phoneno.focus();
		return false;
	}
	else
	{
		//改为返回三个值 单个解析 账号 密码 和 id_no user_passwd s_id_no
		document.form.contractno.value = returnValue.split(",")[0];
		document.form.user_passwd.value = returnValue.split(",")[1];
		document.form.s_id_no.value = returnValue.split(",")[2];
		document.form.khsj.value=returnValue.split(",")[3];
		document.form.cust_name.value=returnValue.split(",")[4];
		//时间校验 begin
		var begin_ym = document.all.begin_ym.value;
		var end_ym = document.all.end_ym.value;
		var khsj = document.all.khsj.value;
		 
	//	alert("s_y is "+s_y+" and khsj is "+khsj+" and y is "+y);
		//end 时间校验
	//	alert("document.form.contractno.value is "+document.form.contractno.value);
		
		if(document.form.contractno.value=='0')
		 {
			rdShowMessageDialog("帐号或者密码输入错误！",0);
			document.form.phoneno.focus();
			return false;
		 }
		  
		 if(document.form.contractno.value=="")
		 {
			rdShowMessageDialog("你没有选择帐号！",0);
			document.form.phoneno.focus();
			return false;
		  }
		//判断密码是否正确
		
		//判断实名制信息 查询出的密码
		checkSzm(document.form.user_passwd.value,document.form.s_id_no.value);
		
		
	}
	 

}
function checkSzm(u_pass,id_no)
{
	
	var myPacket = new AJAXPacket("checkSMZ.jsp","正在提交，请稍候......");
	myPacket.data.add("u_pass",u_pass);	
	//document.all.cus_pass.value phoneno
	myPacket.data.add("phoneno",document.all.phoneno.value);
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
	//  alert("s_flag_mm1 is "+s_flag_mm+" and s_flag_smz is "+s_flag_smz);
	  s_flag_smz="Y";
	  s_flag_mm="Y";
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
			 document.form.action="zgb5_check.jsp?phoneNo="+phoneno+"&contractNo="+contractno+"&begin_ym"+begin_ym+"&end_ym="+end_ym+"&rwsj="+document.form.khsj.value+"&id_no="+document.form.s_id_no.value;
			 //alert("begin_ym is "+begin_ym);
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
//  add liuxmc
	function getTKDate(){
		
		var time = document.form.reuturn_time.value;
		if(time == "" || time.length==0){
			alert("日期不能为空！");
			return false;
		}
		
		if(time.length != 8){
			alert("对不起，您输入的日期格式不对，请按照正确的格式(YYYYMMDD)填写!");
			return false;
		}

    if(time.length!=0){    
       var reg = /^(\d{1,4})(\d{1,2})(\d{1,2})$/;     
       var r = time.match(reg);     
       if(r==null){
         alert("对不起，您输入的日期格式不正确，请按照正确的格式(YYYYMMDD)填写!");
         return false;
       }
     }
     
		var path = "<%= request.getContextPath()%>/npage/s1300/s1362_selectTK.jsp?time="+time;
		window.showModelessDialog(path);
	}
	
	//  end
 
 

</script>
</HTML>