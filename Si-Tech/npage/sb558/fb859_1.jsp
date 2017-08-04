<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<HTML>
	<HEAD>
		<TITLE>局数据操作查询</TITLE>
		<%
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
		%>
		<%
    	String opCode = "b859";
    	String opName = "局数据操作查询";
    	String workNo = (String)session.getAttribute("workNo");
      String workName = (String)session.getAttribute("workName");
      String regionCode=(String)session.getAttribute("regCode");
		%>
	</HEAD>
	<BODY>
		<SCRIPT language="JavaScript">
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
			
			function   CheckIsDate(value)   
			{   
			  var   strValue     =   new   String();       
			  var   year   =   new   String();   
			  var   month   =   new   String();   
			  var   day   =   new   String();   
			  strValue   =   value;
			  year   =   strValue.substr(0,4);   
			  month   =   strValue.substr(4,2);   
			  month   =   month-1;     
			  day   =   strValue.substr(6,2);   
			  var   testDate   =   new   Date(year,month,day); 
			  return     (year   ==   testDate.getFullYear())   &&   (month   ==testDate.getMonth())&&(day   ==   testDate.getDate());   
			}
			
			function monthCheck(date1,date2,months)
			{
			  var year1 = parseInt(date1.substr(0,4)); 
			  var year2 = parseInt(date2.substr(0,4));
			  var month1 = parseInt(date1.substr(4,1))*10+parseInt(date1.substr(5,1));
			  var month2 =  parseInt(date2.substr(4,1))*10+parseInt(date2.substr(5,1));
			  var flag = 0;
			  if(year2 == year1) flag =0;
			  else if(year2 - year1 == 1) flag = 1;
			  else 
			  {
			  	return false;
			  }
			  //rdShowMessageDialog(year2+" "+year1+" "+month1+" "+month2+" "+flag);
			  if((flag*12+month2-month1)<months)
			  {
			  	return true;
			  }
			  else
			  {
			  	return false;  	
			  }
			}
			
			function doCheck()
			{
				var nowDate = getFormatDate(new Date(),"yyyymmdd");
				var inbegintime = document.frmb859.beginTime.value;	
				var inEndtime = document.frmb859.endTime.value;
				var oButton = document.getElementById("queryButton");
				if (document.frmb859.workno.value=="")
		    {
		      rdShowMessageDialog("请输入工号！");
		      document.frmb859.workno.value="";
		      document.frmb859.workno.select();
		      return false;
		    }
		    if (document.frmb859.workno.value.length < 6)
		    {
		      rdShowMessageDialog("输入的工号长度不对！");
		      document.frmb859.workno.value="";
		      document.frmb859.workno.select();
		      return false;
		    }
		    if(document.frmb859.beginTime.value.length != 8)
			  {
			    rdShowMessageDialog("开始时间长度不正确！");
			    document.frmb859.beginTime.value="";
			    document.frmb859.beginTime.select();
			    return false;
			  }
			  if(document.frmb859.endTime.value.length != 8)
			  {
			    rdShowMessageDialog("结束时间长度不正确！");
			    document.frmb859.endTime.value="";
			    document.frmb859.endTime.select();
			    return false;
			  }
			  if(!CheckIsDate(inbegintime))
			  {
			    rdShowMessageDialog("开始时间不合法！");
			    document.frmb859.beginTime.value="";
			    document.frmb859.beginTime.select();
			    return false;
			  }
			  if(!CheckIsDate(inEndtime))
			  {
			    rdShowMessageDialog("结束时间不合法！");
			    document.frmb859.endTime.value="";
			    document.frmb859.endTime.select();
			    return false;
			  }
			  if(inEndtime.localeCompare(inbegintime)<0)
				{
					rdShowMessageDialog("开始时间不能大于结束时间!");
					return;
				}
				if(monthCheck(inbegintime.substr(0,6),nowDate.substr(0,6),12)==false)
				{
					rdShowMessageDialog("只允许查询最近12个月的操作记录!");
					return false;
				}
				if(monthCheck(inbegintime.substr(0,6),inEndtime.substr(0,6),6)==false)
				{
					rdShowMessageDialog("查询跨度不能超过6个月!");
					return false;
				}
			  if(nowDate.localeCompare(inEndtime)<0)
				{
					//如果结束日期晚于当前日期则设定为当前日期
					document.frmb859.endTime.value = nowDate;
				}
				if(nowDate.localeCompare(inbegintime)<0)
				{
					//如果开始日期晚于当前日期则设定为当前日期
					document.frmb859.beginTime.value = nowDate;
				}
				oButton.disabled = true;
				document.frmb859.action="fb859_Qry.jsp"
				frmb859.submit();
			}
		</SCRIPT>
		<FORM method=post name="frmb859">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">局数据同步查询</div>
			</div>
			<TABLE cellSpacing="0">
				<TR>
					<TD class="blue">查询导入类型</TD>
            <TD colspan="5">
                <select name="searchType" onchange="typechange()">
                    <option value="0" selected>SP企业局数据</option>
                    <option value="1">SP业务局数据</option>
                </select>
            </TD>
				</TR>
				<tr>
					<td  class="blue" nowrap>工号</td>
					<TD>
          	<input type="text" name="workno" size="20" maxlength="6">
          </TD>
				  <TD class="blue"  nowrap>开始日期</TD>
          <TD>
              <input type="text" name="beginTime" size="20" maxlength="8" >
          </TD>
          <TD class="blue"  nowrap>结束日期</TD>
          <TD>
              <input type="text" name="endTime" size="20" maxlength="8">
          </TD>
				</tr>
			</TABLE>
			<table cellSpacing="0">
		      <tr> 
		        <td id="footer"> 
		           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="document.frmb859.reset()">&nbsp;
		           <input type="button" name="queryButton"  class="b_foot" value="查询" style="cursor:hand;" onclick="doCheck()">&nbsp;
		           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="parent.removeTab('<%=opCode%>')">&nbsp;
		        </td>
		      </tr>
		    </table>	
		</FORM>
	</BODY>
</HTML>
