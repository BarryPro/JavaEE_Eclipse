 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-22 页面改造,修改样式
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String opCode = "5283";	
		String opName = "批量打印发票";	//header.jsp需要的参数   
		 String regionCode = (String)session.getAttribute("regCode"); 
		 
		String workno=(String)session.getAttribute("workNo");    //工号 
        	String workname =(String)session.getAttribute("workName");//工号名称  	        
       			
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
			      rdShowMessageDialog("代理商号码输入错误，请重新输入！")
			      //document.mainForm.contract_no.focus();
			      return false;
			   }
			
			   if (document.mainForm.cust_phone.value.length != 0 && document.mainForm.cust_phone.value.length != 11) {
			      rdShowMessageDialog("客户号码输入错误，请重新输入！")
			      document.mainForm.contract_no.focus();
			      return false;
			   }
			
			   if (document.mainForm.begin_date.value.length !=8) {
			      rdShowMessageDialog("开始时间输入错误，请重新输入！")
			      document.mainForm.year_month_end.focus();
			      return false;
			   }
			
			   if (document.mainForm.end_date.value.length !=8) {
			      rdShowMessageDialog("结束时间输入错误，请重新输入！")
			      document.mainForm.year_month_end.focus();
			      return false;
			   }
			
			   if (document.mainForm.begin_date.value.substr(0,6) != document.mainForm.end_date.value.substr(0,6)) {
			      rdShowMessageDialog("发票打印不能跨自然月，请重新输入！")
			      document.mainForm.year_month_end.focus();
			      return false;
			   }
			
			   if (document.mainForm.print_ym.value.length != 6) {
			      rdShowMessageDialog("打印月份输入错误，请重新输入！")
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
		<title>空中充值批量打印发票</title>
	</head>
	<BODY>
		<FORM action="" method="post" name="mainForm">
			<input type="hidden" name="sel_type"  value="">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">批量打印发票</div>
			</div> 
		        <table  cellspacing="0">
		       		<tbody>
		          		<tr>
						<td class="blue">打印条件</td>
						<td colspan="3">
							<select name=print_type onChange="printtypechange()">
								<option value="1" selected>按月打印</option>
								<option  value="2">按日期打印</option>
							</select>
						</td>							
					</tr>
					<tr>
		                  		<td class="blue">代理商号码</td>
				                <td>
				                    	<input type="text"   value="" name="agt_phone" size="20" maxlength="11" v_must=1 onblur="checkElement(this)">
						     	<font class="orange">*</font>
				                </td>
				                <td class="blue" nowrap>客户号码</td>
				                <td>
							<input type="text"   value="" name="cust_phone" size="20" maxlength="11" >
				               	</td>
					</tr>
					<tr style="display:" id="IList1">
		                  		<td class="blue">打印月份</td>
				                <td colspan="3">
				                    	<input type="text"   value="<%=dateStr1%>" name="print_ym" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)" onblur="checkElement(this)" v_format="YYYYMM" v_must=1 onblur="checkElement(this)">
						    	<font class="orange">*YYYYMM</font>		
				                </td>
		                	</tr>
					<tr style="display:none" id="IList2">
				                  <td class="blue">开始日期</td>
				                  <td>
				                    	<input type="text"   v_format="YYYYMMDD"  value="<%=dateStr1+"01"%>" name="begin_date" size="20" maxlength="8" onKeyPress="return isKeyNumberdot(0)">
							<font class="orange">*YYYYMMDD</font>		
				                  </td>
				                  <td class="blue" nowrap>结束日期</td>
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
							<font color="#FF0000"> 注意：<br>	                  
				                
							   &nbsp;&nbsp;&nbsp; “有选择打印”是指按照指定条件，营业员可以选择打印或不打印某一缴费发票；（一次可打印70笔缴费发票）<br>
			               
						     	    &nbsp;&nbsp;&nbsp;&nbsp;“全部打印”是指按照指定条件，打印所有打印次数为0的缴费发票。（一次可打印符合条件的所有缴费发票）<br>
		                  	
		                  	 &nbsp;&nbsp;&nbsp;&nbsp;请准备并录入足够并且连续的发票号码。</font>	
		                  		</td>
		 			</tr>			             
		           	</tbody>
		 	</table>
		        <TABLE  cellSpacing="0">
		        	<tbody>
				          <TR>
					            <TD id="footer">					              
					                	<input type="button" name="query1"  class="b_foot" value="有选择打印" onclick="docheck1()"  >
					                	&nbsp;
					               	 	<input type="button" name="query2"  class="b_foot" value="全部打印" onclick="docheck2()"  >
					               	 	&nbsp;
					                	<input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
					                	&nbsp;
					                	<input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()"  >					             
					            </TD>
				          </TR>
			          </tbody>
		        </TABLE>
     			<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
        