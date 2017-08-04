<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 短信催缴定制2280
   * 版本: 1.0
   * 日期: 2008/01/13
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>短信催缴定制</TITLE>

<%
	String opCode="2280";
	String opName="短信催缴定制";
	String phoneNo = (String)request.getParameter("activePhone");			//手机号码
	String workName = (String)session.getAttribute("workName");				//工名
	String region_code=(String)session.getAttribute("regCode");				//地区代码
	Map map = (Map)session.getAttribute("contactInfoMap");
	ContactInfo contactInfo = (ContactInfo) map.get(activePhone);
	String cus_pass = contactInfo.getPasswdVal (2);								//取用户密码
	//取系统流水
%>
	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_code%>" id="loginAccept"/>
<%	
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"","","","","",""};

    Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4),10),
                      (Integer.parseInt(dateStr.substring(4,6),10) - 1),Integer.parseInt(dateStr.substring(6,8),10));
	for(int i=0;i<=5;i++)
      {
	      if(i!=5)
	      {
	        mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
	        cal.add(Calendar.MONTH,-1);
	      }
	      else
	        mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
      }
%>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
</HEAD>

<body>
<SCRIPT language="JavaScript">

onload=function(){
	document.frm1109.Button2.disabled=true;
	document.all.phone_no.focus();
}

//接收到RPC返回的查询值
function doProcess(packet){
	var re_errcode=packet.data.findValueByName("errcode");
	var re_user_status=packet.data.findValueByName("user_status");
	var re_card_type=packet.data.findValueByName("card_type");
	var re_card_no=packet.data.findValueByName("card_no");
	var re_user_name=packet.data.findValueByName("user_name");
    
	var re_awake_fee=packet.data.findValueByName("awake_fee");
	var re_awake_times=packet.data.findValueByName("awake_times");
	var re_calling_times=packet.data.findValueByName("calling_times");
	var re_begin_hm=packet.data.findValueByName("begin_hm");
	var re_end_hm=packet.data.findValueByName("end_hm");
	//var re_time_flag=packet.data.findValueByName("time_flag");
	var re_time_flag =0;
	var re_forbid_flag=packet.data.findValueByName("forbid_flag");
	var re_contact_address=packet.data.findValueByName("contact_address");
	var re_contact_phone=packet.data.findValueByName("contact_phone");
	
	self.status="";
	
	if (re_errcode=="0"){
		rdShowMessageDialog("信息查询失败！",0);
		return false;
	}
	else{
		rdShowMessageDialog("确认信息返回，请核查！");
		
		document.frm1109.user_address.value=re_user_status;
		document.frm1109.id_type.value=re_card_type;
		document.frm1109.id_code.value=re_card_no;
		document.frm1109.user_name.value=re_user_name;
	    
		document.frm1109.awake_times.value=re_awake_times;
        document.frm1109.awake_fee.value=re_awake_fee;
        document.frm1109.calling_times.value=re_calling_times;
        document.frm1109.begin_hm.value=re_begin_hm;
		document.frm1109.end_hm.value=re_end_hm;
		document.frm1109.contact_address.value=re_contact_address;
		document.frm1109.contact_phone.value=re_contact_phone;
		//if (re_time_flag==0)
			//document.frm1109.time_flag[1].checked=true;
		//else
		//	document.frm1109.time_flag[0].checked=true;

		
		if (re_forbid_flag==0)
			document.frm1109.forbid_flag[1].checked=true;
		else
			document.frm1109.forbid_flag[0].checked=true;
			
		change();		
	}
	document.frm1109.Button2.disabled=false;
}


