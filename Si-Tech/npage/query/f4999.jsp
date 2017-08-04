<%
/********************
 * version v2.0
 * ������: si-tech
 * update by wangwg @ 2010-01-06
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<TITLE>DSMP����ȷ�϶��Ų�ѯ</TITLE>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	String opCode = "4999";
	String opName = "DSMP����ȷ�϶��Ų�ѯ";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");	
	String orgCode = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
    
    
  	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"","","","","",""};

 	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
           (Integer.parseInt(dateStr.substring(4,6)) - 1),
            Integer.parseInt(dateStr.substring(6,8)));
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
%>

</HEAD>

<body>
<SCRIPT language="JavaScript">
function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
	for (Count=0; Count < InString.length; Count++)
	{
		TempChar= InString.substring (Count, Count+1);
		if (RefString.indexOf (TempChar, 0)==-1)  
		return (false);
	}
	return true;
}

function   CheckIsDate(value)   
{   
  var   strValue     =   new   String();       
  var   year   =   new   String();   
  var   month   =   new   String();   
  var   day   =   new   String();   
    
  strValue   =   value;   
  if   (strValue.length=null)   
  alert("���ڲ���Ϊ��!");   
    
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

function   CheckIsDate2(value)   
{   
  var   strValue     =   new   String();       
  var   year   =   new   String();   
  var   month   =   new   String();    
    
  strValue   =   value;   
  if   (strValue.length=null)   
  alert("���ڲ���Ϊ��!");   
  
  if   (strValue.length!=6)   
  {     
  	return   false;   
  }         
  year   =   strValue.substr(0,4);   
  month   =   strValue.substr(4,2);   
  month   =   month-1;
  
  var   testDate   =   new   Date(year,month,"01");   
  return     (year   ==   testDate.getFullYear())   &&   (month   ==testDate.getMonth());   
}

function doCheck()
{	
  //ѡ����ǰ�ʱ�䷶Χ
  if(document.frm4999.searchType.selectedIndex == 0)
  {
  	var inbegintime = document.frm4999.beginTime.value;		
		var inEndtime = document.frm4999.endTime.value;
		if(!CheckIsDate(inbegintime))
		{
			rdShowMessageDialog("��ʼ���ڲ��Ϸ�!");
			return;
		}
		if(inEndtime.localeCompare(inbegintime)<0)
		{
			rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
			return;
		}	
		
		if(!CheckIsDate(inEndtime))
		{
			rdShowMessageDialog("�������ڲ��Ϸ�!");
			return;
		}
		
		if(true ==monthsOfDates(inbegintime,inEndtime,5))
		{
			rdShowMessageDialog("��ѯ��Χֻ����6����!");
			return;
		}		
  }
  else
  {
  	var queryDate = document.frm4999.searchTime.value;
  	var nowDate = getFormatDate(new Date(),"yyyymm");
  	if(!CheckIsDate2(queryDate))
		{
			rdShowMessageDialog("��������ڲ��Ϸ�������������!");
			return;
		}
  	if(nowDate.localeCompare(queryDate.substr(0,6))<0)
		{
			rdShowMessageDialog("�������ڲ�Ӧ�ó��ڵ��£�����������!");
			return;
		}
		
  }
	if (document.frm4999.phoneNo.value.length<11) 
	{	
	    rdShowMessageDialog("������벻��С��11λ������������ !");
		document.frm4999.phoneNo.focus();
		return false;
	} 
	else 
	{
	    document.frm4999.action="fDetQryDSMP.jsp";
	    var oButton = document.getElementById("Button1"); 
    	oButton.disabled = true; 
	    frm4999.submit();
	}
	
	return true;
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

function     monthsOfDates(date1,date2,months)
{ 
	/*
	�������ã��ж������·�֮���Ƿ񳬹�6���� �������6���£�����Ϊtrue ����Ϊfalse by wangdx 2009.3.17
	*/
  var temp = date1.substr(0,4);  
  date1 = temp + "-" + date1.substr(4,2);  
  temp = date2.substr(0,4);
  date2 = temp + "-" + date2.substr(4,2);
    
  var   temp1=date1.split("-");   
  var   temp2=date2.split("-") ;

  var   _months=(parseInt(temp2[0])-parseInt(temp1[0])+1)*12-(parseInt(temp1[1])+(12-parseInt(temp2[1])))   
 
 
  if((_months>months)||(_months==months&&(parseInt(temp2[2])-parseInt(temp1[2])>-1)))return   true   
  return   false   
}   

function seltimechange() 
{
	if (document.frm4999.searchType.selectedIndex == 0) 
	{
	   IList1.style.display = "";
	   IList2.style.display = "none";
	}
	else
	{
	   IList1.style.display = "none";
	   IList2.style.display = "";
	}
}

</SCRIPT>

<FORM method=post name="frm4999" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">DSMP����ȷ�϶��Ų�ѯ</div>
</div>
<input type="hidden" name="opCode"  value="<%=opCode%>">
<input type="hidden" name="monNum"  value="1">


<TABLE cellSpacing=0>
    <TR> 
        <TD width=16% class=blue>�������</TD>
        <TD width=34% >
            <input type="text" class="InputGrey" name="phoneNo" value="<%=activePhone%>" size="20" maxlength="11">
        </TD>
        <TD width=16% class=blue>��ѯ����</TD>
        <TD width=34%>
            <select name="searchType" onchange="seltimechange()">
                <option  value="0" selected>ʱ�䷶Χ</option>
                <option  value="1" >��������</option>
            </select>
        </TD>   
    </TR>
    
    <TR style="display:" id="IList1"> 
        <TD class=blue>��ʼ����</TD>
        <TD>
            <input type="text" name="beginTime" size="20" maxlength="8" value=<%=mon[1]+"01"%>>
        </TD>
        <TD class=blue>��������</TD>
        <TD>
            <input type="text" name="endTime" size="20" maxlength="8" value=<%=dateStr%>>
        </TD>
    </TR>
    
    <TR style="display:none" id="IList2"> 
        <TD class=blue>��������</TD>
        <TD colspan=3>
            <input type="text" name="searchTime" size="20" maxlength="6" value=<%=mon[1]%>>
        </TD>
    </TR>
    
    
    <tr id="footer"> 
        <td colspan=4>
            <input class="b_foot" name=Button1  type="button" 	onClick="doCheck()" value=��ѯ>
            <input class="b_foot" name=reset  	type=reset 	  	onClick="" 		value=���>
            <input class="b_foot" name=back 	type=button		onClick="removeCurrentTab()" value=�ر�>
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
