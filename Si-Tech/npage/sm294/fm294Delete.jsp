<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: 2015/07/28 R_CMI_HLJ_guanjg_2015_2350528@���ڹ��ֹ�˾Ϊ�ڶ�������������뿪ͨ���֤ɨ����ʹ��Ȩ�޵���ʾ
   * ����: gejing
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    	String regionCode = (String)session.getAttribute("regCode");
    	String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
    	String iLoginNo = loginNo;
 		String iLoginPwd = noPass;
 		String iOpCode = opCode;
 		String iPhoneNo = phoneNo;
%>

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		function findGroupById(){
			var iGroupId	= $("#groupId").val().trim();			//�������
			if(iGroupId == null || iGroupId == ''){
				rdShowMessageDialog("����д������룡",1);
				return false;
			}else{
				var packet = new AJAXPacket("fm294Query.jsp","���Ժ�...");
				packet.data.add("iLoginAccept" ,"");//��ˮ��������д�������Զ���ȡ
				packet.data.add("iChnSource" ,"01");//������ʶ
				packet.data.add("iOpCode" ,"<%=iOpCode%>");//��������
				packet.data.add("iLoginNo" ,"<%=iLoginNo%>");//��������	
				packet.data.add("iLoginPwd" ,"<%=iLoginPwd%>");//������������
				packet.data.add("iPhoneNo" ,"");//�ֻ�����
				packet.data.add("iUserPwd" ,"");//�û�����
				packet.data.add("iOpNote","��ѯ����");
				packet.data.add("iGroupId" ,iGroupId);//�������
				core.ajax.sendPacket(packet,getGroup,true);//�첽
				packet = null;
			}
			
		}
		
		function getGroup(packet){
			$("#append").remove();
			var vGroupName = packet.data.findValueByName("vGroupName");
			/* var funCodeStr = packet.data.findValueByName("funCodeStr"); */
			var iGroupId = packet.data.findValueByName("iGroupId");
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				if(vGroupName != null && vGroupName != ""){
					$("#tabTr").append("<tr id='append'>"+
														"<td>("+iGroupId+")"+vGroupName+
														"<input type='hidden' id='iGroupId' value='"+iGroupId+"'/>"+
														"</td>"+
														//"<td title='"+funCodeStr+"'>"+funCodeStr+"</td>"+
														"<td><input type='button' value='ɾ��' class='b_text' onclick='deleteGroupFunc("+iGroupId+")'/></td>"
												+"</tr>");
				}else{
					rdShowMessageDialog("������û�����ã�",1);
				}
			}else{
				rdShowMessageDialog(retMsg,1);
			}
		}
		
		function deleteGroupFunc(){
			var iGroupId	= $("#iGroupId").val();			//�������
			
			if(rdShowConfirmDialog('ȷ��Ҫɾ����Ϣ��')==1){
				/*ajax start*/
				var getdataPacket = new AJAXPacket("fm294Submit.jsp","�����ύ���ݣ����Ժ�......");
				getdataPacket.data.add("iLoginAccept" ,"");//��ˮ��������д�������Զ���ȡ
				getdataPacket.data.add("iChnSource" ,"01");//������ʶ
				getdataPacket.data.add("iOpCode" ,"<%=iOpCode%>");//��������
				getdataPacket.data.add("iLoginNo" ,"<%=iLoginNo%>");//��������	
				getdataPacket.data.add("iLoginPwd" ,"<%=iLoginPwd%>");//������������
				getdataPacket.data.add("iPhoneNo" ,"");//�ֻ�����
				getdataPacket.data.add("iUserPwd" ,"");//�û�����
				getdataPacket.data.add("iOpNote","ɾ����������������");//��ע
				getdataPacket.data.add("iGroupId" ,iGroupId);//������� �ش�
				
				core.ajax.sendPacket(getdataPacket,doSuccess,true);
				getdataPacket = null;
			}
			
		}
		
		function doSuccess(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("ɾ���ɹ���",2);
				window.location.reload();
			} else{
				rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
			}
		}
	</script>
</head>
<body>
	<form action="" method="post" name="f1">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<div>
			<table>
				<tr>
					<td class="blue">�������</td>
					<td>
						<input type="text" id="groupId" value="" v_type=string onblur="findGroupById();"/>
					</td>
			    </tr>
		  	</table>
		 </div>
		 
		 <div>
			 <table>
			   <tr>
					<td align=center colspan="4" id="footer"></td>
				</tr>
			</table>
		</div>
		
		 <div>
		 	<table id="tabTr">
		 		<tr>
		 			<th>Ӫҵ������ </th>
		 			<!-- <th>���ܴ���(��������)</th> -->
		 			<th>����</th>
		 		</tr>
		 	</table>
		 </div>
		 
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
</html>
