<%
  /*
   * 功能: 考评项查询
　 * 版本: 1.0
　 * 日期: 2008/11/10
　 * 作者: hanjc 
　 * 版权: sitech
   * 
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*"%>

<%
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
		String regionCode = orgCode.substring(0,2);
		String myParams="";
		String content_id    =  request.getParameter("content_id"); 
		String object_id    =  request.getParameter("object_id");
  	String sqlStr = "select item_id,item_name from dqccheckitem where object_id=:object_id and contect_id=:content_id and bak1='Y'  and is_leaf='Y' and is_scored='Y'  order by item_id";
  	myParams="object_id=" + object_id+",content_id=" + content_id;
    String[][] dataRows = new String[][]{};
			           
if (content_id!=null&&!"".equals(content_id)) {
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
<title>考评项查询</title>
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
		
//单击事件
function onClickNodeSelect(itemId,itemName){        

  //alert("已选考评项");
  // 访问另外一个框架页面
  var framemiddle=window.parent.frames['framemiddle'];
  framemiddle.parent.document.sitechform.beQcItemName.value=itemName;
  framemiddle.parent.document.sitechform.beQcItemId.value=itemId;
}

</script>
</head>


<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table" style="width:100%">
		<table cellspacing="0" >
		<tr >
      <th > 编号</th>
      <th align="center"> 考评项</th>
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
</form>
</body>
</html>

