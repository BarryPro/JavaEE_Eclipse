<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ӪҵԱ������ѯ1507
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GBK");%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	String opCode="1507";
	String opName="ӪҵԱ������ѯ";
	String phoneNo = (String)request.getParameter("activePhone");
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String begin_date = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	begin_date = begin_date + "01";
  String end_date =  "";
  String end_date1 =  "";
	/* ningtn ��CRMϵͳ����*/
	String queryTypeBack = request.getParameter("queryType")==null?"":request.getParameter("queryType");
	String begin_phoneNo = request.getParameter("begin_phoneNo")==null?"":request.getParameter("begin_phoneNo");
	String end_phoneNo = request.getParameter("end_phoneNo")==null?"":request.getParameter("end_phoneNo");
	String begin_loginNo = request.getParameter("begin_loginNo")==null?"":request.getParameter("begin_loginNo");
	String end_loginNo = request.getParameter("end_loginNo")==null?"":request.getParameter("end_loginNo");
	String begin_time = request.getParameter("begin_time")==null?"":request.getParameter("begin_time");
	String end_time = request.getParameter("end_time")==null?"":request.getParameter("end_time");
	System.out.println(" ==== ningtn === |" +queryTypeBack +"|" + begin_phoneNo + "|" + end_phoneNo + "|"
													+ begin_loginNo + "|"+ end_loginNo + "|"
													+ begin_time + "|"+ end_time + "|");

	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=1;i++)
        {
              if(i!=1)
              {
                end_date = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,+1);
              }
              else
                end_date = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
        }
 String sqlStr1="select account_type from dloginmsg where login_no='"+work_no+"'";
 String errCode="";
 String errMsg="";
 String loginNoFlag="";//2Ϊ�ͷ����� ����Ϊ��Ӫҵ������
%>


<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="4" retcode="retCode" retmsg="retMsg">
   <wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="resultStr" scope="end"/>
<%
  System.out.println(sqlStr1);
  errCode = retCode;
  errMsg = retMsg;

  if(errCode.equals("000000"))
  {
  	if(resultStr!=null && resultStr.length>0)
  	{
  	  loginNoFlag=resultStr[0][0];
  	}else
  		{
  		loginNoFlag="";
  		}
   }
%>


