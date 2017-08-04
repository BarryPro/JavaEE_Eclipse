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
		String opCode = "e006";
		String opName = "宽带缴费";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
		
%>
<HTML><HEAD>

<script language="JavaScript">
<!--	
  
   function doProcess(packet)
  {
     if(document.frm.contractno.value=="")
      {
			rdShowMessageDialog("请输入帐户号码!");
			document.frm.contractno.focus();
			return false;
     }
    var retResult=packet.data.findValueByName("retResult");
	if(retResult == "false")
	{
		rdShowMessageDialog("客户密码过于简单,请修改密码！");
    }
	//var i_dp = packet.data.findValueByName("i_dp");
	var s_sm_code = packet.data.findValueByName("s_sm_code"); 
	var contract_new=packet.data.findValueByName("contract_out");
	var phone_new=packet.data.findValueByName("phone_new");
	document.all.phone_input.value=document.all.contractno.value;
	document.all.contractno.value=contract_new;
	document.getElementById("phoneNo").value= phone_new;
	//rdShowMessageDialog("test contract_new is "+contract_new);
	
	//xl add 将品牌传递给cfm页面
	document.getElementById("s_sm_code").value= s_sm_code;
	//xl add 根据品牌判断 非kh的可以继续缴费 kh的就得去zg62做
	if(s_sm_code=="kh")
	{
		rdShowMessageDialog("单品需在zg62进行宽带缴费!");
		return false;
	}
	else
	{
		docheck(); 
	}
    
  }
  function getpasswd(){
  	if(document.all.contractno.value.trim().len()==0){
  		rdShowMessageDialog("宽带号码不能为空!");
  		return false;
  	}
  	
  	document.all.dbBand_Account.value=document.all.contractno.value;
  	document.frm.query.disabled=true;
   	var myPacket = new AJAXPacket("getKdNo_new.jsp","正在查询客户，请稍候......");
		myPacket.data.add("contractNo",(document.all.contractno.value).trim());
		myPacket.data.add("busyType",(document.all.busy_type.value).trim());
		myPacket.data.add("return_page","s1300_2.jsp");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
  }
  
 function sel1()
 {
            window.location.href='s1300.jsp';
 }
 function sel2()
 {
           window.location.href='s1300_2.jsp';
  }
 

 
 function sel5() {
           window.location.href='e034.jsp';
 }

 function init()
 {
    document.frm.contractno.focus();   
 }
 function doclear() {
 		frm.reset();
 }
-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY  onLoad="init()" >
<FORM action="" method="post" name="frm"  >
<input type="hidden" name="busy_type"  value="2">
<input type="hidden" name="op_code"  value="e006">
<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
<input type="hidden" name="water_number"  >
<input type="hidden" name="phoneNo" id = "pno"  value="" >
    
 <%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">请选择缴费方式</div>
		</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue" width="15%">缴费方式</td>
                  <td colspan="3"> 
                    <!--
					<input name="busyType1" type="radio" onClick="sel1()" value="1"  >
                    铁通固话 
					-->
                    <input name="busyType1" type="radio" onClick="sel2()" value="2"  checked>
                    宽带
                    <!--
						<input name="busyType5" type="radio" onClick="sel5()" value="5"  >
                    宽带银行托收
				    -->
					</td>
                 </tr>   
                </tbody> 
              </table>
              <table cellspacing="0" >
                <tr> 
                  <td  class="blue" width="15%">宽带号码</td>
                  <td> 
                    <input type="text" name="contractno" size="20" maxlength="20" style="ime-mode:disabled"   onKeyDown="if(event.keyCode==13) getpasswd();" index="5" >
                  </td>
                  <td nowrap> </td>
                  <td> 
                   </td>
 				</tr>
              </table>
         <input type="hidden" name="phone_input">
         <input type="hidden" name="dbBand_Account">
		 <input type="hidden" id="s_sm_code" name="s_sm_code_name">
		 
        <TABLE cellSpacing="0">
          <TR > 
            <TD noWrap colspan="6" id="footer"> 
              <div align="center"> 
                <input type="button" name="query"  class="b_foot" value="查询" onclick="getpasswd()"  >
                &nbsp;
                <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
                &nbsp;
				<!--
				<input type="button" name="reprint"  class="b_foot" value="重打发票" onclick="doreprint()"  >
                &nbsp;
                <input type="button" name="nopay" class="b_foot_long" value="上笔缴费冲正" onclick="donopay()"  >
                &nbsp;
				-->
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


function querylast()
{
		var opcode = document.all.op_code.value;
		var returnValue="-1";
	  if(document.frm.contractno.value=="")
	  {
				rdShowMessageDialog("请输入帐户号码!");
				document.frm.contractno.focus();
				return "-1";
		 }

		 returnValue=window.showModalDialog('getlast.jsp?contractno='+document.frm.contractno.value+'&yearmonth='+document.frm.yearmonth.value+'&op_code='+document.frm.op_code.value,"",prop);

 			if( returnValue==null )
	    {
					rdShowMessageDialog("查询失败，该号码今天未做业务！");
 					document.frm.contractno.focus();
					return "-1";
		  }
 			
			document.frm.water_number.value=returnValue;
			return "1";
}

 

 
 function docheck()
 {
	document.frm.action="s1300Cfm.jsp";
    document.frm.submit();
}

//-->
</SCRIPT>

</BODY>
</HTML>
