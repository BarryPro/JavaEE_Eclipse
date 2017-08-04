<%
  /*
   * 功能: 显示新通知
　 * 版本: 1.0
　 * 日期: 2008/11/18
　 * 作者: hanjc
　 * 版权: sitech
   * 使用K084_commNoteRecSend.jsp代替此文件接受通知
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String contentList  =(String)request.getParameter("contentList");
	  contentList = contentList.substring(0,contentList.length()-1);//去掉结尾的~
	  String[] contentArr = contentList.split("~"); 
	  String[][] dataRows = new String[contentArr.length][];
	  for(int i=0;i<contentArr.length;i++){
	    dataRows[i]= contentArr[i].split(",");
	  }

%>

<html>
<head>
<title>新通知</title>
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

function updateCfm(){
	//if(rdShowConfirmDialog("下次不在显示该通知？")=="1"){
	  var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K084/K084_update_msgIsRead_rpc.jsp","正在更新通知，请稍候......");
    core.ajax.sendPacket(mypacket,doProcess,true);
    mypacket=null;
 // }
  window.close();
}

function doProcess(packet){
	window.close();
}
</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<div class="title">新通知</div>
		<table cellSpacing="0">
			<tr >
         <th align="center" class="blue" width="15%" > 发送人 </th>
         <th align="center" class="blue" width="55%" > 内容 </th>
         <th align="center" class="blue" width="30%" > 发送时间</th>
      </tr>
		  <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
         <%if((i+1)%2==1){
          tdClass="grey";
          }%>
	   <tr > 
      <td onmouseover="javascript:this.style.backgroundColor='#ececec';" onmouseout="javascript:this.style.backgroundColor='#F7F7F7'" align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td onmouseover="javascript:this.style.backgroundColor='#ececec';" onmouseout="javascript:this.style.backgroundColor='#F7F7F7'" align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td onmouseover="javascript:this.style.backgroundColor='#ececec';" onmouseout="javascript:this.style.backgroundColor='#F7F7F7'" align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
    </tr>
      <% } %>
     
		</table>
			<p align="right" id="footer">
			<input name="send" type="button"  id="send" value="确定" onClick="updateCfm()">
			<input name="send" type="button"  id="send" value="关闭" onClick="window.close()">
			<hr>
		</p>
	</div>
</div>
</form>
</body>
</html>

