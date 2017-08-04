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
	<title>投诉退费管理</title>
	<%@ include file="../../npage/s4140/head_4141_1_javascript.htm" %>
<%
  	String opCode = "zg68";		
	String opName = "GPRS退费界面";	//header.jsp需要的参数
	
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	
	String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
    String groupId = (String)session.getAttribute("groupId");
	//work_no="800111";
    //xl add for 800001
	String region_code_new="";
	
	//System.out.println(str1);
	//String time_sql = "select to_char(sysdate,'YYYYMMDD hh24:mi:ss') from dual";
	String time_sql = "select to_char(sysdate,'YYYYMMDDhh24miss') from dual";
%>
	
	<wtc:pubselect name="TlsPubSelBoss"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
   		<wtc:sql><%=time_sql%></wtc:sql>
   	</wtc:pubselect>
  	<wtc:array id="returnTime" scope="end" /> 
  		
	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    String sysAccept = seq;
    System.out.println("sysAccept="+sysAccept);

String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("#######checkSql->"+checkSql);
//String tfywSql = "select to_char(first_code),first_name from SREFUNDTYPE_new where valid_flag='3' order by first_code asc";
String tfywSql="select to_char(third_code),third_name from SrefundThird where first_code='0000' and second_code='0000' and valid_flag='4' and login_No='3' order by third_code asc";
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		/**根据loginRootDistance来判断工号权限问题**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				loginRootDistance = sVerifyTypeArr[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr[0][0]);
			}
		}		
%>
<%
	String sqlBillType="select first_code,first_name from SREFUNDBillType where valid_flag='0'";
	//xl add 查询工号限额 begin
	int i_login_count=0;
	String[] inPara2 = new String[2];
	inPara2[0]="select to_char(count(*)) from shighlogin_boss where login_no=:s_login_no and op_code='zgau' ";
	inPara2[1]="s_login_no="+work_no;
	%>
	<wtc:service name="TlsPubSelBoss" retcode="retCode1count" retmsg="retMsg1count" outnum="1">
		<wtc:param value="<%=inPara2[0]%>"/>
		<wtc:param value="<%=inPara2[1]%>"/>
	</wtc:service>
	<wtc:array id="ret_val_count" scope="end" />
	<%
	if(ret_val_count.length>0)
	{
		i_login_count=Integer.parseInt(ret_val_count[0][0]);
	}
%>
 
	
	<wtc:pubselect name="TlsPubSelBoss"   outnum="2">
   		<wtc:sql><%=sqlBillType%></wtc:sql>
   	</wtc:pubselect>
  	<wtc:array id="sBillTypeStr" scope="end"/>
	<wtc:pubselect name="TlsPubSelBoss"   outnum="2">
   		<wtc:sql><%=tfywSql%></wtc:sql>
   	</wtc:pubselect>
  	<wtc:array id="stflxStr" scope="end"/>
	 
<%
	String contextPath = request.getContextPath();
%>

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

<script language=javascript>
	

 //定义全局变量
  var reason_name = new Array();
  var reason_code = new Array();//where条件 是 projectCode 要查询显示的是 fee
<%
	out.println("reason_name[0]='流量提示短信不及时';\n");
	out.println("reason_code[0]='0';\n");
	out.println("reason_name[1]='否认使用';\n");
	out.println("reason_code[1]='1';\n");
	out.println("reason_name[2]='话单延迟';\n");
	out.println("reason_code[2]='2';\n");
	out.println("reason_name[3]='其他';\n");
	out.println("reason_code[3]='3';\n");

%> 	

 
function docomm()
{
	if (document.all.phoneno1.value == "")
	{
		rdShowMessageDialog("请输入计费用户号码!");
		return;
	}
	if(document.all.phoneno1.value.length <11)
    {
		rdShowMessageDialog("计费用户号码长度应为11位数字!");
		return;
	}
	if (document.all.acceptno.value == "")
	{
		rdShowMessageDialog("请输入投诉电子流水!");
		return;
	}
	//alert("长度 "+document.all.acceptno.value.length);
	if(document.all.acceptno.value.length <15)
    {
		rdShowMessageDialog("投诉电子流水长度应为15位数字!");
		return;
	}
	var tfje = document.all.backMoney.value;
	//alert(sum_money+" and tflx is "+tflx);
	/*
	if(tfje>300)
    {
		rdShowMessageDialog("退费总金额不可以大于300元!");
		return;
	}
	if(tfje=="")
	{
		rdShowMessageDialog("请输入退费金额!");
		return;
	}*/
	//开始、结束时间不可为空
	var tf_begin =document.all.tf_begin.value ;
	var tf_end =document.all.tf_end.value ;
	if(tf_begin=="" ||tf_end=="")
	{
		rdShowMessageDialog("请输入退费开始、结束时间!");
		return;
	}
	//当退款原因选择其他时，输入退费原因不可以为空
	var s_tfyy = document.all.reason[document.all.reason.selectedIndex].value;
	if(s_tfyy=="3")
	{
		if(document.all.otherReason.value=="")
		{
			rdShowMessageDialog("请输入退费原因!");
			return;
		}
	}
	document.all.op_note.value = document.all.phoneno1.value+"退费:"+tfje;
	//alert(tf_end.substring(0,4)+tf_end.substring(5,7)+tf_end.substring(8,10));
	//2015/01/16 2015/01/07 20100
	//只有当时间有/进行分割的时候 才截取
	if(tf_end.substring(4,5)=="/")
	{
		document.all.tf_end.value = tf_end.substring(0,4)+tf_end.substring(5,7)+tf_end.substring(8,10);
	}	
	if(tf_begin.substring(4,5)=="/")
	{
		document.all.tf_begin.value = tf_begin.substring(0,4)+tf_begin.substring(5,7)+tf_begin.substring(8,10);
	}
	//xl add for fanyan 金额限制
	if("<%=work_no.substring(0,2)%>"=="80")
	{
		if("<%=i_login_count%>">=1 &&tfje>300)
		{
			rdShowMessageDialog("退费总金额不可以大于300元!");
			return;
		}
		else if("<%=i_login_count%>"==0 &&tfje>150)
		{
			rdShowMessageDialog("退费总金额不可以大于150元!");
			return;
		}
	}
	


	var	prtFlag = rdShowConfirmDialog("本次退费金额"+tfje+"元,是否确定退费?");
	if (prtFlag==1)
	{
		frm.action="zg68_2.jsp";
		frm.submit();
	}
	else
	{
		return false;
	}
	
}




