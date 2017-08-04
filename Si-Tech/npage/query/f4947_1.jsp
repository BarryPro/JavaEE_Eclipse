<%
    /********************
 
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<HTML>
<HEAD>
    <TITLE>普通详单查询</TITLE>
    <%
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <%
        String opCode = "4947";
        String opName = "原始话单查询";
        String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String[] mon = new String[]{"", "", "", "", "", ""};
        String account="";

        Calendar cal = Calendar.getInstance(Locale.getDefault());
        cal.set(Integer.parseInt(dateStr.substring(0, 4)),
                (Integer.parseInt(dateStr.substring(4, 6)) - 1), Integer.parseInt(dateStr.substring(6, 8)));
        for (int i = 0; i <= 5; i++) {
            if (i != 5) {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                //cal.add(Calendar.MONTH, -1);
            } else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
        }
        
    
    /***** begin add by diling for 对密码权限整改 @2011/11/1 *****/
        boolean pwrf = false;
    	String pubOpCode = opCode;
    %>
    	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
    <%
        System.out.println("==第三批======f4947_1.jsp==== pwrf = " + pwrf);
    /***** end add by diling *****/
	
  %>
</HEAD>

<body>
<SCRIPT language="JavaScript">
function isNumberString(InString, RefString)
{
    if (InString.length == 0) return (false);
    for (Count = 0; Count < InString.length; Count++) {
        TempChar = InString.substring(Count, Count + 1);
        if (RefString.indexOf(TempChar, 0) == -1)
            return (false);
    }
    return true;
}
function monthsOfDates(date1,date2,months)
{ 
	/*
	函数作用：判断两个月份之间是否超过6个月 如果超过6个月，返回为true 否则为false by wangdx 2009.3.17
	*/
  var temp = date1.substr(0,4);  
  date1 = temp + "-" + date1.substr(4,2);  
  temp = date2.substr(0,4);
  date2 = temp + "-" + date2.substr(4,2);
    
  var   temp1=date1.split("-");   
  var   temp2=date2.split("-") ;

  var   _months=(parseInt(temp2[0],10)-parseInt(temp1[0],10)+1)*12-(parseInt(temp1[1],10)+(12-parseInt(temp2[1],10)))   
 
 
  if((_months>months)||(_months==months&&(parseInt(temp2[2],10)-parseInt(temp1[2],10)>-1)))return   true   
  return   false   
}   
function getFormatDate(date_obj,date_templet)
{
  var year,month,day,hour,minutes,seconds,short_year,full_month,full_day,full_day,full_hour,full_minutes,full_seconds;
  if(!date_templet)date_templet = "yyyy-mm-dd hh:ii:ss";
  year = date_obj.getFullYear().toString();
  short_year = year.substring(2,4);
  month = (date_obj.getMonth()+1).toString();
  month.length == 1 ? full_month = "0"+month : full_month = month;
  day = date_obj.getDate().toString();
  day.length == 1 ? full_day = "0"+day : full_day = day;
  hour = date_obj.getHours().toString();
  hour.length == 1 ? full_hour = "0"+hour : full_hour = hour;
  minutes = date_obj.getMinutes().toString();
  minutes.length == 1 ? full_minutes = "0"+minutes : full_minutes = minutes;
  seconds = date_obj.getSeconds().toString();
  seconds.length == 1 ? full_seconds = "0"+seconds : full_seconds = seconds;
  return date_templet.replace("yyyy",year).replace("mm",full_month).replace("dd",full_day).replace("yy",short_year).replace("m",month).replace("d",day).replace("hh",full_hour).replace("ii",full_minutes).replace("ss",full_seconds).replace("h",hour).replace("i",minutes).replace("s",seconds);
}
function CheckIsDate(value)   
{   
  var   strValue     =   new   String();       
  var   year   =   new   String();   
  var   month   =   new   String();   
  var   day   =   new   String();   
    
  strValue   =   value;   
  if   (strValue.length=null)   
  alert("日期不能为空!");   
    
  if   (strValue.length!=8)   
  {     
  	return   false;   
  }       

    
    
  year   =   strValue.substr(0,4);   
  month   =   strValue.substr(4,2);   
  month   =   month-1;     
  day   =   strValue.substr(6,2);   
  var   testDate   =   new   Date(year,month,day);   
  return     (year   ==   testDate.getFullYear())   &&   (month   ==testDate.getMonth())&&(day   ==   testDate.getDate());   
}

<%
	String loginNo = (String)session.getAttribute("workNo");
	String tmpsql = "select account_type from dloginmsg where login_no = '"+loginNo+"'";
%>

	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=tmpsql%></wtc:sql>	
	</wtc:pubselect>
	<wtc:array id="accountNo" scope="end"/>
	<% 
	if(accountNo!=null&& accountNo.length > 0)
	{
		account = accountNo[0][0];
	}
	%>
	
