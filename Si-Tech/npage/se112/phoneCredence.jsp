<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	
	String xml = request.getParameter("phoneCredence");
	
	System.out.println("specialfunds=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
	
 	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%
	List fundsList = null;
	Iterator it =null;
	
	if(null != mb){
	
		fundsList = mb.getList("OUT_DATA.H08");
	
		if(null!=fundsList)
			it =fundsList.iterator();
	}
	System.out.println("H08_________" + xml);
 %>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm4938" action="">
				
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							�ֻ�ƾ֤��ϸ��Ϣ
						</div>
					</div>
					<div class="input">
					<table>
					<%
						java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
						java.util.Calendar calendar =java.util.Calendar.getInstance();// �������� 
						
						if(null!=it){
							while(it.hasNext()){
							Map stMap = mb.isMap(it.next());
							if(null==stMap)continue;
						
							String multiFlag = (String)stMap.get("MULTI_FLAG") == null ? "":(String)stMap.get("MULTI_FLAG");
							String giftMode = (String)stMap.get("GIFT_TIME_MODE") == null ? "":(String)stMap.get("GIFT_TIME_MODE");
							String giftLimit = (String)stMap.get("GIFT_TIME_LIMIT") == null ?"":(String)stMap.get("GIFT_TIME_LIMIT");
							String giftMonth = (String)stMap.get("GIFT_TIME_MONTH") == null ? "" : (String)stMap.get("GIFT_TIME_MONTH");
							String sendFlag = (String)stMap.get("SEND_PASS_FLAG") == null ? "" : (String)stMap.get("SEND_PASS_FLAG");

					 %>
							<tr>
								
								<th>
									�Ƿ��ζһ�
								</th>
								
								<td>
								<%if("0".equals(multiFlag)){
									out.print("��");
								}else{ 
								  out.print("��");
								}
								%>				
								</td>
								<th>
								<%if("0".equals(giftMode)){
									out.print("���ʱ��");
								}else{ 
								  out.print("����ʱ��");
								}
								%>	
								</th>
								<td>
								<%if("0".equals(giftMode)){
									out.print(giftMonth);
								}else{ 
								  out.print(giftLimit);
								}
								%>	
								</td>
							</tr>
							<tr>
								<th>�Ƿ����ֻ�����</th>
								<td>
								<%if("0".equals(sendFlag)){
									out.print("��");
								}else{ 
								  out.print("��");
								}
								%>	
								</td> 
								<th></th>
								<td></td>
							</tr>
						<%
							}
						}%>
						</table>
						</div>
					<div id="operation_button">
						<input type="button" class="b_foot" value="�ر�" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	
		function closeWin(){
			closeDivWin();
		}

	</script>
</html>