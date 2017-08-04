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
<%
 	//String opCode=request.getParameter("opCode");
	//String opName=request.getParameter("opName");
	String opCode="zg65";
	String opName="铁通宽带退费";
	String flag="";
	String flag1="";
	if((opCode.equals("zg65")) || (opCode=="zg65")){
		flag="checked";
	}else{
		flag1="checked";
	}
	String phoneNo = (String)request.getParameter("activePhone");
	String orgCode = (String)session.getAttribute("orgCode");
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");
//    System.out.println("temfavStr============"+temfavStr);
//    System.out.println("favInfo============"+favInfo);
  	String[] favStr = new String[favInfo.length];
  	for(int i=0;i<favStr.length;i++)
   		favStr[i]=favInfo[i][0].trim();
  	String pwrf="N";
  	if(WtcUtil.haveStr(favStr,"a272"))
			pwrf="N";
	Date date = new Date();
  DateFormat df = new SimpleDateFormat("yyyyMMdd");   
	String now = df.format(date);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>黑龙江BOSS-退预存款</title>
	<META content="text/html; charset=gbk" http-equiv=Content-Type>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
</head>
<body onLoad="form_load();">
<form action="s1362_2.jsp" method="post" name="form">
<input type ="hidden" id ="phoneNo" name="phoneNo">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="busy_type"  value="2">
	<div class="title">
		<div id="title_zi">选择用户类型</div>
	</div>
<table cellspacing="0" >
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
		<td class="blue">宽带号码</td>
		<td> 
			<input type="text" name="phoneno" maxlength="25" onKeyDown="if(event.keyCode==13) getPhoneKd()" >
		</td>
		<td class="blue">用户密码</td>
		<td>
			<jsp:include page="/npage/common/pwd_one.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="cus_pass"  />
				<jsp:param name="pwd" value="12345"  />
			</jsp:include>
			<input class="b_text" type=button value="查询" onClick="getPhoneKd();">
		</td>
	</tr>
	<tr> 
		<td class="blue">帐户号码</td>
		<td> 
			<input type="text" name="contractno" maxlength="20" class="button"  onkeydown="if(event.keyCode==13) getPhoneKd()" onKeyPress="return isKeyNumberdot(0)">
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
			<input class="b_text"  type=button value="查 询" onClick="getTKDate();"> <!--此处调用s1362_selectTK.jsp-->
		</td>
		<input type="hidden" id="cfm_lg">
	</tr>
	<!-- end -->
	<tr> 
		<td align="center" colspan="4" id="footer"> 
			<input class="b_foot" name=sure type=button value=确认 disabled>
			&nbsp;
			<input class="b_foot" name=clear type=reset value=清除>
			&nbsp;
			<input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
			&nbsp; 
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
	<%@ include file="../../npage/common/pwd_comm.jsp" %>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
</form>
</body>
 <script language="JavaScript">
<!--
function form_load(){
	var op_code = "<%=opCode%>";
	if(op_code=="zg65"){
		document.all.busy_type.value = "2";
	}else{
		document.all.busy_type.value = "1";
	}
}
function sel1()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "2";
 	document.all.opCode.value ="zg65";
 	document.all.opName.value ="销户宽带用户退款";
 }
function sel2()
 {
	//alert("新增service name = ?");
	document.all.phoneno.focus();
	document.all.busy_type.value = "1";
	document.all.opCode.value ="zg65";
	document.all.opName.value ="在网宽带用户退款";
  }
 // xl add for 查询宽带号码
function getPhoneKd()
{
	if(document.form.phoneno.value==""){
  		rdShowMessageDialog("宽带号码不能为空!");
  		document.form.phoneno.focus();
		return false;
  	}
	document.getElementById("cfm_lg").value=document.form.phoneno.value;
	var busy_type = document.all.busy_type.value;
	var myPacket = new AJAXPacket("../zg62/getKdNo_new.jsp","正在查询客户，请稍候......");
		myPacket.data.add("contractNo",(document.all.phoneno.value).trim());
		myPacket.data.add("busyType",busy_type);
		myPacket.data.add("return_page","zg65_1.jsp");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
}
function doProcess(packet)
{
    var i_dp = packet.data.findValueByName("i_dp"); 
	var contract_new=packet.data.findValueByName("contract_out");
	var phone_new=packet.data.findValueByName("phone_new"); 
	document.all.contractno.value=contract_new;
	document.getElementById("phoneNo").value= phone_new;
	//xl add 新增品牌和流水查询
	var sm_code = packet.data.findValueByName("s_sm_code");
	//alert(sm_code);
	//rdShowMessageDialog("test phone_new is "+phone_new);
    //alert("phone_new is "+phone_new);
	//docheck(); 
	if(sm_code!="kh")
	{
		rdShowMessageDialog("只有kh品牌可以在该页面进行退费!");
		return false;
	}
	else if(i_dp==0)
    {
		rdShowMessageDialog("非单品需在e033进行宽带退费!");
		return false;
	}
	else
	{
		docheck(); 
	}
}
function docheck()
{
	var busy_type=document.all.busy_type.value;
	/*
	if(form.phoneno.value.length<11 )
	{
		rdShowMessageDialog("请输入服务号码,长度为11位数字 !!")
		document.form.phoneno.focus();
		return false;
	}*/

	var returnValue;
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	//alert("busy_type is "+busy_type);
    if (document.all.busy_type.value=="2") {
    	//alert("e033 begin "+document.getElementById("phoneNo").value);
		returnValue =window.showModalDialog('../e033/getCountdead.jsp?phoneNo_new='+document.getElementById("phoneNo").value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf%>'+'&cfm_lg='+document.getElementById("cfm_lg").value,"",prop);
		//alert("e033 end");
    } else {
		//alert("新写service");
	     returnValue=window.showModalDialog('../e033/getCount.jsp?phoneNo='+document.getElementById("phoneNo").value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf%>',"",prop);
	}
	//alert("ff "+returnValue);
	if(returnValue=='0')
	 {
		rdShowMessageDialog("宽带号码无可以退费信息！",0);
		document.form.phoneno.focus();
		return false;
	  }
	  if(returnValue=="")
	 {
		rdShowMessageDialog("你没有选择帐号！",0);
		document.form.phoneno.focus();
		return false;
	  }

	document.form.contractno.value = returnValue;
	document.form.action="zg65_select.jsp";
	form.submit(); 
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