<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>ӪҵԱ������ѯ</TITLE>
</HEAD>
<body>
<SCRIPT language="JavaScript">
function doCheck(){
	document.frm1507.loginNoFlag.value="<%=loginNoFlag%>";
  if(document.frm1507.queryType.value == "phoneNo")
  {
    if (document.frm1507.queryNumber.value=="")
    {
      rdShowMessageDialog("�������ѯ�ֻ����룡");
      document.frm1507.queryNumber.value="";
      document.frm1507.queryNumber.select();
      return false;
    }
    validateTime();
  }
  else if(document.frm1507.queryType.value == "loginNo")
  {
    if("2"!="<%=loginNoFlag%>")
    {
	    if (document.frm1507.beginLoginNo.value=="")
	    {
	      rdShowMessageDialog("�����뿪ʼ���ţ�");
	      document.frm1507.beginLoginNo.value="";
	      document.frm1507.beginLoginNo.select();
	      return false;
	    }
	    if (document.frm1507.all("beginLoginNo").value.length < 6)
	    {
	    	rdShowMessageDialog("����Ŀ�ʼ���ų��Ȳ��ԣ�");
	      document.frm1507.beginLoginNo.value="";
	      document.frm1507.beginLoginNo.select();
	      return false;
	    }
	    if (document.frm1507.endLoginNo.value=="")
	    {
	      document.frm1507.endLoginNo.value=document.frm1507.beginLoginNo.value;
	      document.frm1507.endLoginNo.select();
	      return false;
	    }
	    if (document.frm1507.all("endLoginNo").value.length < 6)
	    {
	      rdShowMessageDialog("����Ľ������ų��Ȳ��ԣ�");
	      document.frm1507.endLoginNo.value="";
	      document.frm1507.endLoginNo.select();
	      return false;
	    }
	    document.frm1507.begin_loginNo.value=document.frm1507.beginLoginNo.value;
	    document.frm1507.end_loginNo.value=document.frm1507.endLoginNo.value;
    }else
  	{
  		if (document.frm1507.queryLoginNo.value=="")
	    {
	      rdShowMessageDialog("�������ѯ���ţ�");
	      document.frm1507.queryLoginNo.value="";
	      document.frm1507.queryLoginNo.select();
	      return false;
	    }
	    document.frm1507.begin_loginNo.value=document.frm1507.queryLoginNo.value;
	    document.frm1507.end_loginNo.value=document.frm1507.queryLoginNo.value;
  	}
    validateLoginNo();
  }else if(document.frm1507.queryType.value == "broadNo"){
		if(document.frm1507.all("queryTime").value.length == 0)
	  {
	    rdShowMessageDialog("�����뿪ʼʱ�䣡");
	    document.frm1507.queryTime.value="";
	    document.frm1507.queryTime.select();
	    return false;
	  }
	  if(isNaN(document.frm1507.all("queryTime").value))
		{
			rdShowMessageDialog("����Ŀ�ʼʱ��Ӧ�������֣����������룡");
	    return false;				
		}else
		{
			 if(document.frm1507.all("queryTime").value.length == 8)
			  {
			  }else
				{
					rdShowMessageDialog("����Ŀ�ʼʱ���ʽ���ԣ�ӦΪ:YYYYMMDD��");
			    return false;		
				}				
		}
		
		if(document.frm1507.all("end_time").value.length == 0)
	  {
	    rdShowMessageDialog("���������ʱ�䣡");
	    document.frm1507.end_time.value="";
	    document.frm1507.end_time.select();
	    return false;
	  }
	  if(isNaN(document.frm1507.all("end_time").value))
		{
			rdShowMessageDialog("����Ľ���ʱ��Ӧ�������֣����������룡");
	    return false;				
		}else
		{
			 if(document.frm1507.all("end_time").value.length == 8)
			  {
			  }else
				{
					rdShowMessageDialog("����Ľ���ʱ���ʽ���ԣ�ӦΪ:YYYYMMDD��");
			    return false;		
				}				
		}
	
		if(!check(frm1507))
	  {
	    return false;
	  }
	  document.frm1507.action="f1507_2.jsp?queryType="+document.frm1507.queryType.value+"&begin_phoneNo="+document.frm1507.queryNumber.value+"&end_phoneNo="+document.frm1507.queryNumber.value+"&begin_loginNo="+document.frm1507.begin_loginNo.value+"&end_loginNo="+document.frm1507.end_loginNo.value+"&begin_time="+document.frm1507.queryTime.value+" 00:00:00"+"&end_time="+document.frm1507.end_time.value+" 23:59:59"+"&work_no=<%=work_no%>&work_name=<%=work_name%>&function_code="+document.frm1507.function_code.value;
	  frm1507.submit();
	  return true;
	  }
}

