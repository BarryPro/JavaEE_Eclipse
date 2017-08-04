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
	<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
	<%@ page import="com.sitech.common.*" %>
	
<%
 	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	String flag="";
	String flag1="";
	if(opCode.equals("1366")){
		flag="checked";
	}else{
		flag1="checked";
	}
	String phoneNo = (String)request.getParameter("activePhone");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
  	String pwrf1="N";
    
        
	Date date = new Date();
	DateFormat df = new SimpleDateFormat("yyyyMMdd");   
	String now = df.format(date);
	String sql_reason="select reason_node,reason_code from Sreasoncode where op_code='1362' and reason_class='1'  ";
       
    		/* 操作时间 requestTime节点 */
	String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
	/* 获取敏感数据和敏感操作 */
	String readPath = request.getRealPath("npage/properties")+"/treasury.properties";
	/* 资源ID */
	String appId = readValue("treasury",opCode,"appId",readPath);
	/* 资源名称 */
	String appName = readValue("treasury",opCode,"appName",readPath);
	/* 场景ID sceneId */
	String sceneId = readValue("treasury",opCode,"sceneId",readPath);
	/* 测试用场景ID，上线删掉 by zhangyta at 20120824*/
	/*sceneId = "ff808081395641c901395641c9220000";*/
	/* 场景名称 sceneName */
	String sceneName = readValue("treasury",opCode,"sceneName",readPath);
	String ipAddr = (String)session.getAttribute("ipAddr");
	String flag4A = (String)session.getAttribute("flag4A");
	String appSessionId = (String)session.getAttribute("appSessionId");
	if(flag4A == null){
		flag4A = "0";
	}
	if(appSessionId == null){
		appSessionId = "0";
	}
	
%>
<!--
	<jsp:include page="/npage/client4A/treasuryStatus.jsp">
	<jsp:param name="opCode" value="1362"  />
	<jsp:param name="opName" value="退预存款"  />
	</jsp:include>	
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>黑龙江BOSS-退预存款</title>
	<META content="text/html; charset=gbk" http-equiv=Content-Type>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
</head>
<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=sql_reason%>"/>
 	
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
System.out.println("QQQQQQQQQQQ sql_reason is "+sql_reason+" and ret_val is "+ret_val.length);
%>
<body onLoad="form_load();">
<form action="s1362_2.jsp" method="post" name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="busy_type"  value="2">
	<div class="title">
		<div id="title_zi">选择用户类型</div>
	</div>
<table cellspacing="0" >
	<tr> 
		<td  class="blue">预约办理</td>
		<td  class="blue" colspan=2>
			<input type="text" name="orderId">
			预约办理ID
			<input class="b_text" type=button onClick="checkOrder()" value="预约办理">
		</td>
		<td><div id="groupId"></div></td> 
	</tr>
	<tr> 
		<th>用户类型</th>
		<th>
			<input name="busytype" type="radio" onClick="sel1()" value="2" <%=flag%>>
			销户用户
			<input name="busytype" type="radio" onClick="sel2()" value="1" <%=flag1%>>
			在网用户
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
		<td class="blue">用户名称</td>
		<td>
			<input type="text" name="textfield7" class="InputGrey" readonly>
		</td>
	</tr>
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
	<tr> 
		<td class="blue"> 可退金额</td>
		<td>
			<input type="text" name="textfield" class="InputGrey" readonly>
		</td>
		<td class="blue">退费金额</td>
		<td> 
			<input class="button" name=remark2 size=20 value="0.00">
		</td>
	</tr>
	<!--  add liuxmc-->
	<tr>
		<td class="blue">退预存款信息查询：</td>
		<td class="blue" colspan="3">			
			日期：<input type="text" class="button" name="reuturn_time" value="<%=now%>">格式：YYYYMMDD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="b_text"  type=button value="查 询" onClick="getTKDate();">
		</td>
	</tr>
	<!-- end -->
	
	<!--xl add begin-->
	<tr id="tfyy">
		<td class="blue">退预存款原因：</td>
		<td class="blue" colspan="3">			
			<select name="reason" style= "width:135px;" onChange="checkReason(this,reason_name,reason_code)">
				<option value="0" selected>---请选择退款原因</option>
				<%for(int i=0; i<ret_val.length; i++)
					{%>
						<option value="<%=ret_val[i][1]%>"><%=ret_val[i][0]%></option>
				  <%}%>
			</select>
		</td>
	</tr>
	<tr id="reason_id">
		<td class="blue">二级原因：</td>
		<td class="blue" colspan="3">			
			<input type="text" name="otherReason">
		</td>
	</tr>
	<!--xl add end-->
	<tr> 
		<td align="center" colspan="4" id="footer"> 
			<input class="b_foot" name=sure type=button value=确认>
			&nbsp;
			<!--<input class="b_foot" name=clear type=reset value=清除>-->
			<input class="b_foot" name=clear type=button value=清除 onClick="doClean()">
			&nbsp;
			<input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
			&nbsp; 
		</td>
	</tr>
