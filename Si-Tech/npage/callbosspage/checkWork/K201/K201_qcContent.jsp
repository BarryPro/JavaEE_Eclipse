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
	  String regionCode = orgCode.substring(0,2);
		String myParams="";
		String object_id    =  request.getParameter("selectedItemId"); 
  	String sqlStr = "select contect_id,name from dqccheckcontect where object_id=:object_id and bak1='Y' order by contect_id";
  	myParams = "object_id="+object_id;
  	String param="v1="+object_id;
    String[][] dataRows = new String[][]{};	
if (object_id!=null&&!"".equals(object_id)) {
        %>		           
           <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
						<wtc:param value="<%=sqlStr%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="2" scope="end"/>
				<%
				dataRows = queryList;
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
function onClickNodeSelect(content_id,contentName){ 
	//alert("��ѡ��������");       
  // ��������һ�����ҳ��
  var object_id = document.getElementById("object_id").value;
  //alert(object_id);
  var framemiddle=window.parent.frames['framemiddle'];
  framemiddle.parent.document.sitechform.beQcContentName.value=contentName;
  framemiddle.parent.document.sitechform.beQcContentId.value=content_id;
  framemiddle.parent.window.sendIframerightId(content_id,object_id);
}

</script>
</head>


<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table" style="width:100%">
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
	<input type="hidden" id="object_id" name="object_id" value="<%=object_id%>"/>
</form>
</body>
</html>

