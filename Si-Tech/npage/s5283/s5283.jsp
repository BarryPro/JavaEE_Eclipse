 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-22 ҳ�����,�޸���ʽ
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String opCode = "5283";	
		String opName = "������ӡ��Ʊ";	//header.jsp��Ҫ�Ĳ���   
		 String regionCode = (String)session.getAttribute("regCode"); 
		 
		String workno=(String)session.getAttribute("workNo");    //���� 
        	String workname =(String)session.getAttribute("workName");//��������  	        
       			
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1= new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>
<HTML>
	<HEAD>
		<script language="JavaScript">
			<!--
			 function printtypechange() {
				if (document.mainForm.print_type.value == 1) {
				   IList1.style.display = "";
				   IList2.style.display = "none";
				} 
				else if (document.mainForm.print_type.value == 2) {
				   IList1.style.display = "none";
				   IList2.style.display = "";
				}
			}
			
			 function docheck() {	
			   if(!checkElement(document.mainForm.agt_phone)){			   	
			   	return false;
			   }		  			   		   	  
			   if (document.mainForm.agt_phone.value.length != 11) {
			      rdShowMessageDialog("�����̺�������������������룡")
			      //document.mainForm.contract_no.focus();
			      return false;
			   }
			
			   if (document.mainForm.cust_phone.value.length != 0 && document.mainForm.cust_phone.value.length != 11) {
			      rdShowMessageDialog("�ͻ���������������������룡")
			      document.mainForm.contract_no.focus();
			      return false;
			   }
			
			   if (document.mainForm.begin_date.value.length !=8) {
			      rdShowMessageDialog("��ʼʱ������������������룡")
			      document.mainForm.year_month_end.focus();
			      return false;
			   }
			
			   if (document.mainForm.end_date.value.length !=8) {
			      rdShowMessageDialog("����ʱ������������������룡")
			      document.mainForm.year_month_end.focus();
			      return false;
			   }
			
			   if (document.mainForm.begin_date.value.substr(0,6) != document.mainForm.end_date.value.substr(0,6)) {
			      rdShowMessageDialog("��Ʊ��ӡ���ܿ���Ȼ�£����������룡")
			      document.mainForm.year_month_end.focus();
			      return false;
			   }
			
			   if (document.mainForm.print_ym.value.length != 6) {
			      rdShowMessageDialog("��ӡ�·�����������������룡")
			      document.mainForm.begin_ym.focus();
			      return false;
			   }
			 }
			function docheck1() {
				//docheck();
				if(docheck()==false) return false;
				document.mainForm.sel_type.value="1";
				document.mainForm.action="s5283show.jsp";
			    	document.mainForm.submit();
			}
			function docheck2() {
				//docheck();
				if(docheck()==false) return false;
				document.mainForm.sel_type.value="2";
				document.mainForm.action="s5283print.jsp";
			    document.mainForm.submit();
			}
			function doclear(){
				with(document.mainForm)
				     {
				        print_type.value= "1";
				       	agt_phone.value= "";
				       	cust_phone.value= "";
				      	print_ym.value= "<%=dateStr1%>";
				       	IList1.style.display = "";
				   	IList2.style.display = "none";
				     }
				}
				-->
			</script>		
		<title>���г�ֵ������ӡ��Ʊ</title>
	</head>
	<BODY>
		<FORM action="" method="post" name="mainForm">
			<input type="hidden" name="sel_type"  value="">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">������ӡ��Ʊ</div>
			</div> 
		        <table  cellspacing="0">
		       		<tbody>
		          		<tr>
						<td class="blue">��ӡ����</td>
						<td colspan="3">
							<select name=print_type onChange="printtypechange()">
								<option value="1" selected>���´�ӡ</option>
								<option  value="2">�����ڴ�ӡ</option>
							</select>
						</td>							
					</tr>
					<tr>
		                  		<td class="blue">�����̺���</td>
				                <td>
				                    	<input type="text"   value="" name="agt_phone" size="20" maxlength="11" v_must=1 onblur="checkElement(this)">
						     	<font class="orange">*</font>
				                </td>
				                <td class="blue" nowrap>�ͻ�����</td>
				                <td>
							<input type="text"   value="" name="cust_phone" size="20" maxlength="11" >
				               	</td>
					</tr>
					<tr style="display:" id="IList1">
		                  		<td class="blue">��ӡ�·�</td>
				                <td colspan="3">
				                    	<input type="text"   value="<%=dateStr1%>" name="print_ym" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)" onblur="checkElement(this)" v_format="YYYYMM" v_must=1 onblur="checkElement(this)">
						    	<font class="orange">*YYYYMM</font>		
				                </td>
		                	</tr>
					<tr style="display:none" id="IList2">
				                  <td class="blue">��ʼ����</td>
				                  <td>
				                    	<input type="text"   v_format="YYYYMMDD"  value="<%=dateStr1+"01"%>" name="begin_date" size="20" maxlength="8" onKeyPress="return isKeyNumberdot(0)">
							<font class="orange">*YYYYMMDD</font>		
				                  </td>
				                  <td class="blue" nowrap>��������</td>
				                  <td>
							<input type="text"   v_format="YYYYMMDD"  value="<%=dateStr%>" name="end_date" size="20" maxlength="8" onKeyPress="return isKeyNumberdot(0)">
							<font class="orange">*YYYYMMDD</font>	
				                  </td>
		 			</tr>
		 		</TBODY>
			</table>
		        <table cellSpacing="0">
		        	<TBODY>
			 		<tr>
				                  <td>
							<font color="#FF0000"> ע�⣺<br>	                  
				                
							   &nbsp;&nbsp;&nbsp; ����ѡ���ӡ����ָ����ָ��������ӪҵԱ����ѡ���ӡ�򲻴�ӡĳһ�ɷѷ�Ʊ����һ�οɴ�ӡ70�ʽɷѷ�Ʊ��<br>
			               
						     	    &nbsp;&nbsp;&nbsp;&nbsp;��ȫ����ӡ����ָ����ָ����������ӡ���д�ӡ����Ϊ0�Ľɷѷ�Ʊ����һ�οɴ�ӡ�������������нɷѷ�Ʊ��<br>
		                  	
		                  	 &nbsp;&nbsp;&nbsp;&nbsp;��׼����¼���㹻���������ķ�Ʊ���롣</font>	
		                  		</td>
		 			</tr>			             
		           	</tbody>
		 	</table>
		        <TABLE  cellSpacing="0">
		        	<tbody>
				          <TR>
					            <TD id="footer">					              
					                	<input type="button" name="query1"  class="b_foot" value="��ѡ���ӡ" onclick="docheck1()"  >
					                	&nbsp;
					               	 	<input type="button" name="query2"  class="b_foot" value="ȫ����ӡ" onclick="docheck2()"  >
					               	 	&nbsp;
					                	<input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
					                	&nbsp;
					                	<input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()"  >					             
					            </TD>
				          </TR>
			          </tbody>
		        </TABLE>
     			<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
        