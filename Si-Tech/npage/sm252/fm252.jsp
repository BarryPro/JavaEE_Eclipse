 <%
	/********************
	 version v2.0
	������: si-tech
	update:2015/3/26 17:09:31 ningtn
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


%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />
	
<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
		<script language="JavaScript">
			var china=new Array('������','�Ϻ���','�����','������','�ӱ�ʡ','ɽ��ʡ','����ʡ','����ʡ','������ʡ','����ʡ','�㽭ʡ','����ʡ','����ʡ','����ʡ','ɽ��ʡ','����ʡ','����ʡ','����ʡ','�㶫ʡ','����ʡ','�Ĵ�ʡ','����ʡ','����ʡ','����ʡ','����ʡ','�ຣʡ','̨��ʡ','����׳��������','���ɹ�������','����������','���Ļ���������','�½�ά���������','����ر�������');
			var oldCard,newCard = "";
			$(document).ready(function(){
				$(":radio").click(function(){
					var cardType = $(this).val();
					if(cardType == "dis"){
						$("#con").hide();
						$("#dis").show();
					}else if(cardType == "con"){
						$("#dis").hide();
						$("#con").show();
					}
				});
				
				$("#clearBtn").click(function(){doclear();});
				
				$("#cfm").click(function(){
					if(!checkForm()){
						return false;
					}
					
					var cardType = $('input[@name=cardType][@checked]').val();
					
					var input21 = "";
					if(cardType == "dis"){
						oldCard = oldCard.substring(0,oldCard.length - 1);
						newCard = newCard.substring(0,newCard.length - 1);
						input21 = "0";
					}else if(cardType == "con"){
						oldCard = $("#oldCardBegin").val() + "|" + $("#oldCardEnd").val();
						newCard = $("#newCardBegin").val() + "|" + $("#newCardEnd").val();
						input21 = "1";
					}
					
					/*�����ύ����*/
					var getdataPacket = new AJAXPacket("/npage/sm252/fm252Cfm.jsp","���ڻ�����ݣ����Ժ�......");
					getdataPacket.data.add("serviceName","sm252Cfm");
					getdataPacket.data.add("outnum","0");
					getdataPacket.data.add("inputParamsLength","22");
					getdataPacket.data.add("inParams0",$("#sysAccept").val());
					getdataPacket.data.add("inParams1","01");
					getdataPacket.data.add("inParams2","<%=opCode%>");
					getdataPacket.data.add("inParams3","<%=workno%>");
					getdataPacket.data.add("inParams4","<%=noPass%>");
					getdataPacket.data.add("inParams5","");
					getdataPacket.data.add("inParams6","");
					/*�ɿ�*/
					getdataPacket.data.add("inParams7",oldCard);
					/*�¿�*/
					getdataPacket.data.add("inParams8",newCard);
					getdataPacket.data.add("inParams9",$("#isUse").val());
					getdataPacket.data.add("inParams10",$("#isOpen").val());
					getdataPacket.data.add("inParams11",$("#complaintAccept").val());
					getdataPacket.data.add("inParams12",$("#compName").val());
					getdataPacket.data.add("inParams13",$("#orderNo").val());
					getdataPacket.data.add("inParams14",$("#postage").val());
					getdataPacket.data.add("inParams15",$("#prov").val());
					getdataPacket.data.add("inParams16",$("#contactName").val());
					getdataPacket.data.add("inParams17",$("#contactPhoneNo").val());
					getdataPacket.data.add("inParams18",$("#cardNo").val());
					getdataPacket.data.add("inParams19",$("#receiveDate").val());
					getdataPacket.data.add("inParams20",$("#remark").val());
					getdataPacket.data.add("inParams21",input21);
					core.ajax.sendPacket(getdataPacket,doCfmBack);
					getdataPacket = null;
					
				});
				
				function doCfmBack(packet){
		      var retcode = packet.data.findValueByName("retcode");
		      var retmsg = packet.data.findValueByName("retmsg");
		      if(retcode == "000000"){
		        rdShowMessageDialog("�����ɹ�",2);
		      }else{
		      	rdShowMessageDialog("�ύʧ�ܣ�������룺" + retcode + "��������Ϣ��" + retmsg,0);
		      }
		      doclear();
		    }
		    
		    function doclear(){
		    	window.location.href = "fm252.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		    }
				
				function checkForm(){
					/****/
					if(!check(document.frm)){
						return false;
					}
					
					var cardType = $('input[@name=cardType][@checked]').val();
					if(cardType == "dis"){
						//��ɢ��������дһ��
						oldCard = "";
						newCard = "";
						var chkFlag = true;
						var len = 0;
						$("#dis").find("tr:gt(0)").each(function(i,n){
							var f = $.trim($(this).find(":input:eq(0)").val());
							var s = $.trim($(this).find(":input:eq(1)").val());
							
							if((f != "" && s == "") || (f == "" && s != "")){
								chkFlag = false;
								rdShowMessageDialog("��" + (i+1) + "�е��¾ɿ��ű���Ҫһһ��Ӧ��",0);
								return false;
							}else if(f != "" && s != ""){
								len++;
								var reg = new RegExp("^[0-9]+$");
					    	if(!reg.test(f)){
					    		chkFlag = false;
					      	rdShowMessageDialog("��" + (i+1) + "�оɿ�������������!",0);
					    	}
					    	if(!reg.test(s)){
					    		chkFlag = false;
					      	rdShowMessageDialog("��" + (i+1) + "���¿�������������!",0);
					    	}
					    	if(chkFlag){
					    		//û����
					    		oldCard += f + "|";
					    		newCard += s + "|";
					    	}
							}
						});
						
						if(chkFlag && len == 0){
							chkFlag = false;
							rdShowMessageDialog("����������һ���¾ɿ��š�",0);
							return false;
						}
						if(!chkFlag){
							return false;
						}
					}else if(cardType == "con"){
						var chkFlag = true;
						//�������ĸ��򶼱�����д����������һ�¡�
						var oldCardBegin 	= $("#oldCardBegin").val();
						var oldCardEnd 		= $("#oldCardEnd").val();
						var newCardBegin 	= $("#newCardBegin").val();
						var newCardEnd 		= $("#newCardEnd").val();
						var reg = new RegExp("^[0-9]+$");
						
						if(!reg.test(oldCardBegin)){
							chkFlag = false;
							rdShowMessageDialog("�ɿ�ʼ��������������!",0);
						}else if(!reg.test(oldCardEnd)){
							chkFlag = false;
							rdShowMessageDialog("�ɽ�����������������!",0);
						}else if(!reg.test(newCardBegin)){
							chkFlag = false;
							rdShowMessageDialog("�¿�ʼ��������������!",0);
						}else if(!reg.test(newCardEnd)){
							chkFlag = false;
							rdShowMessageDialog("�½�����������������!",0);
						}
						
						if(!chkFlag){
							return false;
						}
					}
					
					return true;
				}
			});
		</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="frm" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="sysAccept" id="sysAccept" value="<%=sysAccept%>"> 
	
	<table cellspacing="0">
		<tr>
			<td class="blue">�ɿ��Ƿ�ο�</td>
			<td>
				<select id="isOpen">
					<option value="0">δ��</option>
					<option value="1">�ѹ�</option>
				</select>
				<font class=orange>*</font>
			</td>
			<td class="blue">�ɿ��Ƿ��ֵ</td>
			<td>
				<select id="isUse">
					<option value="1">�ѳ�</option>
					<option value="0">δ��</option>
				</select>
				<font class=orange>*</font>
			</td>
			<td class="blue">Ͷ����ˮ��</td>
			<td>
				<input type="text" id="complaintAccept" maxlength="20" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">��ʡ�ʼĶ�����</td>
			<td>
				<input type="text" id="orderNo" maxlength="32" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
			<td class="blue">��ʡ������˾����</td>
			<td>
				<input type="text" id="compName" maxlength="256" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
			<td class="blue">�ʷ�</td>
			<td>
				<input type="text" id="postage" maxlength="10" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">�Զ�ʡ</td>
			<td>
				<select id="prov">
					<option value ="������">������ </option>
					<option value ="�����">����� </option>
					<option value ="�Ϻ���">�Ϻ��� </option>
					<option value ="������">������ </option>
					<option value ="�ӱ�ʡ">�ӱ�ʡ </option>
					<option value ="ɽ��ʡ">ɽ��ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<!--<option value ="������ʡ">������ʡ</option>-->
					<option value ="����ʡ"> ����ʡ </option>
					<option value ="�㽭ʡ">�㽭ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="ɽ��ʡ">ɽ��ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="�㶫ʡ">�㶫ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="�Ĵ�ʡ">�Ĵ�ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="����ʡ">����ʡ </option>
					<option value ="�ຣʡ">�ຣʡ </option>
					<option value ="̨��ʡ">̨��ʡ </option>
					<option value ="����׳��������">����׳��������</option>
					<option value ="���ɹ�������"> ���ɹ�������</option>
					<option value ="����������"> ����������</option>
					<option value ="���Ļ���������"> ���Ļ��������� </option>
					<option value ="�½�ά���������">�½�ά���������</option>
					<option value ="����ر�������">����ر�������</option>
					<option value ="�����ر�������">�����ر�������</option>
				</select>
				<font class=orange>*</font>
			</td>
			<td class="blue">��ϵ������</td>
			<td>
				<input type="text" id="contactName" maxlength="60"
						v_type="string" onblur="checkElement(this)"/>
			</td>
			<td class="blue">��ϵ�˵绰</td>
			<td>
				<input type="text" id="contactPhoneNo" maxlength="15"
						v_type="string" onblur="checkElement(this)"/>
			</td>
		</tr>
		<tr>
			<td class="blue">֤������</td>
			<td>
				<input id="cardNo" type="text" maxlength="30"/>
			</td>
			<td class="blue">��������</td>
			<td colspan="3">
				<input type="text" id="receiveDate" v_must="1"
					onClick="WdatePicker({startDate:'%y%M%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true,maxDate:'%y-%M-%d'})"/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">��ע</td>
			<td colspan="5">
				<input type="text" id="remark" maxlength="200" size="100"
						v_type="string" onblur="checkElement(this)"/>
			</td>
		</tr>
	</table>
