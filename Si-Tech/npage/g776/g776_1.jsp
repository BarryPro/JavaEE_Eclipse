<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: �����ز���ͳ�Ʊ���2148
   * �汾: 1.0
   * ����: 200/01/04
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	request.setCharacterEncoding("GBK");%>
<%@ page import="org.apache.log4j.Logger"%>
<%
	String opCode="g776";
	String opName="ͳһCentrex���ų�Ա�˵�����";
	String work_no = (String)session.getAttribute("workNo");
	String rpt_right = (String)session.getAttribute("rptRight");
	String org_code = (String)session.getAttribute("orgCode");
    String sqlStr="";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String[] inParas2 = new String[1];
	inParas2[0]="select to_char(add_months(to_date(to_char(sysdate, 'YYYYMM'), 'YYYYMM'),-1), 'YYYYMM') from dual ";
	
 
%>
	<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas2[0]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />

		<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>��Ʊ�����汨��</TITLE>
</HEAD>
<body>
 
 

 	
<script src="invoice_boss.js" type="text/javascript"></script>		

<SCRIPT language="JavaScript">

function doSubmit()
{
	
  var ym = document.all.end_time.value;
  var jtcpid= document.all.jtcpid.value;
  if(ym=="")
  {
	  rdShowMessageDialog("�������˵���ѯ���£���ʽΪYYYYMM!");
      return false;
  }	
  if(jtcpid=="")
  {
	  rdShowMessageDialog("�����뼯�Ų�ID!");
      return false;
  }
 
   //У�� �Ƿ��Ƕ�ý��ҵ��� �Ƿ�Ϊ�յ� �ȵ�~~
    var check_Packet = new AJAXPacket("CheckUnit.jsp","���ڽ�������У�飬���Ժ�......");
	check_Packet.data.add("cpid",jtcpid);
 
	core.ajax.sendPacket(check_Packet);
	check_Packet=null;
   //end У��	
	
	/*
    select_boss(document.form1);
	document.form1.submit();
	*/
  
}
function doProcess(packet)
{
	var retResult   = packet.data.findValueByName("retResult");
	var ret_count   = packet.data.findValueByName("ret_count");
	//alert("retResult is "+retResult+" and ret_count is "+ret_count);
	var date_bf =packet.data.findValueByName("date_bf"); 
	var date_now =packet.data.findValueByName("date_now"); 
	var date_input =document.all.end_time.value;
	//alert("test date_input is "+date_input+" and date_now is "+date_now+" and date_bf is "+date_bf);
	

	var year_bf =  date_bf.substr(0,4);
    var year_now =  date_now.substr(0,4); 
	var month_bf = date_bf.substr(4,2);
	var month_now = date_now.substr(4,2);
	var year_in =  date_input.substr(0,4); 
	var month_in = date_input.substr(4,2);
	
	var len_bf=(year_bf-year_in)*12+(month_bf-month_in)+1;
	var len_now=(year_now-year_in)*12+(month_now-month_in)+1;
	//alert("len_bf is "+len_bf+" and len_now is "+len_now);
	/*
	if(len_now<=1 || len_bf>6)
	{
		rdShowMessageDialog("���ɲ�ѯ����֮ǰ�������µļ�¼!");
		return false;
	}*/
	if(date_input<date_bf || date_input>=date_now)
	{
		rdShowMessageDialog("���ɲ�ѯ����֮ǰ�������µļ�¼!");
		return false;
	}
	else
	{
		//alert(date_input+" and date_bf is"+date_bf);
		if(retResult=="N")
		{
			rdShowMessageDialog("��ѯ����쳣!");
			return false;
		}
		else
		{
			if(ret_count=="0")
			{
				 rdShowMessageDialog("��������ȷ�ļ��Ų�ƷID,����ý������绰��Ʒ�ɲ�ѯ!");
				 document.all.jtcpid.value = "";
				 document.all.jtcpid.focus();
				 return false;
			}
			else
			{
				var ym = document.all.end_time.value;
				var jtcpid= document.all.jtcpid.value;
				select_boss(document.form1);
				document.form1.submit();
			}
		}
	}
	
	
}
</SCRIPT> 

<FORM method=post name="form1" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ѡ���������</div>
	</div>

<table cellSpacing="0">
			

 
	 
	<tr>
		<td  class="blue">���Ų�Ʒ����</td>
		<td >
			<select name="bank_name" id= "selOp" > 
				<option value="1" selected>��ý������绰</option>
			</select>
		</td>
		<td class="blue">��ѯ����</td>
		<td>
			<input type="text" name="end_time" value=<%=ret_val[0][0]%> size="6" maxlength="6"  onKeyPress="return isKeyNumberdot(0)">(YYYYMM)
		</td>
	</tr>
	<tr>
		<td class="blue">���Ų�ƷID</td>
		<td>
			<input type="text" class="button" name="jtcpid"  size="17" maxlength="11"  onKeyPress="return isKeyNumberdot(0)">
		</td>
		<td class="blue">�˵�״̬</td>
		<td>
			<select name="status_name" id= "status_id" > 
				<option value="x" selected>ȫ��</option>
				<option value="2" >�ѽ���</option>
				<option value="0" >δ����</option>
			</select>
		</td>
	</tr>
	 
	<tr> 
		<td align="center" id="footer" colspan="4">
		&nbsp; <input id=submits class="b_foot" name=submits onclick="return(doSubmit())" type=button value=ȷ��>
		&nbsp; <input class="b_foot" name=reee  type=button onClick="form1.reset()" value=���>
		&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
		</td>
	</tr>
</table>
      <input type="hidden" name="workNo" value="<%=work_no%>">
      <input type="hidden" name="org_code" value="<%=org_code%>">
      <input type="hidden" name="hDbLogin" value ="dbchange">
      <input type="hidden" name="rptright" value="D">
      <input type="hidden" name="hParams1" value="">
      <input type="hidden" name="hTableName" value="">
	  <input type="hidden" name="g_name" id="group_id" value="">
  
  <%@ include file="/npage/public/pubSearchText.jsp" %>
	<%@ include file="/npage/include/footer.jsp" %> 
</FORM>
</BODY></HTML>
		<%
	 
	 
%>

 
