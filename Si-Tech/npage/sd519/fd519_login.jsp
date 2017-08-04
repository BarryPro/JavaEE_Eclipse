<%
  /*
   * 功能: 预存有礼赠亲朋 d519
   * 版本: 1.8.2
   * 日期: 2011/4/22
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
            
<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ include file="/npage/common/pwd_comm.jsp" %>	
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<%
String regionCode = (String)session.getAttribute("regCode");
String loginNo =  (String)session.getAttribute("workNo");
String phoneNo = (String)request.getParameter("activePhone");
String bindNo = (String)request.getParameter("bindNo")==null? "":(String)request.getParameter("bindNo");
String PrintAccept="";
PrintAccept = getMaxAccept();
String sql="";
%>

<script language="JavaScript">
	function validatePwd()
	{
		if(!check(document.frm)){
			return false;
		}	
		if( document.frm.bindNo.value==""){
			rdShowMessageDialog("绑定老用户号码不能为空，请输入！",1);
			return false;
		}
		if( document.frm.bindPwd.value==""){
			rdShowMessageDialog("绑定老用户号密码不能为空，请输入！",1);
			return false;
		}		
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
				checkPwd_Packet.data.add("custType","01");				//01:手机号码 02 客户密码校验 03帐户密码校验
				checkPwd_Packet.data.add("phoneNo",document.frm.bindNo.value);	//移动号码,客户id,帐户id
				checkPwd_Packet.data.add("custPaswd",document.frm.bindPwd.value);//用户/客户/帐户密码
				checkPwd_Packet.data.add("idType"," ");				//en 密码为密文，其它情况 密码为明文
				checkPwd_Packet.data.add("idNum","");					//传空
				checkPwd_Packet.data.add("loginNo","<%=loginNo%>");		//工号
				core.ajax.sendPacket(checkPwd_Packet,doCheckPwd,true);
				checkPwd_Packet=null;
	}
	
	function doCheckPwd(packet)
	{
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog(msg);
			window.location="fd519_login.jsp?opCode=d519&opName=预存有礼赠亲朋&activePhone=<%=phoneNo%>&bindNo="+document.frm.bindNo.value;
		}else
		{
			getFavourInfo();
		}
	}
	
	function getFavourInfo()
	{
		var packet = new AJAXPacket("getFavourInfo.jsp","正在验证和获取用户信息，请稍候......");
	  packet.data.add("phoneNo",document.frm.phoneNo.value);
	  packet.data.add("bindNo",document.frm.bindNo.value);
	  packet.data.add("op_code",document.frm.iOpCode.value);
	  packet.data.add("login_accept",document.frm.login_accept.value);
	  core.ajax.sendPacket(packet,doFavourInfo);
	  packet = null;	
	}
	
	function doFavourInfo(packet)
	{
	 var retCode = packet.data.findValueByName("retCode");
   var retMsg = packet.data.findValueByName("retMsg");
   if(retCode != "000000")
   {
   	rdShowMessageDialog(retMsg+"！");
   }else
   {	
   	var retFee = packet.data.findValueByName("retFee");	
    var retTerm = packet.data.findValueByName("retTerm");	
    var perFee =Number(retFee)/Number(retTerm);
    document.frm.returnFee.value=retFee;
    document.frm.perFee.value=perFee;    
    document.frm.favourInfo.value="赠送"+retFee+"元话费，分"+retTerm+"个返还，每月返还"+perFee+"元";
   	document.frm.confirmAndPrint.disabled = false;
		var cust_name = packet.data.findValueByName("cust_name");	
		document.frm.cust_name.value=cust_name;
		var cust_address = packet.data.findValueByName("cust_address");	
		document.frm.cust_address.value=cust_address;		
		var id_iccid = packet.data.findValueByName("id_iccid");
		document.frm.id_iccid.value=id_iccid;			
		var sm_code = packet.data.findValueByName("sm_code");	
		document.frm.sm_code.value=sm_code;		
		var sm_name = packet.data.findValueByName("sm_name");	
		document.frm.sm_name.value=sm_name;
		var prepay_fee = packet.data.findValueByName("prepay_fee");	
		document.frm.prepay_fee.value=prepay_fee;		
   }
  }
		
	 function printCommit(){
		  getAfterPrompt();	 
		  document.frm.confirmAndPrint.disabled = true;
		  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
			if(typeof(ret)!="undefined")
			    {
			      if((ret=="confirm"))
			      {
			        if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
			        {
				      	frmCfm();
			        }
				  }
				  if(ret=="continueSub")
				  {
			        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
			        {
				      	frmCfm();
			        }
				  }
			    }
			    else
			    {
			       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
			       {
				    	 frmCfm();
			       }
			    }				  	
	 }
	 
	 	function frmCfm(){
	 		document.frm.action = "fd519Cfm.jsp";
	 		document.frm.submit();
		}
		
		function showPrtDlg(printType,DlgMessage,submitCfm)
    {  //显示打印对话框 
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
			var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
			var sysAccept=<%=PrintAccept%>;                            // 流水号
			var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
			var mode_code=null;                                        //资费代码
			var fav_code=null;                                         //特服代码
			var area_code=null;                                        //小区代码
			var opCode="<%=opCode%>";                                  //操作代码
			var phoneNo=document.frm.phoneNo.value;                 //客户电话
		
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;		
  }

  function printInfo(printType)
  {
	  var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		var retInfo = "";
		
		cust_info+="手机号码："+document.frm.phoneNo.value+"|";
		cust_info+="客户姓名："+document.frm.cust_name.value+"|";
		cust_info+="客户地址："+document.frm.cust_address.value+"|";
		cust_info+="证件号码："+document.frm.id_iccid.value+"|";		
 		
		
    opr_info+="用户品牌："+document.all.sm_name.value+"    业务类型：预存有礼赠亲朋"+"|";
		opr_info+="业务流水："+"<%=PrintAccept%>"+"|";
		opr_info+="方案名称：亲朋优惠入网，获赠话费（12个月）"+"|";					
		opr_info+="赠送话费：每月赠送话费"+document.frm.perFee.value+"元"+"|";			

			
		note_info1+="备注：欢迎您参加“预存有礼赠亲朋”活动，根据您亲朋的在网年限，您可获赠话费"+document.frm.returnFee.value+"元，赠送话费将分12个月分月返还，每月返还"+document.frm.perFee.value+"元，赠送话费于活动生效日次月5日内到账。本活动到期前，若签约亲友申请取消，将按照违约处理，您每月获赠话费活动也即刻停止。本次活动未涉及的资费，按现行的移动电话资费标准执行。在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。"+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;		  
  } 
</script>
</HEAD>
<BODY >
<FORM  method=post name=frm >
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div> 
  <table cellspacing="0">
		 	<tr>
	 			<td class="blue">手机号码</td>
	 			<td colspan="3"><input type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" readOnly class="InputGrey"></td>
		 	</tr>
		 		
		 	 <tr>
				<td class="blue" nowrap>绑定老用户号码</td>
				<td> 
					<input type="text" name="bindNo" value="<%=bindNo%>"  name="bindNo" v_type="mobphone" v_must="1" maxlength="11" onblur="checkElement(this)" ><font class="orange">*</font>
		    </td>
				<td class="blue">绑定老用户号密码</td>
				<td> 
					<jsp:include page="/npage/common/pwd_1.jsp">
				      <jsp:param name="width1" value="16%"  />
				      <jsp:param name="width2" value="34%"  />
				      <jsp:param name="pname" value="bindPwd"  />
				      <jsp:param name="pwd" value="account_passwd"  />
			    </jsp:include>
			    <input name=checkout type=button onClick="validatePwd();" class="b_text" style="cursor:hand" id="checkout" value=校验><font class="orange">*</font>
		    </td>
			</tr>
			
		 	<tr>
	 			<td class="blue">可享优惠信息</td>
	 			<td colspan="3"><input type="text" name="favourInfo" id="favourInfo" value="" size="60" readOnly class="InputGrey"></td>
		 	</tr>												
	</table>
	<table>					
		 	<tr>	
		 		<td id="footer" colspan="4">
		 			<input type="button" id="confirmAndPrint" class="b_foot" value="确认&打印" onclick="printCommit()" disabled>
		 			<input type="button" id="colse"  class="b_foot" value="关闭" onclick="removeCurrentTab()">
		 		</td>
		 	</tr>
	</table>
<input type="hidden" name="iOpCode"  value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="login_accept"  value="<%=PrintAccept%>">
<input type="hidden" name="returnFee" id="returnFee">
<input type="hidden" name="perFee" id="perFee">
<input type="hidden" name="cust_address" id="cust_address">
<input type="hidden" name="id_iccid" id="id_iccid">
<input type="hidden" name="sm_code" id="sm_code">
<input type="hidden" name="sm_name" id="sm_name">
<input type="hidden" name="cust_name" id="cust_name">
<input type="hidden" name="prepay_fee" id="prepay_fee">

</FORM>
		<%@ include file="/npage/include/footer.jsp"%>
</BODY> 	
</HTML>
						
  					
