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
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<HTML>
<HEAD>
<title>��Ʊ��Ϣ��ѯ</title>



</HEAD>
<%
		String opCode = "9493";
		String opName = "��Ʊ��Ϣ��ѯ";
			
		String InvoiceNumber = request.getParameter("InvoiceNumber");
		String InvoiceCode =  request.getParameter("InvoiceCode");
		String print_time = request.getParameter("year_name");
		//System.out.println("111111111111111print_time is "+print_time);
		String bill_type = "2";
		String c_month ="";
		String sqlStr = "";
		int  i_month = 1;
		String[][] result = new String[][]{};
		%>
<BODY>
<FORM action="" method="post" name="frm">
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">��Ʊ��Ϣ</div>
		</div>
	<table cellspacing="0">		

		
		<%
		for(int i = 0;i < 12;i++)
		{
			if(i<9)
			{
				c_month = "0"+i_month;	//�Ƿ���ȷ�� �����ӡһ��~~
				//System.out.println("\ntest for c_month is  \n"+c_month);
				i_month ++;
			}
			else
			{
				c_month = String.valueOf(i_month);
				//System.out.println("\ntest for c_month is  \n"+c_month);
				i_month ++;
			}
			sqlStr = "select print_content from Dservorderprtcntt"+print_time+c_month+" where serv_order_id = (select serv_order_id from wServInvoice where Invoice_number = '"+InvoiceNumber+"' and Invoice_code = '"+InvoiceCode+"') and bill_type = '"+bill_type+"' order by col_num asc";
			
%>
		<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<%
			System.out.println("123123==============="+sqlStr);
		%>
		<wtc:array id="retList" scope="end" />
<%
		
		result = retList;
        if(retList.length != 0){%>
	
		<tr>
       	  <td class="blue" width="15%">�ɷ����ڣ�<%//=date.substring(0,4)%>��<%//=date.substring(4,6)%>��</td>
			   <%
			   		String date = result[1][0];
			   %>
			    <td class="blue" width="15%">���ţ�<%=result[0][0]%></td>
			 </tr>
       <tr>
          <td class="blue" width="15%">�ɷѺ��룺<%=result[2][0]%></td>
			    <td class="blue" width="15%"><%=result[4][0]%></td>
       </tr>
       <tr>
          <td class="blue" width="15%">�ɷѽ��(��д)��<%=result[5][0]%></td>
          <%if(retList.length>12){%>
          <td class="blue" width="15%">�ɷѽ��(Сд)��: <%=result[6][0]%></td>
			  
		<%
			   }	else{
				%>
          <td class="blue" width="15%">�ɷѽ��(Сд)��: <%=result[6][0]%></td>
			  
				<%
			}   
	   %>		
          
			   
       </tr>
    
       <tr>
       
       <%if(retList.length>12){%>
           <td class="blue" width="15%"><%=result[7][0]%></td>
			     <td class="blue" width="15%"><%=result[8][0]%></td>
			  
		<%
			   }	else{
				%>
           
			  
				<%
			}   
	   %>		
       
          
       </tr>
       <tr>
        <%if(retList.length>12){%>
           <td class="blue" width="15%">��Ʊ����:<%=result[24][0]%></td>
			     <td class="blue" width="15%">��Ʊ����:<%=result[23][0]%></td>
			  
		<%
			   }	else{
				%>
           <td class="blue" width="15%">��Ʊ����:<%=result[8][0]%></td>
			     <td class="blue" width="15%">��Ʊ����:<%=result[7][0]%></td>
			  
				<%
			}   
	   %>		
       
         
       </tr>
 
    
      <%}else{	%>
       
        
      
      <%}%>
	<%	}

		%>
</table>
  

<%@ include file="/npage/include/footer.jsp" %>
<script language="JavaScript">
	function check(){
		var check_key = document.frm.check_key.value;
		var InvoiceNumber = <%=InvoiceNumber%>;
		var InvoiceCode = <%=InvoiceCode%>;
		var print_time = <%=print_time%>;
		
		var h=340;
    var w=425;
   	var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

		var returnValue = window.showModalDialog('s9493_2.jsp?phoneNo='+phoneNo+'&login_accept='+login_accept+"&print_time="+print_time+"&check_key="+check_key,"",prop);
	}
</script>
</FORM>
</BODY>
</HTML>
