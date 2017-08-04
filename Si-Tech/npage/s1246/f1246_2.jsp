<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 强制开关机1246
   * 版本: 1.0
   * 日期: 2008/12/23
   * 作者: leimd
   * 版权: si-tech
   * update:zhangyan
  */
%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<%
	String hdword_no =(String)session.getAttribute("workNo");//工号
	String hdpowerright =(String)session.getAttribute("powerRight");//角色权限
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code 操作权限归属
	String hdwork_pwd =(String)session.getAttribute("password");//工号密码		
	String hdthe_ip =  (String)session.getAttribute("ipAddr");//登陆IP	
	String[][] favInfo = (String[][])session.getAttribute("favInfo");//读取优惠资费代码	
	String regionCode = (String)session.getAttribute("regCode");
%>

<%
	String opCode="1246";
	String opName="强制开关机";
	String phoneNo = request.getParameter("i1");
%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=hdorg_code.substring(0,2)%>"  id="retListString1"/>	
<head>
<SCRIPT language="javascript">
function turnit()
{
	document.all.better.style.display="";
	document.getElementById("type_row").style.display="none";						    /*zhangyan add 强开操作时,强关类型隐藏*/
	document.getElementById("sendmsgbtn").style.display="none";							/*zhangyan add 发送短信按钮屏蔽*/
}
function checkexpDays()
{
	if(document.form1.expDays.value <= 0)
    {
        rdShowMessageDialog("请正确输入天数,天数不能为负或0天！");
        document.form1.expDays.value = "";
        document.form1.expDays.focus();
        return false;
    }
	if(document.form1.expDays.value > 365)
    {
        rdShowMessageDialog("请正确输入天数,天数不能超过365天！");
        document.form1.expDays.value = "";
        document.form1.expDays.focus();
        return false;
    }

}

/*----------------调用打印页面函数---------------------*/
	function showPrtdlg1246()
	{  
		getAfterPrompt();
		
	/*弹出模式对话筐，并对用户操作进行处理*/
		var h=105;
		var w=260;
		var t=screen.availHeight-h-20;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
		var ret=1;
		if(typeof(ret)!="undefined")
		{
			if(ret==1)                      //点击认可
			{
				//senddata();                      //同时产生页面拼串
				conf();                          
			}
			else if(ret==0)                 //点击取消,问是否提交
			{    
				crmsubmit();                     
			}
		}
	}	
	
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body >
<form action="" method=post name="form1"> 
	<input type="hidden" name="oret_code" value="">
	<%@ include file="/npage/include/header.jsp" %>

<%      
 	String outList[][] = new String [][]{{"0","26"}};
%>
<%
/***********************************定义返回参数*********************************************/

	String oret_code="";              // 错误代码               
	String oret_msg="";		          // 错误信息
	String oid_no="";		  		  // 0  用户id            
	String osm_code="";		          // 1  业务类型代码      
	String osm_name="";		          // 2  业务类型名称      
	String ocust_name="";		      // 3  客户名称          
	String ouser_password="";	      // 4  用户密码          
	String orun_code="";		      // 5  状态代码          
	String orun_name="";		      // 6  状态名称          
	String oowner_grade="";		      // 7  等级代码          
	String ograde_name="";		      // 8  等级名称          
	String oowner_type="";		      // 9  用户类型          
	String oowner_typename="";	      //10  用户类型名称      
	String ocust_addr="";		      //11  客户住址          
	String oid_type="";		          //12  证件类型          
	String oid_name="";		          //13  证件名称          
	String oid_iccid="";		      //14  证件号码          
	String ocard_name="";		      //15  客户卡类型        
	String ototal_owe="";		      //16  当前欠费          
	String ototal_prepay="";          //17  当前预存          
	String ofirst_oweconno="";	      //18  第一个欠费帐号    
	String ofirst_owefee="";	      //19  第一个欠费帐号金额		 
	String obak_field=""; 		      //20  备份字段          
	String ocmd_code="";		      //21  命令代码          
	String ocmd_name="";		      //22  命令名称          
	String onew_run="";		          //23  新状态代码        
	String onew_runname="";           //24  新状态名称 
	String product_name="";           //25  产品名称
	
/**************************调用s1246Init入参数****************************/
	String iwork_no = hdword_no;                                 //操作工号
	String iphone_no = ReqUtil.get(request,"i1");                //手机号码
	String iop_code = "1246";                                    //op_code 
	String iorg_code = hdorg_code;                               //org_code  
	String strOpRunCode = ReqUtil.get(request,"op_run_code");                //操作运行状态
	String owning_fee="";
	String cfm_login = "";//宽带账号
	
