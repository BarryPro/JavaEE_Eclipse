<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����Ԥ��� 8379
   * �汾: 1.0
   * ����: 2010/3/12
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���Ź���������ѯ</title>
<%
  //String opCode="8379";
 //String opName="����Ԥ���";

    String opCode="g210";
	String opName="���Ź���������ѯ";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>
 
<!--    routerKey="region" routerValue="<%=regionCode%>" -->
 
 

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body onload="loads()">
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "g210" >
	<input type="hidden" name="opname" value = "�ն�Ӫ����δ����ԭ���ѯ" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">���Ź���������ѯ</div>
</div>	 
	
	<div class="title">
			<div id="title_zi">��ѡ���ѯ��ʽ</div>
		</div>
		<table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue" width="15%">��ѯ��ʽ</td>
                  <td colspan="3"> 
                    <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" checked >
                    ���Ų�ѯ
                    <input name="busyType1" type="radio" onClick="sel2()" value="2"  >
                    ���˲�ѯ 
                     
                   
					</td>
                 </tr>   
                </tbody> 
              </table>
	<!--���ŵ�-->
	<table cellspacing="0" id="tabGrp">
	   
	   <tr >
			<td class="blue" colspan=2>
				���ű���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="jtbm" value=""  > 
			 &nbsp;&nbsp;&nbsp;&nbsp;<input type=button class="b_foot" name="check" value="��ѯ����"  onclick="getPhone()" > 
			 
		</tr>

		<tr >
			 
		  <td class="blue" colspan=2>
				��Ʒ����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="phoneNo" value=""  > 
			</td>
	    </tr>
		<tr>
			<td class="blue" colspan=2>
				��ѯʱ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="date" value="<%=dateStr%>" maxlength=8 > 
			</td>
		</tr>
		<tr >
			<td align=center colspan=2><input type=button class="b_foot" name="check2" value="��ѯ" id="cz" onclick="docfm()" >
			 
			
			<input type=reset class="b_foot" value="����" >
			</td>
		<tr>
		</tr>
		
	</table>
	<!--���˵�-->
	<table cellspacing="0" id="tabIndival">
	    
	   <tr>
		
		    <td class="blue" colspan=2>
				�ֻ�����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="phoneNo2" value=""  > 
			</td>

	  </tr>
	  <tr>
		
		    <td class="blue" colspan=2>
				��ѯʱ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="date2" value="<%=dateStr%>" maxlength=6 > 
			</td>

	  </tr>
		<tr >
			<td align=center colspan=2><input type=button class="b_foot" name="check2" value="��ѯ" id="cz1" onclick="docfm1()" >
			 
			
			<input type=button class="b_foot" value="����" onclick=document.all.phoneNo2.value="";>
			</td>
		</tr>
		
	</table>
</div>
 
 
 
</table>
 <input type="hidden" id="jtmc">
 <input type="hidden" id="cpmc">
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
	function loads()
	{
		sel1();
	}
	function sel2()
	{
		document.getElementById("tabIndival").style.display="block";
		document.getElementById("tabGrp").style.display="none";
	}
	function sel1()
	{
		document.getElementById("tabIndival").style.display="none";
		document.getElementById("tabGrp").style.display="block";
	}
	 
	function getPhone()
	{
		 
		var jtbm = document.all.jtbm.value;
		 
		if(jtbm=="")
		{
			rdShowMessageDialog("�����뼯�ű���!");
			return false;
		}
		//��� begin
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	 
		var returnValue = window.showModalDialog('getCount.jsp?unit_id='+jtbm,"",prop);
		  
		 if(returnValue==null)
		 {
				rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�",0);
				document.frm.phoneNo.focus();
				return false;
		  }
		  if(returnValue=="")
		 {
				rdShowMessageDialog("��û��ѡ���ʺţ�",0);
				document.frm.phoneNo.focus();
				return false;
		  }
		//alert("returnValue is "+returnValue);
		var s_phone=returnValue.split(",");
		//alert("returnValue is "+returnValue+" and s_phone is "+s_phone[2]);  
		document.getElementById("jtmc").value=s_phone[1];
		document.getElementById("cpmc").value=s_phone[2];
		document.frm.phoneNo.value = s_phone[0]; 
		//��� end
		
			
		 
		
		
	}
	//���ŵ�
	//������ ���ܲ�ѯ�������µ�
	function docfm()
	{
		var phone_no = document.frm.phoneNo.value; 
		var date = document.frm.date.value;
		var unit_id = document.frm.jtbm.value;
		/*
		document.getElementById("jtmc").value=s_phone[1];
		document.getElementById("cpmc").value=s_phone[2];
		*/
		var jtmc = document.getElementById("jtmc").value;
		var cpmc = document.getElementById("cpmc").value;
		if(phone_no=="")
		{
			rdShowMessageDialog("�����뼯�Ų�Ʒ20��������뼯�ű���󵥻���ѯ���밴ť��ȡ!");
			return false;
		}
		if(unit_id=="")
		{
			rdShowMessageDialog("�����뼯�ű��� !");
			return false;
		}
		if(date=="")
		{
			rdShowMessageDialog("�������ѯʱ��!");
			return false;
		}
		//ʱ��� ��������
		var beginYm = date;
		var endYm = "<%=dateStr%>"; //��ǰʱ���~~
		var year1 =  beginYm.substr(0,4);
		  var year2 =  endYm.substr(0,4); 
		  var month1 = beginYm.substr(4,2);
		  var month2 = endYm.substr(4,2);
		  var len=(year2-year1)*12+(month2-month1)+1;
		  //alert(" test len is "+len);
		  if(len>3)
		  {
			rdShowMessageDialog("���ܲ鱾�º�ǰ������Ϣ!");
			return false;
		  }
		var actions = "g210_2.jsp?phone_no="+phone_no+"&date="+date+"&unit_id="+unit_id+"&jtmc="+jtmc+"&cpmc="+cpmc;
		document.all.frm.action=actions;
		document.all.frm.submit();
	}
	//���˵�
	function docfm1()
	{
		var phone_no = document.frm.phoneNo2.value;
		var date = document.frm.date2.value;
		if(phone_no=="")
		{
			rdShowMessageDialog("����������ֻ����� !");
			return false;
		}
		if(date=="")
		{
			rdShowMessageDialog("�������ѯʱ�� !");
			return false;
		}
		//ʱ��� ��������
		var beginYm = date;
		var endYm = "<%=dateStr%>"; //��ǰʱ���~~
		var year1 =  beginYm.substr(0,4);
		  var year2 =  endYm.substr(0,4); 
		  var month1 = beginYm.substr(4,2);
		  var month2 = endYm.substr(4,2);
		  var len=(year2-year1)*12+(month2-month1)+1;
		  //alert(" test len is "+len);
		  if(len>3)
		  {
			rdShowMessageDialog("���ܲ鱾�º�ǰ������Ϣ!");
			return false;
		  }
		var actions = "g210_3.jsp?phone_no="+phone_no+"&date="+date;
		document.all.frm.action=actions;
		document.all.frm.submit();
	}
 

</script>
 
 