<%
    /********************
     version v2.0
     ������: si-tech
     *
     * update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
     * �������û�����������֤����,�����˶���������֤
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
        String opCode = request.getParameter("opCode");
        String opName = request.getParameter("opName");
        int new_date = 201202;
        String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String[] mon = new String[]{"", "", "", "", "", ""};
        String account="";
        String loginNo = (String)session.getAttribute("workNo");
			
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
       
     boolean pwrf = false;
	   System.out.println("====�ڶ���====f1526_1.jsp==== begin============ ") ;
        //2011/9/2  diling ��� ������Ȩ������ start
        	String pubOpCode = opCode;
        	String pubWorkNo = loginNo;
        %>
        	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
        <%
        	System.out.println("===�ڶ���=====f1526_1.jsp==== pwrf = " + pwrf);
        System.out.println("====�ڶ���====f1526_1.jsp==== end============ ") ;
        //2011/9/2  diling ��� ������Ȩ������ end
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
function	monthsOfDates(date1,date2,months)
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



/*by wangdx start*/
<%
	String sqlStr = "select belong_code  from dcustMsg where phone_no = \'";
	String phoneNo = request.getParameter("activePhone");
	/* ningtn ����굥 */
	String broadPhone = request.getParameter("broadPhone");
	sqlStr+=phoneNo;
	sqlStr+="\'";
	System.out.println("sqlStr = "+sqlStr);
	
	String orgCode = (String)session.getAttribute("orgCode");
	
	System.out.println("~~~~~~~~~~~~~~orgCode = "+orgCode);
	
	String changeOwnerDateStr = "select to_char(max(op_time),'YYYYMMDDHH24MISS') from dCustHisInfoQry where last_flag <=1 and qry_flag = 'N' and phone_no = \'";
	changeOwnerDateStr +=phoneNo;     
  changeOwnerDateStr+="\' ";    
  System.out.println("++++++++++++++"+changeOwnerDateStr);
  
	
	String tmpsql = "select account_type from dloginmsg where login_no = '"+loginNo+"'";
	 
%>

	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>	
	</wtc:pubselect>
	<wtc:array id="belongStr" scope="end"/>

		
		
	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=changeOwnerDateStr%></wtc:sql>	
	</wtc:pubselect>
	<wtc:array id="chOwnerStr" scope="end"/>
	
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
	
