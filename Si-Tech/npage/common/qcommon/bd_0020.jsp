<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
 <script>
 	function aaa(info)	{
 		if(info.indexOf("|") == -1){
 			rdShowMessageDialog("û���ʻ���ϸ��Ϣ!");
 			return false;	
 		}else{
 			window.showModalDialog('/npage/common/qcommon/showConUserInfo.jsp?info='+info,'help=no','status=no');
 		}
 	}
 	
 		function showDetail(info,obj)
			{
				var objInner = obj.innerHTML;
				if(objInner.indexOf("��ʾ") != -1){
					obj.innerHTML = "����";
					var packet = new AJAXPacket("/npage/common/qcommon/showConUserInfo.jsp");
				  packet.data.add("info" ,info);
				  core.ajax.sendPacketHtml(packet,doGetHtml);
				  packet =null;
				}else if(objInner.indexOf("����") != -1){
					obj.innerHTML = "��ʾ";
					g("odiv1").innerHTML = "";
				}
			}
			
			function doGetHtml(data)
			{
				//alert(data);
				//eval(data);
				$("#odiv1").html(data);
			}
 </script>
<!--�����ϵ��Ϣ-->
<%
	String bd0020_orgCode = (String)session.getAttribute("orgCode");
	String bd0020_regionCode = bd0020_orgCode.substring(0,2);
	String idNo0020 = request.getParameter("offerSrvId"); 
	System.out.println(".................idNo0020 = " + idNo0020);
%>
<wtc:utype name="sQConUserInfo" id="retConUserInfo" scope="end"  routerKey="region" routerValue="<%=bd0020_regionCode%>">
     <wtc:uparam value="<%=idNo0020%>" type="LONG"/>          
</wtc:utype>
<%
     
     String  retCode_0020 =retConUserInfo.getValue(0);
     String  retMsg_0020  =retConUserInfo.getValue(1);
    System.out.println(".................retMsg_0020 = " + retMsg_0020 + "..."+retCode_0020 );
    
    StringBuffer logBuffer1 = new StringBuffer(80);
	WtcUtil.recursivePrint(retConUserInfo,1,"2",logBuffer1);		
	System.out.println(logBuffer1.toString());
%>
  		
		<div class="list">
			<table>
				<tr>
					<th>�ʻ�ID</th>
					<th>�ʻ�����</th>
					<th>�ʵ�˳��</th>
					<th>�鿴��ϸ</th>
				</tr>
		     <%
		          if(retCode_0020.equals("0")){
		               int num = retConUserInfo.getSize(2);
		               StringBuffer logBuffer = new StringBuffer(80);
										WtcUtil.recursivePrint(retConUserInfo,1,"2",logBuffer);		
										System.out.println(logBuffer.toString());
		               for(int i = 0; i < num; i++){
		                	out.println("<tr>");
	               			out.println("<td>"+ retConUserInfo.getValue("2." + i + ".0.0") +"</td>");
	                    out.println("<td>"+ retConUserInfo.getValue("2." + i + ".0.1") +"</td>");
	                    out.println("<td>"+ retConUserInfo.getValue("2." + i + ".0.3") +"</td>");
		               		int num2 = retConUserInfo.getSize("2."+i+".1");
		               		String tmp = "";
		               		for(int j = 0 ; j < num2; j++ ){
		               			 tmp = tmp + retConUserInfo.getValue("2." + i + ".0.0")+"~";
		                     tmp = tmp + retConUserInfo.getValue("2." + i + ".1." + j + ".2")+"~";
		                     tmp = tmp + retConUserInfo.getValue("2." + i + ".1." + j + ".5")+"~";
		                     tmp += "|";
		                  }
		                  out.println("<td><span style='cursor:pointer;color:#ff9900' onclick=showDetail('"+tmp+"',this)> ��ʾ</span></td>");
	                    out.println("</tr>");
		          }
		     }else{%>
		          <tr><td colspan="5">��ѯ�û������ϵ��ϢΪ�գ�</td></tr>
		     <%}%>
			</table><div id="odiv1">
		</div>
		</div>
 


