<%
/********************
 version v2.0
������: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
        String org_code = (String)session.getAttribute("orgCode");
		String return_page = "e900_2.jsp";
		String opCode = "e900";
		String opName = "��ͨ��Ʊ��Ϣ";
		boolean flag = false;	
		String workno = (String)session.getAttribute("workNo");
		String invoice_code = request.getParameter("invoice_code");
		String invoice_number = request.getParameter("invoice_number");
			
		
	   if(invoice_code == null)
	  {
		    invoice_code = "";
		    flag = false;
	  }
	  else
	  {
	      flag = true;
	  }	

      String return_code="";
	  String ret_msg="";
	  String [] inParas = new String[2];
	  inParas[0]  = invoice_code;
	  inParas[1]  = invoice_number;

	  String sqlStr1 = "SELECT group_id,group_name from schnregionlist ORDER BY group_id";
	  
%>

<wtc:pubselect name="TlsPubSelCrm" outnum="2" retmsg="retMsg" retcode="retCode">
			<wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="return_result1" scope="end"/>	 	

<%
   String mode_options ="<option value=>--��ѡ��--</option>";
   
   for(int i=0;i<return_result1.length;i++)
   {
     mode_options += "<option value="+return_result1[i][0]+">"+return_result1[i][1]+"</option>";
   }
%>
<HTML>
<HEAD>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
<script language="JavaScript">

function commit(){
	
   if(document.frm.invoice_code.value=="")  {
     rdShowMessageDialog("�����뷢Ʊ����!");
     document.frm.invoice_code.value = "";
     document.frm.invoice_code.focus();
     return false;
  }
  
  if(document.frm.invoice_number.value=="")  {
     rdShowMessageDialog("�����뷢Ʊ����!");
     document.frm.invoice_number.value = "";
     document.frm.invoice_number.focus();
     return false;
  }
  
 	 document.frm.submit();
	        
}
 function sel1() {
 		 
		window.location.href='e900.jsp';
 }

 function sel2(){
 
	window.location.href='e900_2.jsp';
 }

function sel3(){
 
	window.location.href='e900_3.jsp';
 }
 function sel4(){
    window.location.href='e900_4.jsp';
 }
 function sel5(){
    window.location.href='e900_5.jsp';
 }
 function sel6(){
    window.location.href='e900_6.jsp';
}
 
function sel7(){
    window.location.href='e900_7.jsp';
}
 function doclear() {
 		frm.reset();
 }
 
 function commit2(){
	
  if(document.frm.s_in_ModeTypeCode.value =="")  {
	     rdShowMessageDialog("��ѡ���������!");
	     document.frm.s_in_ModeTypeCode.value = "";
	     document.frm.s_in_ModeTypeCode.focus();
	     return false;
  }
  if(document.frm.s_in_CaseTypeCode.value =="")  {
     rdShowMessageDialog("��ѡ����������!");
     document.frm.s_in_CaseTypeCode.value = "";
     document.frm.s_in_CaseTypeCode.focus();
     return false;
  }
  
    if(document.frm.fromMonth.value=="")  {
     rdShowMessageDialog("���������!");
     document.frm.fromMonth.value = "";
     document.frm.fromMonth.focus();
     return false;
  }
  
  if(document.frm.toMonth.value=="")  {
     rdShowMessageDialog("�������·�!");
     document.frm.toMonth.value = "";
     document.frm.toMonth.focus();
     return false;
  }
 
     document.frm.action="e900_2Cfm.jsp";
 	 document.frm.submit();	        
}
function select_change()
{
	var region_code = document.all.s_in_ModeTypeCode[document.all.s_in_ModeTypeCode.selectedIndex].value;
	var myPacket = new AJAXPacket("e900_select.jsp","���ڻ��������Ϣ�����Ժ�......");
	var sqlStr = "29";
				  
	var param1 = "region_code="+region_code;
	myPacket.data.add("sqlStr",sqlStr);			  
	myPacket.data.add("param1",param1);
	myPacket.data.add("flag",1);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}
function doProcess(packet)
{	 
    var triListdata = packet.data.findValueByName("tri_list");   
    var flag = packet.data.findValueByName("flag");  
	document.all("s_in_CaseTypeCode").length=0;
	document.all("s_in_CaseTypeCode").options.length=triListdata.length+1;//triListdata[i].length;
	document.all("s_in_CaseTypeCode").options[0].text="--��ѡ��--";
	document.all("s_in_CaseTypeCode").options[0].value="00";
	for(j=0;j<triListdata.length;j++)
	{
		document.all("s_in_CaseTypeCode").options[j+1].text=triListdata[j][1];
		document.all("s_in_CaseTypeCode").options[j+1].value=triListdata[j][0];
	}//Ӫҵ�������
	document.all("s_in_CaseTypeCode").options[0].selected=true;
		  
}
 </script> 
 
<title>������BOSS-�ֻ�֧���ɷ�</title>
</head>
<BODY>
<form action="e900_2.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��ͨ��Ʊ��Ϣ</div>
		</div>

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">��ѯ��ʽ</td>
    	<td>
          <input name="busyType2" type="radio" onClick="sel1()" value="1" >���С�������Ʊ 
          <input name="busyType2" type="radio" onClick="sel5()" value="1">Ӫҵ����Ʊ
          <input name="busyType2" type="radio" onClick="sel2()" value="1" checked>��Ʊʹ�������ѯ 
          <input name="busyType2" type="radio" onClick="sel3()" value="1">���ô������
          <input name="busyType2" type="radio" onClick="sel4()" value="1">�������ô������          
          <input name="busyType2" type="radio" onClick="sel6()" value="1">��ѯ��ɾ��
          <input name="busyType2" type="radio" onClick="sel7()" value="1">��ѯ
         </td> 
    </tr>
  </table>

  
  <table cellspacing="0">    
    <tr>
       <td align="right" class="blue" width="15%">��������&nbsp;&nbsp;&nbsp;</td>
       <td> <select name="s_in_ModeTypeCode" onchange="select_change()">
          	<%=mode_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
      <td align="right" class="blue" width="15%">��������&nbsp;&nbsp;&nbsp; </td>
       <td> <select name="s_in_CaseTypeCode" >
          	<option value="">--��ѡ��--</option>                   
          </select><font color="#FF0000">*</font>
      </td>     
    </tr>
    <tr>
    	<td align="right" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="fromMonth" value="" size="20" maxlength="4"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
      </td>  
      <td align="right" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td>         
        <select name="toMonth" >
          	<option value="">--��ѡ��--</option>   
          	<option value="01">һ��</option> 
          	<option value="02">����</option> 
          	<option value="03">����</option> 
          	<option value="04">����</option>      
          	<option value="05">����</option> 
          	<option value="06">����</option> 
          	<option value="07">����</option> 
          	<option value="08">����</option>      
          	<option value="09">����</option> 
          	<option value="10">ʮ��</option> 
          	<option value="11">ʮһ��</option> 
          	<option value="12">ʮ����</option>            
          </select><font color="#FF0000">*</font>
      </td>  
    </tr>
    <tr>
    	<td align="right" class="blue" width="15%">��Ʊ����&nbsp;&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="invoice_code" value="" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" >
      </td>  
      <td align="right" class="blue" width="15%">��Ʊ����&nbsp;&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="invoice_number" value="" size="20" maxlength="10"  onKeyPress="return isKeyNumberdot(0)" >
      </td>  
    </tr>
  </table>
   <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="��ѯ" onclick="commit()" >
         
          &nbsp;
          <input type="button" name="query" class="b_foot" value="����txt" onclick="commit2()" >
           &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>

  <br>
      

		<div class="title">
			<div id="title_zi">��ѯ���</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
        <th>���</th>
        <th>��Ʊʱ��</th>
        <th>��Ʊ����</th>
        <th>��Ʊ����</th>    
        <th>��Ŀ����</th>     
        <th>���λ</th>
        <th>�ϼƽ��</th>
        <th>��Ʊ��</th>
        <th>��ע</th> 
        <th>�տλ����</th>    
        <th>�տλ��˰��ʶ���</th>   
        <th>��Ʊ����</th>
        <th>��Ʊ����</th>
        <th>����/����</th>
             
      </tr>
<%
   if(flag){
%>

	<wtc:service name="bs_9002Cfm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="16" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%	

   return_code = retCode;
   ret_msg = retMsg;
   if(return_code.equals("000000"))
   {
     for(int i=0; i<tempArr.length ;i++)
     {
%>   
     <tr align="center">
        <td><%=tempArr[i][2]%></td>
        <td><%=tempArr[i][3]%></td>
        <td><%=tempArr[i][4]%></td>
        <td><%=tempArr[i][5]%></td>
        <td><%=tempArr[i][6]%></td>
        <td><%=tempArr[i][7]%></td>
        <td><%=tempArr[i][8]%></td>
        <td><%=tempArr[i][9]%></td>
        <td><%=tempArr[i][10]%></td>
        <td><%=tempArr[i][11]%></td>
        <td><%=tempArr[i][12]%></td>
        <td><%=tempArr[i][13]%></td>
        <td><%=tempArr[i][14]%></td>
        <td><%=tempArr[i][15]%></td>
      </tr>
<%}}

else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("��Ϣ��ѯ����!<br>������룺'<%=return_code%>'��������Ϣ��'<%=ret_msg%>'��");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%	}

}%>      
    </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

