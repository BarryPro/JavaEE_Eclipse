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
		String opCode = "g053";
		String opName = "������Ʊ��Ϣ";
		String login_no = (String)session.getAttribute("workNo");
		String begin_ym = request.getParameter("begin_ym");
		String region_code = request.getParameter("region_code");
		String bank_code = request.getParameter("bank_code");
		String yingyt = request.getParameter("yingyt");
		String [] inParas = new String[2];
		String return_code5="";
	    String ret_msg="";
	    String return_page = "g053_6.jsp";
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
	    String sqlStr = "select BANK_CODE,BANK_NAME from QD_BANKCODE order by BANK_CODE";
	    String sqlStr1 = "select region_code,region_name from sregioncode where region_code<=13 order by region_code";
		
%>
<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg" retcode="return_code">
			<wtc:sql><%=sqlStr%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result" scope="end"/>	 

<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg1" retcode="return_code1">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result1" scope="end"/>	 	

<%
   String bank_options = "<option value=>--��ѡ��--</option>";
   String region_options ="<option value=>--��ѡ��--</option>";
   for(int i=0;i<return_result.length;i++)
   {
     bank_options += "<option value="+return_result[i][0]+">"+return_result[i][1]+"</option>";
   }
   
      for(int i=0;i<return_result1.length;i++)
   {
     region_options += "<option value="+return_result1[i][0]+">"+return_result1[i][1]+"</option>";
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
  
  if(document.frm.bank_code.value =="")  {
     rdShowMessageDialog("��ѡ����������!");
     document.frm.bank_code.value = "";
     document.frm.bank_code.focus();
     return false;
  }
  
  if(document.frm.region_code.value =="")  {
     rdShowMessageDialog("��ѡ���������!");
     document.frm.region_code.value = "";
     document.frm.region_code.focus();
     return false;
  }
	document.frm.submit();
	            
}

function sel1() { 		 
	window.location.href='g053.jsp';
}
function sel2(){
	window.location.href='g053_2.jsp';
} 
function sel3(){
    window.location.href='g053_3.jsp';
}
function sel4(){
    window.location.href='g053_4.jsp';
}
function sel5(){
    window.location.href='g053_5.jsp';
}
function sel6(){
    window.location.href='g053_6.jsp';
}
function sel7(){
    window.location.href='g053_7.jsp';
}
function doclear() {
 	frm.reset();
}
 
function select_yyt()
{
	var bank_code = document.all.bank_code[document.all.bank_code.selectedIndex].value;
	var region_code = document.all.region_code[document.all.region_code.selectedIndex].value;
	var myPacket = new AJAXPacket("g053_select.jsp","���ڻ��Ӫҵ����Ϣ�����Ժ�......");
	var sqlStr = "select GROUP_ID,GROUP_NAME from QD_DLOGINMSG where region_code=:region_code and bank_code=:bank_code";
	var param1 = "region_code="+region_code+",bank_code="+bank_code;
	myPacket.data.add("sqlStr",sqlStr);
	myPacket.data.add("param1",param1);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}
function doProcess(packet)
{	 
    var triListdata = packet.data.findValueByName("tri_list");     
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

 </script> 
 
<title>������BOSS-��Ʊ��Ϣ��ѯ��¼��</title>
</head>
<BODY>
<form action="g053_6.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��Ʊͳ����Ϣ��¼��</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">��ѯ��ʽ</td>
        <td> 
          <input name="busyType2" type="radio" onClick="sel1()" value="1">������Ʊ 
          <input name="busyType2" type="radio" onClick="sel5()" value="1">Ӫҵ����Ʊ
<!--          
          <input name="busyType2" type="radio" onClick="sel2()" value="1">��Ʊʹ�������ѯ 
          <input name="busyType2" type="radio" onClick="sel3()" value="1">���ô������ 
          <input name="busyType2" type="radio" onClick="sel4()" value="1">�������ô������   
 -->               
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
        <select name="bank_code" >
          	<%=bank_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
       
    </tr>
    
    <tr>   
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <select name="region_code" onchange="select_yyt()">
          	<%=region_options%>                   
          </select><font color="#FF0000">*</font>
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
      if(yingyt.equals("00"))
      {
        inParas[0]="SELECT invoice_code,s_invoice_number,e_invoice_number,login_no,to_char(op_time, 'YYYY-MM-DD HH24:MI:SS') FROM qd_wcityinvoice WHERE region_code=:region_code and bank_code=:bank_code AND year_month=:year_month ";
      	inParas[1]="region_code="+region_code+",bank_code="+bank_code+",year_month="+begin_ym;
      	temp="0";
      }
      else
      {
        inParas[0]="SELECT invoice_code,s_invoice_number,e_invoice_number,login_no,to_char(op_time, 'YYYY-MM-DD HH24:MI:SS') FROM qd_wgroupinvoice WHERE region_code=:region_code AND bank_code=:bank_code AND group_id=:group_id AND year_month=:year_month ";
        inParas[1]="region_code="+region_code+",bank_code="+bank_code+",group_id="+yingyt+",year_month="+begin_ym;  
        temp="1";
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
   if(return_code.equals("000000"))
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
        <td><a href="g053_6Cfm.jsp?invoeice_code=<%=tempArr[i][0]%>&s_invoice_number=<%=tempArr[i][1]%>&e_invoice_number=<%=tempArr[i][2]%>&login_no=<%=tempArr[i][3]%>&temp=<%=temp%>&region_code=<%=region_code%>&bank_code=<%=bank_code%>" onclick= "return   confirm( 'ȷ��ɾ��ѡ�еļ�¼�� '); "> ɾ��</a></td>
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