%>
	<wtc:service name="s1246Init" routerKey="region" routerValue="<%=regionCode%>" outnum="27" retcode="retCode" retmsg="retMsg">

		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iop_code%>"/>
		<wtc:param value="<%=iwork_no%>"/> 
		<wtc:param value="<%=hdwork_pwd%>"/>
		<wtc:param value="<%=iphone_no%>"/>
		<wtc:param value=" "/>
		<wtc:param value="<%=iorg_code%>"/>
	  <wtc:param value="<%=strOpRunCode%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	
		oret_code = retCode;
		oret_msg = retMsg;
		              
		System.out.println("2222:" + oret_code + ":" + oret_msg);
		

		if(!oret_code.equals("000000"))
	 	{
%>
<script language="javascript">
	rdShowMessageDialog("<%=String.valueOf(oret_code)%>:"+"<%=oret_msg%>！",0);
	history.go(-1);
</script>
<%}else{
		oid_no  = result[0][0];                     // 0 用户id    
		osm_code  = result[0][1];		        	// 1 业务类型代码       
		osm_name = result[0][2];					// 2 业务类型名称       
		ocust_name = result[0][3];					// 3 客户名称           
		ouser_password = result[0][4];				// 4 用户密码           
		orun_code = result[0][5];					// 5 状态代码           
		orun_name = result[0][6];					// 6 状态名称           
		oowner_grade = result[0][7];				// 7 等级代码           
		ograde_name = result[0][8];					// 8 等级名称           
		oowner_type = result[0][9];					// 9 用户类型           
		oowner_typename = result[0][10];			//10 用户类型名称       
		ocust_addr = result[0][11];					//11 客户住址           
		oid_type = result[0][12];					//12 证件类型           
		oid_name = result[0][13];					//13 证件名称           
		oid_iccid = result[0][14];					//14 证件号码           
		ocard_name = result[0][15];					//15 客户卡类型         
		ototal_owe = result[0][16];					//16 当前欠费           
		ototal_prepay = result[0][17];				//17 当前预存           
		ofirst_oweconno  = result[0][18];			//18 第一个欠费帐号     
		ofirst_owefee = result[0][19];				//19 第一个欠费帐号金额	
		obak_field = result[0][20];                 //20 备份字段           
		ocmd_code = result[0][21];                  //21 命令代码            
		ocmd_name = result[0][22];                  //22 命令名称            
		onew_run = result[0][23];                   //23 新状态代码          
		onew_runname  = result[0][24];              //24 新状态名称
		product_name  = result[0][25];              //25 产品名称
		cfm_login  = result[0][26];              //宽带账号

	/*如果是强关操作则查高额费用 zhangyan */
		System.out.println("zhangyan add  onew_runname=["+onew_runname+"]");
		System.out.println("zhangyan add onew_run= ["+onew_run+"]");

	if ("N".equals(onew_run))
	{
		System.out.println("zhangyan add  iphone_no=["+iphone_no+"]");
	%>
		<wtc:service name="bs_GetOwe" routerKey="region" routerValue="<%=regionCode%>" outnum="3" 
			retcode="retCode1" retmsg="retMsg1">
			<wtc:param value="<%=iphone_no%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>	
	<%
		if(!retCode1.equals("000000"))
		{
		%>
			<script language="javascript">
				rdShowMessageDialog("bs_GetOwe:<%=String.valueOf(retCode1)%>:"+"<%=retMsg1%>！",0);
				history.go(-1);
			</script>
		<%
		}
		else
		{
			owning_fee = result1[0][0];
			System.out.println("zhangyan add  owning_fee=["+owning_fee+"]");
			
		}
	}

}%>
<div class="title">
		<div id="title_zi">客户资料</div>
	</div>
