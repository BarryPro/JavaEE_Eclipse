<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String opCode = "zg01";
    String opName = "һ��֧������ͳ���ֹ�����";
	String contract_no=request.getParameter("contract_no");

	String contract_money = request.getParameter("contract_money");

	String now_day = request.getParameter("now_day");

	//��ҳ
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 10;
	String s_PageNumber="" + iPageNumber;
	String s_PageSize = "" + iPageSize;

	String s_show_flag = request.getParameter("s_show_flag");
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA s_show_flag is "+s_show_flag);
 
%>

<script language="javascript">
	
	function doCfm1()
	{
	    var dconmsg_prepay = document.frm1508_2.act_money.value;//dconmsg��Ԥ��
		var all_money = document.frm1508_2.all_money.value;
		//alert("dconmsg_prepay is "+dconmsg_prepay+" and all_money is "+all_money);
		
		//alert("111 "+document.all.action);
		var now_day = "<%=now_day%>";
	//	now_day="1"; �ֶ��ĵ�ǰ��
 		
		// xl add begin
		 var value="";
		 var regionCheck = document.all.sel_check;
	 
		 //alert("regionCheck.length is "+regionCheck.length);
		 if(regionCheck.length==undefined)
		 {
			// alert("q");
			 regionCheck.length=1;
			 var s_chekck_value = document.getElementById("check_id0").value; 
			 
			 if (document.getElementById("check_id0").checked == true)
			 {
				// alert("ѡ��");
				 for (var i=0;i<regionCheck.length;i++ ){
				 if(document.getElementById("check_id0").checked){ //�жϸ�ѡ���Ƿ�ѡ��
				   value=value+"\'"+document.getElementById("check_id0").value+"\'"+","; //ֵ��ƴ�� .. ���崦�������Ҫ,
				   }
				 }
				// alert("regionCheck.length is "+regionCheck.length);//�����ѡ�е���Щ��ѡ���ֵ
				 if(value=="" && value.length==0 )
				 {
					 rdShowMessageDialog("������ѡ��һ���ʺŽ��а���!");
					 return false;
				 }

				var  contract_Nos_Arrays=[];
				
				var  contract_moneys_Arrays=[];
				var  sum_contract_moneys="";
				var  sum_contract_moneys_all="";

				var len = document.all.sel_check.length;
				//alert(len);
				for (i = 0; i < len; i++) 
				{
					if (document.getElementById("check_id"+i).checked == true) 
					{
						var contract_Nos = document.getElementById("check_id"+i).value;
						//alert(contract_Nos);
						contract_Nos_Arrays.push(contract_Nos);
						//ȡ����
						var contract_moneys = document.getElementById("money_id"+i).value;
						//contract_moneys_Arrays.push(contract_moneys);
						sum_contract_moneys += parseFloat(contract_moneys) ;
						sum_contract_moneys=parseFloat(sum_contract_moneys);
					}			
				}
				


				// xl add end

				//alert("sum_contract_moneys is "+sum_contract_moneys+" and contract_moneys is "+contract_moneys);
				if(parseFloat(dconmsg_prepay)< parseFloat(sum_contract_moneys))
				{
					var minus_money = parseFloat(sum_contract_moneys)-parseFloat(dconmsg_prepay);
					minus_money=parseFloat(minus_money);
					rdShowMessageDialog("�˻�Ԥ����Ϊ"+dconmsg_prepay+"Ԫ,����ֵ���Ϊ"+sum_contract_moneys+"Ԫ,Ԥ�治��,������Ϊ"+minus_money+"Ԫ!");
					return false;
				}
				else if(now_day<=5)
				{
					rdShowMessageDialog("ÿ��5�ź�ſ��԰�����!");
					return false;
				}
				else
				{
					var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ����������?");
					if (prtFlag==1)
					{
						//contract_Nos_Arrays
						//document.frm1508_2.action="zg01_4.jsp?contract_no="+contract_Nos_Arrays+"&pay_money="+"<%=contract_money%>";
						document.frm1508_2.action="zg01_4.jsp?contract_no="+"<%=contract_no%>"+"&pay_money="+sum_contract_moneys+"&contract_Nos_Arrays="+contract_Nos_Arrays;
						document.frm1508_2.submit();
					}
					else
					{
						return false;
					}
					
				}
			 }
			 else
			 {
				 rdShowMessageDialog("������ѡ��һ���ʺŽ��а���!");
				 return false;
			 } 	
			 
		 }
		 else if(regionCheck.length==1)
		 {
			// alert("һ����");
			 var s_chekck_value = document.getElementById("check_id0").value; 
			 
			 if (document.getElementById("check_id0").checked == true)
			 {
				// alert("ѡ��");
				 for (var i=0;i<regionCheck.length;i++ ){
				 if(document.getElementById("check_id0").checked){ //�жϸ�ѡ���Ƿ�ѡ��
				   value=value+"\'"+document.getElementById("check_id0").value+"\'"+","; //ֵ��ƴ�� .. ���崦�������Ҫ,
				   }
				 }
				// alert("regionCheck.length is "+regionCheck.length);//�����ѡ�е���Щ��ѡ���ֵ
				 if(value=="" && value.length==0 )
				 {
					 rdShowMessageDialog("������ѡ��һ���ʺŽ��а���!");
					 return false;
				 }

				var  contract_Nos_Arrays=[];
				
				var  contract_moneys_Arrays=[];
				var  sum_contract_moneys="";
				var  sum_contract_moneys_all="";

				var len = document.all.sel_check.length;
				//alert(len);
				for (i = 0; i < len; i++) 
				{
					if (document.getElementById("check_id0").checked == true) 
					{
						var contract_Nos = document.getElementById("check_id"+i).value;
						//alert(contract_Nos);
						contract_Nos_Arrays.push(contract_Nos);
						//ȡ����
						var contract_moneys = document.getElementById("money_id"+i).value;
						//contract_moneys_Arrays.push(contract_moneys);
						sum_contract_moneys += parseFloat(contract_moneys) ;
						sum_contract_moneys=parseFloat(sum_contract_moneys);
					}			
				}
				


				// xl add end

				//alert("sum_contract_moneys is "+sum_contract_moneys+" and contract_moneys is "+contract_moneys);
				if(parseFloat(dconmsg_prepay)< parseFloat(sum_contract_moneys))
				{
					var minus_money = parseFloat(sum_contract_moneys)-parseFloat(dconmsg_prepay);
					minus_money=parseFloat(minus_money);
					rdShowMessageDialog("�˻�Ԥ����Ϊ"+dconmsg_prepay+"Ԫ,����ֵ���Ϊ"+sum_contract_moneys+"Ԫ,Ԥ�治��,������Ϊ"+minus_money+"Ԫ!");
					return false;
				}
				else if(now_day<=5)
				{
					rdShowMessageDialog("ÿ��5�ź�ſ��԰�����!");
					return false;
				}
				else
				{
					var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ����������?");
					if (prtFlag==1)
					{
						//contract_Nos_Arrays
						//document.frm1508_2.action="zg01_4.jsp?contract_no="+contract_Nos_Arrays+"&pay_money="+"<%=contract_money%>";
						document.frm1508_2.action="zg01_4.jsp?contract_no="+"<%=contract_no%>"+"&pay_money="+sum_contract_moneys+"&contract_Nos_Arrays="+contract_Nos_Arrays;
						document.frm1508_2.submit();
					}
					else
					{
						return false;
					}
					
				}
			 }
			 else
			 {
				 rdShowMessageDialog("������ѡ��һ���ʺŽ��а���!");
				 return false;
			 } 

		 }	
		 else
		 {
			// alert("here?");
			 for (var i=0;i<regionCheck.length;i++ ){
			 if(regionCheck[i].checked){ //�жϸ�ѡ���Ƿ�ѡ��
			   value=value+"\'"+regionCheck[i].value+"\'"+","; //ֵ��ƴ�� .. ���崦�������Ҫ,
			   }
			 }
			// alert("regionCheck.length is "+regionCheck.length);//�����ѡ�е���Щ��ѡ���ֵ
			 if(value=="" && value.length==0 )
			 {
				 rdShowMessageDialog("������ѡ��һ���ʺŽ��а���!");
				 return false;
			 }

			var  contract_Nos_Arrays=[];
			
			var  contract_moneys_Arrays=[];
			var  sum_contract_moneys="";
			var  sum_contract_moneys_all="";

			var len = document.all.sel_check.length;
			//alert(len);
			for (i = 0; i < len; i++) 
			{
				if (document.all.sel_check[i].checked == true) 
				{
					var contract_Nos = document.getElementById("check_id"+i).value;
					//alert(contract_Nos);
					contract_Nos_Arrays.push(contract_Nos);
					//ȡ����
					var contract_moneys = document.getElementById("money_id"+i).value;
					//contract_moneys_Arrays.push(contract_moneys);
					sum_contract_moneys += parseFloat(contract_moneys) ;
					sum_contract_moneys=parseFloat(sum_contract_moneys);
				}			
			}
			


			// xl add end

			//alert("sum_contract_moneys is "+sum_contract_moneys+" and contract_moneys is "+contract_moneys);
			if(parseFloat(dconmsg_prepay)< parseFloat(sum_contract_moneys))
			{
				var minus_money = parseFloat(sum_contract_moneys)-parseFloat(dconmsg_prepay);
				minus_money=parseFloat(minus_money);
				rdShowMessageDialog("�˻�Ԥ����Ϊ"+dconmsg_prepay+"Ԫ,����ֵ���Ϊ"+sum_contract_moneys+"Ԫ,Ԥ�治��,������Ϊ"+minus_money+"Ԫ!");
				return false;
			}
			else if(now_day<=5)
			{
				rdShowMessageDialog("ÿ��5�ź�ſ��԰�����!");
				return false;
			}
			else
			{
				var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ����������?");
				if (prtFlag==1)
				{
					//contract_Nos_Arrays
					//document.frm1508_2.action="zg01_4.jsp?contract_no="+contract_Nos_Arrays+"&pay_money="+"<%=contract_money%>";
					document.frm1508_2.action="zg01_4.jsp?contract_no="+"<%=contract_no%>"+"&pay_money="+sum_contract_moneys+"&contract_Nos_Arrays="+contract_Nos_Arrays;
					document.frm1508_2.submit();
				}
				else
				{
					return false;
				}
				
			}
		 }
		 	
		 
		
	}

	function docheck(select_contract_money)
	{
		//alert("select_contract is "+select_contract); contract_moneys_Arrays
		
		
		document.getElementById("check_not_id").checked=false;
		document.getElementById("check_all_id").checked=false;

	}
	//ȫѡ
	function doSelectAllNodes()
	{
		//document.all.sure.disabled=false;
		if(document.getElementById("check_all_id").checked)
		{
			document.getElementById("check_not_id").checked=false;
			var regionChecks = document.getElementsByName("sel_check");
			for(var i=0;i<regionChecks.length;i++){
				regionChecks[i].checked=true;
			}
		}
		
		 
	}
	function doCancelChooseAll()
	{
		if(document.getElementById("check_not_id").checked)
		{
			document.getElementById("check_all_id").checked=false;
			var regionChecks = document.getElementsByName("sel_check");
			for(var i=0;i<regionChecks.length;i++){
				regionChecks[i].checked=false;
			}
		}	
	}
	function gotos(page,contract_no)
	{
		document.getElementById("toPage").disabled=true;
		window.location.href="zg01_3.jsp?pageNumber="+page+"&contract_no="+contract_no; 
	}
