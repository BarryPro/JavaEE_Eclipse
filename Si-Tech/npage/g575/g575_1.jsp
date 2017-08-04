<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
 <%
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");	
	String orgCode = (String)session.getAttribute("orgCode");
    String opCode = "g575";   
    String opName = "物联网缴费查询";
    
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[6] ;

    Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
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
                                              
      boolean pwrf = false;                                        
	  String pubOpCode ="1231";
	//  pwrf = true;  
%>
<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>交费信息查询</TITLE>
</HEAD>

<body>
<SCRIPT language="JavaScript">
function doCheck2()
{
    
	if (!<%=pwrf%>)//无免密权限 需要输入密码
	{
	//	alert(<%=pwrf%>);
		if (document.getElementById("cus_pass").value == "") 
		{
			rdShowMessageDialog("请输入用户密码", 1);
			return;
		}
		else
		{
			var checkPwd_Packet = new AJAXPacket("pubCheckPwd_wlw.jsp","正在进行密码校验，请稍候......");
			//dcustmsgdead的密码校验 这个页面可能得换
			checkPwd_Packet.data.add("custType", "01");						//01:手机号码 02 客户密码校验 03帐户密码校验
			checkPwd_Packet.data.add("phoneNo", document.frm1527.phoneNo.value);		//移动号码,客户id,帐户id
			checkPwd_Packet.data.add("custPaswd", document.getElementById("cus_pass").value);//用户.客户.帐户密码
			checkPwd_Packet.data.add("idType", "");							//en 密码为密文，其它情况 密码为明文
			checkPwd_Packet.data.add("idNum", "");							//传空
			checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//工号
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
		}
	}
	else
	{
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight "+300+"px; dialogWidth "+500+"px; dialogLeft "+l+"px; dialogTop "+t+"px;toolbar no; menubar no; scrollbars yes; resizable no;location no;status no";
		var str = window.showModalDialog('getCount.jsp?phoneNo='+document.frm1527.phoneNo.value,"",prop);
		alert(str);
		if(str == null ){
		   rdShowMessageDialog("此号码没有找到对应的帐号！");
		   document.frm1527.contractNo.value="";
		   document.frm1527.phoneNo.focus();
		   return false;
		} 
		
		if(str.length == 0) {
			rdShowMessageDialog("您没有选择对应的帐号！" );
			document.frm1527.contractNo.value="";
			document.frm1527.phoneNo.focus();
			return false;
		 }
		// var s_run_code =  str[3];
		 var s_run_code =  "a";
	 //    alert("11 :"+s_run_code);
		 if(s_run_code=="s")
		 {
			rdShowMessageDialog("用户当前状态不允许查询缴费历史信息!" );
			return false;
		 }
		 else
		 {
			 document.frm1527.contractNo.value = str[0];
			 document.frm1527.userType.value = str[1];
			 document.frm1527.newPhone.value = str[2];
			 // 做个hidden 传物联网号码
			 document.getElementById("doQuery").disabled=false;
			 return true;
		 }
		 
	}
	
}
 

function doCheckPwd(packet) 
{
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		//alert("here? "+retResult+"msg is "+msg);
		if (retResult != "000000") {
			rdShowMessageDialog(msg);
			pwdIsRight = "0";
		} 
		else 
		{
			var h=480;
			var w=650;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight "+300+"px; dialogWidth "+500+"px; dialogLeft "+l+"px; dialogTop "+t+"px;toolbar no; menubar no; scrollbars yes; resizable no;location no;status no";
			//alert("document.frm1527.phoneNo.value is"+document.frm1527.phoneNo.value);
			var str = window.showModalDialog('getCount.jsp?phoneNo='+document.frm1527.phoneNo.value,"",prop);
			//alert(str);
			if(str == null ){
			   rdShowMessageDialog("此号码没有找到对应的帐号！");
			   document.frm1527.contractNo.value="";
			   document.frm1527.phoneNo.focus();
			   return false;
			} 
			
			if(str.length == 0) {
				rdShowMessageDialog("您没有选择对应的帐号！" );
				document.frm1527.contractNo.value="";
				document.frm1527.phoneNo.focus();
				return false;
			 }
			 var s_run_code =  str.split(",")[3];
			 //alert(s_run_code);
			 if(s_run_code=="s")
			 {
				rdShowMessageDialog("用户当前状态不允许查询缴费历史信息!" );
				return false;
			 }
			 else
			 {
				 document.frm1527.contractNo.value = str.split(",")[0];
				 document.frm1527.userType.value = str.split(",")[1];
				 document.frm1527.newPhone.value = str.split(",")[2];
				 document.getElementById("doQuery").disabled=false;
				 return true;
			 } 	
			 
		}
	
		 
	
}	
	
