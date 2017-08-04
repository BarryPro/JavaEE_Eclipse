<%
/********************
 version v2.0
开发商: si-tech
*
*update:liutong@2008-8-15
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>



<%
		/**ArrayList arr = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfo = (String[][])arr.get(0);
		String workno = baseInfo[0][2];
		String workname = baseInfo[0][3];
		String org_code = baseInfo[0][16];
		String belongName = baseInfo[0][16];
		String[][] password = (String[][])arr.get(4);//读取工号密码 
		String pass = password[0][0];
		String[][] info1 = (String[][])arr.get(1);
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		**/
		String opCode = "d340";
		String opName = "集团缴费";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String account_id=request.getParameter("account_id");
		//alert(uid+" and invoice_money is "+invoice_money+" and loginaccept is "+loginaccept);
		String invoice_money = request.getParameter("invoice_money");
		String loginaccept = request.getParameter("loginaccept");
		String print_flag = request.getParameter("print_flag"); 
%>
<HTML><HEAD>

<script language="JavaScript">
 	
  
   function doProcess(packet)
  {
    /* if(document.frm.contractno.value=="")
      {
			rdShowMessageDialog("请输入帐户号码!");
			document.frm.contractno.focus();
			return false;
     } */
    var retResult=packet.data.findValueByName("retResult");
	if(retResult == "false")
	  {
	rdShowMessageDialog("客户密码过于简单,请修改密码！");
      } 
    docheck(); 
  }
  function getpasswd(){
  	if(document.all.contractno.value.trim().len()==0 && document.all.phonenoGroup.value.trim().len()==0){
  		rdShowMessageDialog("请输入正确的服务号码!");
		document.all.contractno.focus();
  		return false;
  	}
  	 /*
   	var myPacket = new AJAXPacket("getpasswd_group.jsp","正在查询客户，请稍候......");
		myPacket.data.add("contractNo",(document.all.contractno.value).trim());
		myPacket.data.add("busyType",(document.all.busy_type.value).trim());
		core.ajax.sendPacket(myPacket);
		myPacket=null;*/
	//xl 按旭升哥要求，单击“查询”后，将“查询”置为不可选状态。
	 
	document.frm.query.disabled = true;
	docheck(); 
  }
  
  

 function init()
 {
    var account_id="<%=account_id%>";
	//xl add 增加流水 金额字段
	var invoice_money = "<%=invoice_money%>";
	var loginaccept = "<%=loginaccept%>";
	var print_flag = "<%=print_flag%>";
	if(account_id=="null")
	{
		document.frm.contractno.focus(); 
	}
	else
	{
		document.frm.contractno.value=account_id;
		document.frm.login_aceept.value=loginaccept; 
		document.frm.invoice_money.value=invoice_money; 
		document.frm.print_flag.value=print_flag; 
	}
	  
 }
 function doclear() {
 		frm.reset();
 }
 
function sel1() {
 		window.location.href='s1300_group.jsp';
 }

 function sel2(){
    window.location.href='s1300_groupPhone.jsp';
 }
 </script> 
 
<title>黑龙江BOSS-集团账号缴费</title>
</head>
<BODY  onLoad="init()" >
<FORM action="" method="post" name="frm"  >
<input type="hidden" name="busy_type"  value="2">
<input type="hidden" name="op_code"  value="d340">
<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
<input type="hidden" name="water_number"  >
<input type="hidden" name="phoneNo"  value="" >
    
 <%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">集团账号缴费</div>
		</div>
              <!--
			  <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue" width="15%">缴费方式</td>
                  <td colspan="3"> 
                    
                    <input name="busyType1" type="radio" onClick="sel1()"    value="1"  checked>
                    帐户号码 
                    <input name="busyType2" type="radio" onClick="sel2()" value="2"> 集团手机号码 
					</td>
                 </tr>   
                </tbody> 
              </table>
			  -->
              <table cellspacing="0" >
                <tr> 
                  <td  class="blue" width="15%">帐户号码</td>
                  <td> 
                    <input type="text" name="contractno" size="20" maxlength="20" style="ime-mode:disabled"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) getpasswd();" index="5">
                  </td>
                   <!--xl add for 预开发票 流水 金额字段 begin-->
				   <input type="hidden" id="login_aceept" name="login_aceept">
				   <input type="hidden" id="invoice_money" name="invoice_money">
				   <input type="hidden" id="print_flag" name="print_flag">
				   <!--end for 预开发票 流水 金额字段 begin-->
				   <td  class="blue" width="15%">集团手机号码</td>
                  <td> 
                    <input type="text" name="phonenoGroup" size="20" maxlength="20" style="ime-mode:disabled"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) getpasswd();" index="5">
                  </td>
                 
 				</tr>
              </table>
         
        <TABLE cellSpacing="0">
          <TR > 
            <TD noWrap colspan="6" id="footer"> 
              <div align="center"> 
                <input type="button" name="query"  class="b_foot" value="查询" onclick="getpasswd()"  >
                &nbsp;
                <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
             
                &nbsp;
               <input type="button" name="return2" class="b_foot" value="关闭" onClick="parent.removeTab('<%=opCode%>');"  >
              </div>
            </TD>
          </TR>
        </TABLE>
      
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
  
</FORM>
<SCRIPT LANGUAGE="JavaScript">
<!--
var h=480;
var w=650;
var t=screen.availHeight/2-h/2;
var l=screen.availWidth/2-w/2;
var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";


 

 

 
 function docheck()
 {
	document.frm.action="s1300Cfm_group.jsp";
    document.frm.submit();
}

//-->
</SCRIPT>

</BODY>
</HTML>
