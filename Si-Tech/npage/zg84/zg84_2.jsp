<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%> 
<%
	String opCode ="zg84"; 
	String opName = "�����ټ����ֵ"; 
	String regionCode= (String)session.getAttribute("regCode"); 
	String workno=(String)session.getAttribute("workNo");
	String nopass= (String)session.getAttribute("password");
	String card_no = request.getParameter("card_no");
	String card_pwd = request.getParameter("card_pwd");
	String phoneNo = request.getParameter("phoneNo");
	String user_phone_no = request.getParameter("user_phone_no");
	String user_no = request.getParameter("user_no");
	String cardType = request.getParameter("cardType");
	String remark = request.getParameter("remark");	 
	String Accept_sql="select to_char(sMaxSysAccept.nextval) from dual";
	String[] inParas2 = new String[2];
	inParas2[0]="select to_char(sMaxSysAccept.nextval),to_char(card_money) from dchncardres where card_no =:s_no";
	inParas2[1]="s_no="+card_no;
	String card_money="";
	String loginAccept= request.getParameter("loginAccept");
	String str="";
	str="�ֿ��ˣ����֤����Ϊ��"+user_no+",�ֻ�����Ϊ��"+user_phone_no+")��"+new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())+"��ͨ������"+workno+"��Ϊ����"+phoneNo+"��ֵ�ɹ���";
	//xl add for yusj ����Ĳ��ð� begin
	String[] inParas0 = new String[2];
	inParas0[0]="SELECT to_char(COUNT(1))  FROM WCHNCARDOUTDET B, WCHNCARDOUTSUM A  WHERE A.LOGIN_ACCEPT = B.LOGIN_ACCEPT  AND B.BEGIN_NO LIKE SUBSTR(:s_no0, 1, 10) || '%'  AND B.BEGIN_NO <= :s_no1  AND B.END_NO >= :s_no2  AND A.OP_CODE in ('m240','m242')";
	inParas0[1]="s_no0="+card_no+",s_no1="+card_no+",s_no2="+card_no;
	//xl add for yusj ����Ĳ��ð� end

%>
	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParas0[0]%>"/>
		<wtc:param value="<%=inParas0[1]%>"/>
	</wtc:service>
	<wtc:array id="result_0" scope="end" />
<%
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa result_0.length is "+result_0.length);
	if(result_0!=null&&result_0.length>0)
	{
		if(Integer.parseInt(result_0[0][0])>=1)
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("�ÿ��Ѿ����������ҵ��,�������ٰ����ҵ��!");
					history.go(-1);
				</script>
			<%
		}
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("���Ƿ��Ѿ����������ҵ���ж�ʧ��!");
				history.go(-1);
			</script>
		<%
	}
%>
	<wtc:service name="TlsPubSelCrm"  outnum="2" >
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="resuleArr" scope="end" />
<%
	if(resuleArr!=null&&resuleArr.length>0){
		//loginAccept=resuleArr[0][0];
		card_money=resuleArr[0][1];
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("���Ų�����!");
				history.go(-1);
			</script>
		<%
	}
%>		
	<wtc:service name="bs_zg82Cfm" routerKey="regionCode"   retcode="scode" retmsg="sret" outnum="2">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=user_phone_no%>"/> 
		<wtc:param value="<%=user_no%>"/> 
		<wtc:param value="<%=card_no%>"/>
		<wtc:param value="<%=card_pwd%>"/>
		<wtc:param value="<%=cardType%>"/> 
		<wtc:param value="<%=remark%>"/> 
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="zg84"/>
	</wtc:service>
	<wtc:array id="result" scope="end" /> 
<%
	if(result!=null&&result.length>0){
		String return_flag=result[0][0];
		//return_flag="000000";
		if(return_flag.equals("000000"))
		{					
%>
				<body>
				    <script language="JavaScript">
						rdShowMessageDialog("�����ֵ�ɹ�!");
						window.location.href="zg84_1.jsp";
					</script>
				</body>
<%
		
		}else{
%>			
				<script language="javascript">
					rdShowMessageDialog("�����ֵʧ�ܣ��������"+"<%=result[0][0]%>"+",����ԭ��:"+"<%=result[0][1].replaceAll("[\\pP\\p{Punct}]", "")%>");
				//window.location="zg82_1.jsp";
				history.go(-1);
				</script>
<%		}
	}else{
%>   
			<script language="javascript">
			rdShowMessageDialog("�����ֵʧ��!,���ڹ���Ա��ϵ��");
			//window.location="zg82_1.jsp";
			history.go(-1);
			</script>
<%
	}
%>