function doCheck()
{
	
	var inEndtime = document.frm1527.endTime.value;	
	
	//by wangdx start
	if(document.frm1527.searchType.selectedIndex == 0)//选择的是按时间范围
	{
		
		var inbegintime = document.frm1527.startTime.value;		
		var nowDate = getFormatDate(new Date(),"yyyymmdd");
		var inEndtime = document.frm1527.endTime.value;
		
		if(!CheckIsDate(inbegintime))
		{
			rdShowMessageDialog("开始日期不合法!");
			return;
		}
		
		if(!CheckIsDate(inEndtime))
		{
			rdShowMessageDialog("结束日期不合法!");
			return;
		}


		if(nowDate.localeCompare(inEndtime.substr(0,6))<0)
		{
			//处理结束日期晚于当月月末
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return;
		}		
		else if(nowDate.localeCompare(inEndtime)<0)
		{
			//如果结束日期晚于当前日期则设定为当前日期
			document.frm1527.endTime.value = nowDate;
			//rdShowMessageDialog("晚于今天的详单无法查询，请检查输入!");
			//return;
		}
		else if(inEndtime.localeCompare(inbegintime)<0)
		{
			rdShowMessageDialog("开始时间不能大于结束时间!");
			return;
		}	
		else if(true ==monthsOfDates(inbegintime,inEndtime,5))
		{
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return;
		}		
		var nowDate = getFormatDate(new Date(),"yyyymmdd");
		if(true ==monthsOfDates(inbegintime.substr(0,8),nowDate,8))
		{
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return;
		}
		
		/*if(inbegintime.localeCompare(GuoHuDate)<0);
		{
			rdShowMessageDialog("不允许查询过户前的详单!");
			return;
		}*/
		
		
	}
	else//选择的是按出账月份
	{
		
		var queryDate = document.frm1527.searchTime.value;
		var nowDate = getFormatDate(new Date(),"yyyymm");
	
	
		/*if(queryDate.localeCompare(GuoHuDate)<0);
		{
			rdShowMessageDialog("不允许查询过户前的详单!");
			return;
		}*/
		
		if(nowDate.localeCompare(queryDate.substr(0,6))<0)
		{
			rdShowMessageDialog("出账日期不应该迟于当月，请重新输入!");
			return;
		}	
		if(true ==monthsOfDates(queryDate.substr(0,6),nowDate,6))
		{
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return;
		}
	}
	
	//by wangdx end
	if( document.frm1527.phoneNo.value.length<11) {	
	    rdShowMessageDialog("服务号码不能小于11位，请重新输入 !");
		document.frm1527.phoneNo.focus();
		return false;
	} else {
	    document.frm1527.action="fDetQryA.jsp?qryType="+document.frm1527.detType.value+"&qryName="
		+document.frm1527.detType.options[document.frm1527.detType.options.selectedIndex].text;
		var oButton = document.getElementById("query"); 
    oButton.disabled = true; 
		frm1527.submit();
	}
	return true;
}
function seltimechange() 
{
        if (document.frm1527.searchType.selectedIndex == 0) {
            IList1.style.display = "";
            IList2.style.display = "none";
        } else {
            IList1.style.display = "none";
            IList2.style.display = "";
        }
}

</SCRIPT>

<FORM method=post name="frm1527">
    <input type="hidden" name="opCode" value="1527">
    <input type="hidden" name="monNum" value="1">
    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
        <div id="title_zi">请选择查询类型</div>
    </div>
    <TABLE cellSpacing="0">
        <tr>
            <TD width=16% class="blue">手机号码</TD>
            <TD colspan="3">
            	 <input type="text" class="InputGrey" name="phoneNo" value="<%=activePhone%>" size="20" readonly>
             </TD>
        </TR>

        <tr>
            <TD class="blue" width=16%>查询类型</TD>
            <TD colspan="3">
                <select name="searchType" onchange="seltimechange()">
                    <option value="0" selected>时间范围</option>
                    <option value="1">出帐年月</option>
                </select>
            </TD>
        </TR>

        <TR style="display:''" id="IList1">
            <TD class="blue" width=16%>开始时间</TD>
            <TD width=34%>
                <input type="text" name="startTime" size="20" maxlength="8" value=<%=mon[1]+"01"%>>
            </TD>
            <TD class="blue" width=16%>结束时间</TD>
            <TD width=34%>
                <input type="text" name="endTime" size="20" maxlength="8" value=<%=dateStr%>>
            </TD>
        </TR>

        <TR style="display:none" id="IList2">
            <TD class="blue" width=16%>出帐年月</TD>
            <TD colspan="3">
                <input type="text" name="searchTime" size="20" maxlength="6" value=<%=mon[1]%>>
            </TD>
        </TR>

        <tr>
            <TD class="blue">详单类型</TD>
            <TD>
                <select align="left" name="detType" width=50 index="4">
                    <option value="100">全部</option>
                    <option value="101">语音话单</option>
                    <option value="102">VPMN话单</option>
                    <option value="103">短信话单</option>
                    <option value="104">GPRS话单</option>
                 </select>
            </TD>
            <TD class="blue">二次密码</TD>

     <%
     		if(pwrf) {
     %>
            <TD>
			    		<input type="password" name="towPassword" size="22" maxlength="8" disabled>
						</TD>
     <% 
     		} else { 
     %>
            <TD width=34%>
			   				<jsp:include page="/npage/common/pwd_1.jsp">
	                <jsp:param name="width1" value="16%"/>
	                <jsp:param name="width2" value="34%"/>
	                <jsp:param name="pname" value="towPassword"/>
	                <jsp:param name="pwd" value="12345"/>
 	            	</jsp:include>
						</TD>
     <%
     		}
     %>
        </TR>
    </TABLE>

	
    <table cellspacing="0">
        <tr>
            <td id="footer">
            	  &nbsp; <input class="b_foot" name=query type="button" onClick="doCheck()" value=查询>
                &nbsp; <input class="b_foot" name=clear type=reset onClick="" value=清除>
                &nbsp; <input class="b_foot" name=colse onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
    <jsp:include page="/npage/common/pwd_comm.jsp"/>
</FORM>

</BODY>
</HTML>

