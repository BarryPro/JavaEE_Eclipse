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
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%   

		String opCode = "2200"  ;
		String opName = "��Ϣ�ѵ���";
    String chanel_no = request.getParameter("chanel_no");
		String sequence_no = request.getParameter("sequence_no");
		String    errCode ="";
		String    errMsg = " ";
		String return_sequence_no = "";
		String return_sequence_no1 = "";
		String return_sequence_no2 = "";
		%>	
	<wtc:service name="sGetContactId" outnum="3">
		<wtc:param value="<%=chanel_no%>"/>
		<wtc:param value="<%=sequence_no%>"/>
	</wtc:service>


	<wtc:array id="rows"  scope="end"/>	
	<%
 errCode=retCode;
 errMsg = retMsg;
   if((rows != null) && rows.length!=0)
  {
	
			return_sequence_no =rows[0][0];
			return_sequence_no1 =rows[0][1];
			return_sequence_no2 =rows[0][2];
	  
  }
  
  %>
  
  
  



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
document.location.replace("");
}
</script>
</head>
<body>
<form action="s2204_3.jsp" method=post name=form>
<%@ include file="/npage/include/header.jsp" %>
   <div id="Operation_Table">
   	<div class="title">��Ϣ�ѵ���</div>
    <table cellspacing=0 >
     <tr >
        <td width="13%">������Ϣ</td>
        <td width="35%">
          <%=errCode%>
        </td>
        <td width="13%">��ˮ��</td>
        <td width="35%">
          <%=return_sequence_no%>
        </td>
     
      </tr>    
           <tr >
        <td width="13%">������Ϣ</td>
        <td width="35%">
          <%=return_sequence_no1%>
        </td>
        <td width="13%">��ˮ��</td>
        <td width="35%">
          <%=return_sequence_no2%>
        </td>
     
      </tr>          

  </table>
</div>
<%@ include file="/npage/include/footer.jsp" %>
 </form>
</body>
</html>