function validateTime()
{
	  if(document.frm1507.all("queryTime").value.length == 0)
  {
    rdShowMessageDialog("�����뿪ʼʱ�䣡");
    document.frm1507.queryTime.value="";
    document.frm1507.queryTime.select();
    return false;
  }
  if(isNaN(document.frm1507.all("queryTime").value))
	{
		rdShowMessageDialog("����Ŀ�ʼʱ��Ӧ�������֣����������룡");
    return false;				
	}else
	{
		 if(document.frm1507.all("queryTime").value.length == 8)
		  {
		  	/*var beginDay=document.frm1507.all("queryTime").value;
		  	var daytime=beginDay.substr(4,2);
		  	var yeattime=beginDay.substr(0,4);
		  	if(daytime=="12")
		  	{
		  		yeattime=Number(yeattime)+1;
		  		yeattime=yeattime+"0101000000";
		  		document.frm1507.end_date.value=yeattime;
		  	}else
		  		{
		  			var endDay=Number(beginDay)+1;
		  			endDay=endDay+"01000000";
		  			document.frm1507.end_date.value=endDay;
		  		}
		  	document.frm1507.queryTime.value=document.frm1507.queryTime.value+"01000000";
		    document.frm1507.begin_date.value=document.frm1507.queryTime.value;*/
		  }else
			{
				rdShowMessageDialog("����Ŀ�ʼʱ���ʽ���ԣ�ӦΪ:YYYYMMDD��");
		    return false;		
			}				
	}
	
	if(document.frm1507.all("end_time").value.length == 0)
  {
    rdShowMessageDialog("���������ʱ�䣡");
    document.frm1507.end_time.value="";
    document.frm1507.end_time.select();
    return false;
  }
  if(isNaN(document.frm1507.all("end_time").value))
	{
		rdShowMessageDialog("����Ľ���ʱ��Ӧ�������֣����������룡");
    return false;				
	}else
	{
		 if(document.frm1507.all("end_time").value.length == 8)
		  {
		  	/*var beginDay=document.frm1507.all("queryTime").value;
		  	var daytime=beginDay.substr(4,2);
		  	var yeattime=beginDay.substr(0,4);
		  	if(daytime=="12")
		  	{
		  		yeattime=Number(yeattime)+1;
		  		yeattime=yeattime+"0101000000";
		  		document.frm1507.end_date.value=yeattime;
		  	}else
		  		{
		  			var endDay=Number(beginDay)+1;
		  			endDay=endDay+"01000000";
		  			document.frm1507.end_date.value=endDay;
		  		}
		  	document.frm1507.queryTime.value=document.frm1507.queryTime.value+"01000000";
		    document.frm1507.begin_date.value=document.frm1507.queryTime.value;*/
		  }else
			{
				rdShowMessageDialog("����Ľ���ʱ���ʽ���ԣ�ӦΪ:YYYYMMDD��");
		    return false;		
			}				
	}
	//�жϲ�ѯ���ڲ����Կ���
	var bTime = $("#queryTime").val();
	var eTime = $("#end_time").val();
	var bMonth = bTime.substr(4,2);
	var eMonth = eTime.substr(4,2);
	var bYear = bTime.substr(0,4);
	var eYear = eTime.substr(0,4);
	if((bMonth != eMonth) || (bYear != eYear )){
		rdShowMessageDialog("�������ڱ�����ͬһ�����ڣ�");
		return;
	}
  if(!check(frm1507))
  {
    return false;
  }
  document.frm1507.action="f1507_2.jsp?queryType="+document.frm1507.queryType.value+"&begin_phoneNo="+document.frm1507.queryNumber.value+"&end_phoneNo="+document.frm1507.queryNumber.value+"&begin_loginNo="+document.frm1507.begin_loginNo.value+"&end_loginNo="+document.frm1507.end_loginNo.value+"&begin_time="+document.frm1507.queryTime.value+" 00:00:00"+"&end_time="+document.frm1507.end_time.value+" 23:59:59"+"&work_no=<%=work_no%>&work_name=<%=work_name%>&function_code="+document.frm1507.function_code.value;
  frm1507.submit();
  return true;
}

function validateLoginNo()
{
	var packet = new AJAXPacket("getComp.jsp","������֤������Ϣ�����Ժ�......");
  packet.data.add("work_no","<%=work_no%>");
  packet.data.add("loginNoFlag",document.frm1507.loginNoFlag.value);
  packet.data.add("beginLoginNo",document.frm1507.begin_loginNo.value);
  packet.data.add("endLoginNo",document.frm1507.end_loginNo.value);
  core.ajax.sendPacket(packet,doInfo);
  packet = null;
}

