<%
  /*
   * ����:������������Ч�Ĺ���
   * �汾: 1.0
   * ����: 2012/07/24
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String sWorkNo = (String)session.getAttribute("workNo");
 		String dNopass = (String)session.getAttribute("password");
 		String serverIp=realip.trim();
 		String chnSource="01";
 		String phoneNo = "";
 		String opCode = "e941";
 		String opName = "������������Ч";
 		
%>
<!--ȡ��ˮ�ŷ��� -->
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		String printAccept = seq;
%>
<html>
<head>
	<title>������������Ч</title>
	<script language="javascript">
		
		$(document).ready(function(){
		
		});
		
		function submitt(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("���ϴ�BOSS�����ļ���");
				return false;
			}
			if($("#oaNumber").val()==""){
				rdShowMessageDialog("������OA��ţ�");
				return;
			}
			if($("#oaTitle").val()==""){
				rdShowMessageDialog("������OA���⣡");
				return;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ��BOSS�����ļ���",1);
				document.frm.workNoList.focus();
				return false;
			}
			else
				{
					doajax();
					return true;
				}
			
		}
		
		function doajax()
		{
			var fileName1 = $("input[name='serviceFileName']").val();
			var MydataPacket = new AJAXPacket("/npage/se941/fe941Cfm.jsp","���ڴ���������������Ч�����Ժ�......");
			MydataPacket.data.add("iLoginAccept","0");
			MydataPacket.data.add("iChnSource","<%=chnSource%>");
			MydataPacket.data.add("OpCode","<%=opCode%>");
			MydataPacket.data.add("iLoginNo","<%=sWorkNo%>");
			MydataPacket.data.add("iLoginPwd","<%=dNopass%>");
			MydataPacket.data.add("iPhoneNo","<%=phoneNo%>");
			MydataPacket.data.add("iUserPwd","");
			MydataPacket.data.add("iInputFile",fileName1);
			MydataPacket.data.add("iServerIp","<%=serverIp%>");
			MydataPacket.data.add("iOpNote","������������Ч");
			MydataPacket.data.add("close_reason",$("#close_reason").val());
			MydataPacket.data.add("oaNumber",$("#oaNumber").val());
			MydataPacket.data.add("oaTitle",$("#oaTitle").val());
			core.ajax.sendPacket(MydataPacket);
			MydataPacket = null;
			
		}
		function doProcess(packet){
			//�õ��ɹ�����
			var successNo = packet.data.findValueByName("SuccessNo");
			//�õ�������Ϣ
			var errorMsg = packet.data.findValueByName("ErrorMsg");
			//�õ���Ӧ��ʶ
			var flag = packet.data.findValueByName("Flag");
			//�õ�������
			var all_totalNo = $("input[name='uploadLine']").val();
			//����ʧ������
			var results=all_totalNo-successNo;
			if(flag==0)
			{
				
					//�ɹ�������ӡ
					$("#suc_noinfo").html(successNo+"");
					//ʧ��������ӡ
					$("#err_noinfo").html(results+"");
					$("#sucessMsg").show();
					$("#errorMsg").show();
					//�������ʧ�ܵĹ���
					if(results>0)
					{
						$("#errorbutton").show();
					}
					else 
						{
							$("#errorbutton").hide();
						}
				
			}else{
				rdShowMessageDialog(errorMsg,1);
				return false;
			}

		}
		function uploadWorkNoList(){
			document.frm.target="hidden_frame";
	    document.frm.encoding="multipart/form-data";
	    document.frm.action="fe941_upload.jsp";
	    document.frm.method="post";
	    document.frm.submit();
		}
		function doSetFileName(fileName1,lines){
			$("input[name='serviceFileName']").val(fileName1);
			//�����ϴ�txt�ļ���һ���ж���������
			var arrys = lines.split(",").length-1;
			$("input[name='uploadLine']").val(arrys);
			rdShowMessageDialog("�ϴ��ļ��ɹ���",2);
			$("#oaMsg").show();
			
		}
		//�ϴ�����Ч
		function setdisabled()
		{
			$("#workNoList").attr("disabled","disabled");
			$("#uploadFile").attr("disabled","disabled");
		}
		//�鿴�����ĵ�����
		function seeInformation()
		{
			var filename=$("input[name='printAccept']").val();
			var path = "<%=request.getContextPath()%>/npage/se941/fe941error.jsp?fileName="+filename+".txt";
			window.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		}
	</script>
	</head>
<body>
	<form action="" method="post" name="frm">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">������������Ч</div>
	</div>
	<table>
			<tr>
				<td width="18%" class="blue">
					�������ŵ���
				</td>
				<td>
					<input type="file" name="workNoList" id="workNoList" class="button"
					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
					&nbsp;&nbsp;
					<input type="button" name="uploadFile" id="uploadFile" class="b_text" value="�ϴ�" onclick="uploadWorkNoList();"/>
				</td>
			</tr>
		<tr>
			<td class="blue">��ͣԭ��</td>
			<td>
				<select id="close_reason">
					<option value="1">Υ��</option>
					<option value="2">ͣҵ</option>
					<option value="3">����</option>
					<option value="4">����</option>
				</select>
			</td>
		</tr>
			<tr>
				<td class="blue">
					�ļ���ʽ˵��
				</td>
        <td> 
            �ϴ��ļ��ı���ʽΪ������+�س�������ʾ�����£�<br>
            <font class='orange'>
            	&nbsp;&nbsp; aaa457<br/>
            	&nbsp;&nbsp; aaa889<br/>
            	&nbsp;&nbsp; aacv02<br/>
            	&nbsp;&nbsp; an1051<br/>
            	&nbsp;&nbsp; an1053<br/>
            	&nbsp;&nbsp; ab1204
            </font>
            <b>
            <br>&nbsp;&nbsp; ע����ʽ�е�ÿһ�����������ڿո�,��ÿ�����Ŷ���Ҫ�س����С�
            </b> 
        </td>
	    </tr>
		</table>
		
		<table id="sucessMsg" cellSpacing=0 style="display:none">
					<tr>
						<td class="blue" width="18%">
							�ɹ�����
						</td>
						<td id="suc_noinfo">
							
						</td>
					</tr>
			</table>
			<table id="errorMsg" cellSpacing=0 style="display:none">
					<tr>
						<td class="blue" width="18%">
							ʧ�ܸ���
						</td>
						<td id="err_noinfo">
							
						</td>
						<td id="errorbutton">
							<input class="b_foot_long" name="seeInfo" type="button" value="ʧ����Ϣ�鿴" onClick="seeInformation()">
						</td>
					</tr>
			</table>
			<table id="oaMsg" cellSpacing=0 style="display:none">
					<tr>
						<td class="blue">&nbsp;OA���</td>
						<td><input type="text" id="oaNumber" name="oaNumber" maxlength="30"/></td>
					</tr>
					<tr>
						<td class="blue">&nbsp;OA����</td>
						<td><input type="text" id="oaTitle" name="oaTitle" maxlength="30"/></td>
					</tr>
			</table>
		<table  cellSpacing=0>
				<tbody>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="ȷ��" onclick="submitt()" id="Button1">&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="���" onclick="javascript:window.location.href='/npage/se941/fe941.jsp'" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=�ر� id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
				</tbody>
			</table>
			<!--��ˮ�� -->
			<input type="hidden" name="printAccept" value="<%=printAccept%>">		
			<!--�ϴ��ļ�ȫ·���� -->	
			<input type="hidden" name="serviceFileName" value=""/>
			<!--�ϴ����ܹ��Ÿ��� -->
			<input type="hidden" name="uploadLine" value=""/>
			<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>