function doSearch(){
	//alert(document.frm1109.phone_no.value);
	var myPacket = new AJAXPacket("getUserInfo.jsp","正在查询中，请稍候……");
	myPacket.data.add("phoneNo",document.frm1109.phone_no.value);
	myPacket.data.add("password","<%=cus_pass%>");
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

var temp_retCode;
var temp_retMsg;
var temp_cust_name;
var temp_cust_address;
var temp_id_type;
var temp_id_iccid;
var temp_awake_fee;
var temp_awake_times;


//该函数实现了：如果是增加，则XXXX要填写；如果是取消，则XXXX不用填写
function change(){
	if(document.all.do_type[0].checked){
		document.all.calling_times.disabled=false;
		document.all.awake_times.disabled=false;
		document.all.awake_fee.disabled=false;
		document.all.begin_hm.disabled=false;
		document.all.end_hm.disabled=false;
		document.all.time_flag[0].disabled=false;
		document.all.time_flag[1].disabled=false;
		document.all.forbid_flag[0].disabled=false;
		document.all.forbid_flag[1].disabled=false;				
		isuse();
	}
	else{
		isuse();
	  document.all.forbid_flag[0].checked = true;
		document.all.calling_times.disabled=true;
		document.all.awake_times.disabled=true;
		document.all.awake_fee.disabled=true;
		document.all.begin_hm.disabled=true;
		document.all.end_hm.disabled=true;
		//document.all.time_flag[0].disabled=true;
		//document.all.time_flag[1].disabled=true;
		document.all.forbid_flag[0].disabled=true;
		document.all.forbid_flag[1].disabled=true;		
	}
}

function isusetime(){
    if (document.all.forbid_flag[1].checked) {
			//if (document.all.time_flag[1].checked) {
		//	document.all.begin_hm.value="0000";
		//	document.all.begin_hm.disabled=true;
		//	document.all.end_hm.value="0000";
		//	document.all.end_hm.disabled=true;
		//} else
			//{
			document.all.begin_hm.disabled=false;
			document.all.end_hm.disabled=false;
		//}

	}
}

function isuse(){
	if (document.all.forbid_flag[1].checked) {
	    document.all.begin_hm.disabled=false;
		document.all.end_hm.disabled=false;
		//document.all.time_flag[0].disabled=false;
		//document.all.time_flag[1].disabled=false;


		document.all.calling_times.disabled=false;
		document.all.awake_fee.disabled=false;
		document.all.awake_times.disabled=false;
	} else if (document.all.forbid_flag[0].checked){
		document.all.begin_hm.value="0000";
		document.all.begin_hm.disabled=true;
		document.all.end_hm.value="0000";
		document.all.end_hm.disabled=true;
		//document.all.time_flag[0].disabled=true;
		//document.all.time_flag[1].disabled=true;


		document.all.calling_times.value="0";
		document.all.awake_fee.value="0";
		document.all.awake_times.value="0";
		document.all.calling_times.disabled=true;
		document.all.awake_fee.disabled=true;
		document.all.awake_times.disabled=true;
	}
	isusetime();
}

function doCheck(){
	getAfterPrompt();
		//document.all.time_flag[0].disabled=false;
	//document.all.time_flag[1].disabled=false;
	document.all.forbid_flag[0].disabled = false;
	document.all.forbid_flag[1].disabled = false;

	if (document.all.do_type[0].checked && document.all.forbid_flag[1].checked){
		if (document.all.calling_times.value.length==0||document.all.awake_fee.value.length==0||document.all.awake_times.value.length==0){
			rdShowMessageDialog("催缴次数、提醒次数、提醒费用阀值不能为空！");
			return false;
		}
		if (!forNonNegInt(document.all.calling_times)||!forMoney(document.all.awake_fee)||!forNonNegInt(document.all.awake_times)){
			rdShowMessageDialog("催缴次数、提醒次数、提醒费用阀值输入错误！")
			return false;
		}
		if (parseInt(document.all.awake_times.value,10)==0||parseInt(document.all.awake_fee.value,10)==0){
			rdShowMessageDialog("提醒次数、提醒费用阀值不能为0！")
			return false;
		}
		
		//if (document.all.time_flag[0].checked){
			if ( (document.all.begin_hm.value.length<4) || (document.all.end_hm.value.length<4) ){
				rdShowMessageDialog("时间格式必须输入4位数！")
				return false;
			}
			if ((document.all.begin_hm.value)>(document.all.end_hm.value)){

	            rdShowMessageDialog("开始时间必须小于结束时间！");
				return false;
			}
			if (parseInt(document.all.begin_hm.value.substring(0,2),10)>23||parseInt(document.all.end_hm.value.substring(0,2),10)>23){
				rdShowMessageDialog("开始时间和结束时间的小时数(前两位)必须小于24！")
				return false;
			}
			if (parseInt(document.all.begin_hm.value.substring(2,4),10)>59||parseInt(document.all.end_hm.value.substring(2,4),10)>59){
				rdShowMessageDialog("开始时间和结束时间的分钟数(后两位)必须小于60！")
				return false;
			}			
		//}
			
	}
		
	document.frm1109.action="f2280_confirm.jsp";
	//frm1109.submit();
	//return true;	

//--------------add by notturno begin
	 var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
      
    // if(typeof(ret)!="undefined")
    //{
     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？')==1)
        {
            
	      frm1109.submit();
        }
	  if(ret=="remark")
	  {
        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
        {
	      frm1109.submit();
        }
		else
		{
					//document.all.time_flag[0].disabled=true;
					//document.all.time_flag[1].disabled=true;
					document.all.forbid_flag[0].disabled = true;
					document.all.forbid_flag[1].disabled = true;

	   }
    }
}
    else
    {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
	     frm1109.submit();
       }
		   else
		   {
			    //document.all.time_flag[0].disabled=true;
				//document.all.time_flag[1].disabled=true;
				document.all.forbid_flag[0].disabled = true;
				document.all.forbid_flag[1].disabled = true;
    }	
}
}
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=loginAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="2280" ;                   			 		//操作代码
	var phoneNo="<%=phoneNo%>";                  	 		//客户电话
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;   
  }

  function printInfo(printType)
  {
     //   var   opType = document.all.Sel_Favour_name.options[document.all.Sel_Favour_name.options.selectedIndex].value;

    var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
    
    opr_info+='<%=workName%>'+"|";
    opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|"; 
   	cust_info+="手机号码："+document.all.phone_no.value+"|";
    cust_info+="客户姓名："+document.all.user_name.value+"|";  
    cust_info+="证件号码："+document.all.id_code.value+"|";
    cust_info+="客户地址："+document.all.contact_address.value+ "|";
    cust_info+="联系人电话："+document.all.contact_phone.value + "|";

    opr_info+="申请含阀值催费短信业务|";
	opr_info+="操作流水:"+document.all.loginAccept.value + "|";
    opr_info+=document.all.awake_fee.value +"当您收集帐户中当前可用话费余额(预存款-未出账话费)小于等于阀值时,向你发送催费短信.|";
    note_info1+="备注：";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
  }
