 <%
	/********************
	 version v2.0 ���ڿ�����̬��֤�빦�ܲ�������ĺ�
	������: si-tech
	update:2015/06/02 16:15:21 gaopeng
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode=request.getParameter("opCode");	
		String opName=request.getParameter("opName");

	String workno = (String)session.getAttribute("workNo");
	String regioncode=(String)session.getAttribute("regCode");
	String noPass = (String)session.getAttribute("password");
	String orgcode = (String)session.getAttribute("orgCode");
  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String regionCode= (String)session.getAttribute("regCode");
	String ipAddr = (String)session.getAttribute("ipAddr");
	
%>


<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />

<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="JavaScript">
		/*�ϴ���־*/
		var uploadFlag = false;
		
		$(document).ready(function(){
		
		});
		function doCommit()
		{
			
			var inputSel = $.trim($("input[name='radioSel']").val());
			
			
			if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
			{
				/*�ύ*/
				formConfirm();
			}
			
		}
		
		function formConfirm(){
			
			var inputSel = $.trim($("input[name='radioSel']").val());
			var infoArray = new Array();
			infoArray = inputSel.split("|");
			
			
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm266/fm266Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=sysAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=workno%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo =  $.trim($("#iPhoneNo").val());
			var iUserPwd = "";
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			getdataPacket.data.add("iSimNo",infoArray[0]);
			getdataPacket.data.add("iHlrCode","");
			getdataPacket.data.add("iSimType","");
			getdataPacket.data.add("opNote","<%=workno%>����4G����¼�����");
			
			
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			if(retCode == "000000"){
				
				rdShowMessageDialog("�����ɹ���",2);
				doclear();
				
			}else{
				
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				doclear();
				
			}
			
		}

function doclear(){
	window.location.reload();	
}

function doQry(){
			
		
			var iPhoneNo = $.trim($("#iPhoneNo").val());
			if(iPhoneNo.length == 0){
				rdShowMessageDialog("�������ֻ����룡");
				return false;
			}
			
			var iLoginAccept = "<%=sysAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=workno%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = iPhoneNo;
			var iUserPwd = "";
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm266/fm266Qry.jsp","���ڻ�����ݣ����Ժ�......");
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			
			core.ajax.sendPacket(getdataPacket,doRetQry);
			getdataPacket = null;
		}
		
		function doRetQry(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var retArray = packet.data.findValueByName("retArray");
			
			var trObjdStr = "";
			
			
			if(retCode == "000000"){
				//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
				$("#upgMainTab tr:gt(0)").remove();
				
				for(var i=0;i<retArray.length;i++){
						var inputStr = "<input type='hidden' name='radioSel' value='"+retArray[i][0]+"|"+retArray[i][2]+"|"+retArray[i][3]+"'/>";
						trObjdStr += "<tr>"+
													 "<td>"+retArray[i][0]+inputStr+"</td>"+  
													 "<td>"+retArray[i][2]+"</td>"+  
													 "<td>"+retArray[i][3]+"</td>"+ 
											 "</tr>";
				}
				//��ƴ�ӵ��ж�̬��ӵ�table��
				$("#upgMainTab tr:eq(0)").after(trObjdStr);
				
				$("#iPhoneNo").attr("readonly","readonly");
				$("#iPhoneNo").attr("class","InputGrey");
				$("#qryUnitBtn").attr("disabled","disabled");
				$("#quchoose").attr("disabled","");
				
			}else{
				rdShowMessageDialog("������룺"+retCode+"��������Ϣ��"+retMsg,0);
				
				$("#iPhoneNo").attr("readonly","");
				$("#iPhoneNo").attr("class","");
				$("#qryUnitBtn").attr("disabled","");
				$("#quchoose").attr("disabled","disabled");
				return false;
				
			}
			
			
		}
	
	</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="frm" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
				<table cellspacing="0">
			    <tr>
			  		<td width="20%" class="blue">�ֻ�����</td>
			  		<td width="30%">
			  			<input type="text" id="iPhoneNo" name="iPhoneNo"  maxlength="11" value="" />&nbsp;&nbsp;
			  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="��ѯ" onclick="doQry();"/>
			  		</td>
			    </tr>
	  		</table>   
	  		<div class="title">
					<div id="title_zi">4G������Ϣ</div>
				</div>   	
	  		<table cellSpacing="0" id="upgMainTab">
			    <tr>
			    		
			        <th width="31%">SIM����</th>
			        <th width="31%">����ʱ��</th>
			        <th width="30%">��������</th>
			    </tr>
				</table>
     
             <table cellspacing="0">
              	<tbody>
              		<tr>
                		<td id="footer">
                        <input  name="quchoose" id="quchoose" class="b_foot" type="button" value="ȷ��"  onclick="doCommit();" disabled>
                        &nbsp;
                      	<input  name="clear" class="b_foot" type=reset value="����" onclick="doclear()">
                      	&nbsp;                  			

                		</td>
              		</tr>
              </tbody>
            </table>
      
	     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

