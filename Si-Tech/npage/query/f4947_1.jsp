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
    <TITLE>��ͨ�굥��ѯ</TITLE>
    <%
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <%
        String opCode = "4947";
        String opName = "ԭʼ������ѯ";
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
        
    
    /***** begin add by diling for ������Ȩ������ @2011/11/1 *****/
        boolean pwrf = false;
    	String pubOpCode = opCode;
    %>
    	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
    <%
        System.out.println("==������======f4947_1.jsp==== pwrf = " + pwrf);
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
	�������ã��ж������·�֮���Ƿ񳬹�6���� �������6���£�����Ϊtrue ����Ϊfalse by wangdx 2009.3.17
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
	if(document.frm1527.searchType.selectedIndex == 0)//ѡ����ǰ�ʱ�䷶Χ
	{
		
		var inbegintime = document.frm1527.startTime.value;		
		var nowDate = getFormatDate(new Date(),"yyyymmdd");
		var inEndtime = document.frm1527.endTime.value;
		
		if(!CheckIsDate(inbegintime))
		{
			rdShowMessageDialog("��ʼ���ڲ��Ϸ�!");
			return;
		}
		
		if(!CheckIsDate(inEndtime))
		{
			rdShowMessageDialog("�������ڲ��Ϸ�!");
			return;
		}


		if(nowDate.localeCompare(inEndtime.substr(0,6))<0)
		{
			//��������������ڵ�����ĩ
			rdShowMessageDialog("ֻ�����ѯ���6���µ��굥!");
			return;
		}		
		else if(nowDate.localeCompare(inEndtime)<0)
		{
			//��������������ڵ�ǰ�������趨Ϊ��ǰ����
			document.frm1527.endTime.value = nowDate;
			//rdShowMessageDialog("���ڽ�����굥�޷���ѯ����������!");
			//return;
		}
		else if(inEndtime.localeCompare(inbegintime)<0)
		{
			rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
			return;
		}	
		else if(true ==monthsOfDates(inbegintime,inEndtime,5))
		{
			rdShowMessageDialog("ֻ�����ѯ���6���µ��굥!");
			return;
		}		
		var nowDate = getFormatDate(new Date(),"yyyymmdd");
		if(true ==monthsOfDates(inbegintime.substr(0,8),nowDate,8))
		{
			rdShowMessageDialog("ֻ�����ѯ���6���µ��굥!");
			return;
		}
		
		/*if(inbegintime.localeCompare(GuoHuDate)<0);
		{
			rdShowMessageDialog("�������ѯ����ǰ���굥!");
			return;
		}*/
		
		
	}
	else//ѡ����ǰ������·�
	{
		
		var queryDate = document.frm1527.searchTime.value;
		var nowDate = getFormatDate(new Date(),"yyyymm");
	
	
		/*if(queryDate.localeCompare(GuoHuDate)<0);
		{
			rdShowMessageDialog("�������ѯ����ǰ���굥!");
			return;
		}*/
		
		if(nowDate.localeCompare(queryDate.substr(0,6))<0)
		{
			rdShowMessageDialog("�������ڲ�Ӧ�ó��ڵ��£�����������!");
			return;
		}	
		if(true ==monthsOfDates(queryDate.substr(0,6),nowDate,6))
		{
			rdShowMessageDialog("ֻ�����ѯ���6���µ��굥!");
			return;
		}
	}
	
	//by wangdx end
	if( document.frm1527.phoneNo.value.length<11) {	
	    rdShowMessageDialog("������벻��С��11λ������������ !");
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
        <div id="title_zi">��ѡ���ѯ����</div>
    </div>
    <TABLE cellSpacing="0">
        <tr>
            <TD width=16% class="blue">�ֻ�����</TD>
            <TD colspan="3">
            	 <input type="text" class="InputGrey" name="phoneNo" value="<%=activePhone%>" size="20" readonly>
             </TD>
        </TR>

        <tr>
            <TD class="blue" width=16%>��ѯ����</TD>
            <TD colspan="3">
                <select name="searchType" onchange="seltimechange()">
                    <option value="0" selected>ʱ�䷶Χ</option>
                    <option value="1">��������</option>
                </select>
            </TD>
        </TR>

        <TR style="display:''" id="IList1">
            <TD class="blue" width=16%>��ʼʱ��</TD>
            <TD width=34%>
                <input type="text" name="startTime" size="20" maxlength="8" value=<%=mon[1]+"01"%>>
            </TD>
            <TD class="blue" width=16%>����ʱ��</TD>
            <TD width=34%>
                <input type="text" name="endTime" size="20" maxlength="8" value=<%=dateStr%>>
            </TD>
        </TR>

        <TR style="display:none" id="IList2">
            <TD class="blue" width=16%>��������</TD>
            <TD colspan="3">
                <input type="text" name="searchTime" size="20" maxlength="6" value=<%=mon[1]%>>
            </TD>
        </TR>

        <tr>
            <TD class="blue">�굥����</TD>
            <TD>
                <select align="left" name="detType" width=50 index="4">
                    <option value="100">ȫ��</option>
                    <option value="101">��������</option>
                    <option value="102">VPMN����</option>
                    <option value="103">���Ż���</option>
                    <option value="104">GPRS����</option>
                 </select>
            </TD>
            <TD class="blue">��������</TD>

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
            	  &nbsp; <input class="b_foot" name=query type="button" onClick="doCheck()" value=��ѯ>
                &nbsp; <input class="b_foot" name=clear type=reset onClick="" value=���>
                &nbsp; <input class="b_foot" name=colse onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
    <jsp:include page="/npage/common/pwd_comm.jsp"/>
</FORM>

</BODY>
</HTML>

