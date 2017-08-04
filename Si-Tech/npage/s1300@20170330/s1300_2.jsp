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
		//xl add 集团预开发票
		String account_id = WtcUtil.repNull(request.getParameter("account_id"));
		String invoice_money = WtcUtil.repNull(request.getParameter("invoice_money"));
		String loginaccept = WtcUtil.repNull(request.getParameter("loginaccept"));
		String print_flag = request.getParameter("print_flag");

		String[] inParas2 = new String[2];
		String opCode = "1300";
		String opName = "账号缴费";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
		//xl add 
		inParas2[0]="select account_type from dloginmsg where login_no = :login_no ";
		inParas2[1]="login_no="+workno;
		%>
		<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
		</wtc:service>
		<wtc:array id="ret_val" scope="end" />
	 
	
		
 
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

	  var retResult_mm = packet.data.findValueByName("retResult_mm");
	var msg = packet.data.findValueByName("msg");
	//证件号码
	var s_flag = packet.data.findValueByName("s_flag");
	var s_count = packet.data.findValueByName("s_count");
	var user_check = document.all.user_check[document.all.user_check.selectedIndex].value;

	//alert("密码校验 retResult_mm is "+retResult_mm+" and msg is "+msg+" 证件flag is "+s_flag+" and s_count is "+s_count+" and 当前校验flag是 "+user_check);
	
	if((user_check=="1" && retResult_mm=="000000") ||(user_check=="2" &&s_flag=="0"&&s_count>=1 ) )//密码校验 密码正确
	{
		//alert("校验 通过");
		document.getElementById("pwd_flag").value="0";//通过
	}
	else
	{
		//alert("校验 不通过");
		document.getElementById("pwd_flag").value="1";
	}

    docheck(); 
  }
  function getpasswd(){
  	//改为ajax方式 根据账号查询sm_code
	if(document.all.contractno.value.trim().len()==0){
  		rdShowMessageDialog("帐户号码不能为空!");
  		return false;
  	}
	var checkPwd_Packet = new AJAXPacket("../s1300/pubCheckPwd_new.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("contract_no",document.all.contractno.value);
	checkPwd_Packet.data.add("qry_flag","1");//账号查询
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
	// docheck(); 
  }
 function doProcess(packet)
 {
	var retResult   = packet.data.findValueByName("retResult");
	var s_sm_code   = packet.data.findValueByName("s_sm_code");
	if(retResult=="0")
	{
		if(s_sm_code=="PB")
		{
			rdShowMessageDialog("物联网用户不允许账号缴费!");
  			return false;
		}
		else
		{
			docheck(); 
		}
	}
	else
	{
		rdShowMessageDialog("用户账户信息不存在!");
  		return false;
	}
 }
 function sel1()
 {
            window.location.href='s1300.jsp';
 }
 function sel2()
 {
           window.location.href='s1300_2.jsp';
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
 function sel6() {
    window.location.href='s1300_v.jsp';
 }
 function init()
 {
    //alert("1300_2 is "+"<%=workno%>"+" and is "+"<%=ret_val[0][0]%>"); 
	document.frm.contractno.focus();
	//if("<%=workno%>"!="aaaaxp")
	if("<%=ret_val[0][0]%>"=="4")
	{
		//alert("禁用号码缴费等"); 
		//渠道工号
		document.getElementById("busyType1").disabled=true;
		document.getElementById("busyType5").disabled=true;
		document.getElementById("busyType6").disabled=true;
		//alert("禁用号码缴费等end");
	}
	else
	{
		
	}
 }
 function doclear() {
 		frm.reset();
 }

 function check_user()
{
	var user_check = document.all.user_check[document.all.user_check.selectedIndex].value;
	if(user_check=="1")
	{
		//alert("密码校验");
		document.getElementById("userpasswd").style.display="block";
		document.getElementById("userid").style.display="none";
	}
	else
	{
		//alert("身份证号码");
		document.getElementById("userpasswd").style.display="none";
		document.getElementById("userid").style.display="block";
	}	
}
-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY  onLoad="init()" >
<FORM action="" method="post" name="frm"  >
<input type="hidden" id="pwd_flag" name="pwd_flags">
<input type="hidden" name="custPass"  value="">
<input type="hidden" name="busy_type"  value="2">
<input type="hidden" name="op_code"  value="1300">
<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
<input type="hidden" name="water_number"  >
<input type="hidden" name="phoneNo"  value="" >

	<input type="hidden" name="account_id"  value="<%=account_id%>" >
	<input type="hidden" name="invoice_money"  value="<%=invoice_money%>" >
	<input type="hidden" name="loginaccept"  value="<%=loginaccept%>" >
	<input type="hidden" name="print_flag"  value="<%=print_flag%>" >
 <%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">请选择缴费方式</div>
		</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue" width="15%">缴费方式</td>
                  <td colspan="3"> 
                  	<q vType="setNg35Attr">
                    <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1"  >
                    服务号码 
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel2()" value="2"  checked>
                    帐户号码 
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType5" id="busyType5" type="radio" onClick="sel5()" value="5"  >
                    托收用户交费
                    </q>
                    <q vType="setNg35Attr">
				           	<input name="busyType1" id="busyType6" type="radio" onClick="sel3()" value="3"  >
                    托收单
                  </q>
				  <!--
				   <q vType="setNg35Attr">
		      <input name="busyType6" type="radio" onClick="sel6()" value="6" > 集团成员缴费
		      </q>	
			  -->
                    <!--<input name="busyType4" type="radio" onClick="sel4()" value="4"  >付费号码-->
					</td>
                 </tr>   
                </tbody> 
              </table>
              <table cellspacing="0" >
                <tr> 
                  <td  class="blue" width="15%">帐户号码</td>
                  <td> 
                    <input type="text" name="contractno" size="20" maxlength="20" style="ime-mode:disabled"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) getpasswd();" index="5" value="<%=account_id%>">
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
				<!--
				<input type="button" name="reprint"  class="b_foot" value="重打发票" onclick="doreprint()"  >
                -->
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
		 //  document.frm.reprint.disabled=true;
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
	document.frm.action="s1300Cfm.jsp";
    document.frm.submit();
}

//-->
</SCRIPT>

</BODY>
</HTML>