//--------------add by notturno end


function doReset(){
	frm1109.reset();
	document.frm1109.Button1.disabled=false;
	//document.frm1109.Button2.disabled=true;
	document.all.phone_no.disabled=false;
	document.frm1109.phone_no.focus();
}

function do_switch()
{
	if(document.all.forbid_switch[0].checked)
	{
		document.all.forbid_flag[0].value = '1';
//		document.all.forbid_flag[1].value = '0';
	}
	else if(document.all.forbid_switch[1].checked)
	{
		document.all.forbid_flag[0].value = '2';
//		document.all.forbid_flag[1].value = '0';
	}
	else
	{
		alert("error");
	}
	//alert(document.all.forbid_flag[0].value);
	//alert(document.all.forbid_flag[1].value);
	//alert(document.all.forbid_flag[0].value);
//	alert(document.all.forbid_flag[1].value);
}


</SCRIPT>

<FORM method=post name="frm1109" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">短信催缴定制</div>
	</div>
<table cellspacing="0">
		<tr>
	    		 <TD class="blue" colspan="2"><input type="radio" name="forbid_switch" id="forbid_switch" value="0" checked onclick="do_switch()"/>普通禁催</TD>
		 <TD class="blue" colspan="2"><input type="radio" name="forbid_switch" id="forbid_switch" value="1" onclick="do_switch()" />包年禁催</TD>

	  </tr>

	<tr>
		<TD class="blue">操作类型</TD>
		<TD class="blue">
			<input type="radio" name="do_type" id="do_type" value="0" checked onclick="change()"/>增加</TD>
		<TD colspan="2" class="blue">
			<input type="radio" name="do_type" id="do_type" value="1" onclick="change()" />删除</TD>
	</tr>

	<TR> 
		<TD class="blue">手机号码</TD>
		<TD colspan="3">
			<input type="text" class="InputGrey" readOnly name="phone_no" id="phone_no" value="<%=phoneNo%>" v_type=int maxlength="11" onKeyDown="if(event.keyCode==13) doSearch();" >
			<input type="button" class="b_text" name="Button1" value="校验" onclick="doSearch()">
		</td>	
	</TR>
	<TR> 
		<TD class="blue">客户姓名</TD>        
		<TD>
			<input class="InputGrey" name="user_name" size="20" maxlength="8" readonly >
		</TD>   
		<TD class="blue">当前状态</TD>          
		<TD>
			<input readonly class="InputGrey" name="user_address" size="20" maxlength="8" >
		</TD>
	</TR>
	<TR> 
		<TD class="blue">证件类型</TD>
		<TD>
			<input readonly class="InputGrey" name="id_type" size="20" maxlength="6">
		</TD>
		<TD class="blue">证件号码</TD>
		<TD>
			<input readonly  class="InputGrey" name="id_code" size="20" maxlength="8" >
		</TD>
	</TR>
		
	<TR> 
		<TD class="blue">提醒次数</TD>
		<TD>
			<input class="button" name="awake_times" size="20" maxlength="8">
		</TD>
		<TD class="blue">提醒费用阀值</TD>
		<TD>
			<input class="button" name="awake_fee" size="20" maxlength="6">
		</TD>
	</TR>
	<TR> 
		<TD class="blue">催缴次数</TD>
		<TD colspan="3">
			<input class="button" name="calling_times" size="20" maxlength="6">
		</TD>
	</TR>
	<TR> 
		<TD class="blue">开始时间</TD>
		<TD>
			<input class="button" name="begin_hm" size="20" maxlength="4">(4位数字，表示小时和分钟)
		</TD>
		<TD class="blue">结束时间</TD>
		<TD>
			<input class="button" name="end_hm" size="20" maxlength="4">(4位数字，表示小时和分钟)
		</TD>
	</TR>
	<TR> 
		<TD class="blue">启用提醒/催缴时间</TD>  
		<TD>
			<input type="radio" name="time_flag" id="time_flag" value="1" checked onclick="isusetime()"/>是
			<input type="radio" name="time_flag" id="time_flag" value="0" onclick="isusetime()"/>否
		</TD>
		<TD class="blue">禁止提醒/催缴</TD>
		<TD>
			<input type="radio" name="forbid_flag" id="forbid_flag" value="1" checked onclick="isuse()"/>是
			<input type="radio" name="forbid_flag" id="forbid_flag" value="0" onclick="isuse()"/>否
		</TD>
	</TR>
		
	<TR> 
		<TD class="blue">备注</TD>
		<TD colspan="3"><input type="text" class="InputGrey" readOnly name="note" value="" size="35"></TD>
		<TD><input class="button" type="hidden" name="busy_type" id="busy_type" ></TD>
	</TR>
		<input type="hidden" name="contact_address"  value="">
		<input type="hidden" name="contact_phone"  value="">
		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
		<input type="hidden" name="region_code" value="<%=region_code%>">
	<tr> 
		<td align="center" id="footer" colspan="4">
			&nbsp; <input class="b_foot" name="Button2" id="Button2" type="button" onClick="doCheck()" value="  确 认  " >
			&nbsp; <input class="b_foot" name="Button3" id="Button3" type="button" onClick="doReset()" value="  清 除  " >
			&nbsp; <input class="b_foot" name="back" onClick="removeCurrentTab()" type=button value="关 闭">
		</td>
	</tr>
</table>
       <%@ include file="/npage/include/footer.jsp" %>

</FORM>
  <OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
</BODY></HTML>
<!--***********************************************************************-->
