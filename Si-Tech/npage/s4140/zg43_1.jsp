 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:zhangshuaia@2009-08-10 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page language="java" import="java.sql.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<html>
	<head> 
	<title>投诉退费查询</title>
	<%@ include file="../../npage/s4140/head_4141_1_javascript.htm" %>
<%
  	//String opCode = "4141";		
  	String opCode = "zg43";		
	String opName = "投诉退费查询";	//header.jsp需要的参数
	
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	
	String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
    String groupId = (String)session.getAttribute("groupId");
    //xl add for 800001
	 
	 
   %>
	 
	 
  

	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    String sysAccept = seq;
    System.out.println("sysAccept="+sysAccept);
 
%>
 
 
<%
	String contextPath = request.getContextPath();
%>
<!--xl add for zhangshuo-->
  
<link href="<%= contextPath %>/css/sc.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/date/iOffice_Popup.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/redialog_res/redialog.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_check.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_util.js"></SCRIPT>

<script language=javascript>
function fPopUpCalendarDlg(ctrlobj)
{
	if(N)
	{
		showx = 220 ; // + deltaX;
		showy = 220; // + deltaY;
	}
	else
	{
		showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
		showy = event.screenY - event.offsetY + 18; // + deltaY;
	}
	newWINwidth = 210 + 4 + 18;
	if(N)
	{
		window.top.captureEvents (Event.CLICK|Event.FOCUS);
		window.top.onclick=IgnoreEvents;
		window.top.onfocus=HandleFocus;
		winPopupWindow.args = ctrlobj;
		winPopupWindow.returnedValue = new Array();
		winPopupWindow.args = ctrlobj;
		newWINwidth = 202;
		winPopupWindow.win = window.open("/js/common/date/CalendarDlg.htm","CalendarDialog","dependent=yes,left="+showx + ",top=" + showy + ",width="+newWINwidth + ",height=182px" )
		winPopupWindow.win.focus()
		return winPopupWindow;
	}
	else
	{
		retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
	}
	if(retval != null)
	{
		ctrlobj.value = retval;
	}
	else
	{
		//alert("canceled");
	}
}
</script>
<!--20091220 end -->


<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>

	
function qryChg()
{
		//alert("2");
		document.getElementById("qryValue").value="2";
	
} 
function docomm(subButton)
{
	controlButt(subButton);//延时控制按钮的可用性
	var begin_time = document.all.begin_time.value.substring(0,4)+document.all.begin_time.value.substring(5,7)+document.all.begin_time.value.substring(8,10);
		var end_time1 = document.all.end_time1.value.substring(0,4)+document.all.end_time1.value.substring(5,7)+document.all.end_time1.value.substring(8,10);
		var phone_no = document.all.phone_no.value;
		var op_code = document.all.op_code.value;
		
		//alert("开始时间"+begin_time);
		//alert("结束时间"+end_time1);

		if(phone_no=="")
		{
			rdShowMessageDialog("查询号码不能为空！");
			return;
		}
		if(begin_time=="")
		{
			rdShowMessageDialog("开始时间不能为空！");
			return;
		}
		if(end_time1=="")
		{
			rdShowMessageDialog("结束时间不能为空！");
			return;
		}

		document.all.phone_no.disabled=true;
		document.all.begin_time.disabled=true;
		document.all.end_time1.disabled=true;
		
		document.getElementById("qryOprInfoFrame").style.display="block";
		var tftj = document.all.tftj[document.all.tftj.selectedIndex].value;
		//alert("test tftj is "+tftj);
		document.qryOprInfoFrame.location = "zg43_getInfo.jsp?begin_time="+begin_time+"&phone_no="+phone_no+"&end_time="+end_time1+"&op_code="+op_code+"&tftj="+tftj;
	return true;
}
 
 


function clearnew(){

		document.all.phone_no.value="";
		document.all.begin_time.value="";
		document.all.end_time1.value="";
		document.all.phone_no.disabled=false;
		document.all.begin_time.disabled=false;
		document.all.end_time1.disabled=false;

} 
 

///////////////////
 
 
</script>

