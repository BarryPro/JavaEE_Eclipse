   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-25
********************/
%>
              
<%
  String opCode = "e610";
  String opName = "ͳһ�˵���ӡ";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
<%@ page import="com.sitech.util.DateTrans"%>
<%
		response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);


		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String date1="";
		String date2="";
		DateTrans dt=new DateTrans();
		date1=dt.getYear()+""+dt.getMonth();
		dt.addMonth(-1);
		date2=dt.getYear()+""+dt.getMonth();
		dt.addMonth(1);


		    //String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"","","","","",""};

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
%>
<HTML>
<HEAD>

<script language="JavaScript">
<!--

function change() 
{ 
 	   var i = document.frm.printway.value;
	   var temp0="tb1";
	   var temp1="tb2";
	  
		if (i=="0") 
		{
			document.all(temp1).style.display="none";
			document.all(temp0).style.display="";
			 
			document.frm.phoneNo.focus();
	  	}	
	  	else if (i=="1")
		{
			document.all(temp1).style.display="";
			document.all(temp0).style.display="none";
			 
			document.frm.contract_no.focus();
	  	}
	   document.frm.phoneNo.value = "";
	   document.frm.contract_no.value = "";
	   
}

function docheck()
{
	if((frm.phoneNo.value==""||frm.phoneNo.value.length!=11)&&document.frm.printway.value=="0")
		{
			 rdShowMessageDialog("������Ϸ����û����룡��Ϊ������IMS�̻�������8λ�̻�����ǰ��451����������IMS�̻�������7λ�̻�����ǰ��4λ���ţ���0452��",0);
			document.frm.phoneNo.focus();
		 	 return false;
		}

 
		if((frm.contract_no.value=="")&&document.frm.printway.value=="1")
		{
			rdShowMessageDialog("������Ϸ����ʻ����룡",0);
			document.frm.contract_no.focus();
			return false;
		}
	
	if(!forDate(document.frm.beginDate)) return;
	if(parseFloat(document.frm.beginDate.value)<190001){
		rdShowMessageDialog("�������²���С��1900�꣡",0);
		return;
	}

	 

	var i = document.frm.printway.value;
		if (i=="0") 
		{
			if(document.frm.cus_pass.value=="")
			{
				rdShowMessageDialog("�������û�����!");
				return false;
			}
			else
			{
				document.frm.password.value=document.frm.cus_pass.value;
			}
			
	  	}	
	  	else if (i=="1")
		{
			if(document.frm.cus_pass1.value=="")
			{
				rdShowMessageDialog("�������˻�����!");
				return false;
			}
			else
			{
				document.frm.password.value=document.frm.cus_pass1.value;
			}
			 
	  	}
  
    document.frm.action="e610Cfm.jsp";
	document.frm.query.disabled=true;
	document.frm.return1.disabled=true;
	document.frm.return2.disabled=true;
	document.frm.submit();
}


function doclear() {
	frm.reset();
}

function load_t()
{
document.frm.phoneNo.focus();
-->
}

 </script>

<title>������BOSS-�ʵ���ӡ </title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY onload="load_t()">
<form action="" method="post" name="frm"  >
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">�ɷѹ���</div>
	</div>

	<input type="hidden" name="password"/>
	
<input type="hidden" name="busy_type"  value="1">
<input type="hidden" name="op_code"  value="e610">
<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
<input type="hidden" name="water_number"  >
 
		<table cellspacing="0">
			<tr> 
				<td class="blue">��ӡ��ʽ</td>
				<td>
					<select name="printway" onChange="change();">
						<option value="0" selected>���û�����</option>
						<option value="1">���ʻ�����</option>
					</select>
				</td>
				<td nowrap class="blue">��������</td>
				<td nowrap>
					<input name="beginDate" type="text" v_format="yyyyMM"  class="input-write" value="<%=mon[1]%>" maxlength="6">
				</td>
			</tr>

			<tr id="tb1" style="display:"> 
				<td class="blue">������� </td>
				<td > 
					<input type="text" value="" name="phoneNo"  maxlength="11" onKeyDown="if(event.keyCode==13)frm.beginDate.focus()" onKeyPress="return isKeyNumberdot(0)">
				</td>
				<td class="blue"><div id="pass_msg">�û�����</div></td>
				<td>
					<jsp:include page="/npage/common/pwd_one.jsp">
					<jsp:param name="width1" value="16%"  />
					<jsp:param name="width2" value="34%"  />
					<jsp:param name="pname" value="cus_pass"  />
					<jsp:param name="pwd" value="12345"  />
					</jsp:include>
				</td> 
			 
			</tr>

			<tr id="tb2" style="display:none"> 
				<td class="blue">�ʻ����� </td>
				<td  > 
					<input type="text" name="contract_no"  maxlength="22" onKeyDown="if(event.keyCode==13)frm.beginDate.focus()"  onKeyPress="return isKeyNumberdot(0)">
				</td>
				
				<td class="blue"><div id="pass_msg">�ʻ�����</div></td>
				<td>
					<jsp:include page="/npage/common/pwd_one.jsp">
					<jsp:param name="width1" value="16%"  />
					<jsp:param name="width2" value="34%"  />
					<jsp:param name="pname" value="cus_pass1"  />
					<jsp:param name="pwd" value="12345"  />
					</jsp:include>
				</td> 
			</tr>

			 
 

		</table>
 
        <TABLE  cellSpacing="0">
          <TR >
            <TD noWrap    align="center">
                 <input type="button" name="query" class="b_foot"  value="��ѯ" onclick="docheck()" index="9">
                &nbsp;
                <input type="button" name="return1" class="b_foot"   value="���" onclick="doclear()" index="10">
                &nbsp;
                <input type="button" name="return2"  value="�ر�"  class="b_foot" onClick="removeCurrentTab()" index="13">
             </TD>
          </TR>
        </TABLE>
 
<%@ include file="/npage/include/footer.jsp" %>
</form>


</BODY>
</HTML>