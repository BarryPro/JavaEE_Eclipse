<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ǿ�ƿ��ػ�1246
   * �汾: 1.0
   * ����: 2008/12/23
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String hdword_no =(String)session.getAttribute("workNo");//����
	String opCode="1246";
	String opName="ǿ�ƿ��ػ�";
	String phoneNo = (String)request.getParameter("activePhone");
	String accountType = (String)session.getAttribute("accountType"); //1 ΪӪҵ���� 2 Ϊ�ͷ�����
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������BOSS-���ػ�����ǿ�ƿ��ػ�</title>
</head>
<body>
<form action="" method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ѡ���������</div>
	</div>

	<table cellspacing="0">
	<tr>
		<td class="blue">��������</td>
		<td  class="blue">
			<input type="radio" name="op_run_code" value="K" checked>ǿ��
			<input type="radio" name="op_run_code" value="N"  <%if("2".equals(accountType)){out.print(" disabled");}%>> ǿ��
			<input type="radio" name="op_run_code" value="BK" onclick="show4A();"> ����ǿ��
			<input type="radio" name="op_run_code" value="BN" onclick="show4A();" <%if("2".equals(accountType)){out.print(" disabled");}%>> ����ǿ��
		</td>
	</tr>

	<tr>
		<td class="blue">�������</td>
		<td>
			<input name="i1" value="<%=phoneNo%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td align=center colspan="2">
			<input class="b_foot" name=sure  type=button value=����ǿ�ؽ����ѯ onClick="go_plresult()" >
			<input class="b_foot" name=sure  type=button value=ȷ�� onClick="if(check(form1))  pageSubmit();" >
			<input class="b_foot" name=reset onClick="" type="reset" value=���>
			<input class="b_foot" name=close onClick="removeCurrentTab()" type=button value=�ر�>
		</td>
	</tr>
</table>
	<!-- 2014/12/26 14:47:50 gaopeng �������ƽ��ģʽ�����������Ϣģ���������� ���빫��ҳ�� openType����������ͨ���У��Ͷ����๫��У��-->
	<jsp:include page="/npage/public/intf4A/common/intfCommon4A.jsp">
		<jsp:param name="openType" value="SPECIAL"  />
	</jsp:include>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<%/*-----------------------------javascript��-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------loadҳ��ʱ��ȡ----------------------------------*/

/***
	2������������ǿ�ؽ����ѯ��
	����Ԫ�أ�������ˮ(������ǿ�ط��صĲ�����ˮ)
	��ѯ������ֻ����롢������
	���У��������ɹ�����������ʾ���ɹ�����
	     �������ʧ�ܣ���������ʾʧ�ܵ�ԭ��
	˵����������ǿ�ؽ����ѯ�����ڡ�1246��ǿ�ƿ��ػ�������������һ����ť���ɣ����������������롣
*/
	function go_plresult(){
	    var tpath = "f1246_show_plresult.jsp?opCode=<%=opCode%>"+//opcode
	    																		"&opName=����ǿ�ؽ����ѯ" ;
			form1.action=tpath;
			form1.submit();	    																		
	}
	
	function pageSubmit(){
		var op_run_codeC = $("input[name='op_run_code'][checked]").val();
		if(op_run_codeC == "BK" || op_run_codeC == "BN"){
			window.location.href="f1246_bat.jsp?opCode=<%=opCode%>&opName=<%=opName%>&opType="+op_run_codeC+"&i1=<%=phoneNo%>";
		}
		else{
			form1.action="f1246_2.jsp";
			form1.submit();
		}
	}
	/*���ƵĽ��У�鷽��*/
	function show4A(){
		var flag4A = allCheck4A("<%=opCode%>");
		if(!flag4A){
			$("input[name='op_run_code']").eq(0).attr("checked","checked");
		}
		
	}
</script>