function doCheck()
{	
	  var decmonth = document.frm1527.endTime.value.substring(2,6)- document.frm1527.beginTime.value.substring(2,6); 
	
    var otherFlag = document.frm1527.otherFlag[document.frm1527.otherFlag.selectedIndex].value;
    //if (otherFlag == 0) {
      /* if( document.frm1527.phoneNo.value.length<11) 
	   {	
		  rdShowMessageDialog("请输入查询服务号码！");
		  document.frm1527.phoneNo.select();
		  return false;
	    }
		*/
	//}
   
 	if( document.frm1527.contractNo.value=="") 
	{	
		rdShowMessageDialog("请输入查询帐号！");
		document.frm1527.phoneNo.select();
		return false;
	}

  if ( document.frm1527.beginTime.value >= '200201'&& (  ( 0 <= decmonth && decmonth<= 5 ) || ( 89 <= decmonth && decmonth<= 93 ) ))
	{
			document.frm1527.action="g575_2.jsp";
			document.frm1527.conPass.value = document.all.cus_pass.value;
			frm1527.submit();
	}	
	else	
	{
			rdShowMessageDialog("只能查询开始时间和结束时间为六个月内，且时间大于2002年1月的数据！");
			return false;
	}
  
	return true;
}

function query()
{
	 if(!doCheck())
		 return false;

	 return true;
}

function changsearchtype() {
   var otherFlag = document.frm1527.otherFlag[document.frm1527.otherFlag.selectedIndex].value;
   if (otherFlag == 0) {
      document.frm1527.contractNo.readOnly = true;
   } else if (otherFlag == 1){
      document.frm1527.contractNo.readOnly = false;
   }
}
</SCRIPT>

<FORM method=post name="frm1527" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">交费信息查询</div>
</div>
<input type="hidden" name="opCode"  value="1528">
<input type="hidden" name="userType"  value="0">
<input type="hidden" name="conPass" >

<TABLE cellSpacing=0>
    <TR> 
        <TD class=blue>查询方式</TD>
        <TD>
            <select size="1" name="otherFlag" onchange="changsearchtype()">
                <option class=button value=0>物联网号码</option>
     
            </select>
        </TD>
        <TD class=blue>帐号密码</TD>
          <TD>
          	<jsp:include page="/npage/common/pwd_one.jsp">
				      <jsp:param name="width1" value="16%"  />
				      <jsp:param name="width2" value="34%"  />
				      <jsp:param name="pname" value="cus_pass"  />
				      <jsp:param name="pwd" value="12345"  />
	 	   	</jsp:include>
          </TD>  
    </TR>
    <TR> 
        <TD class=blue>物联网号码</TD>
        <TD>
            <input type="text" name="phoneNo" size="20" maxlength="13" onKeyDown="if(event.keyCode==13){ return query() }"   onKeyPress="return isKeyNumberdot(0)"  >
            <input type="button" class="b_text" name="Button1" value="查询帐号" onclick="doCheck2()">
        </TD>
        <TD class=blue>帐户号码</TD>
        <TD><input type="text" name="contractNo" readOnly size="20" maxlength="20"></TD>  
    </TR>
    <TR> 
        <TD class=blue>开始时间</TD>
        <TD>
            <input v_type=int type="text"  name="beginTime" size="20" maxlength="6" value=<%=mon[3]%>>
        </TD>
        <TD class=blue>结束时间</TD>
        <TD>
            <input v_type=int type="text" name="endTime" size="20" maxlength="6" value=<%=dateStr.substring(0,6)%>>
        </TD>
    </TR>
    <input type="hidden" name="newPhone">
    <tr id="footer" > 
        <td colspan=4>
            <input class="b_foot" name=Button2 id="doQuery"  type="button" onClick="query()" value="  查 询  " disabled>
            <input class="b_foot" name=reset  type=reset onClick="" value="  清 除  ">
            <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="  关 闭  ">
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<!--***********************************************************************-->

