<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page  contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String opCode = "e488";
	String opName = "��Ϣ����";
	
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");	
	
	
	//Ĭ�ϲ�ѯ�ҽ��յ�����Ϣ����������Ϊ��½����
	String sendType = request.getParameter("sendType")==null?"receive":request.getParameter("sendType");
	
	//�����ѯʱ����ȡ�ύ��ֵ��Ȼ����й��˲�ѯ
	String send_no = request.getParameter("send_no")==null?"":((String)request.getParameter("send_no")).trim();
	String receive_no = request.getParameter("receive_no")==null?"":((String)request.getParameter("receive_no")).trim();
	String msg_type = request.getParameter("msg_type")==null?"":(request.getParameter("msg_type")).trim();
	System.out.println(msg_type);
	String beginDate = request.getParameter("beginDate")==null?"":(request.getParameter("beginDate")).trim();
	String endDate = request.getParameter("endDate")==null?"":(request.getParameter("endDate")).trim();		
	
	//��ҳ���ܱ���
	int iPageNumber = request.getParameter("pageNumber") == null ? 1: Integer.parseInt(request.getParameter("pageNumber"));
  int iPageSize = 10;
  int iStartPos = (iPageNumber - 1) * iPageSize;
  int iEndPos = iPageNumber * iPageSize;	
  int totalNum = 0;
