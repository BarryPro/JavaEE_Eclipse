<%
  /*
   * ����: ��ʾ��֪ͨ
�� * �汾: 1.0
�� * ����: 2008/11/18
�� * ����: hanjc
�� * ��Ȩ: sitech
   * ʹ��K084_commNoteRecSend.jsp������ļ�����֪ͨ
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String contentList  =(String)request.getParameter("contentList");
	  contentList = contentList.substring(0,contentList.length()-1);//ȥ����β��~
	  String[] contentArr = contentList.split("~"); 
	  String[][] dataRows = new String[contentArr.length][];
	  for(int i=0;i<contentArr.length;i++){
	    dataRows[i]= contentArr[i].split(",");
	  }

%>

<html>
<head>
<title>��֪ͨ</title>
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
	//if(rdShowConfirmDialog("�´β�����ʾ��֪ͨ��")=="1"){
	  var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K084/K084_update_msgIsRead_rpc.jsp","���ڸ���֪ͨ�����Ժ�......");
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
		<div class="title">��֪ͨ</div>
		<table cellSpacing="0">
			<tr >
         <th align="center" class="blue" width="15%" > ������ </th>
         <th align="center" class="blue" width="55%" > ���� </th>
         <th align="center" class="blue" width="30%" > ����ʱ��</th>
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
			<input name="send" type="button"  id="send" value="ȷ��" onClick="updateCfm()">
			<input name="send" type="button"  id="send" value="�ر�" onClick="window.close()">
			<hr>
		</p>
	</div>
</div>
</form>
</body>
</html>

