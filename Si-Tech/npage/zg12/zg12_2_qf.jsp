<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %> 
 
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String opCode = "zgb8";
    String opName = "Ƿ����ֵ˰��Ʊ��ӡ";
	String s_flag=request.getParameter("s_flag");
	String phone_no = request.getParameter("phone_no");
	String[] inParas2 = new String[2];
	
	//��ȡ��˰����Ϣ
	String tax_name = request.getParameter("tax_name");
	String tax_no1 = request.getParameter("tax_no1");
	String tax_address = request.getParameter("tax_address");
	String tax_phone = request.getParameter("tax_phone");
	String tax_khh = request.getParameter("tax_khh");
	String tax_contract_no = request.getParameter("tax_contract_no");
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String dateStr_yyyymm=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa dateStr_yyyymm is "+dateStr_yyyymm);
%>
<html>
<FORM method=post name="frm1508_2">

		<HEAD><TITLE>��ֵ˰��Ʊ��ӡ</TITLE>
	
			<script language="javascript">
				function docheck()
				{
					//xl add for zg23 ����ǰ�ȶ��Ƿ��Ѿ���Ʊ��������У��
					var phone_no = document.all.phone_no.value;//"<%=phone_no%>";
					var tax_id = "<%=tax_no1%>";
					//xl add ���ݵ�ѡ��ȡֵ
					var q_flag = document.getElementsByName("busyType1");
					var q_value;
					var begin_dt ;
					var end_dt;
					for(var i=0;i<q_flag.length;i++)
					{ 
						if(q_flag[i].checked)
						{
							q_value = q_flag[i].value;
						}
					}
					//alert("q_value is "+q_value+" and begin_dt is "+begin_dt+" and end_dt is "+end_dt);
					if(q_value!="4") 
					{ 
						 
						begin_dt = document.frm1508_2.begindate.value;
						end_dt = document.frm1508_2.enddate.value;
						//alert("Ӫ���� begin_dt is "+begin_dt+" and end_dt is "+end_dt);
						
					} 
					else 
					{ 
						begin_dt = document.frm1508_2.yj_date.value;
						end_dt = document.frm1508_2.yj_end_date.value;
						//alert("�½��� begin_dt is "+begin_dt+" and end_dt is "+end_dt);
					} 
					var pactket1 = new AJAXPacket("zg12_sp.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
					pactket1.data.add("phone_no",phone_no);
					pactket1.data.add("tax_id",tax_id);
					pactket1.data.add("begin_dt",begin_dt);
					pactket1.data.add("end_dt",end_dt);
					core.ajax.sendPacket(pactket1);
					pactket1=null;
					//end of zg23 
					/*
					
					*/
					
				}
				function doProcess(packet)
				{
					var s_flag = packet.data.findValueByName("s_flag");
					var s_count = packet.data.findValueByName("s_count");
				//	alert("s_flag is "+s_flag+" and s_count is "+s_count);
					//s_count="1";
					if(s_flag=="1")
					{
						rdShowMessageDialog("�ж�רƱ���������¼����!");
						history.go(-1);
					}
					else
					{
						if(s_flag=="0")
						{
							if(s_count<1)
							{
								rdShowMessageDialog("��Ʊδ������������,������zgb7���𿪾�����!",0);
								history.go(-1);
							}
							else
							{
								var q_flag = document.getElementsByName("busyType1");
								var q_value;
								for(var i=0;i<q_flag.length;i++)
								{ 
									if(q_flag[i].checked)
									{
										q_value = q_flag[i].value;
									}
								}
							 
								if(q_value=="4") 
								{ 
									//alert("�½���"); 
									document.frm1508_2.action="zg12_yj.jsp?q_value=4";
									document.frm1508_2.submit();
								} 
								else
								{
									rdShowMessageDialog("�½���רƱ�Ĵ�ӡ��ʼʱ��Ϊ20140701!");
								}
							}
							
						}
						else
						{
							rdShowMessageDialog("�ж�רƱ���������¼����1!");
							history.go(-1);
						}
					}
				 }
				function sel1()
				{
					//window.location.href='zg12_2.jsp?phone_no='+document.frm1508_2.phone_no.value;
					//alert("1");
					document.getElementById("s_flag_qry").value="1";
					document.all.yxl_begin.style.display="block";
					document.all.yxl_end.style.display="block";
					document.all.yjl.style.display="none";
				}
				function sel2()
				{
					//alert("2");
					document.getElementById("s_flag_qry").value="4";
					document.all.yxl_begin.style.display="none";
					document.all.yxl_end.style.display="none";
					document.all.yjl.style.display="block";

					
					//xl ȥ��20140701����
					/*
						rdShowMessageDialog("�½���רƱ�Ĵ�ӡʱ��Ϊ20140701��!");
						sel1();
					*/

				}
		</script>
		
		</HEAD>



		<body onload="sel2()">


		 
		 

		
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">��ѡ���ӡ��ʽ</div>
		</div>

			  <table cellspacing="0">
					<tbody>
						<tr>
							<td class="blue" width="15%">��ӡ��ʽ</td>
							<td colspan="3">
								<!--
								<q vType="setNg35Attr">
								<input name="busyType1" type="radio" onClick="sel1()" value="1" checked>
								Ӫ����������ֵ˰רƱ��ӡ
								</q>
								-->
								<q vType="setNg35Attr">
								<input name="busyType1" type="radio" onClick="sel2()" checked value="4" >
								�½���ֵ˰רƱ��ӡ
								</q>
								 
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">�ֻ�����</td>
							<td colspan="3">
								<input type="text" name="phone_no" readonly  maxlength=11 value="<%=phone_no%>">
								</q>
								 
							</td>
						</tr>
						 
							<tr id="yxl_begin">
								<td class="blue" width="15%" >��ѯ��ʼʱ��(YYYYMMDD)</td>
								<td colspan="3">
									<input type="text" name="begindate" maxlength=8 value="<%=dateStr%>">
									</q>
								</td>
							</tr>
							<tr id="yxl_end">
								<td class="blue" width="15%">��ѯ����ʱ��(YYYYMMDD)</td>
								<td colspan="3">
									<input type="text" name="enddate" maxlength=8 value="<%=dateStr%>">
									</q>
									 
								</td>
							</tr>
					 
						 
							<tr id="yjl">
								<td class="blue" width="15%">�½ᷢƱ��ӡ��ʼ����(YYYYMM)</td>
								<td >
									<input type="text" name="yj_date" maxlength=6 value="<%=dateStr_yyyymm%>">
									</q>
								</td>
								<td class="blue" width="15%">�½ᷢƱ��ӡ��������(YYYYMM)</td>
								<td >
									<input type="text" name="yj_end_date" maxlength=6 value="<%=dateStr_yyyymm%>">
									</q>
								</td>
							</tr>
							
					 
					</tbody>
				</table>

				<table cellspacing="0">
					<tbody>
						<tr>
							<td class="blue" colspan=6>������λ��Ϣչʾ</td>
							 
						</tr>
						<tr>
							<td class="blue" width="15%">��˰������</td>
							<td>
								<input type="text" name="tax_name" readonly  value="<%=tax_name%>">
								</q>
								 
							</td>
							<td class="blue" width="15%">��˰��ʶ���</td>
							<td>
								<input type="text" name="tax_no1" readonly  value="<%=tax_no1%>">
								</q>
								 
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">��ַ</td>
							<td>
								<input type="text" name="tax_address" readonly  value="<%=tax_address%>">
								</q>
								 
							</td>
							<td class="blue" width="15%">�绰</td>
							<td>
								<input type="text" name="tax_phone" readonly  value="<%=tax_phone%>">
								</q>
								 
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">������</td>
							<td>
								<input type="text" name="tax_khh" readonly  value="<%=tax_khh%>">
								</q>
								 
							</td>
							<td class="blue" width="15%">�˺�</td>
							<td>
								<input type="text" name="tax_contract_no" readonly  value="<%=tax_contract_no%>">
								</q>
								 
							</td>
						</tr>
					</tbody>
				</table>

				<table cellSpacing="0">
					<tr> 
					  <td id="footer"> 
					  <input type="button" id="query_id" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
						  &nbsp;
							<input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
						  &nbsp;
							  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
					 
					  </td>
					</tr>
				  </table>
			  <tr id="footer"> 
				   
				  </tr>
			
				
		<input type="hidden" id="s_flag_qry">	<!--�ж��ǰ����½�2����Ӫ��1-->		
				

		<%@ include file="/npage/include/footer.jsp" %>
		</form>
		</BODY>
	</HTML>

</FORM>