/*by wangdx end*/
/*wangwg Ϊ�����������������*/
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
	
	var inEndtime = document.frm1527.endTime.value;	
	
	//by wangdx start
	if(document.frm1527.searchType.selectedIndex == 0)//ѡ����ǰ�ʱ�䷶Χ
	{
		
		var inbegintime = document.frm1527.beginTime.value;		
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

		/* liujian 2012-3-22 10:17:50 1526���ܲ�ѯ����2012��4��1�ŵ�ʱ��� begin*/
		if('1526' == '<%=opCode%>' && parseInt(inbegintime.substr(0,6)) < <%=new_date%>  
															 && parseInt(inEndtime.substr(0,6)) >= <%=new_date%> )
		{
			rdShowMessageDialog("�굥ʱ��β��ܰ���2012��4��1��!");
			return;
		}	
		/* liujian 2012-3-22 10:17:50 1526���ܲ�ѯ����2012��4��1�ŵ�ʱ��� end*/
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
		/*wangwg ����10�·ݲ��ܲ�ѯ9�·��굥������
		if(true ==monthsOfDates(inbegintime.substr(0,8),nowDate,8))
		{
			rdShowMessageDialog("ֻ�����ѯ���6���µ��굥!");
			return;
		}
		*/
		if(monthCheck(inbegintime.substr(0,6),nowDate.substr(0,6),6)==false)
		{
			rdShowMessageDialog("ֻ�����ѯ���6���µ��굥!");
			return false;
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
		/*wangwg ����10�·ݲ��ܲ�ѯ9�·��굥������	
		if(true ==monthsOfDates(queryDate.substr(0,6),nowDate,6))
		{
			rdShowMessageDialog("ֻ�����ѯ���6���µ��굥!");
			return;
		}*/
		if(monthCheck(queryDate.substr(0,6),nowDate.substr(0,6),6)==false)
		{
			rdShowMessageDialog("ֻ�����ѯ���6���µ��굥!");
			return false;
		}
	}
	
	//by wangdx end
	if( document.frm1527.phoneNo.value.length<11) {	
		rdShowMessageDialog("������벻��С��11λ������������ !");
		document.frm1527.phoneNo.focus();
		return false;
	}
	if("<%=opCode%>" == "e155"){
		if($("#broadPhone").val() == ""){
			rdShowMessageDialog("���������˺� !");
			$("#broadPhone")[0].focus();
			return false;
		}
		if(document.frm1527.passWord.value == ""){
			rdShowMessageDialog("������������ !");
			return false;
		}
	}
	/* liujian 2012-3-22 10:35:48 ��ѯ��֧  2012��4�·�ǰ�����ϰ汾ҳ�棬֮������°汾 begin*/
	var bt = $('#beginTime').val();
	
		document.frm1527.action="e796_2.jsp?qryType="+document.frm1527.detType.value+"&qryName="
			+document.frm1527.detType.options[document.frm1527.detType.options.selectedIndex].text;
	
	/* liujian 2012-3-22 10:35:48 ��ѯ��֧  2012��4�·�ǰ�����ϰ汾ҳ�棬֮������°汾 end*/
	var oButton = document.getElementById("Button1"); 
	oButton.disabled = true; 
	frm1527.submit();
	
	return true;
}

    function seltimechange() {
        if (document.frm1527.searchType.selectedIndex == 0) {
            IList1.style.display = "";
            IList2.style.display = "none";
        } else {
            IList1.style.display = "none";
            IList2.style.display = "";
        }
    }
 
		$(document).ready(function(){
			var opCode = "<%=opCode%>";
			if(opCode == "e155"){
				$("#broadTR").show();
			}else{
				$("#broadTR").hide();
			}
			/* liujian 2012-3-22 10:12:45 �����굥���ͣ�2012��4�·�ǰ�����굥������4�·��Լ��Ժ������굥 begin*/
			$('#beginTime').keyup(function() {
					setTypeDisplay();
			}).mouseup(function() {
					setTypeDisplay();
			});
			$('#searchTime').keyup(function() {
					setTypeDisplay();
			}).mouseup(function() {
					setTypeDisplay();
			});
			$('#beginTime').keyup();
			/* liujian 2012-3-22 10:12:45 �����굥���ͣ�2012��4�·�ǰ�����굥������4�·��Լ��Ժ������굥 end*/
		});

</SCRIPT>