</div>

<div id="Operation_Table">
	<div class="title">
		<div id="title_zi">������Ϣ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">����</td>
			<td>
				<label for="radioA">
					<input type="radio" id="radioA" value="dis" name="cardType" checked/>��ɢ����
				</label>
				&nbsp;&nbsp;
				<label for="radioB">
					<input type="radio" id="radioB" value="con" name="cardType"/>��������
				</label>
			</td>
		</tr>
		<tbody id="dis">
		<tr>
			<th>�ɿ�����</th>
			<th>�¿�����</th>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
			<td><input type="text" size="30" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<!---->
		</tbody>
		<tbody id="con" style="display:none;">
		<tr>
			<td class="blue">�ɿ�ʼ���� ~ �ɽ�������</td>
			<td><input type="text" size="30" id="oldCardBegin" maxlength="32"/> ~ <input type="text" size="30" id="oldCardEnd" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		<tr>
			<td class="blue">�¿�ʼ���� ~ �½�������</td>
			<td><input type="text" size="30" id="newCardBegin" maxlength="32"/> ~ <input type="text" size="30" id="newCardEnd" maxlength="32"/><font class=orange>*</font></td>
		</tr>
		</tbody>
	</table>
	<table cellspacing="0">
		<tr>
			<td id="footer" colspan="6">
			<input  name="cfm" id="cfm" class="b_foot" type="button" value="ȷ��">
			&nbsp;
			<input  name="clear" id="clearBtn" class="b_foot" type="button" value="����" />
			&nbsp;                  			
			</td>
		</tr>
	</table>
	
	
	<%@ include file="/npage/include/footer.jsp" %>
	</FORM>
</BODY>
</HTML> 