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
		String opCode = "zgbh";
		String opName = "家庭成员未出账查询";
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
 
function doqry()
{
	var phone_no = document.all.phone_no.value;
	var s_flag = document.all.s_flag.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("请输入查询号码!")
		return false;
	}
	else
	{
		var checkPwd_Packet = new AJAXPacket("sphone_check.jsp","正在进行号码校验，请稍候......");
		checkPwd_Packet.data.add("phone_no",phone_no);
		checkPwd_Packet.data.add("s_flag",s_flag);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
	}
	
}
 


 function doclear() {
 		frm.reset();
 }
   
  
 function sel1()
 {
	document.all.s_flag.value="1";
 }
 function sel2()
 {
	document.all.s_flag.value="2";
 }
 function inits()
 {
	 sel1();
 }
 function doProcess(packet)
 {
	var s_return_flag   = packet.data.findValueByName("s_return_flag");
	//alert("s_return_flag is "+s_return_flag);
	//s_return_flag="0";
	if(s_return_flag=="1")
	{
		rdShowMessageDialog("主副卡关系校验失败!");
		return false;
	}
	else
	{
		 document.frm.action="zgbh_2.jsp";
		 document.frm.submit();
	}	
 }
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	
 <div class="title">
			<div id="title_zi">请选择查询方式</div>
		</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue" width="15%">查询方式</td>
                  <td colspan="3"> 
                  	<q vType="setNg35Attr">
                    <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" checked value="1"  >
                    主卡号码 
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel2()" value="2"  >
                    副卡号码 
                    </q>
                 <input type="hidden" name="s_flag">    
			 		</td>
                 </tr>   
                </tbody> 
              </table>
              <table cellspacing="0" >
                <tr> 
                  <td  class="blue" width="15%">用户号码</td>
                  <td> 
                    <input type="text" name="phone_no" size="20" maxlength="20" style="ime-mode:disabled"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) getpasswd();" index="5"  >
                  </td>
                  <td nowrap> </td>
                  <td> 
                   </td>
 				</tr>

				 
				
				 
				 

              </table>
         
        
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="账户信息查询" onclick="doqry()" >
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