   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-23
********************/
%>
              
<%
  String opCode = "1451";
  String opName = "电子帐单受理";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
    String loginName = (String)session.getAttribute("workName");
String regionCode = (String)session.getAttribute("regCode");

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));

	String dirtPage=request.getParameter("dirtPage");

String accountType = (String)session.getAttribute("accountType");

//----------------------------------------------------------
  
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl_t" /> 


<%

String  sysAcceptl =sysAcceptl_t;
  request.setCharacterEncoding("GBK");

  HashMap hm=new HashMap();
  hm.put("1","没有客户ID！");
  hm.put("3","密码错误！");
  hm.put("4","手续费不确定，您不能进行任何操作！");
  
  hm.put("2","未取到数据1，请核查数据或咨询系统管理员！");
  hm.put("10","未取到数据2，请核查数据或咨询系统管理员！");
  hm.put("11","未取到数据3，请核查数据或咨询系统管理员！");
  hm.put("12","未取到数据4，请核查数据或咨询系统管理员！");
  hm.put("13","未取到数据5，请核查数据或咨询系统管理员！");
  hm.put("14","未取到数据6，请核查数据或咨询系统管理员！");
  String op_name="";
  String op_code = request.getParameter("op_code");
  //System.out.println("op_code === "+ op_code );
  //op_code="1250";
 
  if(op_code.equals("1220"))
    op_name="换卡变更";
  else if(op_code.equals("1217"))
    op_name="预销恢复";
  else if(op_code.equals("1260"))
    op_name="预拆恢复";
  else if(op_code.equals("2419"))
    op_name="积分转赠业务受理";
  else if(op_code.equals("1296"))
    op_name="动感地带积分转赠";
  else if(op_code.equals("1250"))
    op_name="积分兑奖";
  else if(op_code.equals("1221"))
    op_name="换卡冲正";
  else if(op_code.equals("1353"))
    op_name="工单补打";
  else if(op_code.equals("1290"))
    op_name="身份证挂失";
  else if(op_code.equals("1291"))
    op_name="手机证券申请";
  else if(op_code.equals("1295"))
    op_name="手续费";
  else if(op_code.equals("1299"))
    op_name="动感地带M值兑换";
  else if(op_code.equals("2420"))
    op_name="积分转赠业务冲正";
  else if(op_code.equals("2421"))
    op_name="改号通知业务";
  else if(op_code.equals("1442"))
    op_name="SIM卡营销";
  else if(op_code.equals("1445"))
    op_name="全球通签约计划";
  else if(op_code.equals("1448"))
    op_name="邮寄帐单";
  else if(op_code.equals("7114"))
    op_name="详单查询短信提醒";
  else if(op_code.equals("1458"))
    op_name="信息收集";
  else if(op_code.equals("1469"))
    op_name="全网sp业务退费";
  else if(op_code.equals("7115"))
    op_name="商务电话免费换机";
  else if(op_code.equals("2299"))
    op_name="二代身份证读卡器设置";
  else if(op_code.equals("1499"))
    op_name="数据业务付奖类型维护";
  else if(op_code.equals("1451"))
    op_name="电子帐单受理";
  else if(op_code.equals("1452"))
    op_name="二代身份证";
  else if(op_code.equals("5036"))
    op_name="客服系统套餐配制";
  else if(op_code.equals("5037"))
    op_name="卡类费用查询";
  else if(op_code.equals("1577"))
    op_name="彩信核检话单查询";
  else if(op_code.equals("1446"))
    op_name="改号通知";
  else if(op_code.equals("1440"))
    op_name="新业务兑奖";
  else if(op_code.equals("5118"))
    op_name="数据业务付奖";
  else if(op_code.equals("1449"))
    op_name="全球通签约计划冲正";
  else if(op_code.equals("1450"))
    op_name="积分兑换冲正";
  else if(op_code.equals("1443"))
    op_name="四季有礼";
  else if(op_code.equals("2267"))
    op_name="手机用户实名预登记查询/确认";
  else if(op_code.equals("2266"))
    op_name="促销品统一付奖";
  else if(op_code.equals("2849"))
    op_name="垃圾短信集团反馈结果信息查询";
  else if(op_code.equals("5303"))
    op_name="工号登陆短信提醒配置";
  else if(op_code.equals("5309"))
    op_name="工号登陆短信提醒配置历史查询";
%>


<html>
<head>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>


<title><%=op_name%></title>

<!-------------------------------------------->
<!---日期:  2005-11-22                    ---->
<!---作者:  王良                          ---->
<!---代码:  f1451.jsp                     ---->
<!---功能 Email受理                     ---->
<!---修改                               ---->
<!-------------------------------------------->

<script language=javascript>
<!--
 
  onload=function()
  {
    	self.status="";
  }
 