</table>
<input type="hidden" id="ifsmz" value="">
<input type="hidden" name="ifKdNo" value="N">
<input type="hidden" name="reason1" value="0">
<input type="hidden" name="reason2">
	<%@ include file="/npage/include/footer_simple.jsp" %>
	<%@ include file="../../npage/common/pwd_comm.jsp" %>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
</form>
</body>
 <script language="JavaScript">

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
	  if ( CodeArray[x] == choose.value &&choose.value=="1004" )
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

<!--
function form_load(){
	document.getElementById("groupId").style.display="none";
	document.getElementById("reason_id").style.display="none";
	sel2();
	var op_code = "<%=opCode%>";
	if(op_code=="1362"){
		document.all.busy_type.value = "1";
	}else{
		document.all.busy_type.value = "2";
	}
	
}
function sel1()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "2";
 	document.all.opCode.value ="1366";
 	document.all.opName.value ="销户退款";
	document.all.tfyy.style.display = "none";
 }
function sel2()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "1";
	document.all.opCode.value ="1362";
	document.all.opName.value ="退预存款";
	document.all.tfyy.style.display = "block";
  }
 //判断是不是宽带账号 add by hq
function checkKd(packet){
	  var checkResult=packet.data.findValueByName("checkResult");//可以取出物联网号码
	  var s_flag = packet.data.findValueByName("s_flag");//t=铁通 w=物联网
	  //alert("s_flag is "+s_flag);
	  if(s_flag=="t")
	  {
		  if(checkResult==0||checkResult=="0"||checkResult=="")
		  {
				//return true;
				document.all.ifKdNo.value="N";
		  }
		  else
		  {
				//rdShowMessageDialog("此服务号码为宽带号码，请输入非宽带号码!");
				//document.form.phoneno.focus();
				document.all.ifKdNo.value="Y";
				//return false;
		  }
	  }
	  else if(s_flag=="w")
	  {
		  //alert("物联网");
		  document.form.phoneno.value=checkResult;
	  }	
	  else
	  {
	  }	
	  
}

function checkKdNo()
{
	var myPacket = new AJAXPacket("checkKD.jsp","正在提交，请稍候......");
		myPacket.data.add("phoneNo",form.phoneno.value);	
		core.ajax.sendPacket(myPacket,checkKd);
    myPacket=null;
}
function checkSmz(id_no)
{
	//alert("id_no is "+id_no);
	var myPacket = new AJAXPacket("s1362_checksmz.jsp","正在提交，请稍候......");
		myPacket.data.add("id_no",id_no);	
		core.ajax.sendPacket(myPacket,get_smz);
    myPacket=null;
}
function get_smz(packet)
{
	var s_flag1=packet.data.findValueByName("s_flag1");
//	alert("s_flag1 is "+s_flag1);
	document.getElementById("ifsmz").value=s_flag1;
}