function doInfo(packet)
{
	 var retCode = packet.data.findValueByName("retCode");
   var retMsg = packet.data.findValueByName("retMsg");
   if(retCode != "000000")
   {
   	rdShowMessageDialog("������Ϣ��"+retMsg+"��",0);
   }else
   {
   	validateTime();
   }
}

function change(){
        if(document.frm1507.queryType.value == "phoneNo")
        {
          document.frm1507.all("phoneNo_type").style.display="";
          document.frm1507.all("loginNo_type").style.display="none";
          document.frm1507.all("broadNoTr").style.display="none";
          document.frm1507.queryNumber.value ="";
          document.frm1507.beginLoginNo.value ="a";
          document.frm1507.endLoginNo.value ="a";
          document.frm1507.queryTime.value =document.frm1507.begin_date.value;
          document.frm1507.all("loginNo_type_query").style.display="none";
        }
        else if(document.frm1507.queryType.value == "loginNo")
        {
        	if("2"=="<%=loginNoFlag%>")
        	{
        		document.frm1507.all("loginNo_type_query").style.display="";
        	}else
      		{
      			document.frm1507.all("loginNo_type").style.display="";
      		}
          document.frm1507.all("phoneNo_type").style.display="none";
          document.frm1507.all("broadNoTr").style.display="none";
          document.frm1507.queryNumber.value ="a";
          document.frm1507.beginLoginNo.value ="";
          document.frm1507.endLoginNo.value ="";
          document.frm1507.queryTime.value =document.frm1507.begin_date.value;
        }
        else if(document.frm1507.queryType.value == "broadNo")
        {
        	document.frm1507.all("broadNoTr").style.display="";
          document.frm1507.all("phoneNo_type").style.display="none";
          document.frm1507.all("loginNo_type").style.display="none";
          document.frm1507.queryNumber.value ="a";
          document.frm1507.beginLoginNo.value ="";
          document.frm1507.endLoginNo.value ="";
          document.frm1507.queryTime.value =document.frm1507.begin_date.value;
        }  
}

function curLost(){
	if(document.frm1507.endLoginNo.value.length==0)
	{
		document.frm1507.endLoginNo.value=document.frm1507.beginLoginNo.value;
	}
	if(document.frm1507.end_broadNo.value.length==0){
		document.frm1507.end_broadNo.value=document.frm1507.begin_broadNo.value;
	}
	return true;
}

$(document).ready(function(){
	var beginTime = "<%=begin_time%>";
	var endTime = "<%=end_time%>";
	var beginPhoneNo = "<%=begin_phoneNo%>";
	var endPhoneNo = "<%=end_phoneNo%>";
	var beginLoginNo = "<%=begin_loginNo%>";
	var endLoginNo = "<%=end_loginNo%>";
	var queryType = "<%=queryTypeBack%>";

	if(queryType != ""){
		$("#queryType").attr('value',queryType);
		change();
	}
	if(queryType != "broadNo"){
		if(beginPhoneNo != ""){
			$("#queryNumber").val(beginPhoneNo);
		}
		if(endPhoneNo != ""){
			$("#queryNumber").val(endPhoneNo);
		}
		if(beginLoginNo != ""){
			$("#beginLoginNo").val(beginLoginNo);
		}
		if(endLoginNo != ""){
			$("#endLoginNo").val(endLoginNo);
		}
	}
	if(beginTime != ""){
		$("#queryTime").val(beginTime.substr(0,8));
		$("#begin_date").val(beginTime.substr(0,8));
	}
	if(endTime != ""){
		$("#end_date").val(endTime.substr(0,8));
	}
});

</SCRIPT>

<FORM method=post name="frm1507">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ӪҵԱ������ѯ</div>
	</div>
