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
		String opCode = "e900";
		String opName = "��ͨ��Ʊ��Ϣ";
		String login_no = (String)session.getAttribute("workNo");
		String begin_ym = request.getParameter("begin_ym");
		String s_in_ModeTypeCode = request.getParameter("s_in_ModeTypeCode");
		String s_in_CaseTypeCode = request.getParameter("s_in_CaseTypeCode");
		String yingyt = request.getParameter("yingyt");
		String [] inParas = new String[2];
		String return_code5="";
	    String ret_msg="";
	    String return_page = "e900_6.jsp";
	    String temp = "";
	    
		boolean flag = false;
		if(begin_ym == null)
	   {
		    begin_ym = "";
		    flag = false;
	   }
	   else
	   {
	      flag = true;
	   }	
	    String sqlStr1 = "SELECT group_id,group_name from schnregionlist ORDER BY group_id";
%>

<wtc:pubselect name="TlsPubSelCrm" outnum="2" retmsg="return_msg1" retcode="return_code1">
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
<script language="JavaScript">

function commit(){
	
	
  if(document.frm.begin_ym.value =="")  {
     rdShowMessageDialog("�������·�!");
     document.frm.begin_ym.value = "";
     document.frm.begin_ym.focus();
     return false;
  }
  
  if(document.frm.s_in_ModeTypeCode.value =="")  {
     rdShowMessageDialog("��ѡ���������!");
     document.frm.s_in_ModeTypeCode.value = "";
     document.frm.s_in_ModeTypeCode.focus();
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
function select_yyt()
{
	
	var district_code = document.all.s_in_CaseTypeCode[document.all.s_in_CaseTypeCode.selectedIndex].value;
	var myPacket = new AJAXPacket("e900_select.jsp","���ڻ��Ӫҵ����Ϣ�����Ժ�......");
	var sqlStr = "30";
	var param1 = "district_code="+district_code;
	myPacket.data.add("sqlStr",sqlStr);
	myPacket.data.add("param1",param1);
	myPacket.data.add("flag",2);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}
function doProcess(packet)
{	 
    var triListdata = packet.data.findValueByName("tri_list");   
    var flag = packet.data.findValueByName("flag");  
    if(flag==1 )
	{
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
	else
	{
		document.all("yingyt").length=0;
		document.all("yingyt").options.length=triListdata.length+1;//triListdata[i].length;
		document.all("yingyt").options[0].text="--��ѡ��--";
		document.all("yingyt").options[0].value="00";
		for(j=0;j<triListdata.length;j++)
		{
			document.all("yingyt").options[j+1].text=triListdata[j][1];
			document.all("yingyt").options[j+1].value=triListdata[j][0];
		}//Ӫҵ�������
		document.all("yingyt").options[0].selected=true;
	}	
		  
}

 </script> 
 
<title>������BOSS-��Ʊ��Ϣ��ѯ��¼��</title>
</head>
<BODY>
<form action="e900_6.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��ͨ��Ʊ��Ϣ</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">��ѯ��ʽ</td>
        <td> 
          <input name="busyType2" type="radio" onClick="sel1()" value="1">���С�������Ʊ 
          <input name="busyType2" type="radio" onClick="sel5()" value="1">Ӫҵ����Ʊ
          <input name="busyType2" type="radio" onClick="sel2()" value="1">��Ʊʹ�������ѯ 
          <input name="busyType2" type="radio" onClick="sel3()" value="1">���ô������ 
          <input name="busyType2" type="radio" onClick="sel4()" value="1">�������ô������
          <input name="busyType2" type="radio" onClick="sel6()" value="1" checked>��ѯ��ɾ��
          <input name="busyType2" type="radio" onClick="sel7()" value="1">��ѯ
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td align="left" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="begin_ym" size="10" maxlength="6" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <select name="s_in_ModeTypeCode" onchange="select_change()">
          	<%=mode_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
       
    </tr>
    
    <tr>   
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <select name="s_in_CaseTypeCode" onchange="select_yyt()">
          	<option value="00">--��ѡ��--</option>                   
          </select>
      </td>
      <td align="left" class="blue" width="50%">Ӫ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ҵ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��:&nbsp;
        <select name="yingyt" style=width:80%>
          	<option value="00">--��ѡ��--</option>                   
          </select>
      </td>     
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="��ѯ" onclick="commit()" >
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
        <th>��Ʊ����</th>
        <th>��Ʊ��ʼ����</th>
        <th>��Ʊ��������</th>
        <th>¼�빤��</th>    
        <th>¼��ʱ��</th>     
        <th>����</th>           
      </tr>
<%
   if(flag)
   {
             
      if(s_in_CaseTypeCode.equals("00") && yingyt.equals("00"))
      {
        inParas[0]="SELECT invoice_code,s_invoice_number,e_invoice_number,login_no,to_char(op_time, 'YYYY-MM-DD HH24:MI:SS') FROM dbcustadm.tt_wcityinvoice WHERE region_code=:region_code AND year_month=:year_month ";
      	inParas[1]="region_code="+s_in_ModeTypeCode+",year_month="+begin_ym;
      	temp="0";
      }
      else if(!s_in_CaseTypeCode.equals("00") && yingyt.equals("00"))
  	  {
  	    inParas[0]="SELECT invoice_code,s_invoice_number,e_invoice_number,login_no,to_char(op_time, 'YYYY-MM-DD HH24:MI:SS') FROM dbcustadm.tt_wdisinvoice  WHERE region_code=:region_code AND district_code = :district_code AND year_month=:year_month ";
  	    inParas[1]="region_code="+s_in_ModeTypeCode+",district_code="+s_in_CaseTypeCode+",year_month="+begin_ym;
  	    temp="1";
  	  }
      else
      {
        inParas[0]="SELECT invoice_code,s_invoice_number,e_invoice_number,login_no,to_char(op_time, 'YYYY-MM-DD HH24:MI:SS') FROM dbcustadm.tt_wgroupinvoice WHERE region_code=:region_code AND district_code = :district_code AND group_id = :group_id AND year_month=:year_month ";
        inParas[1]="region_code="+s_in_ModeTypeCode+",district_code="+s_in_CaseTypeCode+",group_id="+yingyt+",year_month="+begin_ym;  
        temp="2";
      }
   
%>

	<wtc:service name="TlsPubSelBoss"   retcode="retCode" retmsg="retMsg" outnum="5">
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>	
		</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%	

   return_code5 = retCode;
   ret_msg = retMsg;
   if(return_code5.equals("000000"))
   {
     for(int i=0; i<tempArr.length ;i++)
     {
%>   
     <tr align="center">
        <td><%=tempArr[i][0]%></td>
        <td><%=tempArr[i][1]%></td>
        <td><%=tempArr[i][2]%></td>
        <td><%=tempArr[i][3]%></td>
        <td><%=tempArr[i][4]%></td>
        <td><a href="e900_6Cfm.jsp?invoeice_code=<%=tempArr[i][0]%>&s_invoice_number=<%=tempArr[i][1]%>&e_invoice_number=<%=tempArr[i][2]%>&login_no=<%=tempArr[i][3]%>&temp=<%=temp%>&s_in_ModeTypeCode=<%=s_in_ModeTypeCode%>" onclick= "return   confirm( 'ȷ��ɾ��ѡ�еļ�¼�� '); "> ɾ��</a></td>
      </tr>
<%}}

else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("��Ϣ��ѯ����!<br>������룺'<%=return_code5%>'��������Ϣ��'<%=ret_msg%>'��");
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