<input type = "hidden" name = "strOpRunCode" value = "<%=strOpRunCode%>">
<table cellspacing="0">
	<tr> 
		<td class="blue">服务号码 </td>
		<td>
			<input name="i1" value="<%=ReqUtil.get(request,"i1")%>" size="20" v_type="mobphone" 
				 v_must=1 onBlur="if(this.value!=''){if(checkElement('i1')==false){return false;}}" 
				 Class="InputGrey" readOnly>
		</td>
		<td class="blue">客户名称 </td>
		<td >
			<input name="ocust_name" size="20"  value="<%=ocust_name%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td class="blue">产品名称  </td>
		<td >
			<input name="product_name" size="20"  value="<%=product_name%>" Class="InputGrey" readOnly>
		</td>
		<td class="blue">客户住址</td>
		<td >
			<input name="ocust_addr" size="20"  value="<%=ocust_addr%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<tr > 
		<td class="blue">证件类型</td>
		<td ><input name="oid_type" value="<%=oid_name%>" size="20" Class="InputGrey" readOnly>
		</td>
		<td class="blue">证件号码</td>
		<td>
			<input name="oid_iccid" size="20"  value="<%=oid_iccid%>"   Class="InputGrey" readOnly >
		</td>
	</tr>
	<tr> 
		<td class="blue">状态代码</td>
		<td >
			<input name="orun_code" size="20"  value="<%=orun_code%>" Class="InputGrey" readOnly>
		</td>
		<td class="blue">状态名称 </td>
		<td >
			<input name="orun_name" size="20"  value="<%=orun_name%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<%
		String strsql = "";
		String favor_code = "";
		String hand_fee = "";

		strsql = "select HAND_FEE, FAVOUR_CODE from sNewFunctionFee where region_code='05' and function_code='1246'";
	%>
		<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
			<wtc:sql><%=strsql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="handFeeArr" scope="end" />
	<%
		if(retCode.equals("000000")){
			if(handFeeArr.length>0){
				hand_fee = handFeeArr[0][0];
				favor_code = handFeeArr[0][1];				
			}
		}
	%>
	<tr >
		
			<input name="ohand_cash" v_name='手续费' type="hidden" size="20" maxlength=20 value="0">
			<input type="hidden" name="ishould_fee" size="20" maxlength=20 value="0" Class="InputGrey" readOnly>
		
		<td class="blue">开关机命令函数 </td>
		<td>
			<input name="icmd_code" value="<%=onew_runname%>" size="4" Class="InputGrey" readOnly>
			<span id=better style="DISPLAY: none">
				<input name="expDays" size="12" v_type="0_9" onChange="checkexpDays()" maxlength=20 value="1"  onblur="if(this.value!=''){if(checkElement(this)==false){return false;}}">天
			</span>
		</td>

	<td class="blue">宽带账号 </td>
		<td>
			<input  id="cfm_login" name="cfm_login" value="<%=cfm_login%>"   Class="InputGrey" readOnly>
		</td>
	</tr>

	<%
	/*zhangyan add 关于完善强关操作业务功能的需求 b*/		
	%>
	<tr id =  "type_row">
		<td class="blue">强关类型 </td>
		<td nowrap colspan = "3">
			<input type = "hidden" name = "force_type" id = "force_type" value = "">
			<select name = "force_type_sel" onchange = "show_detail()" >
				<option value = "0">---请选择---</option>
				<option value = "1"> 高额 </option>
				<option value = "2"> 违章停机 </option>
				<option value = "3"> 其它 </option>
				<option value = "4"> 非实名停机 </option>
				<option value = "5"> 发送垃圾短信 </option>
			</select>
			<font color = "red"> * </font>
		</td>		
	</tr>	
	<%
	/***  gaoe*/
	%>
	<tr  id = "reason_row" style ="display:none" >
		<td class="blue">强关原因 </td>
		<td nowrap colspan = "3">
			<textarea name = "force_reason" cols = "100" ></textarea>
			<font color = "red">*</font>
		</td>		
	</tr>	
	<tr   id ="judge_row"  style ="display:none" >
		<td class="blue">强关判断标准 </td>
		<td nowrap colspan = "3">
			<textarea name = "force_judgement" cols = "100" ></textarea>
			<font color = "red">*</font>
		</td>		
	</tr>			
	<tr id = "ticket_row"  style ="display:none" >
		<td class="blue">监控到高额话单的时间 </td>
		<td nowrap >
			<input type="text"  name = "largeticket_time" maxlength = "20" 
				size = "30" id = "largeticket_time" readonly>
			<img id = "largeticket_time_sel" onclick="WdatePicker({el:'largeticket_time',startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
		 		src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			<font color = "red">*</font>
		</td>		
		<td class="blue">高额话单的费用 </td>
		<td nowrap >
			<input type="text"  name = "largeticket_fee" maxlength = "10"  
				size = "30" >
			<font color = "red">*</font>
		</td>			
	</tr>		
	<tr id = "fee_row"  style ="display:none" >	
		<td class="blue">当前可用余额</td>
		<td nowrap colspan="3">
			<input type="text"  name = "owning_fee"  id = "owning_fee"
				size = "30" value = "<%=owning_fee%>" readOnly>
			<font color = "red">*</font>
		</td>			
	</tr>		
	<%
	/*** weizhangtingji */
	%>
	<tr id = "office_row" style ="display:none" >
		<td class="blue">所辖分局</td>
		<td colspan="3">
			<input name="suboffice" size="100" maxlength = "30">
			<font color = "red">* (30汉字以内)</font>
		</td>
	</tr>
	<tr id = "office_phone_row" style ="display:none" >
		<td class="blue">所辖分局电话</td>
		<td colspan="3">
			<input name="suboffice_phone" size="100" maxlength = "30">
			<font color = "red">* (30汉字以内)</font>
		</td>
	</tr>	
	<tr id = "doc_row" style ="display:none" >
		<td class="blue">文件编号 </td>
		<td nowrap >
			<input type="text"  name = "document_number" maxlength = "15" 
				size = "60">
			<font color = "red">*</font>
		</td>	
		<td class="blue">来文日期 </td>
		<td nowrap >
			<input type="text"  name = "document_date"  
				v_type="date"  onblur="checkElement(this);"  size = "10"  >
			<font color = "red">*</font>
		</td>		
	</tr>	
	
	<tr id = "doc_row45" style ="display:none" >
		<td class="blue">文件编号 </td>
		<td nowrap >
			<input type="text"  name = "document_number1" maxlength = "15" 
				size = "60">
			<font color = "red">*</font>
		</td>	
		<td class="blue">&nbsp; </td>
		<td class="blue">&nbsp; </td>
	</tr>	
	<tr id = "contact_row" style ="display:none" >
		<td class="blue">联系人姓名 </td>
		<td nowrap >
			<input type="text"  name = "contact_name" maxlength = "10" 
				size = "15">
			<font color = "red">*</font>
		</td>	
		<td class="blue">联系人电话 </td>
		<td nowrap >
			<input type="text"  name = "contact_phone" maxlength = "20" 
				size = "30" >
			<font color = "red">*</font>
		</td>		
	</tr>	
	<tr id = "operator_row" style ="display:none" >
		<td class="blue">操作人姓名 </td>
		<td nowrap >
			<input type="text"  name = "operator_name" size = "15"  maxlength = "5"  ><font color = "red">*</font>
		</td>	
		<td class="blue">操作人联系电话 </td>
		<td nowrap >
			<input type="text"  name = "operator_phone" size = "20" maxlength = "20"   ><font color = "red">*</font>
		</td>		
	</tr>	
	<%
	/*zhangyan add 关于完善强关操作业务功能的需求 e*/

	%>
	<!--huangrong update 将备注的只读属性和背景样式2011-6-13-->
	<tr>
		<td class="blue">备注</td>
		<td colspan="3">
			<input name="sysnote" size="60" maxlength="30">
		</td>
	</tr>

	<tr> 
		<td align=center colspan="4">
			<input class="b_foot" id = "sendmsgbtn" name="sendmsgbtn" onClick="sendMsg()"   type=button 
				value="发送短信">     
			<input class="b_foot_long" name=sure  type=button value="确认&打印" 
				onclick="if(checknum(ohand_cash,ishould_fee)) if(check(form1)) showPrtdlg1246();">
			<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
			<input class="b_foot" name=back  onClick="history.go(-1)" type=button value=返回>
		</td>
	</tr>
