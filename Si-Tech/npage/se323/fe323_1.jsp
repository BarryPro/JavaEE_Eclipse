<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ǿ�ؿͻ���ѯ
   * �汾: 1.0
   * ����: 2011/10/13 15:55:19
   * ����: zhangyan
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String hdword_no =(String)session.getAttribute("workNo");//����
	String opCode="e323";
	String opName="ǿ�ؿͻ���ѯ";
	String phoneNo = (String)request.getParameter("activePhone");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������BOSS-ǿ�ؿͻ���ѯ</title>
</head>
<body>
	<form action="" method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<%
	/*	��׼7�����
		iLoginAccept ��ˮ     =>  ����
		iChnSource  ������ʶ(��������01-BOSS��02-����Ӫҵ����
		             03-����Ӫҵ����04-����Ӫҵ����05-��ý���ѯ����06-10086)  =>01
		iOpCode     �������� =>1246
		iLoginNo    ����  =>  ����������
		iLoginPwd   �������� ==>����
		iPhoneNo    �ƶ����� ==>���ֻ���
		iUserPwd    �������� ==>����
	*/
		String iLoginAccept = "";
		String iChnSource  = "01";
		String iOpCode = "1246";
		String iLoginNo = (String)session.getAttribute("workNo");				/*����*/
		String iLoginPwd = "";
		String iPhoneNo =  (String)request.getParameter("activePhone");			/*�ֻ�����*/
		String iUserPwd = "";		
		
		System.out.println("zhangyan add :   iLoginAccept	=["+ iLoginAccept	+"]   "); 
		System.out.println("zhangyan add :   iChnSource  	=["+ iChnSource  	+"]   "); 
		System.out.println("zhangyan add :   iOpCode		=["+ iOpCode		+"]   "); 
		System.out.println("zhangyan add :   iLoginNo 	    =["+ iLoginNo 	    +"]   "); 
		System.out.println("zhangyan add :   iLoginPwd 	   	=["+ iLoginPwd 	    +"]   "); 
		System.out.println("zhangyan add :   iPhoneNo		=["+ iPhoneNo		+"]   "); 
		System.out.println("zhangyan add :   iUserPwd		=["+ iUserPwd		+"]   "); 

		String error_code = "";
		String error_msg = "";
	%>
	<wtc:service name="s1246OperQry" routerKey="region" routerValue="<%=iPhoneNo%>"   
		retcode="code" retmsg="msg"  outnum="18" >
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/> 	
		<wtc:param value="<%=iUserPwd%>"/> 		
	</wtc:service>
	<wtc:array id="s1246OperQryArr" scope="end"/>  
	<%
	error_code = code;
	error_msg = msg;
	System.out.println("zhangyan add :   error_code 	   	=["+ error_code 	    +"]   "); 
	System.out.println("zhangyan add :   error_msg		=["+ error_msg		+"]   "); 
	if(!error_code.equals("000000"))
 	{
	%>
		<script language="javascript">
			rdShowMessageDialog("<%=String.valueOf(error_code)%>:"+"<%=error_msg%>��",0);
			removeCurrentTab();
		</script>
	<%}else {
	String regionname        =s1246OperQryArr[0][0];
	String districtname      =s1246OperQryArr[0][1];
	String custname          =s1246OperQryArr[0][2];
	String force_type	     =s1246OperQryArr[0][3];
	String force_reason	     =s1246OperQryArr[0][4];
	String force_judgement	 =s1246OperQryArr[0][5];
	String largeticket_time  =s1246OperQryArr[0][6];
	String largeticket_fee   =s1246OperQryArr[0][7];
	String owning_fee        =s1246OperQryArr[0][8];
	String suboffice		 =s1246OperQryArr[0][9];
	String suboffice_phone   =s1246OperQryArr[0][10];
	String document_number	 =s1246OperQryArr[0][11];
	String document_date	 =s1246OperQryArr[0][12];
	String operator_name     =s1246OperQryArr[0][13];
	String operator_phone    =s1246OperQryArr[0][14];
	String contact_name		 =s1246OperQryArr[0][15];
	String contact_phone	 =s1246OperQryArr[0][16];
	String op_time			 =s1246OperQryArr[0][17];
	String force_type_name = "";
	if (force_type.equals("1"))
	{
		force_type_name="�߶�";
	}
	else if (force_type.equals("2"))
	{
		force_type_name="Υ��ͣ��";
	}
	else if (force_type.equals("3"))
	{
		force_type_name="����";
	}else if (force_type.equals("4"))
	{
		force_type_name="��ʵ��ͣ��";
	}
	else if (force_type.equals("5"))
	{
		force_type_name="������������";
	}

	System.out.println("zhangyan add regionname       		=["+regionname          +"]");     
	System.out.println("zhangyan add districtname           =["+districtname        +"]");     
	System.out.println("zhangyan add custname               =["+custname            +"]");     
	System.out.println("zhangyan add force_type	            =["+force_type	        +"]");     
	System.out.println("zhangyan add force_reason	        =["+force_reason	    +"]");     
	System.out.println("zhangyan add force_judgement	    =["+force_judgement	    +"]");     
	System.out.println("zhangyan add largeticket_time       =["+largeticket_time    +"]");     
	System.out.println("zhangyan add largeticket_fee        =["+largeticket_fee     +"]");     
	System.out.println("zhangyan add owning_fee             =["+owning_fee          +"]");     
	System.out.println("zhangyan add suboffice				=["+suboffice			+"]");     
	System.out.println("zhangyan add suboffice_phone        =["+suboffice_phone     +"]");     
	System.out.println("zhangyan add document_number	    =["+document_number	    +"]");     
	System.out.println("zhangyan add document_date	        =["+document_date	    +"]");     
	System.out.println("zhangyan add operator_name          =["+operator_name       +"]");     
	System.out.println("zhangyan add operator_phone         =["+operator_phone      +"]");     
	System.out.println("zhangyan add contact_name		    =["+contact_name		+"]");     
	System.out.println("zhangyan add contact_phone	        =["+contact_phone	    +"]");     
	System.out.println("zhangyan add op_time			    =["+op_time			    +"]");     

	%>
	<div class="title">
		<div id="title_zi">�ͻ�ǿ����Ϣ</div>
	</div>
	<table>		
		<tr>
			<td class="blue">����</td>
			<td class="blue">
				<input name="regionname" size="20"  value="<%=regionname%>" 
					Class="InputGrey" readOnly>
			</td>
			<td class="blue">����</td>
			<td class="blue">
				<input name="districtname" size="20"  value="<%=districtname%>" 
					Class="InputGrey" readOnly>	
			</td>
		</tr>
		<tr>
			<td class="blue">�ͻ�����</td>
			<td>
				<input name="custname" size="60"  value="<%=custname%>" 
					Class="InputGrey" readOnly>
			</td>
			
			<td class="blue">�ͻ�����</td>
			<td>
				<input name="iPhoneNo" size="20"  value="<%=iPhoneNo%>" 
					Class="InputGrey" readOnly>
			</td>
		</tr>
		<tr>
			<td class="blue">ǿ������</td>
			<td>
				<input name="force_type_name" size="20"  value="<%=force_type_name%>" 
					Class="InputGrey" readOnly>
			</td>
			
			<td class="blue">ǿ��ʱ��</td>
			<td>
				<input name="op_time" size="20"  value="<%=op_time%>" 
					Class="InputGrey" readOnly>
			</td>
		</tr>

		<%
		if ("1".equals(force_type)  )											/*�߶�*/					    
		{
		%>
			<tr>
				<td class="blue">ǿ��ԭ��</td>
				<td colspan = "3">
					<textarea name ="force_reason"   cols = "100"  readonly><%=force_reason%>
					</textarea>
				</td>
			</tr>
			<tr>
				<td class="blue">ǿ���жϱ�׼</td>
				<td nowrap colspan = "3">
					<textarea name = "force_judgement" cols = "100"  readonly><%=force_judgement%>
					</textarea>
				</td>
			</tr>
			<tr >
				<td class="blue">��ص��߶����ʱ�� </td>
				<td nowrap >
					<input type="text"  name = "largeticket_time" maxlength = "20" readOnly
						 Class="InputGrey" size = "30"  value = "<%=largeticket_time%>">
				</td>		
				<td class="blue">�߶������ </td>
				<td nowrap >
					<input type="text"  name = "largeticket_fee" maxlength = "10"  readOnly
						size = "30" Class="InputGrey" value = "<%=largeticket_fee%>" >
				</td>			
			</tr>	
			<tr>
				<td class="blue">��ǰ������� </td>
				<td nowrap colspan="3">
					<input type="text"  name = "owning_fee" maxlength = "10"  readOnly
						size = "30" Class="InputGrey" value = "<%=owning_fee%>" >
				</td>			
			</tr>	
			<tr >
				<td class="blue">���������� </td>
				<td nowrap >
					<input type="text"  name = "operator_name" size = "10" readOnly
						 Class="InputGrey" value = "<%=operator_name%>" >
				</td>	
				<td class="blue">��������ϵ�绰 </td>
				<td nowrap >
					<input type="text"  name = "operator_phone" size = "20" readOnly
						 Class="InputGrey" value = "<%=operator_phone%>"  >
				</td>		
			</tr>	
			
		<%
		}
		else if  ("2".equals(force_type))										/*Υ��ͣ��*/
		{%>
		
			<tr>
				<td class="blue">ǿ��ԭ��</td>
				<td colspan = "3">
					<textarea name ="force_reason"   cols = "100"  readonly><%=force_reason%>
					</textarea>
				</td>
			</tr>
			<tr>
				<td class="blue">��Ͻ�־�</td>
				<td colspan="3">
					<input name="suboffice" size="100" maxlength = "60"  readonly
					 	value = "<%=suboffice%>">
				</td>
			</tr>
			<tr >
				<td class="blue">��Ͻ�־ֵ绰</td>
				<td colspan="3">
					<input name="suboffice_phone" size="100" maxlength = "60"  readonly
						 Class="InputGrey" value = "<%=suboffice_phone%>" >
				</td>
			</tr>	
			<tr >
				<td class="blue">�ļ���� </td>
				<td nowrap >
					<input type="text"  name = "document_number" maxlength = "30" 
						Class="InputGrey" size = "60" readonly 	value = "<%=document_number%>">
				</td>	
				<td class="blue">�������� </td>
				<td nowrap >
					<input type="text"  name = "document_date"  maxlength = "8"  
						Class="InputGrey" size = "10" readonly	value = "<%=document_date%>">
				</td>		
			</tr>	
			<tr >
				<td class="blue">���������� </td>
				<td nowrap >
					<input type="text"  name = "operator_name" size = "10" 
						Class="InputGrey"  readonly 	value = "<%=operator_name%>">
				</td>	
				<td class="blue">��������ϵ�绰 </td>
				<td nowrap >
					<input type="text"  name = "operator_phone" size = "20"
						 Class="InputGrey"  readonly 	value = "<%=operator_phone%>">
				</td>		
			</tr>	
		<%
		}else if  ("3".equals(force_type))										/*����*/
		{
		%>
		
			<tr>
				<td class="blue">ǿ��ԭ��</td>
				<td colspan = "3">
					<textarea name ="force_reason"   cols = "100"  readonly><%=force_reason%>
					</textarea>
				</td>
			</tr>
			<tr >
				<td class="blue">��ϵ������ </td>
				<td nowrap >
					<input type="text"  name = "contact_name" maxlength = "10" 
						Class="InputGrey" size = "15" readonly value = "<%=contact_name%>"  >
				</td>	
				<td class="blue">��ϵ�˵绰 </td>
				<td nowrap >
					<input type="text"  name = "contact_phone" maxlength = "20" 
						Class="InputGrey" size = 15  readonly value = "<%=contact_phone%>">
				</td>		
			</tr>		
		<%
		}
		%>
		
	</table>	
		
	<%
	}%>
		
	</form>
</body>