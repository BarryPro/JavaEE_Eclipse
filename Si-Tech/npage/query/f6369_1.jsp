<%
/********************
 * version v2.0
 * 开发商: si-tech
 * author wangzc @ 2010-03-21
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
    String opCode = "6369";
    String opName = "包年自动续签记录查询";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String begin_date = "";

	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=3;i++)
        {
              if(i!=3)
              {
                begin_date = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                begin_date = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
        }
        begin_date=begin_date+"01";

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>包年自动续签记录查询</TITLE>
</HEAD>
<body>
<%
	String contextPath = request.getContextPath();
%>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/date/iOffice_Popup.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/redialog_res/redialog.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_check.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_util.js"></SCRIPT>
<SCRIPT language="JavaScript">

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

function ajaxGetAutoMsg(phone_no,begin_time,end_time,vartype)
{
	
	var packet = new AJAXPacket("f6369_2.jsp","请稍后...");
    packet.data.add("phone_no" ,phone_no);
    packet.data.add("begin_time",begin_time);
    packet.data.add("end_time" ,end_time);
    packet.data.add("vartype" ,vartype);
  	core.ajax.sendPacket(packet,doAjaxGetAutoMsg);
}

function doAjaxGetAutoMsg(packet)
{
	$("#resultListDiv table").remove();
	var return_code = packet.data.findValueByName("return_code"); 
	var return_msg =packet.data.findValueByName("return_msg");
	var retAry = packet.data.findValueByName("retAry");
	if(return_code=='999999')
	{
		rdShowMessageDialog(return_msg); 
	}
	if(return_code == "111111")
	{
		rdShowMessageDialog('没有查到相关数据！');
	}
	else
	{
		initTab(retAry);
	}
	
	
}		
function initTab(retAry)
{
	$("#resultListDiv table").remove();
	$("#resultListDiv").append("<table id='resultListTab'><thead><tr style='cursor:hand'><th>用户ID</th><th>电话号码</th><th>操作时间</th><th>操作信息</th><th>结果类型(1:成功 0：失败)</th><th>城市代码</th></tr></thead></table>");
	for(var i=0 ; i<retAry.length; i++)
	{
		var idno = retAry[i][0];
		var phone_no = retAry[i][1];
		var op_time = retAry[i][2];
		var op_note=retAry[i][3];
		var vartype=retAry[i][4];
		var region_code=retAry[i][5];
	    $("#resultListTab").append("<tr><td>"+idno+"</td><td>"+phone_no+"</td><td>"+op_time+"</td><td>"+op_note+"</td><td>"+vartype+"</td><td>"+region_code+"</td></tr>");
	}
}	

function doCheck(){
	var phone_no='';
	var begin_time='';
	var end_time='';
	var vartype='';
	if(document.getElementById("queryType").value == "queryTypePhone")
	{ 
		if (document.getElementById("phone_no").value=="")
		{
			rdShowMessageDialog("请输入开始手机号码！");
			return false;
		}
   
	} 

	if(document.getElementById("begin_time").value =='')
	{
		rdShowMessageDialog("请输入开始时间！");
		return false;
	}
	if(document.getElementById("end_time").value =='')
	{
		rdShowMessageDialog("请输入结束时间！");
		return false;
	}

	if(document.getElementById("begin_time").value.length == 10)
		document.getElementById("begin_time").value=document.getElementById("begin_time").value+" 00:00:00";
	if(document.getElementById("end_time").value.length == 10)
		document.getElementById("end_time").value=document.getElementById("end_time").value+" 23:59:59";
	var begin_time=document.getElementById("begin_time").value;
	var end_time=document.getElementById("end_time").value;
	if(begin_time>end_time)
	{
		rdShowMessageDialog("开始时间比结束时间大");
		return false;
	}
	phone_no=document.getElementById("phone_no").value;
	begin_time=document.getElementById("begin_time").value;
	end_time=document.getElementById("end_time").value;
	vartype=document.getElementById("querytype1").value;
	ajaxGetAutoMsg(phone_no,begin_time,end_time,vartype);
}


function change()
{    
	if($("#queryType").val() == "queryTypePhone")
	{
		document.getElementById("phone_no").disabled='';
		document.getElementById("phone_no").value='';
	}
	else
	{
		document.getElementById("phone_no").disabled='disabled';
		document.getElementById("phone_no").value='';
	}   
}

</SCRIPT>

<FORM method=post name="frm6369">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户信息</div>
</div>

<table cellspacing="0">
    <TR>
        <TD class=blue>查询方式</td>
        <td>
            <select id="queryType" name="queryType" onchange="change()">
                <option value="queryTypePhone">按号码</option>
                <option value="queryTypeAll">全部</option>
            </select>
        </TD>
        <TD class=blue>电话号码</td>
        <td>
            <input type="text" name="phone_no" id="phone_no"  />
        </TD>
        
    </tr>
    <TR>
         <TD class=blue>类型</td>
         <td colspan=3>
        	<select name="querytype1">
                <option value='1'>成功</option>
                <option value='0'>失败</option>
                <option value=''>全部</option>
            </select> 
        </TD>
    </TR>
   <tr id="add_time3">		
			<td width="15%" class="blue" nowrap>开始时间</td>
			<td width="35%">
				<input type="text" name="begin_time" id="begin_time" size="18" readonly='true'/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(begin_time);return false' alt=弹出日历下拉菜单 align=absMiddle readonly></td>
			</td>
		
			<td width="15%" class="blue" nowrap>结束时间</td>
			<td width="35%">
				<input type="text" name="end_time" id="end_time" size="18" readonly='true'/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(end_time);return false' alt=弹出日历下拉菜单 align=absMiddle readonly></td>
			</td>
		</tr>
    
    <tr id="footer"> 
        <td colspan=4>
            <input class="b_foot" name=commit onClick="doCheck()" type=button value=确认>
            <input class="b_foot" name=reset  type=reset onClick="" value=清除>
            <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
        </td>
    </tr>
</table>



	<div id="resultListDiv">
		</div>

		
<input type="hidden" name="begin_date" value=<%=begin_date%>>
<input type="hidden" name="end_date" value=<%=dateStr%>>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>


