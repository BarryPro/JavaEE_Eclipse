<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
    String opCode = "zgag";
    String opName = "Ӫ�������ͳ�ֵ����ֵ";
	String phone_no = request.getParameter("phone_no"); 
	String card_no = request.getParameter("card_no");
%>
<body onload = "inits()">
<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>   
	 
 
<script language = "javascript">
	 function inits()
	 {
		 document.all.doCfm.disabled=false;
		 document.all.doCfm2.disabled=true;
	 }
	 function checkCard2()
	 {
		var myPacket = new AJAXPacket("zgag_check.jsp","���ڲ�ѯ��ֵ����Ϣ�����Ժ�......");
		myPacket.data.add("phoneNo",document.all.phone_no.value );//�ֻ�����
		myPacket.data.add("card_no",document.all.card_no.value ); //����
		core.ajax.sendPacket(myPacket,doPosSubInfo1);
		myPacket=null;
	 }
	 function doPosSubInfo1(packet)
	 {
		//alert("123"); ���������ͽ�� ��ֵ����ֵ
		var s_flag =  packet.data.findValueByName("s_flag");
		var s_ycz =  packet.data.findValueByName("s_ycz");
		var s_mz =  packet.data.findValueByName("s_mz");
	//	alert("s_flag is "+s_flag+" and s_ycz is "+s_ycz+" and s_mz is "+s_mz);
		if(s_flag=="1")
		{
			rdShowMessageDialog("��ֵ����¼������!");
			history.go("-1");
		}
		else
		{
			document.all.doCfm2.disabled=false;
			 
			document.all.yzsje.value=s_ycz;
			document.all.czkmz.value=s_mz;
			document.all.czkmm.focus();
		}
	 }
	 function doCfmP()
	 {
		 var czkmm = document.all.czkmm.value;
		 if(czkmm=="")
		 {
			rdShowMessageDialog("�������ֵ������!");
			document.all.czkmm.focus();
			return false;
		 } 	
		 
		 //�ж� kczje ������
		 var finalNew= "";
	
		 finalNew = (document.all.kzsje.value)-(document.all.yzsje.value)-(document.all.czkmz.value);
	//	 alert("1 finalNew is "+finalNew);
		 /*
		 if(finalNew<0)
		 {
			rdShowMessageDialog("�ɳ�ֵ���������ܽ��,�������ٽ��г�ֵ!");
			history.go("-1");
		 }*/
		 var	prtFlag = rdShowConfirmDialog("��ֵ����ֵ"+document.all.czkmz.value+"Ԫ,�Ƿ�ȷ����ֵ��");
		 if (prtFlag==1)
		 {
			document.frm1508_2.action="zgag_3.jsp?phoneNo="+document.all.phone_no.value+"&kzsje="+document.all.kzsje.value+"&kmz="+document.all.czkmz.value+"&yczje="+document.all.kzsje.value+"&card_no="+document.all.card_no.value+"&km="+document.all.czkmm.value+"&o_login_accept="+document.all.o_login_accept.value;
			//alert(document.all.action);
			document.frm1508_2.submit();
		 }
		 else
		 {
			return false;
		 }
	 }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>Ӫ�������ͳ�ֵ����ֵ</TITLE>
</HEAD>

<wtc:service name="se257QryAct" routerKey="phone" routerValue="<%=phone_no%>"  retcode="errCodeNew" retmsg="errMsgNew" outnum="2">
		    <wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=card_no%>"/>
</wtc:service>
<wtc:array id="results" scope="end" />
<%
	String return_code="";
	String return_msg="";
	String s_zje="";
	String s_login_accept="";
	String[][] result1  = null ;
	result1=results;
	if(result1!=null)
	{
		return_code=errCodeNew;
		return_msg=errMsgNew;
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaffffffffffffffffffffffff return_code is  "+return_code);
		if(return_code=="000000" ||return_code.equals("000000"))
		{
			s_login_accept=results[0][0];
			s_zje=results[0][1];
			%>
			<input type="hidden" name="o_login_accept" value="<%=s_login_accept%>">
				<div class="title">
					<div id="title_zi">��ѯ���</div>
				</div>
					
					  <table cellspacing="0" >
								<tr> 
									<td class="blue" >�û��ֻ�����</td>
									<td> 
										<input type="text"  name="phone_no" value="<%=phone_no%>" readonly class="InputGrey" >
									</td>
								  
								</tr>
								<tr> 
									<td class="blue" >��ֵ������</td>
									<td> 
										<input type="text"  name="card_no" value="<%=card_no%>" readonly class="InputGrey" >
									</td>
								  
								</tr>
								<tr> 
									<td class="blue" >�����ͽ��</td>
									<td> 
										<input type="text"  name="kzsje" value="<%=s_zje%>"  readonly class="InputGrey" >
									</td>
								  
								</tr>
								<tr> 
									<td class="blue" >�����ͽ��</td>
									<td> 
										<input type="text"  name="yzsje"   readonly class="InputGrey" >
									</td>
								  
								</tr>
								<tr> 
									<td class="blue" >��ֵ����ֵ</td>
									<td> 
										<input type="text"  name="czkmz" readonly class="InputGrey" >
									</td>
								  
								</tr>
								<tr> 
									<td class="blue" >��ֵ������</td>
									<td> 
										<input type="password" name="czkmm" >
									</td>
								  
								</tr>
				 

						 
						  <tr align="center" id="footer">
							<td colspan="8">
								
								<input class="b_foot" name=doCfm  type=button index="8" value="����У��" onclick="checkCard2()">
							 
							 
								<input class="b_foot" name=doCfm2 type=button  value="Ϊ���˳�ֵ" onclick="doCfmP()">
							</td>
						</tr>
						  
					  </table>
					  <tr id="footer"> 
						   
						  </tr>
					
						
							
						

				<%@ include file="/npage/include/footer.jsp" %>
				
			<%
		}
		else
		{
			%>
				<script language="JavaScript">
						rdShowMessageDialog("�����ѯ����,�������:"+"<%=return_code%>"+",����ԭ��:"+"<%=return_msg%>");
						history.go("-1");
				 </script>
			<%
		}
	}
%>
</FORM>
				</BODY>
</HTML>