function simChk()
{
 
  var myPacket = new AJAXPacket("postSimEmail.jsp","正在查询客户，请稍候......");
	myPacket.data.add("phoneNo",(document.all.phoneno.value).trim());
	myPacket.data.add("opCode",(document.all.op_code.value).trim());
	for(var i = 0 ; i < document.all.r_cus.length ; i ++){
	if(document.all.r_cus[i].checked){
			var value = document.all.r_cus[i].value;
			myPacket.data.add("r_cus",(value).trim());
		}
	}
	core.ajax.sendPacket(myPacket);
	myPacket = null;
  }


 //--------4---------doProcess函数----------------
function doProcess(packet)
{
 	var vRetPage=packet.data.findValueByName("rpc_page");  
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");

	var mail_address1 = packet.data.findValueByName("mail_address1");
	var mail_address2 = packet.data.findValueByName("mail_address2");
	var mail_address3 = packet.data.findValueByName("mail_address3");
	var cust_iccid = packet.data.findValueByName("cust_iccid");
	var cust_name = packet.data.findValueByName("cust_name");
	var has_paper_bill = packet.data.findValueByName("has_paper_bill");
	
	if(retCode == "000000"){
		if(mail_address1!="NULL")
		document.all.mail_address1.value = mail_address1;
		/*if(mail_address2!="NULL")
		document.all.mail_address2.value = mail_address2;
		if(mail_address3!="NULL")
		document.all.mail_address3.value = mail_address3;
		by wangdx 2009.7.7*/
		document.all.cust_iccid.value = cust_iccid;
		document.all.cust_name.value = cust_name;
		document.all.confirm.disabled=false;
		if (has_paper_bill == "1" &&(	document.all.r_cus[0].checked||document.all.r_cus[1].checked)){
			rdShowMessageDialog("重要提示:\n    如果用户定制电子帐单，其邮寄帐单和电子帐单并行发送三个月，三个月后将自动取消邮寄帐单的寄送。如果用户在并行期内取消电子帐单，邮寄帐单在并行期结束后随之取消!");
		}
	}else
	{
		rdShowMessageDialog("错误:"+ retCode + "->" + retMsg,0);
		return;
	}    
    
}

//-------2---------验证及提交函数-----------------

function printCommit()
{
	getAfterPrompt();
	//校验
	
  if(!checkElement(document.f1451.phoneno)) return false;
  
  if (document.all.mail_address1.value == ""){
  	rdShowMessageDialog("请您添入该用户的Email地址1!",0);
  	document.f1451.mail_address1.focus();
  	return false;
  }
  else{
  	if(!forMail(document.f1451.mail_address1)) return false;
  	}
  
  //当增加或修改时，提示选择客户信息
	if(document.all.r_cus[0].checked||document.all.r_cus[1].checked){  
 		if (document.all.tran_content.value == "0"){
  		rdShowMessageDialog("请选择询问客户信息,是否接受!",0);
  		document.f1451.tran_content.focus();
  		return false;
  	}
	}
   
 	if(!check(document.f1451)) return false;
	
   //打印工单并提交表单
	document.all.t_sys_remark.value="用户"  + document.all.phoneno.value + "Email受理";
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");

  if((ret=="confirm")){
  	if(rdShowConfirmDialog('确认要提交信息吗？')==1){  
	  	f1451.submit();
    }
		
		if(ret=="remark"){
         if(rdShowConfirmDialog('确认要提交信息吗？')==1)
         {
	       　f1451.submit();
         }
	   }
	}
    else
    {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
	     　f1451.submit();
       }
    }	
    return true;
  }
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
     var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 

     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =<%=sysAcceptl%>;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = <%=activePhone%>;                            //客户电话
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
     return ret;    
  }

  function printInfo(printType)
  {
 
       	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
    cust_info+="手机号码："+document.all.phoneno.value+"|";
    cust_info+="客户姓名："+document.all.cust_name.value+"|";  
    
    
    opr_info+="E_maild地址1："+document.all.mail_address1.value+"|||";
    /*opr_info+="E_maild地址2："+document.all.mail_address2.value+"|";
    opr_info+="E_maild地址3："+document.all.mail_address3.value+"|";*/
    opr_info+="身份证号："+document.all.cust_iccid.value+"|";
    
    
    if (document.all.tran_content.value == "Y"){
    	opr_info+="接收移动公司相关资费和业务信息是："+"|";
  	}else{
  		opr_info+="接收移动公司相关资费和业务信息否："+"|";
  	}
    opr_info+="    业务类型："+'<%=op_name%>'+"|";
    if(document.all.r_cus[0].checked)
	{
      opr_info+="    操作类型："+"添加"+"|";
	}
	if(document.all.r_cus[1].checked)
	{
      opr_info+="     操作类型："+"修改"+"|";
	}
	if(document.all.r_cus[2].checked)
	{
      opr_info+="    操作类型："+"删除"+"|";
	}
    opr_info+="流水："+document.all.loginAccept.value+"|";
    note_info1+="备注："+document.all.t_sys_remark.value+"|";
    note_info2+="备注："+document.all.t_op_remark.value+" "+document.all.simBell.value+"|";
      

		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
    return retInfo;;	
  }

 //-->
 
