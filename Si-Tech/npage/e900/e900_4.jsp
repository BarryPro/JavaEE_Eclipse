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
		String opCode = "e900";
		String opName = "��ͨ��Ʊ��Ϣ";
		boolean flag = false;	
		
		String return_page = "e900_4.jsp";
		String s_in_ModeTypeCode = request.getParameter("s_in_ModeTypeCode");
		String s_in_CaseTypeCode = request.getParameter("s_in_CaseTypeCode");
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		String workno = (String)session.getAttribute("workNo");
		
			
		
		if(from == null)
		{
		    from = "";
		    flag = false;
		}
		  else
		  {
		      flag = true;
		  }	

      String return_code="";
	  String ret_msg="";
	  String [] inParas = new String[5];
	  inParas[0]  = from;
	  inParas[1]  = to;
	  inParas[2]  = s_in_ModeTypeCode;
	  inParas[3]  = s_in_CaseTypeCode;
	  inParas[4]  = workno;  

	String sqlStr = "SELECT group_id,group_name from schnregionlist ORDER BY group_id";
%>
<wtc:pubselect name="TlsPubSelCrm" outnum="2" retmsg="retMsg" retcode="retCode">
			<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="return_result" scope="end"/>	 
	 	
<%
   String case_options = "";
   String mode_options ="<option value=>--��ѡ��--</option>";
   String[][] return_result1=new String[1][2];
   return_result1[0][0]="00";
   return_result1[0][1]="������ʡ";
   for(int i=0;i<return_result.length;i++)
   {
     case_options += "<option value="+return_result[i][0]+">"+return_result[i][1]+"</option>";
   }
   
      for(int i=0;i<return_result1.length;i++)
   {
     mode_options += "<option value="+return_result1[0][0]+">"+return_result1[0][1]+"</option>";
   }
%>
<HTML>
<HEAD>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
<script language="JavaScript">
var modetypecode = new Array();//ģ�����
  var modetypename = new Array();//ģ������
  var casetypecode = new Array();//������ʹ���
  var casetypename = new Array();//�����������
  <%
  for(int m=0;m<return_result.length;m++)
  {
		out.println("casetypecode["+m+"]='"+return_result[m][0]+"';\n");
		out.println("casetypename["+m+"]='"+return_result[m][1]+"';\n");
  }
  for(int m=0;m<return_result1.length;m++)
  {
		out.println("modetypecode["+m+"]='"+return_result1[m][0]+"';\n");
		out.println("modetypename["+m+"]='"+return_result1[m][1]+"';\n");
  }
  %>
  
function getCase(control,controlToPopulate)
{
	for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
  myEle = document.createElement("option") ;
    myEle.value = control.value;
      myEle.value = "00";
        myEle.text = control.options[control.selectedIndex].text;
//        myEle.value = "";
//        myEle.text = "--��ѡ��--";
        controlToPopulate.add(myEle) ;
	for ( x = 0 ; x < casetypecode.length  ; x++ )
   {
//      if ( casetypecode[x] == control.value )
//      {
        myEle = document.createElement("option") ;
        myEle.value = casetypecode[x] ;
        myEle.text = casetypename[x] ;
        controlToPopulate.add(myEle) ;
//      }
   }
	
}
function commit(){
	
  if(document.frm.temp.value=="1")  {
  	
	  if(document.frm.year.value=="")  {
	     rdShowMessageDialog("���������!");
	     document.frm.year.value = "";
	     document.frm.year.focus();
	     return false;
	  }
	  
	  if(document.frm.jd.value=="")  {
	     rdShowMessageDialog("�����뼾��!");
	     document.frm.jd.value = "";
	     document.frm.jd.focus();
	     return false;
	  }
	  document.frm.from.value=document.frm.year.value
	  document.frm.to.value=document.frm.jd.value
  }
  
  if(document.frm.temp.value=="2")  {
  	
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
	  
	  document.frm.from.value=document.frm.fromMonth.value
	  document.frm.to.value=document.frm.toMonth.value
  }
	  
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
  
     document.frm.action="e900_4.jsp";
 	 document.frm.submit();
	        
}

function commit2(){
	
  if(document.frm.temp.value=="1")  {
  	
	  if(document.frm.year.value=="")  {
	     rdShowMessageDialog("���������!");
	     document.frm.year.value = "";
	     document.frm.year.focus();
	     return false;
	  }
	  
	  if(document.frm.jd.value=="")  {
	     rdShowMessageDialog("�����뼾��!");
	     document.frm.jd.value = "";
	     document.frm.jd.focus();
	     return false;
	  }
	  document.frm.from.value=document.frm.year.value
	  document.frm.to.value=document.frm.jd.value
  }
  
  if(document.frm.temp.value=="2")  {
  	
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
	  
	  document.frm.from.value=document.frm.fromMonth.value
	  document.frm.to.value=document.frm.toMonth.value
  }
	
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
  
   if(document.frm.zbr.value=="")  {
     rdShowMessageDialog("�������Ʊ���!");
     document.frm.zbr.value = "";
     document.frm.zbr.focus();
     return false;
  }
  
   if(document.frm.shr.value=="")  {
     rdShowMessageDialog("�����������!");
     document.frm.shr.value = "";
     document.frm.shr.focus();
     return false;
  }

   if(document.frm.date.value=="")  {
     rdShowMessageDialog("�����������!");
     document.frm.date.value = "";
     document.frm.date.focus();
     return false;
  }
   if(document.frm.date.value.length!=8)  {
     rdShowMessageDialog("���ڳ���Ϊ8λ����!");
     document.frm.date.value = "";
     document.frm.date.focus();
     return false;
  }
     document.frm.action="e900_4Cfm.jsp";
 	 document.frm.submit();
	        
}

 

