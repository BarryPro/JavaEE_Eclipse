<%
	/*
	 * ����: �ڰ�������ѯ - ������
	 * �汾: v1.0
	 * ����: 2007/10/25
	 * ����: sunzg
	 * ��Ȩ: sitech
	 * �޸���ʷ
	 * �޸�����      �޸���      �޸�Ŀ��
	 * 2009-09-07   qidp       �����°��Ʒ����
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	//��ȡ�û�session��Ϣ	
    String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	Logger logger = Logger.getLogger("f2893_1.jsp");
	String op_name="�ڰ�������ѯ";
	
	String opCode = "2893";
	String opName = "�ڰ�������ѯ";
%>	
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language=javascript>
	
	
function queryBWInfo()
{
	var flag="0";
	
	if($("#spCode").val()=="" && $("#bizCode").val()=="" && $("#phoneNo").val()==""){
	    rdShowMessageDialog("��ҵ���롢ҵ����롢�ֻ���������������һ����ѯ������",0);
	    return false;
	}
	/*
	if(!checkElement(document.form1.oprDate)){
		return false;
	}	
	*/
	if(($("#phoneNo").val()!="") && !forMobil(document.all.phoneNo)){
	    return false;
	}
	if(check(form1)){
		var spCode = document.all.spCode.value;
		var bizCode = document.all.bizCode.value;
		var phoneNo = document.all.phoneNo.value;
		//liujian 2012-8-30 14:36:09 ��Ӳ���ʱ�� begin
		var oprDate = $.trim($('#oprDate').val());
		//liujian 2012-8-30 14:36:09 ��Ӳ���ʱ�� begin
		//wuxy alter ��ʱ��9��ͷ
		//if(document.all.spCode.value.substr(0,1)=='9'&& spCode.length<=8)
		//{
		//	flag="1";
	  //  }
	  //liujian 2012-8-30 14:37:22 ��Ӳ���ʱ��
		document.middle.location="f2893info.jsp?spCode="+spCode+"&bizCode=" + bizCode+"&phoneNo="+phoneNo+"&flag="+flag + "&oprDate=" + oprDate;
		//tabBusi.style.display="";
    loading("���ڼ��ز�ѯ��Ϣ�����Ժ򡤡���������");
   }
}	
function UnLoad(){
	unLoading();
}
	
</script>

</head>

<body>
	<form action="" name="form1"  method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�ڰ�������ѯ</div>
</div>
	<table cellspacing="0" >
		<tr>
			<td class='blue' nowrap>��ҵ����</TD>
			<TD>
				<input name="spCode" id="spCode" align="left" type="text" v_maxlength=18 v_type="string" maxlength="18"> 
			</TD>
			<td class='blue' nowrap>ҵ�����</TD>
			<TD height=20>
				<input name ="bizCode" id="bizCode" type="text" v_maxlength=14 v_type="string" maxlength="14">
			</TD>	
		</TR>
			<TR>
				<td class='blue' nowrap>�ֻ�����</TD>
				<TD>
					<input name="phoneNo" id="phoneNo" type="text" v_maxlength=11 v_type="phone" maxlength="11">
				</TD>
				<td class='blue' nowrap>����ʱ��</TD>
				<TD>
					<input name="oprDate" id="oprDate" type="text" v_type="date" v_maxlength="8" maxlength="8">
					(yyyyMMdd)
				</TD>
			</TR>	
		</TABLE>
		
		<TABLE id="tabBtn" style="display:''" id="mainOne" cellspacing="0" >	    
			    <TR id="footer"> 
		         	<TD colspan = "4" align="center"> 
		         	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="��  ѯ" onClick="queryBWInfo()">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onclick="javascript:location.reload();">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onClick="removeCurrentTab();" >
				 	  </TD>
		       </TR>
	     </TABLE> 
	      
					<IFRAME frameBorder=0 id=middle name=middle 
					 style="HEIGHT: 306px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
					</IFRAME>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