<FORM method=post name="frm1527">
    <input type="hidden" name="opCode" value="<%=opCode%>">
    <input type="hidden" name="opName" value="<%=opName%>">
    <input type="hidden" name="monNum" value="1">
    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
        <div id="title_zi">��ѡ���ѯ����</div>
    </div>
    <TABLE cellSpacing="0">
        <tr>
            <TD width=16% class="blue">�������</TD>
            
            	<% if(account.equals("2")){ %>
            	 <TD colspan="3">
            	<% }else{%>
            	 <TD>
            	<%}%>
                <input type="text" class="InputGrey" name="phoneNo" value="<%=activePhone%>" size="20" readonly>
            </TD>
            <% if(!account.equals("2")){ %>
            <TD width=16% class="blue">��ѯ����</TD>
            <TD width=34%>
            	<jsp:include page="/page/common/pwd_1.jsp">
	                <jsp:param name="width1" value="16%"  />
	                <jsp:param name="width2" value="34%"  />
	                <jsp:param name="pname" value="passWord"  />
	                <jsp:param name="pwd" value="12345"  />
 	           </jsp:include>
            </TR>
            <%}%>
        </TR>
				<tr id="broadTR">
					<td class="blue">����˺�</td>
					<td colspan="3">
						<input type="text" class="InputGrey" name="broadPhone" id="broadPhone" value="<%=broadPhone%>" size="20" readonly>
					</td>
				</tr>
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
            <TD class="blue" width=16%>��ʼ����</TD>
            <TD width=34%>
                <input type="text" name="beginTime" id="beginTime" size="20" maxlength="8" value=<%=mon[1]+"01"%>>
            </TD>
            <TD class="blue" width=16%>��������</TD>
            <TD width=34%>
                <input type="text" name="endTime" id="endTime" size="20" maxlength="8" value=<%=dateStr%>>
            </TD>
        </TR>

        <TR style="display:none" id="IList2">
            <TD class="blue" width=16%>��������</TD>
            <TD colspan="3">
                <input type="text" id="searchTime" name="searchTime" size="20" maxlength="6" value=<%=mon[1]%>>
            </TD>
        </TR>

        <tr>
            <TD class="blue">�굥����</TD>
            <TD>
                <select align="left" name="detType" width=50 index="4" id="orderType">
                	  <%
                    if("e155".equals(opCode)){
                    %>
                    <option value="701">��ͨ���</option>
                    <%
                  	}else{
                    %>
                    <option value="0">ȫ��</option>
                    <option value="1">����</option>
                    <option value="2">ʡ������</option>
                    <option value="3">����</option>
                    <option value="4">��ת</option>
                    <option value="46">���ӵ绰</option>
                    <option value="51">���ӵ绰��ת</option>    
                    <option value="5">����</option>
                    <option value="6">�ƶ�����</option>
                    <option value="7">GPRS</option>
                    <option value="8">���Ż�ͨ</option>
                    <option value="9">VPMN</option>
                    <option value="10">����</option>
                    <option value="11">�ƶ�����</option>
                    <option value="12">WLAN</option>
                    <option value="13">����</option>
                    <option value="14">�ʻ�</option>
                    <option value="15">������־</option>
                    <option value="16">�Ų��ܼ�</option>
                    <option value="17">ȫ���</option>
                    <option value="18">�߽�����</option>
                    <option value="19">VPMN����</option>
                    <option value="20">������Ƭ��</option>
                    <option value="21">�ֻ�����</option>
                    <option value="22">�����ܻ�</option>
                    <option value="23">С������</option>
                    <option value="24">��ҵ��Ϣ��</option>
                    <option value="33">��������</option>
                    <option value="35">�ֻ�����</option>
                    <option value="36">ר��ͨ</option>
                    <option value="37">���ʲ���</option>
                    <option value="38">����绰</option>
                    <option value="39">�������־��ֲ�</option>
                    <option value="40">��ƱͶע����</option>
                    <option value="41">��ҵӦ�ö��Ż���</option>
                    <option value="43">�ֻ���ͼ</option>
                    <option value="44">ȫ��ũ��ͨ</option>
                    <option value="47">��E��G3�����ʼǱ�</option>
                		<option value="45">��ý�����</option>
                    <option value="48">��Ƶ����</option>
                    <option value="49">��Ƶ����</option>
                    <option value="50">��Ƶ����</option>        
                    <option value="52">MMK����</option>
                    <option value="53">widget����</option>
                    <option value="54">�ֻ��������ӷ�(������)</option>
                    <option value="55">�ֻ��Ķ�</option>
                    <option value="56">�̺Ŷ���</option>
                    <option value="57">�ֻ���Ϸ</option>
                    <option value="58">�ֻ��Խ�ҵ��(PoC)</option>
                    <option value="59">�ֻ�����ҵ��</option>
                    <option value="60">12582ũ��ͨ������</option>
                    <option value="61">���Ż�ִҵ��</option>
                    <option value="62">����ͨ</option>
                    <option value="63">GPRS��������</option>
                    <option value="64">�˾�ͨ</option>
                    <%}%>                   
                </select>
            </TD>
            <TD class="blue">��������</TD>

     <%
     		if(pwrf) {
     %>
            <TD>
			    		<input type="password" name="towPassWord" size="22" maxlength="8" disabled>
						</TD>
     <% 
     		} else { 
     %>
            <TD width=34%>
			   				<jsp:include page="/npage/common/pwd_1.jsp">
	                <jsp:param name="width1" value="16%"/>
	                <jsp:param name="width2" value="34%"/>
	                <jsp:param name="pname" value="towPassWord"/>
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
            	


                &nbsp; <input class="b_foot" name=Button1 type="button" onClick="doCheck()" value=��ѯ>
                &nbsp; <input class="b_foot" name=reset type=reset onClick="" value=���>
                &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
    <jsp:include page="/npage/common/pwd_comm.jsp"/>
</FORM>

</BODY>
</HTML>
