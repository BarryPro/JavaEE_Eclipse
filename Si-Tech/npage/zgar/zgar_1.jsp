 <!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ������Ϣ��ѯ5186
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode="zgar";
	String opName="ǰ̨���ӷ�Ʊ��ӡ";
	//String phoneNo = (String)request.getParameter("activePhone");			//�ֻ�����
 
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>ǰ̨���ӷ�Ʊ��ӡ</TITLE>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
</HEAD>

<body>
<SCRIPT language="JavaScript">
function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
	for (Count=0; Count < InString.length; Count++)  {
		TempChar= InString.substring (Count, Count+1);
		if (RefString.indexOf(TempChar, 0)==-1)  
		return (false);
	}
	return true;
}
function doCheck()
{
	//if(jtrim(document.frm5186.cus_pass.value).length ==0)
	//	document.frm5186.cus_pass.value="123456";   
	var beginym = document.frm5186.beginym.value;
	var endym = document.frm5186.endym.value;
	var qryvalue = document.frm5186.qryvalue.value;
	var qry_type = document.frm5186.qrytype[document.frm5186.qrytype.selectedIndex].value;
	if(qry_type=="1")
	{
		document.frm5186.contract_no.value="99999999999";
	}
	else
	{
		document.frm5186.contract_no.value=qryvalue;
		qryvalue="";//�Ƿ���Ҫ�ÿ�?
	}
	if(document.frm5186.qryvalue.value=="")
	{	rdShowMessageDialog("�������ѯ������");
		document.frm5186.qryvalue.focus();
		return false;
	}
	else if(beginym=="" ||endym=="")
	{
		rdShowMessageDialog("�������ѯ�����գ�");
		return false;
	}
	else if(beginym.substr(0,6)!=endym.substr(0,6))
	{
		rdShowMessageDialog("ֻ�ܲ�ѯ��ͬ���µĵ��ӷ�Ʊ!");
		return false;
	}
	/*ֻ�ܲ�ѯͬ�µ�*/
	else{
		document.frm5186.action="zgar_2.jsp";
		frm5186.submit();
	}
	 
}
function doCheck1()
{
	var qry_type = document.frm5186.qrytype1[document.frm5186.qrytype1.selectedIndex].value;
	//alert("У����������action qry_type is "+qry_type);
	//�Ƚ��к���ת�� Ȼ���������У��
	var beginym = document.frm5186.beginym.value;
	var endym = document.frm5186.endym.value;
	var qryvalue = document.frm5186.qryvalue.value;
	if(document.frm5186.qryvalue.value=="")
	{	rdShowMessageDialog("�������ѯ������");
		document.frm5186.qryvalue.focus();
		return false;
	}
	else if(beginym=="" ||endym=="")
	{
		rdShowMessageDialog("�������ѯ�����գ�");
		return false;
	}
	else if(beginym.substr(0,6)!=endym.substr(0,6))
	{
		rdShowMessageDialog("ֻ�ܲ�ѯ��ͬ���µĵ��ӷ�Ʊ!");
		return false;
	}
	else
	{
		var checkPwd_Packet = new AJAXPacket("zgar_getPhoneNo.jsp","���ڽ�������У�飬���Ժ�......");
		//dcustmsgdead������У�� ���ҳ����ܵû�
		checkPwd_Packet.data.add("qry_type", qry_type);//��������					 
		checkPwd_Packet.data.add("qryvalue",qryvalue); //����
		checkPwd_Packet.data.add("custPaswd", document.getElementById("cus_pass").value);
		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
		checkPwd_Packet=null;
	}	
}
function doCheckPwd(packet) 
{
		var s_phone_no_out = packet.data.findValueByName("s_phone_no_out");
		var qry_type = packet.data.findValueByName("qry_type");
		var retResult = packet.data.findValueByName("retResult");
		//retResult="000000";
		var retResultMsg = packet.data.findValueByName("retResultMsg");
		//alert("s_phone_no_out is "+s_phone_no_out+" and qry_type is "+qry_type+" and retResult is "+retResult+" and retResultMsg is "+retResultMsg);
		if(qry_type=="6")
		{
			document.frm5186.contract_no.value=document.frm5186.qryvalue.value;
			document.all.qrytype.value="0";
			document.frm5186.action="zgar_2.jsp";
		    frm5186.submit();
		}
		else
		{
			if(qry_type=="0"||qry_type=="1"||qry_type=="2")
			{
				if(retResult=="000000")//У��ͨ��
				{
					document.all.qrytype.value="0";
					document.frm5186.contract_no.value=s_phone_no_out;
					//qryvalue ���ֵҲ��
					document.frm5186.qryvalue.value=s_phone_no_out;
					document.frm5186.action="zgar_2.jsp";
					frm5186.submit();
				}
				else
				{
					rdShowMessageDialog("����У��ʧ��!�������:"+retResult+",����ԭ��:"+retResultMsg);
					return false;
				}
			}
			else
			{
				//alert("s_phone_no_out is "+s_phone_no_out);//>0 ˵���м�¼
				if(s_phone_no_out>0)//������Ϣ����
				{
					if(qry_type=="5")
					{
						document.frm5186.contract_no.value="99999999999";
						document.all.qrytype.value="1";
					}
					else
					{
						document.frm5186.contract_no.value=document.frm5186.qryvalue.value;
						 
						document.all.qrytype.value="0";
					}
					document.frm5186.action="zgar_2.jsp";
					frm5186.submit();
				}
				else
				{
					rdShowMessageDialog("������Ϣ������,��˶Ժ���������!");
					return false;
				}	
			}
		}
		
}
</SCRIPT>

<FORM method=post name="frm5186">
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="opCode"  value="5186">
<input type="hidden" name="custPass"  value="">
	<div class="title">
		<div id="title_zi">ǰ̨���ӷ�Ʊ��ӡ</div>
	</div>
<table cellspacing="0">
		<TR> 
	      <td class="blue">��������</TD>
          <td colspan=3>
          	<select name="qrytype1">
				<option value="0" selected>�ֻ�����</option>
				<option value="1" >����������</option>
				<option value="2" >�������</option>
				<option value="3" >�����û�</option>
				<option value="4" >�������</option>
				<option value="5" >һ��֧��</option>
				<option value="6" >��ؽɷѺ���</option>
			</select>
			</td>
		</TR>
		<!--
		<TR> 
	      <td class="blue">��ѯ��ʽ</TD>
          <td colspan=3>
          	<select name="qrytype">
				<option value="0" selected>�û�����</option>
				<option value="1" >�˻�����</option>
			</select>
			</td>
		</TR>
		-->
		<tr>
			<td class="blue">��ѯ����</TD>
			<td >
				<input type="text" name="qryvalue">
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
		  <TR> 
	      <td class="blue">��ѯ��ʼ������</TD>
          <td>
          <input type="hidden" name="qrytype">	
			<input type="text"  name="beginym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="8"  >
			</td>
          <td class="blue">��ѯ����������</TD>
          <td>
          	
			<input type="text"  name="endym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="8"  >
			</td>
          </TR>
		  <input type="hidden" name="contract_no">	
			 
	    <TR> 
	      <TD align="center" id="footer" colspan="4"> 
		  <input type="submit" class="b_foot" name="Button1" value="��ѯ" onclick="doCheck1()">
	        &nbsp; 
	        &nbsp;&nbsp;<input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
	        &nbsp; 
	      </TD>
	    </TR>
	    </table> 
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html> 