<table cellspacing="0">
	<TR>
		<TD class="blue">��ѯ��ʽ </td>
		<td>
			<select name="queryType" onChange="change()">
				<option value=phoneNo>������</option>
				<option value=loginNo>������</option>
				<option value="broadNo">����ͨ�˺�</option>
			</select>
		</TD>
		<TD class="blue">�������� </td>
		<td>
			<select name=function_code>
		<%
		try
		{
//			ArrayList retArray = new ArrayList();
//			String[][] result = new String[][]{};
//			S1100View callView = new S1100View();
			String sqlStr = "select function_code,function_code||'-->'||function_name from sFuncCode where function_code<'9999' and length(rtrim(function_code))=4 order by function_code";
//			retArray = callView.view_spubqry32("2",sqlStr);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
//			result = (String[][])retArray.get(0);
			int recordNum = result.length;
			out.println("<option class='button' value='ZZZZ'>ZZZZ-->ȫ������</option>");
			for(int i=0;i<recordNum;i++)
			{
			out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
			}
			}catch(Exception e)
			{
			//System.out.println("Call sunView is Failed!");
		}
		%>
			</select>
		</TD>
	</TR>
<!--huangrong �޸� ��ѯ�����չʾ��ʽ-->
	<TR id=phoneNo_type>
		<TD class="blue">��ѯ���� </td>
		<td colspan="3">
			<input type="text" class="button" name="queryNumber" id="queryNumber" size="15" value="<%=begin_phoneNo%>"
							maxlength="11" style="ime-mode:disabled"
							onKeyPress="return isKeyNumberdot(0)"/>
		</TD>
		<!--<TD class="blue">��������</td>
		<td>
			<input type="text" class="button" name="end_phoneNo" id="end_phoneNo" size="15"
					maxlength="11" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" />
		</TD>-->
	</TR>

	<TR style="display:none" id=loginNo_type>
	<TD class="blue">��ʼ����</td>
	<td>
		<input type="text" class="button" name="beginLoginNo" id="beginLoginNo" size="15" onBlur="curLost()" maxlength="6" />
	</TD>
	<TD class="blue">��������</td>
	<td>
	 	<input type="text" class="button" name="endLoginNo" id="endLoginNo" size="15"
	 				maxlength="6" />
	 </TD>
	</tr>

	<TR style="display:none" id=loginNo_type_query>
	<TD class="blue">��ѯ����</td>
	<td colspan="3">
		<input type="text" class="button" name="queryLoginNo" id="queryLoginNo" size="15" maxlength="6" />
	</TD>
	</tr>
<!--huangrong �޸� ʱ���չʾ��ʽ-->
	<TR style="display:none" id="broadNoTr">
		<TD class="blue">��ʼ��ͨ�˺�</td>
		<td>
			<input type="text" class="button" name="begin_broadNo" size="25"  onBlur="curLost()" maxlength="25">
		</TD>
		<TD class="blue">������ͨ�˺�</td>
		<td>
			<input type="text" class="button" name="end_broadNo" size="25" maxlength="25">
		</TD>
	</tr>
	<TR>
		<TD class="blue">��ʼʱ��</td>
		<td>
		 	<input type="text" v_type="date" class="button" name="queryTime"
		 			id="queryTime" value=<%=begin_date%>  >
		 </TD>
		<TD class="blue">����ʱ��</td>
		<td>
			<input type="text" v_type="date" class="button" name="end_time"
					id="end_time" value=<%=dateStr%>   >
		</TD>
	</tr>

	<tr>
		<td align="center" id="footer" colspan="4">
		&nbsp; <input class="b_foot" name=commit onClick="doCheck()" type=button value=ȷ��>
		&nbsp; <input class="b_foot" name=reset  type=reset onClick="" value=���>
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
		&nbsp;
		</td>
	</tr>
</table>
      <input type="hidden" name="begin_date" value=<%=begin_date%>>
      <input type="hidden" name="end_date" value=<%=end_date%>>
      <input type="hidden" name="begin_loginNo">
      <input type="hidden" name="end_loginNo">
      <input type="hidden" name="loginNoFlag">   <!--���ű�ʶ-->

	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