%>

	<head>
		<title><%=opName%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<META content=no-cache http-equiv=Pragma>
		<META content=no-cache http-equiv=Cache-Control>
		<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
		<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/My97DatePicker/WdatePicker.js"></script>
	</head>
	
	<script>
		$(document).ready(function(){
	$("select").width("40");
	$("#msg_type").width("80");
	$("input[type='text']").width("150");
});
	
		//������Ϣ
		function createMsg(){
			var path = "message_add.jsp";
			//window.open(path);
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
			if(typeof(retInfo)=="undefined")      
    		{   
    			return false;   
    		}
    		if(retInfo){//���سɹ���������²�ѯҳ��
    				
    		}
		}
			
			
		function doProcess(packet)      
 		{
	       var opType = packet.data.findValueByName("opType"); 
	       var retCode = packet.data.findValueByName("retCode"); 
	       var retMsg = packet.data.findValueByName("retMsg"); 
	       var tempInfos = packet.data.findValueByName("tempInfos"); 
	      
	       if(opType=="delete"){
       			if(retCode=="000000"){
       				rdShowMessageDialog("ɾ���ɹ���",2);
       				queryMsg();
       			}else{
       				rdShowMessageDialog("ɾ��ʧ��!<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
       				return false;
       			}
       			
       	   }
       }
       		
		//ɾ��
		function delMsg(){
				var msgVal = "";
				f=document.getElementsByName("delSel");
					for( i=0 ; i<f.length ; i++) {
						if(f[i].checked==true){//��װѡ������
							msgVal = msgVal + f[i].value +"~";
						}
				}
				if(msgVal==""){
					rdShowMessageDialog("��ѡ��Ҫɾ�������ݣ�",1);
					return false;
				}
				if(rdShowConfirmDialog("ȷ��Ҫɾ��ѡ�����Ϣ��")==1)
	      {
							var delPacket = new AJAXPacket("message_op.jsp","����ִ��,���Ժ�...");
			      	delPacket.data.add("opType", "delete");
			      	delPacket.data.add("msg_seq", msgVal);
			      	core.ajax.sendPacket(delPacket,doProcess,true);
			      	delPacket = null; 
			  }		
		}
		
		function changeSender(msgType){
				if(msgType=="send"){//�ҷ��͵���Ϣ
						$("#sender").text("�����˹���");
						$("#receive_no").show();
						$("#send_no").hide();
				}else if(msgType=="receive"){//�ҽ��յ�����Ϣ
						$("#sender").text("�����˹���");
						$("#receive_no").hide();
						$("#send_no").show();
				}
		}
		
		function queryMsg(){
			 var myMsg =  $('input[name=myMsg]:checked').val();
			 if(myMsg=="receive"){//���յ�����Ϣ
			 			document.qrymessageFrm.action="message_main.jsp?sendType=receive";
			 }else if(myMsg=="send"){//�ҽӷ��͵���Ϣ
			 		  document.qrymessageFrm.action="message_main.jsp?sendType=send";
			 }		 
			 document.qrymessageFrm.submit();
		}
		
		//ѡ��ȫ��
		function setdelSelChecked(checkedVal) {
			f=document.getElementsByName("delSel");
			for( i=0 ; i<f.length ; i++) {
					if(checkedVal){
						f[i].checked=true;
					}else{
						f[i].checked=false;
					}
			}
			
		}
	</script>
	<body>
		
		<form name="qrymessageFrm" action="" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
					
					<div class="title"> 
							<div id="title_zi">
								<div style="float:left;margin-right:10px">
								��Ϣ��ѯ
								</div>
								<div style="float:right;margin-right:10px">
									<input type="radio" name="myMsg" id="myMsg" value="receive" onclick="changeSender(this.value)" <%if("receive".equals(sendType)){%>checked="checked"<%}%> />�ҽ��յ���Ϣ
									<input type="radio" name="myMsg" id="myMsg" value="send" onclick="changeSender(this.value)" <%if("send".equals(sendType)){%>checked="checked"<%}%>/>�ҷ��͵���Ϣ
								</div>
							</div>
							
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue" width="15%" id="sender">
								<%if("receive".equals(sendType)){%>
									�����˹���
									<%}else{%> 
									�����˹���
									<%}%>	
								</td>
								<td class="blue" width="35%">
									<input type="text"  v_must=1 v_type="string" v_maxlength="20" name="send_no" id="send_no" value=""/><input type="text"  v_must=1 v_type="string" v_maxlength="20" name="receive_no" id="receive_no" style="display:none"/>
								</td>
								<td class="blue" width="15%">��Ϣ���</td>
								<td class="blue" width="35%">
									<select id="msg_type" name="msg_type">
										<option value="" selected>
											ȫ��
										</option>
										<option value="0" >
											ϵͳ��Ϣ
										</option>
										<option value="1">
											������Ϣ
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="blue">����ʱ��</td>
								<td class="blue">
									<input type="text"  v_must=1 v_type="string" v_maxlength="20" name="beginDate" id="beginDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,onpicked:function(){}})"/>��
									<input type="text"  v_must=1 v_type="string" v_maxlength="20" name="endDate" id="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,onpicked:function(){}})"/>
								</td>
								<td class="blue">&nbsp;</td>
								<td class="blue">&nbsp;</td>
							</tr>
							<tr>
								<td class="blue" colspan="4" style="text-align:center">
									<input type="button" class="b_foot" value="�� ѯ" onclick="queryMsg()" />
									<input type="button" class="b_foot" value="������Ϣ" onclick="createMsg()" />
								</td>
							</tr>
						</table>
					</div>
					
					<div id="Operation_Table">
						<div class="title">
							<div id="title_zi">							
								<%if("receive".equals(sendType)){%>
									������Ϣ�б�
									<%}else{%> 
									������Ϣ�б�
									<%}%>									
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr>
								<th width="6%">
									<input type="checkbox" name="selAll"  id="selAll"  onclick="setdelSelChecked(this.checked);"/>ȫѡ
								</th>
								<th width="8%">
									��Ϣ���
								</th>
								<th width="8%">
									<%if("receive".equals(sendType)){%>
									������
									<%}else{%> 
									������
									<%}%>
								</th>
								<th width="15%">
									����ʱ��
								</th>
								<th nowrap="nowrap">
									��Ϣ����
								</th>
							</tr>
							<%				
								//��ѯ����
								String countSql = "select to_char(count(*)) from dmessagemng where ";
								
								//��ҳ��ѯ						
								String sql = "select * from (select a.*, rownum id from(select to_char(seq),sender_no,receive_no,mess_type,to_char(send_time,'yyyy-mm-dd HH24:MI:SS'),mess_content,is_read from dmessagemng where ";
								if("receive".equals(sendType)){//��ѯ���յ�����Ϣ����������Ϊ��½����
										countSql +=" receive_no in ('"+workNo+"',substr('"+powerCode+"', 0, length(receive_no))) and ";
										sql +=" receive_no in ('"+workNo+"',substr('"+powerCode+"', 0, length(receive_no)) ) and ";
										if(!"".equals(send_no)){//���յ�����Ϣ���Բ�ѯ������
											countSql +=" sender_no='"+send_no +"' and ";
											sql +=" sender_no='"+send_no +"' and ";
										}
								}else if("send".equals(sendType)){//��ѯ�ҷ��͵���Ϣ����������Ϊ��½����						
									  countSql +=" sender_no='"+workNo+"' and ";
									  sql +=" sender_no='"+workNo+"' and ";
										if(!"".equals(receive_no)){//�ҷ��͵���Ϣ���Բ�ѯ������
											countSql +=" receive_no='"+receive_no +"' and ";
											sql +=" receive_no='"+receive_no +"' and ";
										}
								}
								
								if(!"".equals(msg_type)){
									countSql += " mess_type = '"+msg_type+"' and ";
									sql += " mess_type = '"+msg_type+"' and ";
								}
								if(!"".equals(beginDate)&&!"".equals(endDate)){
									countSql +=" send_time between to_date('"+beginDate+"','yyyy-mm-dd HH24:MI:SS') and to_date('"+endDate+"','yyyy-mm-dd HH24:MI:SS') and ";
									sql +=" send_time between to_date('"+beginDate+"','yyyy-mm-dd HH24:MI:SS') and to_date('"+endDate+"','yyyy-mm-dd HH24:MI:SS') and ";

								}else{
									if(!"".equals(beginDate)){
										countSql +=" send_time = to_date('"+beginDate+"','yyyy-mm-dd HH24:MI:SS') and ";
										sql +=" send_time = to_date('"+beginDate+"','yyyy-mm-dd HH24:MI:SS') and ";
									}else if(!"".equals(endDate)){
										countSql +=" send_time = to_date('"+endDate+"','yyyy-mm-dd HH24:MI:SS') and ";
										sql +=" send_time = to_date('"+endDate+"','yyyy-mm-dd HH24:MI:SS') and ";
									}
								}
								countSql+=" del_flag = '0' and seq not in (select sysmsg_seq from DMESSAGEMNG where sysmsg_no = '"+workNo+"' and mess_type = '0') order by send_time ";
								sql+=" del_flag = '0' and seq not in (select sysmsg_seq from DMESSAGEMNG where sysmsg_no = '"+workNo+"' and mess_type = '0')  order by send_time) a) where id <= " + iEndPos + " and id > " + iStartPos ;
								System.out.println("sql-------->"+sql);
								System.out.println("countSql-------->"+countSql);
							%>
							<wtc:service name="TlsPubSelCrm" outnum="8" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=countSql%>" />						
							</wtc:service>
							<wtc:array id="msgCount" scope="end"/>
									
							<wtc:service name="TlsPubSelCrm" outnum="8" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />						
							</wtc:service>
							<wtc:array id="messageList" scope="end"/>
							<%				
							if("000000".equals(retCode)){ 
									totalNum = messageList.length;
								for(int i=0;i<messageList.length;i++){
									%>
									<tr>
										<td class='blue' align="center"><input type="checkbox" name="delSel" value="<%=messageList[i][0]%>"></td>
										<td class='blue'><%="0".equals(messageList[i][3])?"<span style='color: red;'>ϵͳ��Ϣ</span>":"������Ϣ"%></td>
										<td class='blue'>
										<%
										String msg_workNo = "";
										if("receive".equals(sendType)){
											 msg_workNo = messageList[i][1];
										}else if("send".equals(sendType)){//�ҷ��͵���Ϣ������ϵͳ��Ϣ��ʾ��ɫ����
											if("0".equals(messageList[i][3])){
												String powerSql = " select power_name from spowercodemop where power_code=:power_code ";
												String powerParam = "power_code="+messageList[i][2];
											%>
												<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode %>">
													<wtc:param value="<%=powerSql%>" />	
													<wtc:param value="<%=powerParam%>" />						
												</wtc:service>
												<wtc:array id="powerList" scope="end"/>												
											<%
												if("000000".equals(retCode)){
													if(powerList.length>0){
														msg_workNo = powerList[0][0];
													}
												}
											}else{
											 	msg_workNo = messageList[i][2];
											}
										}											
										%>
											<%=msg_workNo%>&nbsp;
										</td>
										<td class='blue'><%=messageList[i][4]%></td>
										<td class='blue'><%=messageList[i][5]%></td>
	               	</tr>	
									<%
								}
							}
							%>		
							
							<tr>
							<td class='blue' align="center"><input type="button" class="b_text" value="ɾ��" onclick="delMsg()" /></td>
							<td colspan="4">
								
							<%
								int iQuantity = 0;
								if(totalNum>0){
									iQuantity = Integer.parseInt(msgCount[0][0].trim());;
								}
								Page pg = new Page(iPageNumber, iPageSize, iQuantity);
								PageView view = new PageView(request, out, pg);
								view.setVisible(true, true, 0, 0);
							%>
							</td>
				   </tr>	
						</table>					
					
			<%@ include file="/npage/include/footer.jsp"%>
		</form>
	</body>
</html>
