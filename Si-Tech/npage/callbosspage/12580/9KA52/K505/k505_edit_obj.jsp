
<%
	 /*
	 * ����: 12580Ⱥ��-edit
	 * �汾: 1.0.0
	 * ����: 2009/01/12
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<%
  
  String opCode = "K505";
  String opName = "Ⱥ��";

  String org_code = (String)session.getAttribute("orgCode");
  String workNo = (String)session.getAttribute("workNo");
  
  String SERIAL_NO = request.getParameter("SERIAL_NO");
  
  String GRP_NAME= "";
  String ACCEPT_NO = "";
  String GRP_DESCR = "";
  
  String strSql = "select GRP_NAME,ACCEPT_NO,GRP_DESCR from DMSGGRP where SERIAL_NO = '"+SERIAL_NO+"'";
%>

<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=strSql%>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />
<% 
  
  GRP_NAME = (queryList[0][0].length() != 0) ? queryList[0][0]: "";
  ACCEPT_NO = (queryList[0][1].length() != 0) ? queryList[0][1]: "";
  GRP_DESCR = (queryList[0][2].length() != 0) ? queryList[0][2]: "";
%>

<html>
	<head>
		<title>Ⱥ��</title>
		<script language=javascript>
			
			function modCfmUP(){
				var GRP_NAME = document.getElementById("GRP_NAME").value;
			    var ACCEPT_NO = document.getElementById("ACCEPT_NO").value;
			    var GRP_DESCR = document.getElementById("GRP_DESCR").value;
			    
			    if(GRP_NAME==null){
			    	
			    	showTip(document.sitechform.GRP_NAME,"Ⱥ�����Ʋ���Ϊ�գ������ѡ�������");
			        sitechform.GRP_NAME.focus();
			        return;
			    }
			    if(ACCEPT_NO==null){
			    	
			    	showTip(document.sitechform.ACCEPT_NO,"�������벻��Ϊ�գ������ѡ�������");
			        sitechform.ACCEPT_NO.focus();
			        return;
			    }
			    
			  var myPacket = new AJAXPacket("k505_editsave_obj.jsp","�����ύ�����Ժ�......");
			  myPacket.data.add("GRP_NAME",GRP_NAME);
				myPacket.data.add("ACCEPT_NO",ACCEPT_NO);
				myPacket.data.add("GRP_DESCR",GRP_DESCR);
				myPacket.data.add("SERIAL_NO",<%=SERIAL_NO%>);
				core.ajax.sendPacket(myPacket,doProcess,true);
				myPacket=null;
			}
			function doProcess(myPacket)
			{
		
			    var retType = myPacket.data.findValueByName("retType");
				var retCode = myPacket.data.findValueByName("retCode");
				var retMsg = myPacket.data.findValueByName("retMsg");
					if(retCode=="000000"){
						//alert("����ɹ�");
						rdShowMessageDialog("�ɹ�",2);
						window.dialogArguments.submitMe('1');
					  window.close();
					}else if(retCode=="44444"){
						rdShowMessageDialog("ʧ�ܣ���Ⱥ�������Դ��ڣ�",0);
						return false;
					}else{
						//alert("����ʧ��!");
						rdShowMessageDialog("ʧ��",0);
						return false;
					}
			}
		</script>
	</head>
	<body>
		
		<%@ include file="/npage/include/header.jsp"%>
	    <form name="sitechform" id="sitechform">
		    <div id="Operation_Table">
				<div class="title">
					����Ⱥ����Ϣ
				</div>
				<table  cellspacing="0">
					
					<tr>
						<td>
						Ⱥ�����ƣ�
						</td>
						<td>
						<input type="text" name="GRP_NAME" id="GRP_NAME" value="<%=GRP_NAME %>"><font color="orange">*</font>
						</td>
					</tr>
					<tr>
						<td>
						�������룺
						</td>
						<td>
						<input type="text" name="ACCEPT_NO" id="ACCEPT_NO" value="<%=ACCEPT_NO %>" disabled >
						</td>
					</tr>
					<tr>
						<td>
						��ע��
						</td>
						<td>
						<input type="text" name="GRP_DESCR" id="GRP_DESCR" value="<%=GRP_DESCR %>">
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right">
				        <input type="button" name="cfm" class="b_foot" value="ȷ��" onclick="modCfmUP();"/>
					    <input type="button" name="clo" class="b_foot" value="�ر�" onclick="javascript:window.close();"/>
						</td>
					</tr>
				</table>
			</div>
		</form>
	    <%@ include file="/npage/include/footer.jsp"%>		
	</body>	  

</html>