</table>
	   <!-----------------------------------设置隐藏域----------------------------------------------->
	   <!--input type="hidden" value="<%=onew_runname%>" name="onew_runname"-->
	   <input type="hidden" name="stream" value="<%=retListString1%>">
	   <input type="hidden" name="oid_no" value="<%=oid_no%>">
	   <input type="hidden" name="onew_run" value="<%=onew_run%>">
	   <input type="hidden" name="osm_code" value="<%=osm_code%>">

	   <!-------------------------------------------------------------------------------------------->
	  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

<script language="javascript">
	onload=function()
	{
		<%if(onew_runname.trim().equals("强开")){%>
		turnit();
		<%}%>
		//begin huangrong add 设置备注信息 2011-6-13 
		var imo_phone = '<%=ReqUtil.get(request,"i1")%>' ;	
		var onew_runname=document.all.icmd_code.value;		
		thesysnote = imo_phone + onew_runname;                        //生成系统备注			
		document.all.sysnote.value= thesysnote.trim();  
		//end huangrong add 设置备注信息 2011-6-13 
	}
	/*** zhangyan add  发送短信*/
	function sendMsg()
	{
		var i1 = document.form1.i1.value;
		var force_type = document.form1.force_type.value;	
		var force_reason = document.form1.force_reason.value;     	
		var force_judgement = document.form1.force_judgement.value;            
		var largeticket_time = document.form1.largeticket_time.value;            
		var largeticket_fee = document.form1.largeticket_fee.value;            
		var suboffice = document.form1.suboffice.value;               			      
		var suboffice_phone = document.form1.suboffice_phone.value;   				       
		var document_number = document.form1.document_number.value;   
		var document_date = document.form1.document_date.value;              
		var operator_name = document.form1.operator_name.value;             
		var operator_phone = document.form1.operator_phone.value;                
		var contact_name = document.form1.contact_name.value;                  
		var contact_phone = document.form1.contact_phone.value;   
		var owning_fee=		document.form1.owning_fee.value;   
		if (!forNotNegReal(document.form1.largeticket_fee)) 
		{
			rdShowMessageDialog("必须输入正确的高额话单费用!");
			return false;
		}	
		if(!forPhone(document.form1.operator_phone)) 
		{
			rdShowMessageDialog("必须输入正确的手机号码!");
			return false;	
		}			
		if ( ""==force_reason )
		{
			rdShowMessageDialog("强关原因不能为空!");
			return false;
		}
		if ( ""==force_judgement )
		{
			rdShowMessageDialog("强关判断标准不能为空!");
			return false;
		}		
		if ( ""==largeticket_time )
		{
			rdShowMessageDialog("监控到高额话单的时间不能为空!");
			return false;
		}	
		if ( ""==largeticket_fee )
		{
			rdShowMessageDialog("监控到高额话单费用不能为空!");
			return false;
		}	 
		if ( ""==largeticket_fee )
		{
			rdShowMessageDialog("监控到高额话单费用不能为空!");
			return false;
		}	
		
		if ( ""==owning_fee )
		{
			rdShowMessageDialog("当前可用余额不能为空!");
			return false;
		}	
		/*长度校验*/
		if (force_judgement.len() > 512)
		{
			rdShowMessageDialog("强关判断标准输入太长!");
			return false;
		}
		
		if (force_reason.len() > 120)
		{
			rdShowMessageDialog("强关判断原因输入太长!");
			return false;
		} 
		document.form1.force_type_sel.disabled = true;
		document.form1.largeticket_time_sel.disabled = true;
		document.form1.i1.readOnly = true;
		document.form1.force_type.readOnly = true;
		document.form1.force_reason.readOnly = true;
		document.form1.force_judgement.readOnly = true;
		document.form1.largeticket_time.readOnly = true;
		document.form1.largeticket_fee.readOnly = true;
		document.form1.suboffice.readOnly = true;
		document.form1.suboffice_phone.readOnly = true;
		document.form1.document_number.readOnly = true;
		document.form1.document_date.readOnly = true;
		document.form1.operator_name.readOnly = true;
		document.form1.operator_phone.readOnly = true;
		document.form1.contact_name.readOnly = true;
		document.form1.contact_phone.readOnly = true;
		document.form1.sysnote.readOnly=true;
		document.form1.owning_fee.readOnly=true;
    	var myPacket = new AJAXPacket("f1246_sendMsg.jsp","正在发短信");
        myPacket.data.add("largeticket_time" , largeticket_time);
        myPacket.data.add("i1" , i1);
        myPacket.data.add("owning_fee" , owning_fee);
        core.ajax.sendPacket(myPacket);
        myPacket=null;

	}
	var  iTime = 179;																/*短信时间*/
	function doProcess(packet)
	{
		var retCode = packet.data.findValueByName("retCode"); 
    	var retMsg = packet.data.findValueByName("retMsg"); 

    	if ( "000000"!=retCode )
    	{
    		rdShowMessageDialog(  retCode+":"+retMsg);
    		removeCurrentTab();
    	}
    	else
    	{
    		rdShowMessageDialog("短信发送成功!");
    	}
    	document.form1.sendmsgbtn.disabled = true;
		document.form1.sure.disabled = true;
       	RemainTime(); 
	}
	/*** zhangyan add 倒计时函数*/
	function RemainTime()
	{
    	if (iTime > 0)
    	{
	       	setTimeout("RemainTime()",1000);
        	iTime=iTime-1;
        	document.form1.sure.value = "("+iTime+"s)确认&打印";
    	}
    	else
		{
			document.form1.sure.value = "确认&打印";
			document.form1.sure.disabled = false;
		}

	}
	
	/*** zhangyan add 强关明细显隐 b*/
	function show_detail() 
	{
		var force_type_sel = document.form1.force_type_sel.value;
		document.form1.force_type.value = force_type_sel;
		var force_type = force_type_sel;
		
		document.form1.force_reason.value="";     	
		document.form1.force_judgement.value="";            
		document.form1.largeticket_time.value="";            
		document.form1.largeticket_fee.value="";            
		document.form1.suboffice.value="";               			      
		document.form1.suboffice_phone.value="";   				       
		document.form1.document_number.value="";   
		document.form1.document_number1.value="";  
		document.form1.document_date.value="";              
		document.form1.operator_name.value="";             
		document.form1.operator_phone.value="";                
		document.form1.contact_name.value="";                  
		document.form1.contact_phone.value="";             

		
		if ( 1==force_type )												    /*高额*/
		{
			document.form1.sendmsgbtn.disabled = false;
			document.form1.force_reason.value="高额";   
			document.form1.force_reason.readOnly = true;
			document.form1.sure.value = "(180s)确认&打印";	
			document.form1.sure.disabled = true;			
			document.getElementById("reason_row").style.display = "block";
			document.getElementById("judge_row").style.display = "block";
			document.getElementById("ticket_row").style.display = "block";
			document.getElementById("fee_row").style.display = "block";
			document.getElementById("office_row").style.display = "none";
			document.getElementById("office_phone_row").style.display = "none";
			document.getElementById("doc_row").style.display = "none";
			document.getElementById("doc_row45").style.display = "none";
			document.getElementById("contact_row").style.display = "none";
			
			document.getElementById("operator_row").style.display = "block";
		}
		else if ( 2==force_type )											    /*违章停机*/
		{
			document.form1.sendmsgbtn.disabled = true;
			document.form1.force_reason.value="";   
			document.form1.force_reason.readOnly = false;
			document.form1.sure.value = "确认&打印";	
			document.form1.sure.disabled = false;
						
			document.getElementById("reason_row").style.display = "block";
			document.getElementById("judge_row").style.display = "none";
			document.getElementById("ticket_row").style.display = "none";
			document.getElementById("fee_row").style.display = "none";
			document.getElementById("office_row").style.display = "block";
			document.getElementById("office_phone_row").style.display = "block";
			document.getElementById("doc_row").style.display = "block";
			document.getElementById("doc_row45").style.display = "none";
			document.getElementById("contact_row").style.display = "none";
			
			document.getElementById("operator_row").style.display = "block";
		}
		else if ( 3==force_type )											    /*其它*/
		{
			document.form1.sure.value = "确认&打印";
			document.form1.sure.disabled = false;
			document.form1.sendmsgbtn.disabled = true;
			document.form1.force_reason.value="";   
			document.form1.force_reason.readOnly = false;
			document.getElementById("reason_row").style.display = "block";
			document.getElementById("judge_row").style.display = "none";
			document.getElementById("ticket_row").style.display = "none";
			document.getElementById("fee_row").style.display = "none";
			document.getElementById("office_row").style.display = "none";
			document.getElementById("office_phone_row").style.display = "none";
			document.getElementById("doc_row").style.display = "none";
			document.getElementById("doc_row45").style.display = "none";
			document.getElementById("contact_row").style.display = "block";
			
			document.getElementById("operator_row").style.display = "none";
		}else if ( 4==force_type||5==force_type )		 /*“非实名停机”和“发送垃圾短信”*/
		{
			document.form1.sure.value = "确认&打印";
			document.form1.sure.disabled = false;
			document.form1.sendmsgbtn.disabled = true;
			document.form1.force_reason.value="";   
			document.form1.force_reason.readOnly = false;
			document.getElementById("reason_row").style.display = "block";
			document.getElementById("judge_row").style.display = "none";
			document.getElementById("ticket_row").style.display = "none";
			document.getElementById("fee_row").style.display = "none";
			document.getElementById("office_row").style.display = "none";
			document.getElementById("office_phone_row").style.display = "none";
			document.getElementById("doc_row").style.display = "none";
			document.getElementById("doc_row45").style.display = "block";
			document.getElementById("contact_row").style.display = "none";
			document.getElementById("operator_row").style.display = "block";
		}
		else																	/*请选择*/
		{
			document.form1.sure.value = "确认&打印";
			document.form1.sure.disabled = false;
			document.form1.force_reason.value="";   
			document.form1.force_reason.readOnly = false;
			document.getElementById("reason_row").style.display = "none";
			document.getElementById("judge_row").style.display = "none";
			document.getElementById("ticket_row").style.display = "none";
			document.getElementById("fee_row").style.display = "none";
			document.getElementById("office_row").style.display = "none";
			document.getElementById("office_phone_row").style.display = "none";
			document.getElementById("doc_row").style.display = "none";
			document.getElementById("doc_row45").style.display = "none";
			document.getElementById("contact_row").style.display = "none";
			
			document.getElementById("operator_row").style.display = "none";			
		}
		
		

	}
	