</script>

<wtc:service name="bs_zg01Init" retcode="retCode1" retmsg="retMsg1" outnum="8">
		<wtc:param value="<%=contract_no%>"/>
		<wtc:param value="<%=s_PageNumber%>"/>
		<wtc:param value="<%=s_PageSize%>"/>
</wtc:service>
<wtc:array id="ret_val1" scope="end" start="0"  length="2" />	
<wtc:array id="ret_val2" scope="end" start="2"  length="4" />
<wtc:array id="ret_val3" scope="end" start="6"  length="2" />
<%
	String return_code="";
	String return_msg="";

	return_code=retCode1;
	return_msg=retMsg1;
	System.out.println("zg01_03չʾ ccccccccccccccccccccccccccc"+ret_val2.length);
	if(!return_code.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("��ѯ����!�������"+"<%=return_code%>������ԭ��"+"<%=return_msg%>");
				window.location.href="zg01_1.jsp";
			</script>
		<%
	}
	else
	{
		int nowPage = 1;
		int allPage = 0;
		allPage = (Integer.parseInt(ret_val3[0][1])- 1) / 10 + 1 ;//ҳ���� ����ҲҪ��
		%>
		<html xmlns="http://www.w3.org/1999/xhtml">
			<HEAD><TITLE>һ��֧������ͳ���ֹ�����</TITLE>
				
			</HEAD>
			<body>
			

			<FORM method=post name="frm1508_2">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">��ѯ���</div>
			</div>

				  <table cellspacing="0" id = "PrintA">
				<input type="hidden" name="act_money" value="<%=contract_money%>">			
							
						<tr> 
						  <th>ѡ��</th>
						  <th>��֧���ʺ�</th>
						  <th>Ӧ�������</th>
						  <%
							if(s_show_flag.equals("1"))
							{
							%>
								<th>�ֻ�����</th>
								<th>����</th>
							<%
							}
							if(s_show_flag.equals("A"))
							{
							%>
								<th>�������</th>
								<th>��Ʒ����</th>
							<%
							}
						  %>
						  
						</tr>
					<%
						System.out.println("test ret_val2.length is "+ret_val2.length);
						for(int i=0;i<ret_val2.length;i++)
						{
							%>
								<tr>
									<td><input type="checkbox" name="sel_check" id="check_id<%=i%>"  value="<%=ret_val2[i][0]%>" onclick="docheck('<%=ret_val2[i][1]%>')"></td>
									<td><%=ret_val2[i][0]%></td>
									<td><%=ret_val2[i][1]%></td>
									<td><%=ret_val2[i][2]%></td>
									<td><%=ret_val2[i][3]%></td>
									<input type="hidden" name="money_name" id="money_id<%=i%>" value="<%=ret_val2[i][1]%>">
								</tr>
								
							<%
						}
				    %>
					 <input type="hidden" name="all_money" value="<%=ret_val3[0][0]%>">
					 <input type="hidden" name="all_count" value="<%=ret_val3[0][1]%>">
					<tr>
						<td colspan="3">
							<input type="checkbox" id="check_all_id" onclick="doSelectAllNodes()">ȫѡ &nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="check_not_id" onclick="doCancelChooseAll()">ȡ��ȫѡ 
						</td>
					</tr> 
					  <tr id="footer"> 
						<td colspan="9">
						 
					 
						  <input class="b_foot" name=doCfm onClick="doCfm1()" type=button value= "��������"> 
				 
						  <input class="b_foot" name=back onClick="window.location.href='zg01_1.jsp'" type=button value=����>
						</td>
					  </tr>
					  
				  </table>

				  <!--��ҳ ����ҳ�� >��ǰҳ�� ��1ʱ ��չʾ��ҳ��--> 
				  
				  <%
					if(allPage>iPageNumber || (allPage==iPageNumber && allPage>1) )
					{
					  %>  
						<div align="center">
							<table align="center">
							<tr>
								<td align="center">
									�ܼ�¼����<font name="totalPertain" id="totalPertain"><%=ret_val3[0][1]%></font>&nbsp;&nbsp;
									��ҳ����<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
									��ǰҳ��<font name="currentPage" id="currentPage"><%=s_PageNumber%></font>&nbsp;&nbsp;
									ÿҳ������10
								 
									&nbsp;&nbsp;��ת��
									<select name="toPage" id="toPage" style="width:80px" onchange="gotos(this.value,'<%=contract_no%>');">
										<%
										 
										for (int i = 1; i <= allPage; i ++){
											
											if(iPageNumber==i){
												//System.out.println("aaaaaaaaaaaaaaaaaaaa "+i);
												%>
												<option value="<%=i%>" selected >
													��<%=i%>ҳ
												</option>	
												<%
											}else{
												
												%>
													<option value="<%=i%>">��<%=i%>ҳ</option>
												<%
												}
										%>
										
									
									<%}%>
									</select>
									<input type="hidden" id="nowPage" />
									<input type="hidden" id="allPage" value="<%= allPage %>" />
									ҳ
								</td>
							</tr>
							</table>
						</div>
					  <%
					}
				  %>
					
				 
					<!--end ��ҳ-->
				  <tr id="footer"> 
					   
					  </tr>
				
					
			<input type="hidden" id="id_contractNo">			
					

			<%@ include file="/npage/include/footer.jsp" %>
			</FORM>
			</BODY>
		</HTML>

		<%
	}
%>


