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
    String opName = "Ƿ����ֵ˰רƱ��ֿ���";
	String s_qry_flag="2";
	String[] inParas2 = new String[2];
	
	//xl add ������ˮ��ѯ��Ϣ begin
	String s_xf="";
	String login_accept = request.getParameter("login_accept");
	inParas2[0]="select to_char(PHONE_NO),TAX_NO,TAX_NAME,TAX_ADDRESS,TAX_PHONE,TAX_KHH,TAX_CONTRACT,BEGIN_YM,END_YM,HWMC,to_char(DJ),SL,to_char(SE),to_char(JSHEJE),nvl(BZXX,'') from DINVOICE_TAX_SPLIT where login_accpet=:s_accept";
	inParas2[1]="s_accept="+login_accept;
	%>
		<wtc:service name="TlsPubSelBoss" retcode="retCode_ch" retmsg="retMsg_ch" outnum="15">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
		</wtc:service>
		<wtc:array id="ret_ch" scope="end" />
	<%
	if(ret_ch.length>0)
	{
	 
			//end of ������ˮ��ѯ
	//��ȡ��˰����Ϣ
	String tax_name = ret_ch[0][2];
	String tax_no1 = ret_ch[0][1];
	String tax_address = ret_ch[0][3];
	String tax_phone = ret_ch[0][4];
	String tax_khh = ret_ch[0][5];
	String tax_contract_no = ret_ch[0][6];
	String s_flag="0";//������ѯ�ɹ� s_flag=0
	String phone_no = ret_ch[0][0];
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String dateStr_yyyymm=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	//xl add ���Ӹ�������� ��ѯ�Ŀ�ʼʱ�� ����ʱ��
	String begin_dt=ret_ch[0][7];
	String end_dt=ret_ch[0][8];
	String s_hwmc=ret_ch[0][9];
	String s_dj=ret_ch[0][10];
	String s_sl=ret_ch[0][11];
	String s_se=ret_ch[0][12];
	String s_jshjje=ret_ch[0][13];
	String s_notes = ret_ch[0][14];
 
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa dateStr_yyyymm is "+dateStr_yyyymm);
%>
<html>
<FORM method=post name="frm1508_2">

		<HEAD><TITLE>��ֵ˰��Ʊ��ӡ</TITLE>
	
			<script language="javascript">
				function docheck()
				{
					//xl add for zg23 ����ǰ�ȶ��Ƿ��Ѿ���Ʊ��������У��
					var phone_no = "<%=phone_no%>";
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
				 
					if(q_value=="1") 
					{ 
						 
						begin_dt = document.frm1508_2.begindate.value;
						end_dt = document.frm1508_2.enddate.value;
						//alert("Ӫ���� begin_dt is "+begin_dt+" and end_dt is "+end_dt);
						
					} 
					else 
					{ 
						begin_dt = document.frm1508_2.yj_date.value;
						end_dt = document.frm1508_2.yj_date.value;
						//alert("�½��� begin_dt is "+begin_dt+" and end_dt is "+end_dt);
					} 
					var pactket1 = new AJAXPacket("../zg12/zg12_sp.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
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
					//alert("s_flag is "+s_flag+" and s_count is "+s_count);
					if(s_flag=="1")
					{
						rdShowMessageDialog("�ж�רƱ���������¼����!");
						history.go(-1);
					}
					else
					{
						if(s_flag=="0")
						{
							s_count=1;
							if(s_count<1)
							{
								rdShowMessageDialog("��Ʊδ������������,������zg23���𿪾�����!",0);
								history.go(-1);
							}
							else
							{
								var q_flag = document.getElementsByName("busyType1");
								//alert(q_flag);
								var q_value;
								for(var i=0;i<q_flag.length;i++)
								{ 
									if(q_flag[i].checked)
									{
										q_value = q_flag[i].value;
									}
								}
							 
								if(q_value=="1") 
								{ 
									//alert("Ӫ����"); 
									document.frm1508_2.action="zg12_yx.jsp";
									document.frm1508_2.submit();
								} 
								else if(q_value=="2"||q_value=="3") 
								{ 
									//alert("�½���"); 
									document.frm1508_2.action="../zg12/zg12_yj_cf.jsp?q_value=4";
									//alert("�½��� is "+document.frm1508_2.action); 
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
					document.getElementById("s_flag_qry").value="2";
					document.all.yxl_begin.style.display="none";
					document.all.yxl_end.style.display="none";
					document.all.yjl.style.display="block";

					
					//xl ȥ��20140701����
					/*
						rdShowMessageDialog("�½���רƱ�Ĵ�ӡʱ��Ϊ20140701��!");
						sel1();
					*/

				}
				function sel3()
				{
					//alert("2");
					document.getElementById("s_flag_qry").value="3";
					document.all.yxl_begin.style.display="none";
					document.all.yxl_end.style.display="none";
					document.all.yjl.style.display="block";

					
					//xl ȥ��20140701����
					/*
						rdShowMessageDialog("�½���רƱ�Ĵ�ӡʱ��Ϊ20140701��!");
						sel1();
					*/

				}
				//���� ��s_qry_flag=1ʱΪӪ���� �½�ĵ�ѡ�򲻿���
				function inits(s_qry_flag)
				{
					//alert("test s_qry_flag is "+s_qry_flag);
					if(s_qry_flag=="1")
					{
						//alert("begin 1");
						sel1();
						document.getElementById("radio1").checked=true;
						document.getElementById("radio2").disabled=true;
						document.getElementById("radio3").disabled=true;
						//alert("end 1");
					}
					else if(s_qry_flag=="2")
					{
						//alert("begin 2");
						sel2();
						document.getElementById("radio2").checked=true;
						document.getElementById("radio1").disabled=true;
						document.getElementById("radio3").disabled=true;
						//alert("end 2");
					}
					else
					{
						//alert("begin 3");
						sel3();
						//alert("??");
						document.getElementById("radio2").disabled=true;
						document.getElementById("radio1").disabled=true;
						document.getElementById("radio3").checked=true;
						//alert("end 2");
					}

				}
		</script>
		
		</HEAD>



		<body onload="inits(<%=s_qry_flag%>)">


		 
		 

		
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">��ѡ���ӡ��ʽ</div>
		</div>

			  <table cellspacing="0">
					<tbody>
						<tr>
							<td class="blue" width="15%">��ӡ��ʽ</td>
							<td colspan="3">
								<q vType="setNg35Attr">
								<input name="busyType1" id="radio1" type="radio" onClick="sel1()" value="1">
								Ӫ����������ֵ˰רƱ��ӡ
								</q>
								<q vType="setNg35Attr">
								<input name="busyType1" id="radio2" type="radio" onClick="sel2()" value="2" >
								�½���ֵ˰רƱ��ӡ
								</q>
								<q vType="setNg35Attr">
								<input name="busyType1" id="radio3" type="radio" onClick="sel3()" value="3" >
								һ��֧����ֵ˰רƱ��ӡ
								</q> 
							</td>
						</tr>
						<tr>
							<td class="blue" width="15%">�ֻ�����</td>
							<td colspan="3">
							<!--<input type="text" name="phone_no"   maxlength=11 value="20210058797">-->
								<input type="text" name="phone_no" readonly   maxlength=11 value="<%=phone_no%>">
								
								</q>
								 
							</td>
						</tr>
						 
							<tr id="yxl_begin">
								<td class="blue" width="15%" >��ѯ��ʼʱ��(YYYYMMDD)</td>
								<td colspan="3">
									<input type="text" name="begindate" readonly maxlength=8 value="<%=begin_dt%>">
									</q>
								</td>
							</tr>
							<tr id="yxl_end">
								<td class="blue" width="15%">��ѯ����ʱ��(YYYYMMDD)</td>
								<td colspan="3">
									<input type="text" name="enddate" readonly maxlength=8 value="<%=end_dt%>">
									</q>
									 
								</td>
							</tr>
					 
						 
							<tr id="yjl">
								<td class="blue" width="15%">�½ᷢƱ��ӡ��ʼ����(YYYYMM)</td>
								<td >
									<input type="text" name="yj_date" readonly maxlength=6 value="<%=begin_dt%>" >
									</q>
								</td>
								<td class="blue" width="15%">�½ᷢƱ��ӡ��������(YYYYMM)</td>
								<td >
									<input type="text" name="yj_end_date" readonly maxlength=6 value="<%=end_dt%>" >
									</q>
								</td>
							</tr>
						<input type="hidden" name="s_xf" value="<%=s_xf%>">	
					 
					</tbody>
				</table>
<input type="hidden" name="cfls" value="<%=login_accept%>">
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
								<input type="text" name="tax_no1"    value="<%=tax_no1%>">
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
								 <input type="hidden" name="s_notes" value="<%=s_notes%>">
							</td>
						</tr>
						<!--���ӱ�ע��Ϣչʾ-->
						<tr>
							<td class="blue" width="15%">��ע��Ϣ</td>
							<td colspan=3>
								<input type="text" name="s_notes"    value="<%=s_notes%>">
								</q>
								 
							</td>
						</tr>
					</tbody>
				</table>

				<table cellSpacing="0">
					<tr> 
					  <td id="footer"> 
					
					  <input type="button" id="query_id" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >  <!--
						  &nbsp;
						  -<input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >-->
							<input type="button" name="return1" class="b_foot" value="����" onclick="history.go(-1)" >
						  &nbsp;
							  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
					 
					  </td>
					</tr>
				  </table>
			  <tr id="footer"> 
				   
				  </tr>
			
				
		<input type="hidden" id="s_flag_qry" value="<%=s_qry_flag%>">	<!--�ж��ǰ����½�2����Ӫ��1-->		
				

		<%@ include file="/npage/include/footer.jsp" %>
		</form>
		</BODY>
	</HTML>

</FORM>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("��ˮ��¼������!");
				window.location.href="zgb8_1.jsp";
			</script>
		<%
	}
	%>
