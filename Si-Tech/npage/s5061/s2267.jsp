<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-16 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
   
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	String regionCode= (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
<html>
<head>
	<title><%=opName%></title>
<script language=javascript>
<!--
 
  onload=function()
  {
  	document.all.phoneno.focus();   	
  }
 
 	function PhoneChk()
 	{
 		if((document.all.phoneno.value.trim()).length<1)
		{
   		rdShowMessageDialog("手机号码不能为空！");
 	  	return;
		} 

  		var myPacket = new AJAXPacket("post2267Qry.jsp","正在查询客户，请稍候......");
		myPacket.data.add("phoneNo",document.all.phoneno.value.trim());
		myPacket.data.add("opCode",document.all.op_code.value.trim());
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
  
 //--------4---------doProcess函数----------------
function doProcess(packet)
{
	var vRetPage=packet.data.findValueByName("rpc_page");  
	var retCode = packet.data.findValueByName("retCode");
  	var retMsg = packet.data.findValueByName("retMsg");
	var cust_name = packet.data.findValueByName("cust_name");
	var type_name = packet.data.findValueByName("type_name");
	var type_no = packet.data.findValueByName("type_no");
	var contact_no = packet.data.findValueByName("contact_no");
	var cust_address = packet.data.findValueByName("cust_address");
	var valid_flag = packet.data.findValueByName("valid_flag");
	if(retCode == 0){
		document.all.cust_name.value = cust_name;
		document.all.IdType.value = type_name;
		document.all.IdTypeNo.value = type_no;
		document.all.ContactNo.value = contact_no;
		document.all.user_address.value = cust_address;
		
		if (valid_flag == '1')
		{
			rdShowMessageDialog("错误: 100003 -> 用户已经办理过实名预登记信息确认");
		}else
		{
			document.all.confirm.disabled=false;
		}
		
	}else
	{
		rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
		return;
	}    
    
}

//-------2---------验证及提交函数-----------------

function printCommit(){
    getAfterPrompt();
	//校验
    if(!checkElement(document.s2267.phoneno)) return false;	
    
    if (document.all.ContactNo.value.length < 7)
    {
    	alert("请添入有效的联系方式!")
    	return false;
    }
    
    if (document.all.user_address.value.length < 8)
    {
    	alert("请添入有效的用户居住地址!")
    	return false;
    }
    
    
	//if(!check(s2267)) return false;
   //打印工单并提交表单
   document.all.op_mark.value="用户"  + document.all.phoneno.value + "实名信息登记";
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");

     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？')==1)
        {  
	      　s2267.submit();
        }


	    if(ret=="remark")
	    {
         if(rdShowConfirmDialog('确认要提交信息吗？')==1)
         {
	       s2267.submit();
         }
	   }
	}
    else
    {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
	     s2267.submit();
       }
    }	
    return true;
  }
  
function showPrtDlg(printType,DlgMessage,submitCfm)
{  
	//显示打印对话框 		
	var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
	var billType="1";                      //  票价类型1电子免填单、2发票、3收据
	var sysAccept ="<%=sysAcceptl%>";                       // 流水号
	var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
	var mode_code=null;                        //资费代码
	var fav_code=null;                         //特服代码
	var area_code=null;                    //小区代码
	var opCode =   "<%=opCode%>";                         //操作代码
	var phoneNo = <%=activePhone%>;                           //客户电话		
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);    

}

 function printInfo(printType)
 { 	
		
	var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var retInfo = "";  //打印内容
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4 
	
	cust_info+="客户姓名：   "+document.all.cust_name.value+"|";
	cust_info+="手机号码：   "+document.all.phoneno.value+"|";  
	
	opr_info+="办理业务："+"手机用户实名预登记查询/确认"+"|";
    note_info1+="备注："+"|";
	
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
	return retInfo;	
 }

 //-->
</script>

</head>
<body> 
<form action="2267Cfm.jsp" method="POST" name="s2267"  onKeyUp="chgFocus(s2267)">
	
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">手机用户实名预登记查询/确认</div>
	</div>	
	<input type="hidden" name="op_code" id="op_code" value="<%=opCode%>">
	<input type="hidden" name="op_type" id="op_type" value="a">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	
	<input type="hidden" name="opName" value="<%=opName%>">
	
	<table cellspacing="0">
		<tr> 
			<td  nowrap width="10%" class="blue">用户号码</td>
			<td nowrap   colspan="3"> 
				<input   type="text" name="phoneno"  v_must=1  v_type="mobphone"  maxlength=11  index="6" value =<%=activePhone%>  readonly class="InputGrey">
				<font class="orange">*</font> 				            
				<input  type="button" name="qryId_No" class="b_text" value="查询" onClick="PhoneChk()" >            
			</td>    
		</tr>
		<tr> 
			<td  nowrap width="10%" class="blue">用户名称</td>
			<td  nowrap  width="40%"> 
				<input name="cust_name" type="text"   index="6" readonly class="InputGrey">
			</td>
			<td  nowrap  width="10%" class="blue">有效证件类型</td>
			<td  nowrap  width="40%"> 
				<input  type="text" name="IdType" size="30" value="" readonly class="InputGrey">
			</td>
		</tr>
		<tr> 
			<td  nowrap width="10%" class="blue">有效证件号码</td>
			<td  nowrap  width="40%"> 
				<input  type="text" name="IdTypeNo" size="30" value=""  readonly class="InputGrey">
			</td>
			<td  nowrap  width="10%" class="blue">有效联系方式</td>
			<td  nowrap  width="40%"> 
				<input  type="text" name="ContactNo" size="30" value="">
			</td>
		</tr>
		<tr> 
			<td class="blue"> 用户居住地址</td>
			<td colspan="3"> 
				<input type="text"  name="user_address" id="user_address" size="60"  maxlength=30>
			</td>
		</tr>
		<tr>
			<td class="blue"> 操作备注</td>		
			<td colspan="3" > 
				<input type="text"  name="op_mark" id="op_mark" size="60" v_maxlength=60  v_type=string   index="28" readonly class="InputGrey" maxlength=60> 
			</td>
		</tr>
	</table>	
	<table cellspacing="0">
		<tr>
			<td id="footer">	
      				<input  type="button" name="confirm" class="b_foot_long" value="打印&确认"  onClick="printCommit()" index="26" disabled >
      				<input  type=reset name=back value="清除" class="b_foot" onClick="document.all.confirm.disabled=true;" >
      				<input  type="button" name="b_back" class="b_foot" value="返回"  onClick="removeCurrentTab()" index="28">    	
    			</td>
    		</tr>
	</table>	
	<%@ include file="/npage/include/footer.jsp" %> 
	<input type="hidden" value="<%=sysAcceptl%>" name="loginAccept"/>
</form>
</body>
</html>