/*-----------------------------页面跳转函数-----------------------------------------------*/
	function pageSubmit(page){
		document.form1.action="<%=request.getContextPath()%>/npage/"+page;
		form1.submit();
		/*if(flag==1){
		document.form1.action="<%=request.getContextPath()%>/npage/change/f1274_3.jsp";  
		form1.submit();
		}*/
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
		
		if(document.all.icmd_code.value== "强开")
		{	
			var tmpDays = parseInt(document.all.expDays.value,10);
		
			if( tmpDays <= 0 || tmpDays > 365 || (document.all.expDays.value).trim().length==0)
			{
				rdShowMessageDialog("强开时请输入正确的强开时间,强开时间在0-365之间!",0);
				return false;
			}
		}
		/*** zhangyan add 强关页面校验*/
		if(document.form1.strOpRunCode.value=="N")
		{
			var force_type = document.form1.force_type.value;	
			var force_reason = document.form1.force_reason.value;     	
			var force_judgement = document.form1.force_judgement.value;            
			var largeticket_time = document.form1.largeticket_time.value;            
			var largeticket_fee = document.form1.largeticket_fee.value;            
			//document.form1.owning_fee.value;  
			var suboffice = document.form1.suboffice.value;               			      
			var suboffice_phone = document.form1.suboffice_phone.value;   				       
			var document_number = document.form1.document_number.value;   
			var document_number1 = document.form1.document_number1.value;  
			var document_date = document.form1.document_date.value;              
			var operator_name = document.form1.operator_name.value;             
			var operator_phone = document.form1.operator_phone.value;                
			var contact_name = document.form1.contact_name.value;                  
			var contact_phone = document.form1.contact_phone.value;      
			
			
			
			if (force_judgement.len() > 512)
			{
				rdShowMessageDialog("强关判断标准输入太长!");
				return false;
			}
		
			if ( 0==force_type )											    /*请选择时*/
			{
				rdShowMessageDialog("强关类型必须选择!");
				return false;
			}
			else if ( 1==force_type )										    /*高额*/
			{
				if ( ""==force_reason )
				{
					rdShowMessageDialog("强关原因不能为空!");
					return false;
				}
				if ( ""==force_judgement )
				{
					rdShowMessageDialog("强关判断标准不能为空!");
					return false;
				}		
				if ( ""==largeticket_time )
				{
					rdShowMessageDialog("监控到高额话单的时间不能为空!");
					return false;
				}	
				if ( ""==largeticket_fee )
				{
					rdShowMessageDialog("监控到高额话单费用不能为空!");
					return false;
				}			
						
			}
			else if ( 2==force_type )									 	    /*违章停机*/
			{
				if ( ""==force_reason )
				{
					rdShowMessageDialog("强关原因不能为空!");
					return false;
				}
				if ( ""==suboffice )
				{
					rdShowMessageDialog("所辖分局 不能为空!");
					return false;
				}				
				if ( ""==suboffice_phone )
				{
					rdShowMessageDialog("所辖分局联系电话 不能为空!");
					return false;
				}				
				if ( ""==document_number )
				{
					rdShowMessageDialog("文件编号不能为空!");
					return false;
				}			
				if ( ""==document_date )
				{
					rdShowMessageDialog("来文日期不能为空!");
					return false;
				}						
				if ( ""==operator_name )
				{
					rdShowMessageDialog("操作人姓名 不能为空!");
					return false;
				}		
				if ( ""==operator_phone )
				{
					rdShowMessageDialog("操作人联系电话 不能为空!");
					return false;
				}	

				if(  !forPhone(document.form1.operator_phone)  ) 
				{
					rdShowMessageDialog("必须输入正确的手机号码!");
					return false;	
				}	
							
				if (force_reason.len() > 120)
				{
					rdShowMessageDialog("违章停机，强关判断原因输入太长!"); 
					return false;
				} 											
			}
			else if ( 3==force_type )										    /*其它*/
			{
				if ( ""==force_reason )
				{
					rdShowMessageDialog("强关原因不能为空!");
					return false;
				}	
				
				if ( ""==contact_name )
				{
					rdShowMessageDialog("联系人不能为空!");
					return false;
				}		
				if ( ""==contact_phone )
				{
					rdShowMessageDialog("联系人电话不能为空!");
					return false;
				}	
				if (force_reason.len() > 512)
				{
					rdShowMessageDialog("强关判断原因输入太长!");
					return false;
				} 		
				if (contact_name.len() > 10)
				{
					rdShowMessageDialog("联系人姓名输入过长!");
					return false;
				} 					
				if (contact_phone.len() > 20)
				{
					rdShowMessageDialog("联系人电话输入过长!");
					return false;
				} 					
			}else if ( 4==force_type||5==force_type )				 /*“非实名停机”和“发送垃圾短信”*/
			{
				if ( ""==force_reason )
				{
					rdShowMessageDialog("强关原因不能为空!");
					return false;
				}	
				
				 if ( ""==operator_name )
				{
					rdShowMessageDialog("操作人姓名 不能为空!");
					return false;
				}		
				if ( ""==operator_phone )
				{
					rdShowMessageDialog("操作人联系电话 不能为空!");
					return false;
				}	
				
				if (force_reason.len() > 512)
				{
					rdShowMessageDialog("强关判断原因输入太长!");
					return false;
				} 		
				 
				if ( ""==document.form1.document_number1.value )
				{
					rdShowMessageDialog("文件编号不能为空!");
					return false;
				}else{
					document.form1.document_number.value = document.form1.document_number1.value
				}				
			}
			
		}
		
		return true;
	} 
	
	var thesysnote = ""; //定义全局变量－系统备注
	
	function printInfo(printType)
	{
		var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		var retInfo = "";  //打印内容
		
		var phoneNo = "<%=ReqUtil.get(request,"i1")%>";
		if("<%=cfm_login%>"!=""){
			phoneNo = "<%=cfm_login%>";
		}
		
		cust_info+="手机号码："+phoneNo+"|";
		cust_info+="客户姓名："+'<%=ocust_name%>'+"|";         	
		cust_info+="客户地址："+'<%=ocust_addr%>'+"|";
		cust_info+="证件号码："+'<%=oid_iccid%>'+"|";
		
		opr_info+="业务类型：强制开关机"+"|";
		opr_info+="业务流水："+document.all.stream.value+"|";
		note_info1+="备注: "+document.all.sysnote.value+"|";
		
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		
	   	return retInfo;	
	}

