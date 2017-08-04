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
		String opCode = "b924";
		String opName = "主办省一点支付缴费";
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
    docheck(); 
  }
  function getpasswd(){
  	if(document.all.contractno.value.trim().len()==0){
  		rdShowMessageDialog("帐户号码不能为空!");
  		return false;
  	}
  	
   	var myPacket = new AJAXPacket("getpasswd.jsp","正在查询客户，请稍候......");
		myPacket.data.add("contractNo",(document.all.contractno.value).trim());
		myPacket.data.add("busyType",(document.all.busy_type.value).trim());
		core.ajax.sendPacket(myPacket);
		myPacket=null;
  }
  
 function sel1()
 {
            window.location.href='s1300.jsp';
 }
 function sel2()
 {
           window.location.href='s1311.jsp';
  }
 function sel3()
 {
           window.location.href='s1300_3.jsp';
 }

 function sel4() {
           window.location.href='s1300_4.jsp';
 }
 function sel5() {
           window.location.href='s1300_5.jsp';
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
<input type="hidden" name="op_code"  value="b924">
<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
<input type="hidden" name="water_number"  >
<input type="hidden" name="phoneNo"  value="" >
    
 <%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">请选择缴费方式</div>
		</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue" width="15%">缴费方式</td>
                  <td colspan="3"> 
                    <input name="busyType1" type="radio" onClick="sel2()" value="2"  checked>
                    帐户号码 

					</td>
                 </tr>   
                </tbody> 
              </table>
              <table cellspacing="0" >
                <tr> 
                  <td  class="blue" width="15%">帐户号码</td>
                  <td> 
                    <input type="text" name="contractno" size="20" maxlength="20" style="ime-mode:disabled"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) getpasswd();" index="5">
                  </td>
                  <td nowrap> </td>
                  <td> 
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
				<input type="button" name="reprint"  class="b_foot" value="重打发票" onclick="doreprint()"  >
                &nbsp;
                <input type="button" name="nopay" class="b_foot_long" value="上笔缴费冲正" onclick="donopay()"  >
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

function donopay()
{

      var ret= querylast();
			if(ret=="-1")
			    return false;
 			 document.frm.action="s1310_2.jsp";
		   document.frm.query.disabled=true;
		   document.frm.return1.disabled=true;
		   document.frm.reprint.disabled=true;
		   document.frm.nopay.disabled=true; 
		   document.frm.return2.disabled=true;
 			 frm.submit();		
 
}

function doreprint()
{

			var opname="帐户缴费";
      var returnValue= querylast();
			if(returnValue=="-1")
				return false;
			/*window.showModalDialog('s1352_print.jsp?contractno='+document.all.contractno.value+'&total_date='+document.frm.totaldate.value+'&payAccept='+document.frm.water_number.value+'&opname='+opname+'&workno=<%=workno%>&returnPage=s1300_2.jsp',"",prop);	*/	
			var totalDate = document.frm.totaldate.value.substring(0,4) +document.frm.totaldate.value.substring(5,7)+document.frm.totaldate.value.substring(8,10);
			document.frm.action='s1352_print.jsp?contractno='+document.all.contractno.value+'&total_date='+totalDate+'&payAccept='+document.frm.water_number.value+'&opname='+opname+'&workno=<%=workno%>&returnPage=s1300_2.jsp';
			document.frm.submit();	
			document.all.phoneNo.value="";
			document.all.contractno.value="";	
}
 function docheck()
 {
	document.frm.action="s1311Cfm.jsp";
    document.frm.submit();
}

//-->
</SCRIPT>

</BODY>
</HTML>