function docheck()
{
  checkKdNo();
	//alert(document.all.ifKdNo.value);
 if(document.all.ifKdNo.value=="Y"){
		rdShowMessageDialog("此服务号码为宽带号码，请输入非宽带号码!");
	 	document.form.phoneno.focus();
 }else{
	var busy_type=document.all.busy_type.value;

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
	var returnValue;
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    if (document.all.busy_type.value=="2") {
    	
		returnValue =window.showModalDialog('getCountdead_new.jsp?phoneNo='+document.form.phoneno.value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf1%>',"",prop);
		//alert(returnValue);
		document.form.contractno.value = returnValue.split(",")[0];
    } else {
	     returnValue=window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneno.value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf1%>',"",prop);
		 document.form.contractno.value = returnValue;
	}
	if(document.all.busy_type.value=="2")
	{
		//实名制校验 returnValue返回一个id_no
		checkSmz(returnValue.split(",")[1]);
	//	alert("test value is "+document.getElementById("ifsmz").value);
		if(document.getElementById("ifsmz").value!="1")
		{
			rdShowMessageDialog("非实名制不可以办理!");
			return false;
		}

	}	
	if(returnValue=='0')
	 {
		rdShowMessageDialog("帐号或者密码输入错误！",0);
		document.form.phoneno.focus();
		return false;
	  }
	  if(returnValue=="")
	 {
		rdShowMessageDialog("你没有选择帐号！",0);
		document.form.phoneno.focus();
		return false;
	  }
	  
	if (document.all.busy_type.value=="1")
	{
		
		//xl add for 一二级原因
		var reason1 = document.all.reason1.value;
		var reason2 = document.all.reason2.value;
		var reason2_txt = document.all.otherReason.value;
		//alert("reason1 is "+reason1+" and reason2 is "+reason2);
		
		if(reason1=="0")
		{
			rdShowMessageDialog("请选择退费一级原因");
			return false;
		}	
		else if(reason2=="show" &&reason2_txt=="")
		{
			rdShowMessageDialog("请输入退费二级原因");
			return false;
		}
		else if(reason2=="show" &&reason2_txt.length>64)
		{
			rdShowMessageDialog("退费二级原因长度不可超过64！");
			return false;
		}
		else
		{
			/*
			 var getdataPacket = new AJAXPacket("/npage/query/fAjax5085.jsp","正在获得数据，请稍候......");
				getdataPacket.data.add("loginNo","<%=workNo%>");
				getdataPacket.data.add("sceneId","<%=sceneId%>");
				getdataPacket.data.add("sceneName","<%=sceneName%>");
				getdataPacket.data.add("phoneNo",document.form.phoneno.value);
				getdataPacket.data.add("currTime","<%=currTime%>");
				getdataPacket.data.add("appId","<%=appId%>");
				getdataPacket.data.add("appName","<%=appName%>");
				getdataPacket.data.add("flag4A","<%=flag4A%>");
				getdataPacket.data.add("appSessionId","<%=appSessionId%>");
				getdataPacket.data.add("ipAddr","<%=ipAddr%>");
				
				core.ajax.sendPacket(getdataPacket,doFileInput);
				getdataPacket = null;*/
				document.form.action="s1362_select.jsp";
				form.submit(); 
	     
		}
	}
	else
	{	
		   var getdataPacket = new AJAXPacket("/npage/query/fAjax5085.jsp","正在获得数据，请稍候......");
				getdataPacket.data.add("loginNo","<%=workNo%>");
				getdataPacket.data.add("sceneId","<%=sceneId%>");
				getdataPacket.data.add("sceneName","<%=sceneName%>");
				getdataPacket.data.add("phoneNo",document.form.phoneno.value);
				getdataPacket.data.add("currTime","<%=currTime%>");
				getdataPacket.data.add("appId","<%=appId%>");
				getdataPacket.data.add("appName","<%=appName%>");
				getdataPacket.data.add("flag4A","<%=flag4A%>");
				getdataPacket.data.add("appSessionId","<%=appSessionId%>");
				getdataPacket.data.add("ipAddr","<%=ipAddr%>");
				
				core.ajax.sendPacket(getdataPacket,doFileInput);
				getdataPacket = null;
	 
	}
 }
}
function doFileInput(packet){
			var result = packet.data.findValueByName("result");
		   // alert("test result is "+result);
			var resultDesc = packet.data.findValueByName("resultDesc");
			if(result == "1"){
			/**调用成功 */
				if (document.all.busy_type.value=="1")
				{
					var reason1 = document.all.reason1.value;
					var reason2_txt = document.all.otherReason.value;
					document.form.action="s1362_select.jsp?reason1="+reason1+"&reason2_txt="+reason2_txt;
					form.submit();
				}else{
					document.form.action="s1362_select.jsp";
					form.submit(); 
				}

			}else{
				/**调用失败 */
				rdShowMessageDialog("执行失败，失败原因：" + resultDesc);
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
//预约情况查询
function checkOrder()
{
	if(document.all.orderId.value=="")
	{
		rdShowMessageDialog("请输入在网站预约的ID号码!");
		return false;
	}
	var myPacket = new AJAXPacket("s1362Order.jsp","正在提交，请稍候......");
	myPacket.data.add("orderId",document.all.orderId.value);
	if (document.all.busy_type.value=="2")
	{
		myPacket.data.add("flag","2");
	}
	else if (document.all.busy_type.value=="1")
	{
		myPacket.data.add("flag","1");
	}
	else
	{
		rdShowMessageDialog("请确定号码类型!");
		return false;
	}
	core.ajax.sendPacket(myPacket);
    myPacket=null;
}
function doProcess(packet)
{
	var flag1 = packet.data.findValueByName("flag1");
	var custPhone= packet.data.findValueByName("custPhone");
	var custPass= packet.data.findValueByName("custPass");
	var group_name = packet.data.findValueByName("group_name");
	//alert("phone is "+custPhone+" and custPass is "+custPass+" and flag1 is  "+flag1);
	if(flag1==0)
	{
		//alert("phone is "+custPhone+" and custPass is "+custPass);
		document.all.phoneno.value=custPhone;
		document.all.cus_pass.value=custPass;
		document.getElementById("groupId").style.display="block";
		document.getElementById("groupId").innerHTML="预约办理营业厅："+group_name;
	}
	else if(flag1==1)
	{
		rdShowMessageDialog("用户信息不存在");
		return false;
	}
	else
	{
		rdShowMessageDialog("用户没有预约记录或预约已过期!");
		return false;
	}
}
function doClean()
{
	document.getElementById("groupId").style.display="none";
	document.all.orderId.value="";
	document.all.phoneno.value="";
	document.all.cus_pass.value="";
	document.all.contractno.value="";
	document.all.textfield7.value="";
	document.all.textfield3.value="";
	document.all.textfield2.value="";
	document.all.textfield.value="";
	document.all.remark2.value="";
}

</script>
</HTML>