<style type="text/css">
	<!--
    body {
      margin:0;
      padding:0;
      font:  12px/1.5em Verdana;
    }
		
    #tabsJ {
      float:left;
      width:100%;
      background:#f6f6f6;
      font-size:93%;
      line-height:normal;
    }
    #tabsJ ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabsJ li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsJ a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabsJ a:hover span {
      color:#FFF;
    }
    #tabsJ a:hover {
      background-position:0% -42px;
    }
    #tabsJ a:hover span {
      background-position:100% -42px;
    }

    #tabsJ .current a {
      background-position:0% -42px;
    }
    #tabsJ .current a span {
			font: bold;
      background-position:100% -42px;
      color:#FFF;
    }

	
	-->
	</style>

</head>
<body>
<form name="frm" method="POST" >
<input type="hidden" id="qryValue" value="1" >
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
<input type="hidden" name="op_code" id="op_code" value="<%=opCode%>">
<input type="hidden" name="sysAccept" value="<%=sysAccept%>">
<input type="hidden" name="backMoney1" value="">
<input type="hidden" name="phoneNo" value="">
<input type="hidden" name="ivrflag" value="">
<!--xl add for 单倍or双倍-->
<input type="hidden" name="feeflag" value="">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">投诉退费查询 </div>
	</div>

	<table>
 		 
		
		<tr id="add_no3">
			<td width="15%" class="blue" nowrap>查询号码</td>
			<td width="35%"><input type="text" name="phone_no" id="phone_no"  maxlength=11 size="18" value=""><font class="orange">*</font>&nbsp;&nbsp;</td>
			<input type="hidden" name="login_no" value="">&nbsp;&nbsp;	
			<!--xl add 查询条件 begin-->
		 <td width="15%" class="blue" nowrap>退费业务</td>
				<td width="35%">
					<select name="tftj">
						<option value="1" selected>GPRS业务</option>
						<option value="2">自有业务</option>
					</select>
				</td>
			
		</tr>
		<!--xl add end 查询条件-->
		</tr>
		
<!-- 20091220 注释掉本段修改为日期控件
		<tr style="display:none"  id="add_time3">		
			<td width="15%" class="blue" nowrap>开始时间</td>
			<td width="35%"><input type="text" name="begin_time" id="begin_time"  v_must=1 size="18" maxlength="8" value=""><font class="orange">*(格式YYYYMMDD)</font>&nbsp;&nbsp;</td>
			<td width="15%" class="blue" nowrap>结束时间</td>
			<td width="35%"><input type="text" name="end_time1" id="end_time1"  v_must=1 size="18" maxlength="8" value=""><font class="orange">*(格式YYYYMMDD)</font>&nbsp;&nbsp;
		</tr>
-->
<!--20091220 begin -->
		<tr id="add_time3">		
			<td width="15%" class="blue" nowrap>开始时间</td>
			<td width="35%">
				<input type="text" name="begin_time" id="begin_time" size="18" readonly="true"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(begin_time);return false' alt=弹出日历下拉菜单 align=absMiddle readonly></td>
			</td>
		
			<td width="15%" class="blue" nowrap>结束时间</td>
			<td width="35%">
				<input type="text" name="end_time1" id="end_time1" size="18" readonly="true"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(end_time1);return false' alt=弹出日历下拉菜单 align=absMiddle readonly></td>
			</td>
		</tr>
 
		 
		
	 
		 
	 
		 
			</table>
			 
		</tr>
	    
	 
<!--xl add for zhangshuo end-->
	</table>
	
	<table cellspacing="0">
		<tr id="add_3">
			<td style="height:0;">
				<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:1300px; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
			</td>
		</tr>
	</table>
	
	<table  cellspacing="0" >
	<tr>
		<td id="footer">     
   			<input type=button name="confirm"class="b_foot"   value="确认" onClick="docomm(this)">    
  			<input type=button name=back value="清除" class="b_foot" onmouseup="clearnew()" onClick="clearnew()">
	  		<input type=button name=qryP value="关闭" class="b_foot" onClick="removeCurrentTab();">             
		</td>
	</tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
<script language="javascript">
	function gethjsj()
	{
		var myDate = new Date();
		//var mytime=myDate.toLocaleTimeString(); //获取当前时间 toLocaleString
		var mytime = myDate.toLocaleString();
		alert("mytime is "+mytime+" and myDate is "+myDate);
		var mytime_str = "";
	}
	function checkIvr()
	{
		if(document.all.ivrcheck.checked)
		{
			//document.all.SecondClass[0].selected;
			//alert("1");
			document.all.SecondClass.options[0].selected = true;
		}
		else
		{
			//alert("2.");
			//document.all.SecondClass[0].selected;
			document.all.SecondClass.options[0].selected = true;
		}	
		
	}
	
</script>