function clearnew()
{
	document.all.phone_no.value="";
	document.all.begin_tm.value="";
	document.all.begin_tm.value="";
	document.all.phone_no.disabled=false;	
}

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
	function inits()
	{
		document.getElementById("reason_id").style.display="none";
	}
	function checkReason(choose,NameArray,CodeArray)
	{
		
		document.all.otherReason.value="";
		//alert("1 "+choose+" 2 "+NameArray+" 3 "+CodeArray);
		for ( x = 0 ; x < CodeArray.length  ; x++ )
		{
		  //alert("CodeArray[x] is "+CodeArray[x]+" and choose.value is "+choose.value);
		  if ( CodeArray[x] == choose.value &&choose.value=="3" )
		  {
			 document.getElementById("reason_id").style.display="block";
			 document.all.reason1.value=choose.value;
			 document.all.reason2.value="show";
		  }
		  else
		  {
			  document.getElementById("reason_id").style.display="none";
			  document.all.reason1.value=choose.value;
			  document.all.reason2.value="none";
		  }	
		}
		
	}
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
<body onload="inits()">
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<input type="hidden" id="qryValue" value="1" >
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
<input type="hidden" name="op_code" id="op_code" value="<%=opCode%>">
<input type="hidden" name="sysAccept" value="<%=sysAccept%>">
<input type="hidden" name="backMoney1" value="">
<input type="hidden" name="phoneNo" value="">
<input type="hidden" name="op_note" value="">
<!--xl add for 单倍or双倍-->
<input type="hidden" name="feeflag" value="">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">梦网/自有业务退费 </div>
	</div>
	<input type="hidden" name="reason1" value="0">
	<input type="hidden" name="reason2">
	<table>
 		
		<tr> 
	        <td class=blue nowrap>计费用户号码</td>
	        <td nowrap> 
	            <input type="text" name="phoneno1" v_must=1  v_type="mobphone" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11 >
	            <font class="orange">*</font>              
	        </td>
	        <td class=blue nowrap>投诉电子流水</td>
	        <td nowrap> 
	            <input type="text" name="acceptno" v_must=1   onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=15 size="30" onKeyPress="return isKeyNumberdot(0)">
	            <font class="orange">*</font>
	        </td>
	    </tr>
	    
		
		<tr> 
	        <td nowrap class=blue>退费业务</td>
	        <td nowrap> 
	            <select name="tfyw" class="button">
	            	<%
						for(int i = 0 ; i < stflxStr.length ; i ++)
						{
							%>
							<option value="<%=stflxStr[i][0]%>"><%=stflxStr[i][1]%></option>
							<%
						}
					%>
	            </select>
	            <font class="orange">*</font>
	        </td>
			<td class="blue">退预存款原因：</td>
			<td class="blue" colspan="3">			
				<select name="reason" style= "width:135px;" onChange="checkReason(this,reason_name,reason_code)">
					<option value="0" selected>流量提示短信不及时</option>
					<option value="1" >否认使用</option>
					<option value="2" >话单延迟</option>
					<option value="4" >GPRS边界漫游问题</option>
					<option value="3" >其他</option>
				</select>
			</td>
	    </tr>	
		
		<tr id="reason_id">
			<td class="blue">请输入退费原因：</td>
			<td class="blue" colspan="3">			
				<input type="text" name="otherReason">
			</td>
		</tr>
	   
	    
		
		<tr id="add_mon"> 
	        <td nowrap class=blue>退费金额</td>
	        <td colspan=4> 
	            <input type="text" name="backMoney" maxlength="10" value=""  onKeyPress="return isKeyNumberdot(1)" >
	            
	        </td>
	         
	         
	            <input class="InputGrey" type="hidden" name="compMoney" value="" readonly >
	        
	    </tr>
	
		<tr> 
	        <td class=blue nowrap>退费开始时间</td>
	        <td nowrap> 
	            <input type="text" name="tf_begin"  maxlength=8 readonly>
	            <img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(tf_begin);return false' alt=弹出日历下拉菜单 align=absMiddle readonly>
	        </td>
			 
	        <td class=blue nowrap>退费结束时间</td>
	        <td nowrap> 
	            <input type="text" name="tf_end" maxlength=8 readonly>
	            <img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(tf_end);return false' alt=弹出日历下拉菜单 align=absMiddle readonly>
	        </td>
	    </tr>
	</table>
	
	
	
	<table  cellspacing="0" >
	<tr>
		<td id="footer">     
   			<input type=button name="confirm"class="b_foot"  value="确认" onClick="docomm()">    
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
	 
	
</script>