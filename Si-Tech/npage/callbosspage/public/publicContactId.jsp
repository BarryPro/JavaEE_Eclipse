<%
  /*
   * ����: ��ѯ�Ӵ���ˮ��
�� * �汾: 1.8.2
�� * ����: 2008/10/10
�� * ����: tancf
�� * ��Ȩ: sitech
	 *update:zhanghonga@2008-04-23
��*/
%>
<%
		String opCode = "2200"  ;
		String opName = "��ѯ�Ӵ���ˮ��" ;

%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html><head><title>��ѯ�Ӵ���ˮ��</title>
<script language="JavaScript">
	$(document).ready(
	function()
	{
		$("td").not("[input]").addClass("blue");
		$("td:not(#footer) input:button").addClass("b_text");
		$("#footer input:button").addClass("b_foot");
		$("input:text[@readonly]").addClass("InputGrey");
		}
	);
function gohome()
{
document.location.replace("s2200.jsp");
}
</script>
</head>
<body>
<form action="publicContactId_save.jsp" method=post name=form>
<%@ include file="/npage/include/header.jsp" %>
   <div id="Operation_Table">
   	<div class="title">��ˮ�Ų�ѯ</div>
    <table cellspacing=0 >
       <tr>
        <td width="13%">������ʶ</td>
      <td width="35%">
        <input type=text name=chanel_no value="">
      </td>      
        <td width=13% >��������</td>
      <td width="35%">
         <input type="text"   name="sequence_no"  value="">
      </td>
      </tr>         
      
      <tr >
        <td align=center id="footer" colspan="4" >
          <input  name=sure type=submit class="b_foot" value=ȷ�� >
          <input  name=reset type=reset class="b_foot"  value=���� onClick="gohome()">
        </td>
       </tr>
  </table>
</div>
<%@ include file="/npage/include/footer.jsp" %>
 </form>
</body>
</html>