//如果为客服工号则直接展现页面   hejwa add 2013年10月15日15:57:56         
$(document).ready(function(){
	if("<%=accountType%>"=="2"){
			$("#qryId_No").hide();
			simChk();
	}
});
 
</script>

<%@ include file="../../page/common/pwd_comm.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.S1100View" %>
 



</head>
<script language=javascript>
function showWorldMsg()
{
		
     if( document.all.r_cus[0].checked){}
}
</script>
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<form action="f1451BackCfm.jsp" method="POST" name="f1451"  onKeyUp="chgFocus(f1451)">
	<%@ include file="/npage/include/header.jsp" %>                         

	<%@ include file="../../include/remark.htm" %>
	<div class="title">
		<div id="title_zi">电子帐单受理</div>
	</div>
	<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<input type="hidden" name="loginAccept" value="<%=sysAcceptl%>">

        <table cellspacing="0">
          <tr> 
            <td   nowrap width="10%" height=10 class="blue">操作类型</td>
            <td   nowrap colspan="3" height=10>
            <input type="radio" name="r_cus" index="0" value="0" checked >添加
  					<input type="radio" name="r_cus"  index="1" value="1">修改
  					<input type="radio" name="r_cus" index= "2" value="2">取消
            </td>
          </tr>
          <tr> 
            <td  nowrap width="10%" class="blue">用户号码</td>
            <td nowrap  colspan="3"> 
              <input   type="text" name="phoneno"   v_must=1  v_type="mobphone" onBlur="if(this.value!=''){if(checkElement(document.f1451.phoneno)==false){return false;}}" maxlength=11  index="6"  value =<%=activePhone%>  Class="InputGrey" readOnly >	               
            <font class="orange">*</font>
            <input class="b_text" type="button" name="qryId_No" id="qryId_No" value="查询" onClick="simChk()" >            </td>
          </tr>
          <tr> 
            <td   nowrap width="16%" class="blue">用户名称</td>
            <td  nowrap  width="34%"> 
              <input type="text"  name="cust_name"  v_minlength=0 v_maxlength=60  v_type=string  v_name="用户名称" maxlength=10 value="" tabindex="0" readonly class="InputGrey"  >
            </td>
            <td  nowrap  width="16%" class="blue">身份证号码</td>
            <td  nowrap  width="34%"> 
             <input type="text"  name="cust_iccid" maxlength=60 v_must=0 v_minlength=0 v_type=string v_name = "身份证号码" value="" tabindex="0" readonly class="InputGrey"  >
            </td>
          </tr>
         <tr> 
            <td   nowrap width="16%" class="blue">E_mail地址</td>
            <td  nowrap  width="34%"> 
              <input  type="test" name="mail_address1" v_must=0 v_name="E_mail地址1"  v_type=string v_minlength=0 size="40" value="">
              <font class="orange">*</font>
            </td>
            <td  nowrap  width="16%" class="blue">询问客户</td>
            <td  nowrap  width="34%"> 
								<select name ="tran_content">
									<option class='button' value='0' selected>未选择</option>
									<option class='button' value='Y' >是</option>
									<option class='button' value='N' >否</option>
								</select>
								<font class="orange">*接收移动公司相关资费和业务信息</font>
							</td>
          </tr>
            <!--<td   nowrap height=10 class="blue">E_mail地址2</td>
             <td   nowrap colspan="3" height=10>
              <input  type="test" name="mail_address2" v_must=0 v_name="E_mail地址2"  v_type=string v_minlength=0 size="40" value="">
             </td>
          </tr>
          <tr> 
            <td   nowrap height=10 class="blue">E_mail地址3</td>
             <td   nowrap colspan="3" height=10>
              <input  type="test" name="mail_address3" v_must=0 v_name="E_mail地址3"  v_type=string v_minlength=0 size="40" value="">
             </td>
          </tr>-->
          <tr > 
            <td valign="top" class="blue"> 
              <div align="left">系统备注</div>
            </td>
            <td colspan="4" valign="top"> 
              <input type="text" class="InputGrey"  name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30>
              <input type="hidden"  name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  v_name="用户备注" index="28" maxlength=60> 
            </td>
          </tr>
 
          <tr > 
            <td colspan="4" height="30" id="footer"> 
              <div align="center"> 
                <input  type="button" name="confirm" class="b_foot_long" value="打印&确认"  onClick="printCommit()" index="26" disabled >
                <input  type=reset name=back value="清除" class="b_foot" onClick="document.all.confirm.disabled=true;" >
                <input  type="button" name="b_back" value="返回"  class="b_foot" onClick="window.close()" index="28">
              </div>
            </td>
          </tr>
        </table>
 
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>


</html>
