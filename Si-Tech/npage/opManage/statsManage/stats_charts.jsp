<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.Calendar"  %>
<%
		String themePath = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
    String workNo = (String)session.getAttribute("workNo");
    String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);

		String optionStr = "";
		
		String statsDate = request.getParameter("statsDate")==null?"":request.getParameter("statsDate");
		String stats_type = request.getParameter("stats_type")==null?"":request.getParameter("stats_type");
%>
	<div class="title"> 
			<div id="title_zi">
				<%if("0".equals(stats_type)){%>
				��������ͳ��
				<%}else if("1".equals(stats_type)){%>
				����ʱ��ͳ��
				<%}else if("2".equals(stats_type)){%>
				����̨ʹ��Ƶ��ͳ��
				<%}%>
			</div>							
	</div>
	<table cellspacing="0">
		<tr>
				<td class="blue">
					<div id="chartdiv"></div>
				</td>
		</tr>
	</table>
		<script type="text/javascript">											
	   queryUser();	    
		 
		 function queryUser(){
				  var packet = new AJAXPacket("stats_op.jsp","���ڼ���,���Ժ�...");
				  packet.data.add("statsType", "<%=stats_type%>");
				  packet.data.add("statsDate", "<%=statsDate%>");
	      	core.ajax.sendPacket(packet,doQuery,true);
	      	packet = null; 
	      	
			}
			
			function doQuery(packet)      
 		{
	       var statsType = packet.data.findValueByName("statsType"); 
	       var retCode = packet.data.findValueByName("retCode"); 
	       var retMsg = packet.data.findValueByName("retMsg"); 
	       var retLog = packet.data.findValueByName("retLog"); 
	      
	      if(statsType=="1"){
	      	if(retCode=="000000"){
	   				 var dataXml = packet.data.findValueByName("dataXml"); 
	   				 if(dataXml==""){
	   				    $("#chartdiv").html("<font color='red'>û�в�ѯ�����ݣ�</font>");
	   				 }else{
	   				 	  var chart = new FusionCharts("<%=request.getContextPath()%>/nresources/swf/MSColumn3D.swf", "ChartId", "800", "400");
	  				 	  chart.setDataXML(dataXml);		   
	           	  chart.render("chartdiv");
	   				}
	   			}else{
	   				rdShowMessageDialog("ʧ��!<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
	   				return false;
	   			}
	      }else {
	   			if(retCode=="000000"){
	   				 var dataXml = packet.data.findValueByName("dataXml"); 
	   				 if(dataXml==""){
	   				    $("#chartdiv").html("<font color='red'>û�в�ѯ�����ݣ�</font>");
	   				 }else{
	   				 	  var chart = new FusionCharts("<%=request.getContextPath()%>/nresources/swf/Column3D.swf", "ChartId", "600", "350");
	  				 	  chart.setDataXML(dataXml);		   
	           	  chart.render("chartdiv");
	   				}
	   			}else{
	   				rdShowMessageDialog("ʧ��!<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
	   				return false;
	   			}
       }
     } 
	</script>