<%
  /*
   * ����: �������ѯ
�� * �汾: 1.0
�� * ����: 2008/11/10
�� * ����: hanjc 
�� * ��Ȩ: sitech
   * 
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
		String selectedItemId    =  request.getParameter("selectedItemId"); 
		System.out.println("==============selectedItemId==="+selectedItemId);
  	String sqlStr = "select object_id,name from dqccheckcontect where object_id="+selectedItemId;
  	String param="v1="+selectedItemId;
    String[][] dataRows = new String[][]{};	
if (selectedItemId!=null&&!"".equals(selectedItemId)) {
        %>		           
           <wtc:service name="s151Select" outnum="2">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="2" scope="end"/>
				<%
				dataRows = queryList;
				System.out.println("===========dataRows=="+dataRows);
    }
   
%>


<html>
<head>
<title>�������ѯ</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	

//�����¼�
function onClickNodeSelect(contentId,contentName){ 
	//alert("��ѡ��������");       
  // ��������һ�����ҳ��
  var framemiddle=window.parent.frames['framemiddle'];
  framemiddle.parent.document.sitechform.beQcContentName.value=contentName;
  framemiddle.parent.document.sitechform.beQcContentId.value=contentId;
}

</script>
</head>


<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table cellspacing="0" >
		<tr >
      <th > ���</th>
      <th > �ʼ�����</th>
    </tr>
     <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
           
         <%if((i+1)%2==1){
          tdClass="grey";
          }%>
	   <tr onclick="onClickNodeSelect('<%=dataRows[i][0]%>','<%=dataRows[i][1]%>')" style="cursor:hand">
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
    </tr>
      <% } %>
		</table>    
	</div>
	<input type="hidden" name="selectedItemId" value=""/>
</form>
</body>
</html>