/*-------------------------打印流程提交处理函数-------------------*/
	function conf()
	{ 
		var h=200;
		var w=400;
		var t=screen.availHeight/2-h/20;
		var l=screen.availWidth/2-w/2;
		
		var DlgMessage = "确实要进行电子免填单打印吗?";
		var submitCfm = "Yes";
	
	   var pType="subprint";                                     // 打印类型：print 打印 subprint 合并打印
	   var billType="1";                                         //  票价类型：1电子免填单、2发票、3收据
	   var sysAccept=document.all.stream.value;                  // 流水号
	   var printStr=printInfo("Detail");                         //调用printinfo()返回的打印内容
	   var mode_code=null;                                        //资费代码
	   var fav_code=null;                                         //特服代码
	   var area_code=null;                                        //小区代码
	   var opCode="1246";                                         //操作代码
	   var phoneNo="<%=phoneNo%>"              						//客户电话
	   
	   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	   path+=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	   var ret_value=window.showModalDialog(path,printStr,prop);
		
	/**********************打印所需的参数组织完毕****************************/
		//if(ret_value == "continueSub")
		//{
			//document.all.stream.value = ;
      
			crmsubmit();
		
		//}
	
	}
	
	function crmsubmit()
	{
		if(rdShowConfirmDialog("是否提交此次操作？")==1){
			form1.action="f1246_3.jsp";
			form1.submit();
		 }else{
			return false;
		 }
	}

 </script>
