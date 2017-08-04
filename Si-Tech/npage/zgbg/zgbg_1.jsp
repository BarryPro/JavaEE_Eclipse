<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "zgbg";
		String opName = "专票拆分开具申请";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*默认，12个月之前*/
    String startTime = sdf.format(today.getTime());
	activePhone = request.getParameter("activePhone");	
%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function cx()
{
	/* 
	var prtFlag=0;
	prtFlag=rdShowConfirmDialog("是否确定进行虚拟集团添加操作?");
	if (prtFlag==1){
		document.frm.action="zg44_2.jsp?unit_id="+document.frm.phoneNo.value+"&contract_name="+document.frm.contract_name.value;
		//alert(document.frm.action);
		document.frm.submit();
	}
	else
	{ 
		return false;	
	}
	*/
	//ajax 校验该纳税人识别号码是否已在o001生效
	var phoneNo = document.all.phoneNo.value;
	var ym = document.all.ym.value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("请输入产品号码!");
		return false;
	}
	else if(ym=="")
	{
		rdShowMessageDialog("请输入开票账期!");
		return false;
	}
	else
	{
		var myPacket = new AJAXPacket("zgbg_check.jsp","正在提交，请稍候......");
		//校验产品号码是否申请审批通过 校验通过后调用专票查询接口
		myPacket.data.add("phoneNo",phoneNo);
		myPacket.data.add("ym",ym);
		core.ajax.sendPacket(myPacket,doPosSubInfo3);
		myPacket=null;
	}
	
}
 function doPosSubInfo3(packet)
 {
	 //alert("2");
	 var s_flag =  packet.data.findValueByName("s_flag");
	 var i_count =  packet.data.findValueByName("i_count");
	 var phoneNo = document.all.phoneNo.value;
	 var ym = document.all.ym.value;
	 alert("s_flag is "+s_flag+" and i_count is "+i_count);
	 if(s_flag==0)
	 {
		 if(i_count>0)
		 {
			 //出现选择页面 选择要开具的纳税人识别号码信息
			 //document.frm.action="zgbg_2.jsp?phoneNo="+phoneNo+"&ym="+ym;//展示分项信息 调用staxtailadd接口进行录入
			 //document.frm.submit();
				var h=480;
				var w=650;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
				returnValue = window.showModalDialog('getCount.jsp?phoneNo='+phoneNo,"",prop);
				//alert(returnValue);
				document.all.s_tax_no.value=returnValue.split(",")[0];
				document.all.s_tax_name.value=returnValue.split(",")[1];
				document.all.s_tax_address.value=returnValue.split(",")[2];
				document.all.s_tax_phone.value=returnValue.split(",")[3];
				document.all.s_tax_khh.value=returnValue.split(",")[4];
				document.all.s_tax_contract.value=returnValue.split(",")[5];
				document.frm.action="zgbg_2.jsp?phoneNo="+phoneNo+"&ym="+ym+"&s_tax_no="+document.all.s_tax_no.value+"&s_tax_name="+document.all.s_tax_name.value+"&s_tax_address="+document.all.s_tax_address.value+"&s_tax_phone="+document.all.s_tax_phone.value+"&s_tax_khh="+document.all.s_tax_khh.value+"&s_tax_contract="+document.all.s_tax_contract.value;
				//alert(document.frm.action);
				document.frm.submit();
		 }
		 else
		 {
			rdShowMessageDialog("该产品号码在系统中无效,请校验有效性!");
			return false;
		 }	
	 }	
	 else
	 {
		 //rdShowMessageDialog("该产品号码在系统中无效,请校验有效性!");
		 rdShowMessageDialog("产品号码校验合法性失败!");
	     return false;
	 } 
	
 } 


 function doclear() {
 		frm.reset();
 }
   
 function sel1() {
 		window.location.href='zgbe_1.jsp';
 }

  
 
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">请输入产品号码</div>
	</div>
	
	 
	
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">产品号码</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="24" maxlength="24"  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
      
    </tr>
	<tr> 
      <td class="blue" width="15%">开票账期</td>
      <td> 
        <input class="button"type="text" name="ym" size="6" maxlength="6"  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
      
    </tr> 
  </table>
<input type="hidden" name="s_tax_no">
<input type="hidden" name="s_tax_name">
<input type="hidden" name="s_tax_address">
<input type="hidden" name="s_tax_phone">
<input type="hidden" name="s_tax_khh">
<input type="hidden" name="s_tax_contract">
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="查询" onclick="cx()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>