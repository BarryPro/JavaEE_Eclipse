
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ��ʡ�û�����ʡ����Ϣ��¼
�� * �汾: v1.0
�� * ����: 2015/4/2 14:50:54
�� * ����: ningtn
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
			<%@ page contentType= "text/html;charset=gb2312" %>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
			response.setHeader("Pragma","No-Cache"); 
			response.setHeader("Cache-Control","No-Cache");
			response.setDateHeader("Expires", 0); 
			
			String opCode = "m253";
			String opName = "��ʡ�û�����ʡ����Ϣ��¼";
			
			String regionCode = (String)session.getAttribute("regCode");
			String workno = (String)session.getAttribute("workNo");
			String noPass = (String)session.getAttribute("password");
			
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />
<html>
	<head>
	<title>��ʡ�û�����ʡ����Ϣ��¼</title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript">
		<!--
			
			$(document).ready(function(){
				
				var winObj = window.dialogArguments;
				var oldCardNo 		= winObj.oldCardNo;
				var compName			= winObj.compName;
				var orderNo				= winObj.orderNo;
				var addr					= winObj.addr;
				var reviceDate		= winObj.reviceDate;
				var phoneDate			= winObj.phoneDate;
				var activateDate	= winObj.activateDate;
				
				if(typeof(compName) != "undefined" && compName != "-"){
					$("#compName").val(compName);
					$("#compName").attr("readonly","readonly").addClass("InputGrey");
				}
				if(typeof(orderNo) != "undefined" && orderNo != "-"){
					$("#orderNo").val(orderNo);
					$("#orderNo").attr("readonly","readonly").addClass("InputGrey");
				}
				if(typeof(addr) != "undefined" && addr != "-"){
					$("#addr").val(addr);
					$("#addr").attr("readonly","readonly").addClass("InputGrey");
				}
				if(typeof(reviceDate) != "undefined" && reviceDate != "-"){
					$("#reviceDate").val(reviceDate);
					$("#reviceDate").attr("readonly","readonly").addClass("InputGrey");
				}
				if(typeof(phoneDate) != "undefined" && phoneDate != "-"){
					$("#phoneDate").val(phoneDate);
					$("#phoneDate").attr("readonly","readonly").addClass("InputGrey");
				}
				if(typeof(activateDate) != "undefined" && activateDate != "-"){
					$("#activateDate").val(activateDate);
					$("#activateDate").attr("readonly","readonly").addClass("InputGrey");
				}
				
				
				$("#confirmButton").click(function(){
					var cardStatus 	= $.trim($("#status").val());
					var compName 		= $.trim($("#compName").val());
					var orderNo 		= $.trim($("#orderNo").val());
					var addr 				= $.trim($("#addr").val());
					var reviceDate 	= $.trim($("#reviceDate").val());
					var phoneDate 	= $.trim($("#phoneDate").val());
					var activateDate 	= $.trim($("#activateDate").val());
					
					if(compName == ""
							&& orderNo == ""
							&& addr == ""
							&& reviceDate == ""
							&& phoneDate == ""
							&& activateDate == ""){
							rdShowMessageDialog("��������дһ����Ϣ",1);
							return false;
					}
					
					//��д���мۿ�����ʱ�䡱 ���붼��д��״ֻ̬���������
					if(activateDate != ""){
						if(cardStatus == "1"){
							rdShowMessageDialog("��д���мۿ�����ʱ�䡱 ������״ֻ̬���������",1);
							return false;
						}
						if(compName == ""
							|| orderNo == ""
							|| addr == ""
							|| reviceDate == ""
							|| phoneDate == ""
							|| activateDate == ""){
							rdShowMessageDialog("��д���мۿ�����ʱ�䡱��������Ϣ������Ϊ�ա�",1);
							return false;
					}
					}
					
					var getdataPacket = new AJAXPacket("/npage/sm252/fm253Cfm.jsp","���ڻ�����ݣ����Ժ�......");
					getdataPacket.data.add("serviceName","sm253Cfm");
					getdataPacket.data.add("outnum","0");
					getdataPacket.data.add("inputParamsLength","15");
					getdataPacket.data.add("inParams0",$("#sysAccept").val());
					getdataPacket.data.add("inParams1","01");
					getdataPacket.data.add("inParams2","<%=opCode%>");
					getdataPacket.data.add("inParams3","<%=workno%>");
					getdataPacket.data.add("inParams4","<%=noPass%>");
					getdataPacket.data.add("inParams5","");
					getdataPacket.data.add("inParams6","");
					getdataPacket.data.add("inParams7",oldCardNo);
					getdataPacket.data.add("inParams8",cardStatus);
					getdataPacket.data.add("inParams9",compName);
					getdataPacket.data.add("inParams10",orderNo);
					getdataPacket.data.add("inParams11",addr);
					getdataPacket.data.add("inParams12",reviceDate);
					getdataPacket.data.add("inParams13",phoneDate);
					getdataPacket.data.add("inParams14",activateDate);
					core.ajax.sendPacket(getdataPacket,doCfmBack);
					getdataPacket = null;
					
				});
				
				
				$("#closeButton").click(function(){
					goBack(0);
				});
				
			});
			
			function doCfmBack(packet){
		      var retcode = packet.data.findValueByName("retcode");
		      var retmsg = packet.data.findValueByName("retmsg");
		      if(retcode == "000000"){
		        rdShowMessageDialog("�����ɹ�",2);
		        goBack(1);
		      }else{
		      	rdShowMessageDialog("��ѯʧ�ܣ�������룺" + retcode + "��������Ϣ��" + retmsg,0);
		      	return false;
		      }
			}
			
			function goBack(s){
				if(s == 1){
					window.returnValue="1";
				}else{
					window.returnValue="0";
				}
				window.close();
			}
			
		//-->
	</script>