function check_HidPwd()
{
  if(document.frm.phoneNo.value=="")
  {
     rdShowMessageDialog("������������!");
     document.frm.phoneNo.focus();
     return false;
  }
  

 if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("�������ֻ����11λ!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
	       
			var phone_no = document.all.phoneNo.value;
		  var busy_type = "1";  
			var checkPwd_Packet = new AJAXPacket("../s1300/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("phone_no",phone_no);
			checkPwd_Packet.data.add("busy_type",busy_type);
			core.ajax.sendPacket(checkPwd_Packet);
			
			checkPwd_Packet=null;
 
}


 function doProcess(packet){
	var retResult   = packet.data.findValueByName("retResult");
	var SzxFlag     = packet.data.findValueByName("SzxFlag");
	var IsMarketing = packet.data.findValueByName("IsMarketing");
	var returnCode = packet.data.findValueByName("returnCode");
	
	if(returnCode=="999999"){
		rdShowMessageDialog("û�д��û����������!");
		return;
	}
 
  commit();
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
 
 function selt1(){
	document.getElementById("selectJd").style.display = (document.getElementById("selectJd").style.display=="")?"none":"";
    document.getElementById("selectMonth").style.display = (document.getElementById("selectMonth").style.display=="")?"none":"";  
    document.frm.temp.value = "1";
}
function selt2(){
	document.getElementById("selectJd").style.display = (document.getElementById("selectJd").style.display=="")?"none":"";
    document.getElementById("selectMonth").style.display = (document.getElementById("selectMonth").style.display=="")?"none":"";
    document.frm.temp.value = "2";
}
 </script> 
 
<title>������BOSS-�ֻ�֧���ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��ͨ��Ʊ��Ϣ</div>
		</div>
<input name="temp" type="hidden" value="1">
<input name="from" type="hidden">
<input name="to" type="hidden">
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">��ѯ��ʽ</td>
    	<td>
          <input name="busyType2" type="radio" onClick="sel1()" value="1" >���С�������Ʊ  
          <input name="busyType2" type="radio" onClick="sel5()" value="1">Ӫҵ����Ʊ
          <input name="busyType2" type="radio" onClick="sel2()" value="1" >��Ʊʹ�������ѯ 
          <input name="busyType2" type="radio" onClick="sel3()" value="1" >���ô������
          <input name="busyType2" type="radio" onClick="sel4()" value="1" checked>�������ô������
          <input name="busyType2" type="radio" onClick="sel6()" value="1">��ѯ��ɾ��
          <input name="busyType2" type="radio" onClick="sel7()" value="1">��ѯ
         </td> 
    </tr>
  </table>
 <table cellspacing="0">
     <tr>
    	<td class="blue" width="15%">��ѯʱ�䷶Χѡ��</td>
    	<td>
          <input name="busyType3" type="radio" onClick="selt1()" value="1" checked>���Ȳ�ѯ 
          <input name="busyType3" type="radio" onClick="selt2()" value="2">�·ݲ�ѯ
         </td> 
    </tr>
  </table> 
  <table cellspacing="0">
    <tr id="selectJd" style="display;">
    	<td align="right" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="year" value="" size="20" maxlength="4"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
      </td>  
      <td align="right" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td>         
        <select name="jd" >
          	<option value="">--��ѡ��--</option>   
          	<option value="1">��һ����</option> 
          	<option value="2">�ڶ�����</option> 
          	<option value="3">��������</option> 
          	<option value="4">���ļ���</option>                 
          </select><font color="#FF0000">*</font>
      </td>  
    </tr>
    <tr id="selectMonth" style="display:none;">
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
    	<td align="right" class="blue" width="15%">ʡ&nbsp;��&nbsp;��&nbsp;&nbsp;&nbsp;</td>
       <td> <select name="s_in_ModeTypeCode" onchange="getCase(this,s_in_CaseTypeCode)">
          	<%=mode_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
      <td align="right" class="blue" width="15%">��������&nbsp;&nbsp;&nbsp; </td>
       <td> <select name="s_in_CaseTypeCode" >
          	<option value="">--��ѡ��--</option>                   
          </select><font color="#FF0000">*</font>
      </td>   
      </td>      
    </tr>
    
    <tr>
    	<td align="right" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="zbr" value="" size="20" maxlength="20"   >
        <font class="orange"> *</font>
      </td>  
      <td align="right" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="shr" value="" size="20" maxlength="20"   >
        <font class="orange"> *</font>
      </td>  
    </tr>
    <tr> 
      <td align="right" class="blue" width="15%">�����&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="date" value="" size="20" maxlength="8"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
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
        <th>��Ʊ��λ����</th>
        <th>��Ʊ����</th>
        <th>���ڽ�����</th>
        <th>���ڽ�����</th>    
        <th>�칺����</th>     
        <th>�칺����</th>
        <th>ʹ�ò���</th>
        <th>ʹ�÷���</th>
        <th>������</th>    
        <th>������</th>        
        <th>���߽��</th>  
      </tr>
<%
   if(flag){
%>

	<wtc:service name="bs_9004Cfm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="13" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%	

   return_code = retCode;
   ret_msg = retMsg;
   if(tempArr.length != 0 && return_code.equals("000000"))
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

