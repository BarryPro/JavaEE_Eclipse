<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ȫ��ͨ��������1121
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode="1121";
	String opName="��ͨ��������";
	String phoneNo = (String)request.getParameter("activePhone");
%>
<%
	/*
	* ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
			���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
	*/
%>
<%
	String workNo =(String)session.getAttribute("workNo");    		//����
	String workName =(String)session.getAttribute("workName");      //��������
	String info =  (String)session.getAttribute("ipAddr");//��½IP
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");	
	String regionCode = (String)session.getAttribute("regCode");
	/*ѭ����ӡ�Ż��ʷѴ���
	for(int p = 0;p< favInfo.length;p++){//��ӡ�Ż��ʷѴ���
		for(int q = 0;q< favInfo[p].length;q++)
		{
	     out.println("�Ż��ʷѴ��룺"+ favInfo[p][q]);
		}
	}*/
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������BOSS-������ȫ��ͨ��ͨ�������� </title>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body>
<form action="" method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr>
		<td width="20%" class="blue">
			��ѯ����
		</td>
		<td width="30%">
			<select name="s1" onchange="change()">
				<option value="�ֻ�����">�ֻ����� </option>
				<option value="������ˮ">������ˮ </option>
			</select>
		</td>
		<td width="50%" id="tb1">
			<input class="button" name="i1" size="11" maxlength=11 v_must=0 v_type=mobphone value="" onkeydown="if(event.keyCode==13)if(theform()) if(check(form1)) pageSubmit();">
			<input class="b_text" name=verify  type=button value=��ѯ onclick="if(theform()) if(check(form1)) pageSubmit(); ">
		</td>
		<td id="tb2" style="display:none">
			<input class="button" name="ii" size="11" v_must=0 v_type=0_9 onkeydown="if(event.keyCode==13)if(theform())if(check(form1)) pageSubmit(); ">
			<input class="b_text" name=query  type=button value=��ѯ onclick="if(theform()) if(check(form1)) pageSubmit(); ">
		</td>
	</tr>
	<tr>
		<td align=center colspan="3">
			<input class="b_foot" name=sure   type="button" onClick="if(check(form1)) printCommit();" disabled value=ȷ��>
			<input class="b_foot" name="resetName"  onClick="document.all.i1.value='';ii.value=''" type="button" value="���">
			<input class="b_foot" name=close  type="button" onClick="removeCurrentTab()" value=�ر�>
		</td>
	</tr>
</table>
   <%@ include file="/npage/include/footer.jsp" %>
   <input type="hidden" name="my_phone" value="<%=activePhone%>"/>
</form>
</body>
</html>
<%/* --------------------------------javascript��-------------------------------- */%>

<script language="javascript">
function pageSubmit(){
		document.form1.action="<%=request.getContextPath()%>/npage/innet/f1121_2.jsp";
        form1.submit();
    }
/*-----------------------------------��������Ŀ��ƺ���--------------------------*/
function change(){
	   var i = document.form1.s1.selectedIndex+1;
	   var temp="tb"+i;

	  var j = 1;
	  for(j=1;j<3;j++){
	  	var tem ="tb"+j;
	  	document.all(tem).style.display="none";
	  }

   	    document.all(temp).style.display="";

}//��������Ŀ���

/*-------------------------�ı���У�麯��----------------------------*/
function theform(){
	var temp = document.all.s1.selectedIndex;
	var i1 = document.all.i1.value;
	var ii = document.all.ii.value;
	
	if(temp == 0 && i1=="")
	{
		rdShowMessageDialog("�ֻ������������д��",0);
		document.all.i1.focus();
		return false;
	}
	if(temp ==1 && ii==""){
		rdShowMessageDialog("������ˮ�������д��",0);
		document.all.ii.focus();
		return false;
	}
	return true;
}
</script>