</head>
<body>
		<%@ include file="/npage/include/header_pop.jsp" %>
		<input type="hidden" name="sysAccept" id="sysAccept" value="<%=sysAccept%>"> 
     <table cellspacing="0">
     	<tr>
	  		<td class="blue">����״̬</td>
	  		<td colspan="3">
	  			<select id="status">
						<option value="1">�ʼ���</option>
						<option value="2">�����</option>
					</select>
				</td>
	  	</tr>
			<tr>
	  		<td class="blue">������˾</td>
	  		<td>
	  			<input type="text" id="compName" maxlength="256" v_must="1" 
							v_type="string" onblur="checkElement(this)"/>
				</td>
	  		<td class="blue">�ʼĶ�����</td>
	  		<td>
	  			<input type="text" id="orderNo" maxlength="32" v_must="1" 
							v_type="string" onblur="checkElement(this)"/>
	  		</td>
	  	</tr>
	  	
	  	<tr>
	  		<td class="blue">�ʼĵ�ַ</td>
	  		<td>
	  			<input type="text" id="addr" maxlength="256" v_must="1" 
							v_type="string" onblur="checkElement(this)"/>
				</td>
	  		<td class="blue">�ͻ�ǩ��ʱ��</td>
	  		<td>
	  			<input type="text" id="reviceDate" v_must="1" 
	  				onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true,maxDate:'%y-%M-%d'})"/>
	  		</td>
	  	</tr>
	  	
	  	<tr>
	  		<td class="blue">�绰�ظ�ʱ��</td>
	  		<td>
	  			<input type="text" id="phoneDate" v_must="1" 
	  				onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true,maxDate:'%y-%M-%d'})"/>
				</td>
	  		<td class="blue">�мۿ�����ʱ��</td>
	  		<td>
	  			<input type="text" id="activateDate" v_must="1" 
	  				onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true,maxDate:'%y-%M-%d'})"/>
	  		</td>
	  	</tr>
		</table>
		<table cellspacing="0">
			<tr> 
				<td id="footer"> 
					<input type="button" id="confirmButton" class="b_foot" value="ȷ��" />&nbsp;
					<input type="button" id="closeButton" class="b_foot" value="�ر�" />&nbsp;
				</td>
			</tr>
		</table>
 	<%@ include file="/npage/include/footer_pop.jsp" %>
</body>
</html>    		

 
