<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "g430";
		String opName = "ǩԼ�û��۷ѽ������";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*Ĭ�ϣ�12����֮ǰ*/
    String startTime = sdf.format(today.getTime());
		
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	


 

 function docheck()
{
	 var cus_pass = document.all.cus_pass.value;
	 var phone_no = document.all.phone_no.value;
	 if(phone_no=="")
	 {
		 rdShowMessageDialog("�������ֻ�����!");
		 return false;
	 }	
	 if(cus_pass=="")
	 {
		rdShowMessageDialog("�������û�����!");
		return false;
	 }
	 var temp=document.getElementsByName("kg");
     var cg_select=document.getElementById("chs").value;
	 if(cg_select==0)
	 {
		 rdShowMessageDialog("��ѡ�����ñ�ʶ");
		 return false;
	 }	
	 //alert(cg_select);
	 var cg_radio="";
	 var values1 = document.all.values.value;

	 var values1_fz = document.all.values_fz.value;
	 if((cg_select=="1" &&values1=="")   )
	 {
		 rdShowMessageDialog("���������ý�� ");
		 return false;
	 }	
	 if(   (cg_select=="2" &&values1_fz=="") )
	 {
		 rdShowMessageDialog("���������÷�ֵ");
		 return false;
	 }
	for (i=0;i<temp.length;i++){

  //����Radio

    if(temp[i].checked &&cg_select==3)

      {
		//  alert("��ѡ����"+temp[i].value);
		  cg_radio=	temp[i].value;
      //��ȡRadio��ֵ

     // document.form2.textfield.value="��ѡ����"+temp[i].value;

      //���ݸ�����һ����

      }

  }
		if(cg_select==3 &&cg_radio=="")
		{
			rdShowMessageDialog("��ȷ�Ͽ���");
			return false;
		}

 
        //rdShowMessageDialog("�û���Լ�ɹ�!");
 
		document.frm.action="g430_2.jsp?kg="+cg_radio+"&flag="+cg_select+"&values="+values1+"&custPass="+cus_pass+"&phoneNo="+phone_no+"&value_fz="+values1_fz;
	   // alert("kg is "+cg_radio+" and flag is "+cg_select+" and values1 is "+values1);
	    document.frm.submit();
 
	 
 } 
 
 


 
 
  function doclear() {
 		frm.reset();
 }
	
	function inits()
	{
		document.getElementById("div1").style.display="none";
		document.getElementById("div2").style.display="none";
		document.getElementById("div3").style.display="none";
	}

	function changes()
	{
		var cg_id=document.getElementById("chs");
		var cg_txt = cg_id.options(cg_id.selectedIndex).text;
		//alert("cg_id is "+cg_id.value+" and cg_txt "+cg_txt);
		if(cg_id.value==3)
		{
			document.getElementById("div1").style.display="none";
			document.getElementById("div3").style.display="none";
			document.getElementById("div2").style.display="block";
			document.all.values.value="";//����ʱ �����ֵΪ��
		}
		if(cg_id.value==1) 
		{
			document.getElementById("div1").style.display="block";
			document.getElementById("div2").style.display="none";
			document.getElementById("div3").style.display="none";
			//document.all.values.value="";//���� ���ʱ 
		}
		if(cg_id.value==2) 
		{
			document.getElementById("div3").style.display="block";
			document.getElementById("div2").style.display="none";
			document.getElementById("div1").style.display="none";
			//document.all.values.value="";//���÷�ֵ 
		}

	}


-->
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">�������ѯ����</div>
		</div>
	<table cellspacing="0">
    <tr> 
      
	  <td class="blue" width="15%">�ֻ�����</td>
      <td> 
        <input class="button"type="text" name="phone_no" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" >
      </td>
       
       
    </tr>

	<tr> 
      <td class="blue"  width="15%">�û�����</td>
          <td colspan=3>
           	<jsp:include page="/npage/query/pwd_one.jsp">
		      	<jsp:param name="width1" value="16%"  />
		      	<jsp:param name="width2" value="34%"  />
		      	<jsp:param name="pname" value="cus_pass"  />
		      	<jsp:param name="pwd" value="12345"  />
	    	   	</jsp:include>
       </td>
     
    </tr>

	<tr> 
	  <td class="blue" width="15%">���ñ�ʶ</td>
	  <td>
      <select id="chs" name="cg" onchange="changes()">
		<option value="0">��ѡ��</option>
		<option value="1">���</option>
		<option value="2">��ֵ</option>
		<option value="3">����</option>
	  </select>
	 &nbsp;&nbsp;&nbsp;&nbsp;
        <div id="div1">
			<input class="button"type="text" name="values"  >
		</div>
		<div id="div3">
			<input class="button"type="text" name="values_fz"  >
		</div>
		<div id="div2">
			<input type="radio" name="kg" value="1" checked>��&nbsp;
			<input type="radio" name="kg" value="0">��
		</div>
      </td>
       
       
    </tr> 
 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="ȷ��" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>