<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>

<%	
	response.setHeader("Pragma","No-Cache"); 
    response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 
%>
 
<%
	String phoneNo = request.getParameter("phoneNo").trim();					//�û�����
	//String opCode = request.getParameter("opCode");
	String opName = "��ֵ���ֹ���ֵ";//��������
	String opCode = "e251";	
	String orgCode = request.getParameter("orgCode");					//��������
	String regionCode = (String)session.getAttribute("regCode");		//���д���
	String iLoginAccept ="0";
	String iChnSource  =request.getParameter("channelId");
	
	String workno = (String)session.getAttribute("workNo");
	String pwd = request.getParameter("pwd");
	String nopass = (String)session.getAttribute("password");
	String op_codes = request.getParameter("s_opcode");
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA "+op_codes);
 %>
 	<wtc:service name="se257QryBD" routerKey="region" routerValue="<%=regionCode%>" outnum="13" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=pwd%>"/>
		<wtc:param value="<%=op_codes%>"/>
	</wtc:service>
	<wtc:array id="mainInfo1" start="0" length="2" scope="end"/>
	<wtc:array id="mainInfo2" start="2" length="3" scope="end"/>
	<wtc:array id="mainInfo3" start="5" length="2" scope="end"/>
	<wtc:array id="mainInfo4" start="7" length="4" scope="end"/>
	<wtc:array id="mainInfo5" start="11" length="2" scope="end"/>
 <%
 	String errCode = retCode;
	String errMsg = retMsg;
	String oProjectName = "";
	String oPartInTime = ""; /*����ʱ��*/
	String oOnlyMyFlag = "";/* �Ƿ������ת����ʶ 1��ʾ������*/
	String oAllFee=""; /*�ܽ��*/
	String oMyFee="";/*���Լ���ֵ�Ľ��*/
	/*���¿����ж�ֵ*/
	String oStoreNo="";/*��ֵ����ʼ����*/
	String oEndStoreNo="";/*��ֵ����������*/
	String oTranFee=""; /*ת�����*/
	String oTranTime ="";/*ת��ʱ��*/
	String oTranPhone="";/*ת���绰*/
	String oCustName="";
	String[][] result1  = null ;
	String[][] result2  = null ;
	String[][] result3  = null ;
	//xl add
	String[][] result4  = null ;
	String[][] result5  = null ;
	result1 = mainInfo1;
	result2 = mainInfo2;
	result3 = mainInfo3;
	result4 = mainInfo4;
	result5 = mainInfo5;
	System.out.println("fffffffffffffffAAAAAAAAAAAAAAAAAAAAAAAAAAA test for mainInfo3 is "+mainInfo3+" result3.legnth is "+result3.length);
	//Integer.parseInt(result3.length)=1;
	if(result3==null||result3.length==0)
	{
   %>
      <SCRIPT LANGUAGE="JavaScript">
      <!--
       		  window.close();
       //-->
      </SCRIPT>
<%
	}
	 
   else  if ( result3.length==1 )
   {
%>      
 		<SCRIPT LANGUAGE="JavaScript">
 		<!--
			window.returnValue="<%=result3[0][0].trim()%>";
			//alert("1����� window.returnValue is "+window.returnValue);
			window.close(); 
 		//-->
 		</SCRIPT>
<%   
    }
else
  {
%>

<HEAD>
<TITLE>������BOSS-�û�ѡ��</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script language="JavaScript">
window.returnValue='';
function selUser()
{	
	  if(isNaN(document.frm.user.length))
	  {
         window.returnValue=document.frm.user.value;    
 	  }
      else
      for(i=0;i<document.frm.user.length;i++) 
	  {		    
		     if (document.frm.user[i].checked==true)
		     {
 					 window.returnValue=document.frm.user[i].value;     
					 break;
			 }
	   }
	 //  alert("test "+window.returnValue);
 	   window.close(); 
}
</script>

</head>

<BODY>
<form name="frm" method="post" action="">
      <%@ include file="/npage/include/header_pop.jsp" %>
     
<table>
	<tr> 
		<th>&nbsp;</th>
		<th class="blue" align="center">��ʼ����</td>
		<th align="center">��������</td>
		<th align="center">����ҵ�����</td> 
		<th align="center">����ҵ����ˮ</td>
		<th align="center">��������</td>
		<th align="center">����ʱ��</td>
	
	</tr>
    <%
    String tbClass = "";
	String add_money="";
//	String sql_money="select to_char(add_pay_money) from wChargeCardMsg where phone_no1='?' and phone_no2='?' ";
    

			
			for(int j=0;j<result3.length;j++)//forѭ����
			{
				{
					%>
					<tr> 
			<td class="<%=tbClass%>"> 
				<div align="center"> 
				<%
					//��Ŀ���Ƹ���ͬ������һ��
					//���Ÿ��������� �������Ŀ�ĸ���
					 
					
						 
						%>
						<input type="radio" name="user" value="<%=result3[j][0]+","+result3[j][1]+","+result5[j][0]+","+result5[j][1]+","+result1[j][0]+","+result1[j][1]%>"  <%if (j==0) {%>checked<%}%>>
						<td class="<%=tbClass%>"> 
							<div align="center"><%=result3[j][0]%></div>
						</td>
						<td class="<%=tbClass%>"> 
							<div align="center"><%=result3[j][1]%></div>
						</td> 
							<td class="<%=tbClass%>"> 
								<div align="center"><%=result5[j][0]%></div>
							</td>
							<td class="<%=tbClass%>"> 
								<div align="center"><%=result5[j][1]%></div>
							</td>
							<td class="<%=tbClass%>"> 
								<div align="center"><%=result1[j][0]%></div>
							</td>
							<td class="<%=tbClass%>"> 
								<div align="center"><%=result1[j][1]%></div>
							</td>
						<%
					
				//	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaa i is "+i+" and result2[i][0] is "+result2[i][0]+" and result2[i][1] is "+result2[i][0]+" and result4[i][0] is "+result4[i][0]+" and result4[i][1] is "+result4[i][1]);

				%>

							 
				</div>
			</td>
			 
				 </tr>
					<%
				}
	%>
			 
		
	 
				
				 
		
    <%}
	
	%>
	 
	<tr> 
		<td colspan="7"> 
			<div align="center"> 
				<input class="b_foot" type="button" name="Button" value="ȷ��" onClick="selUser()">
				<input class="b_foot" type="button" name="return" value="����" onClick="window.close();">
			</div>
		</td>
	</tr>
</table>
  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
<%
  }
%>
