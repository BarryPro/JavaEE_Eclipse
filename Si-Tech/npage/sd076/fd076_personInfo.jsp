<%
  /*
   * ����: ����ͨ��ԭ���������˷�����������ҵ��
   * �汾: 2.0
   * ����: 2011/1/5
   * ����: weigp
   * ��Ȩ: si-tech
   * update: wanglma 
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = "d076";
  String opName = "����ͨҵ��";
  String method = request.getParameter("method");
  String tabData = (request.getParameter("tabData")==null)?"":request.getParameter("tabData");
  /*
  	addRela
  	addFirst
  	addFrid
  	addNaber
  */
%>
<head>
<title>��Ȩ��λ����Ϣ</title>
<script type="text/javascript">
	$(document).ready(function(){
		if("<%=method%>" == "addRela"){
			$("#div1").css("display","block");
			$("#title_zi").text("��Ȩ��λ����Ϣ");
			$("#title_zi1").text("��Ȩ��λ�˶����˶�λ�����Ƿ���Ч�����˶���ȷ�ϻظ����Ϊ׼.");
			if("<%=tabData%>" != ""){
				var tabData = "<%=tabData%>";
				var dataArr = tabData.split("-");
				var relaName = dataArr[0];
				var relaRelation = dataArr[1];
				var relaMobilephone = dataArr[2];
				var relaTelphone = dataArr[3];
				var relaAddress = dataArr[4];
				var relaComPanyTel = dataArr[5];
				var relaCompanyAddr = dataArr[6];
				$("#relaName").val(relaName);
				$("#relaRelation").val(relaRelation);
				$("#relaMobilephone").val(relaMobilephone);
				$("#relaTelphone").val(relaTelphone);
				$("#relaAddress").val(relaAddress);
				$("#relaComPanyTel").val(relaComPanyTel);
				$("#relaCompanyAddr").val(relaCompanyAddr);
			}
		}else if("<%=method%>" == "addFirst"){
			$("#div2").css("display","block");
			$("#title_zi").text("��һ��ϵ����Ϣ");
			document.title="��һ��ϵ����Ϣ";
			if("<%=tabData%>" != ""){
				var tabData = "<%=tabData%>";
				var dataArr = tabData.split("-");
				var firstName = dataArr[0];
				var firstRelation = dataArr[1];
				var firstMobilephone = dataArr[2];
				var firstTelphone = dataArr[3];
				var firstAddress = dataArr[4];
				var firstPropAddr = dataArr[5];
				var firstCompanyTel = dataArr[6];
				var firstCompanyAddr = dataArr[7];
				$("#firstName").val(firstName);
				$("#firstRelation").val(firstRelation);
				$("#firstMobilephone").val(firstMobilephone);
				$("#firstTelphone").val(firstTelphone);
				$("#firstAddress").val(firstAddress);
				$("#firstPropAddr").val(firstPropAddr);
				$("#firstCompanyTel").val(firstCompanyTel);
				$("#firstCompanyAddr").val(firstCompanyAddr);
			}
		}else if("<%=method%>" == "addFrid"){
			$("#div3").css("display","block");
			$("#title_zi").text("������Ϣ");
			document.title="������Ϣ";
			if("<%=tabData%>" != ""){
				var tabData = "<%=tabData%>";
				var dataArr = tabData.split("-");
				var secondName = dataArr[0];
				var secondRelation = dataArr[1];
				var secondTelphone = dataArr[2];
				var secondMobilephone = dataArr[3];
				var secondPropAddr = dataArr[4];
				$("#secondName").val(secondName);
				$("#secondRelation").val(secondRelation);
				$("#secondTelphone").val(secondTelphone);
				$("#secondMobilephone").val(secondMobilephone);
				$("#secondPropAddr").val(secondPropAddr);
			}
		}else if("<%=method%>" == "addNaber"){
			$("#div4").css("display","block");
			$("#title_zi").text("�ھ���Ϣ");
			document.title="�ھ���Ϣ";
			if("<%=tabData%>" != ""){
				var tabData = "<%=tabData%>";
				var dataArr = tabData.split("-");
				var neighborName = dataArr[0];
				var neighborTelphone = dataArr[1];
				var neighborMobilephone = dataArr[2];
				var neighborPropAddr = dataArr[3];
				$("#neighborName").val(neighborName);
				$("#neighborTelphone").val(neighborTelphone);
				$("#neighborMobilephone").val(neighborMobilephone);
				$("#neighborPropAddr").val(neighborPropAddr);
			}
		}
		//���������Ϣ
		$("#btn1").click(function(){
			if(check(frm1)){
				//if($("#relaName").val()== "" || $("#relaRelation").val() == "" || $("#relaMobilephone").val()== "" || $("#relaTelphone").val()==""|| $("#relaAddress").val()==""|| $("#relaComPanyTel").val()==""||$("#relaCompanyAddr").val()==""){
				if($("#relaName").val()== "" || $("#relaMobilephone").val()== ""){
					rdShowMessageDialog("������������������Ϣ��");
					return;
				}
				validateCustInfo($("#relaName").val(),$("#relaMobilephone").val(),"btn1");
				
			}
		});
		//��ӵ�һ��ϵ����Ϣ
		$("#btn2").click(function(){
			if(check(frm1)){
				/*ningtn ����Э����������ͨABC�ײ͵ĺ� (��������)*/
				if($("#firstName").val()==""||$("#firstMobilephone").val()==""){
					rdShowMessageDialog("�����������ĵ�һ��ϵ����Ϣ��");
					return;
				}
				validateCustInfo($("#firstName").val(),$("#firstMobilephone").val(),"btn2");
				
			}
		});
		//���������ϵ��
		$("#btn3").click(function(){
			if(check(frm1)){
				if($("#secondName").val()==""||$("#secondMobilephone").val() ==""){
					rdShowMessageDialog("������������������Ϣ��");
					return;
				}
				validateCustInfo($("#secondName").val(),$("#secondMobilephone").val(),"btn3");
				
			}
		});
		//����ھ���ϵ��
		$("#btn4").click(function(){
			if(check(frm1)){
				if($("#neighborName").val()==""||$("#neighborTelphone").val()==""||$("#neighborMobilephone").val()==""||$("#neighborPropAddr").val()==""){
					rdShowMessageDialog("�������������ھ���Ϣ��");
					return;
				}
				validateCustInfo($("#neighborName").val(),$("#neighborMobilephone").val(),"btn4");
				
			}
		});
	});
	
	function validateCustInfo(custName,custMobilePhone,but)
	{	
				var packet = new AJAXPacket("fd076_validateCustInfo.jsp","������֤�ͻ���Ϣ�����Ժ�......");
			  packet.data.add("custName",custName);
			  packet.data.add("custMobilePhone",custMobilePhone);
			  packet.data.add("but",but);
			  core.ajax.sendPacket(packet,doValidateCustInfo,false);
			  packet = null;			

	}
	
	function doValidateCustInfo(packet){
	  var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    if (retCode != "000000")
    {
    	rdShowMessageDialog("������Ϣ��"+retMsg+"��������룺"+retCode+"��",2);
    	return ;
	  }else{
			    var result_long = packet.data.findValueByName("result_long");
			    if(result_long!="0")
			    {
			    	var but = packet.data.findValueByName("but");	
			    	if(but=="btn1")
			    	{
			    		var tab1 = window.opener.document.getElementById("tab1");
							var tabData = "";
							tabData += $("#relaName").val()+"|";
							tabData += $("#relaRelation").val()+"|";
							tabData += $("#relaMobilephone").val()+"|";
							tabData += $("#relaTelphone").val()+"|";
							tabData += $("#relaAddress").val()+"|";
							tabData += $("#relaComPanyTel").val()+"|";
							tabData += $("#relaCompanyAddr").val()+"|";
							tabData += "δ��Ч"+"|";
							/*�����޸İ�ť
							var dataInfo = tabData;
							dataInfo = dataInfo.replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-");
							tabData += "<input type='button' class='b_text' value='�޸�' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode),window.open(\"fd076_personInfo.jsp?method=addRela&tabData="+dataInfo+"\",\"������Ϣ\",\"width=400,height=300,left=400,top=200\");'/>";
							*/
							tabData += "<input type='button' class='b_text' value='ɾ��' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode)'/>";
							window.opener.addTr(tab1,9,tabData);
							window.close();
			    	}else if(but=="btn2")
			    		{
			    			var tab2 = window.opener.document.getElementById("tab2");
								var tabData = "";
								tabData += $("#firstName").val()+"|";
								tabData += $("#firstRelation").val()+"|";
								tabData += $("#firstMobilephone").val()+"|";
								tabData += $("#firstTelphone").val()+"|";
								tabData += $("#firstAddress").val()+"|";
								/*tabData += $("#firstPropAddr").val()+"|";*/
								if($("#firstPropAddr").val() == "0"){
									tabData += "��"+"|";
								}else if($("#firstPropAddr").val() == "1"){
									tabData += "��"+"|";
								}
								tabData += $("#firstCompanyTel").val()+"|";
								tabData += $("#firstCompanyAddr").val()+"|";
								tabData += "δ��Ч"+"|";
								/*var dataInfo = tabData;
								dataInfo = dataInfo.replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-");
								tabData += "<input type='button' class='b_text' value='�޸�' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode),window.open(\"fd076_personInfo.jsp?method=addFirst&tabData="+dataInfo+"\",\"��һ��ϵ����Ϣ\",\"width=400,height=330,left=400,top=200\");'/>";
								*/
								tabData += "<input type='button' class='b_text' value='ɾ��' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode)'/>";
								window.opener.addTr(tab2,10,tabData);
								window.close();
			    		}else if(but=="btn3")
			    			{
			    				var tab3 = window.opener.document.getElementById("tab3");
									var tabData = "";
									tabData += $("#secondName").val()+"|";
									tabData += $("#secondRelation").val()+"|";
									tabData += $("#secondTelphone").val()+"|";
									tabData += $("#secondMobilephone").val()+"|";
									/*tabData += $("#secondPropAddr").val()+"|";*/
									if($("#secondPropAddr").val() == "0"){
									  tabData += "��"+"|";
								    }else if($("#secondPropAddr").val() == "1"){
									  tabData += "��"+"|";
								    }
									tabData += "δ��Ч"+"|";
									/*�����޸İ�ť
									var dataInfo = tabData;
									dataInfo = dataInfo.replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-").replace("|","-");
									tabData += "<input type='button' class='b_text' value='�޸�' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode),window.open(\"fd076_personInfo.jsp?method=addFrid&tabData="+dataInfo+"\",\"������Ϣ\",\"width=400,height=330,left=400,top=200\");'/>";
									*/
									tabData += "<input type='button' class='b_text' value='ɾ��' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode)'/>";
									window.opener.addTr(tab3,7,tabData);
									window.close();
			    			}else
			    				{
			    					var tab4 = window.opener.document.getElementById("tab4");
										var tabData = "";
										tabData += $("#neighborName").val()+"|";
										tabData += $("#neighborTelphone").val()+"|";
										tabData += $("#neighborMobilephone").val()+"|";
										/*tabData += $("#neighborPropAddr").val()+"|";*/
										if($("#neighborPropAddr").val() == "0"){
									      tabData += "��"+"|";
								        }else if($("#neighborPropAddr").val() == "1"){
									  	  tabData += "��"+"|";
								        }
										tabData += "δ��Ч"+"|";
										/*�����޸İ�ť
										var dataInfo = tabData;
										dataInfo = dataInfo.replace("|","-").replace("|","-").replace("|","-").replace("|","-");
										tabData += "<input type='button' class='b_text' value='�޸�' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode),window.open(\"fd076_personInfo.jsp?method=addNaber&tabData="+dataInfo+"\",\"�ھ���Ϣ\",\"width=400,height=330,left=400,top=200\");'/>";
										*/
										tabData += "<input type='button' class='b_text' value='ɾ��' onclick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode)'/>";
										window.opener.addTr(tab4,6,tabData);
										window.close();	
			    				}	    	
			    }else
			    	{
			    		rdShowMessageDialog("���û��ֻ�״̬������!",2);
			    		return ;
			    	}
	        }

}
</script>
</head>
<body>

	<form name="frm1" method="POST" onKeyUp="chgFocus(frm1)">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">��Ȩ��λ����Ϣ</div>
		</div>
		<div class="title">
			<div id="title_zi1" class="blue"></div>
		</div>
		<div id="div1" style="display:none">
		<table cellspacing="0">
			<tr>
				<td class="blue" width="100">����</td>
				<td>
					<input type="text" name="relaName" id="relaName" v_type="string" maxlength="15" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">��ϵ</td>
				<td>
					<input type="text" name="relaRelation" id="relaRelation" v_type="string" maxlength="10" />
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">�ƶ��绰</td>
				<td>
					<input type="text" name="relaMobilephone" id="relaMobilephone" v_type="mobphone" maxlength="20" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">ס���绰</td>
				<td>
					<input type="text" name="relaTelphone" id="relaTelphone" v_type="phone" maxlength="20" />
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">ס����ַ</td>
				<td>
					<input type="text" name="relaAddress" id="relaAddress" v_type="string" size="40" maxlength="100" />
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">��λ�绰</td>
				<td>
					<input type="text" name="relaCompanyTel" id="relaComPanyTel" v_type="phone" maxlength="20" />
				</td>
			</tr>
			<tr>
				<td class="blue" width="100">��λ��ַ</td>
				<td>
					<input type="text" name="relaCompanyAddr" id="relaCompanyAddr" v_type="string" size="40" maxlength="100" />
				</td>
			</tr>
			<tr>
					<td align="center" id="footer" colspan="2">
					<input type="button" value="ȷ��" class="b_foot" id="btn1"/>
					<input type="reset" value="����" class="b_foot"/>
				</td>
			</tr>
		</table>
		</div>
		<div id="div2" style="display:none">
		<table cellspacing="0">
			<tr>
				<td class="blue" width="110">��һ��ϵ������</td>
				<td>
					<input type="text" name="firstName" id="firstName" v_type="string" maxlength="15" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">��ϵ�˹�ϵ</td>
				<td>
					<input type="text" name="firstRelation" id="firstRelation" v_type="string" maxlength="10" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">��ϵ���ƶ��绰</td>
				<td>
					<input type="text" name="firstMobilephone" id="firstMobilephone" v_type="mobphone" maxlength="20" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">��ϵ��ס���绰</td>
				<td>
					<input type="text" name="firstTelphone" id="firstTelphone" v_type="phone" maxlength="20" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">��ϵ��ס����ַ</td>
				<td>
					<input type="text" name="firstAddress" id="firstAddress" v_type="string" size="40" maxlength="100" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">�Ƿ�������˶�λ</td>
				<td>
					<select name="firstPropAddr" id="firstPropAddr" style="width:135px">
						<option value="0">��</option>
						<option value="1">��</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">��ϵ�˵�λ�绰</td>
				<td>
					<input type="text" name="firstCompanyTel" id="firstCompanyTel" v_type="phone" maxlength="20" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
				<td class="blue" width="110">��ϵ�˵�λ��ַ</td>
				<td>
					<input type="text" name="firstCompanyAddr" id="firstCompanyAddr" v_type="string" size="40" maxlength="100" onblur="checkElement(this)"/>
				</td>
			</tr>
			<tr>
					<td align="center" id="footer" colspan="2">
					<input type="button" value="ȷ��" class="b_foot" id="btn2"/>
					<input type="reset" value="����" class="b_foot"/>
				</td>
			</tr>
		</table>
		</div>
		<div id="div3" style="display:none">
			<table cellspacing="0">
				<tr>
					<td class="blue" width="110">��������</td>
					<td>
						<input type="text" name="secondName" id="secondName" v_type="string" maxlength="15" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td class="blue" width="110">�������˹�ϵ</td>
					<td>
						<input type="text" name="secondRelation" id="secondRelation" v_type="string" maxlength="10" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td class="blue" width="110">���ѹ̻�</td>
					<td>
						<input type="text" name="secondTelphone" id="secondTelphone" v_type="phone" maxlength="20" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td class="blue" width="110">�����ƶ��绰</td>
					<td>
						<input type="text" name="secondMobilephone" id="secondMobilephone" v_type="mobphone" maxlength="20" onblur="checkElement(this)"/>
					</td>
				</tr>

				<tr>
					<td class="blue" width="110">�Ƿ�������˶�λ</td>
					<td>
						<select name="secondPropAddr" id="secondPropAddr" style="width:135px">
							<option value="0">��</option>
							<option value="1">��</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" id="footer" colspan="2">
						<input type="button" value="ȷ��" class="b_foot" id="btn3"/>
						<input type="reset" value="����" class="b_foot"/>
					</td>
				</tr>
			</table>
		</div>
		<div id="div4" style="display:none">
			<table cellspacing="0">
				<tr>
					<td class="blue" width="110">�ھ�����</td>
					<td>
						<input type="text" name="neighborName" id="neighborName" v_type="string" maxlength="15" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td class="blue" width="110">�ھӹ̻�</td>
					<td>
						<input type="text" name="neighborTelphone" id="neighborTelphone" v_type="phone" maxlength="20" onblur="checkElement(this)"/>
					</td>
				</tr>
				<tr>
					<td class="blue" width="110">�ھ��ƶ��绰</td>
					<td>
						<input type="text" name="neighborMobilephone" id="neighborMobilephone" v_type="mobphone" maxlength="20" onblur="checkElement(this)"/>
					</td>
				</tr>

				<tr>
					<td class="blue" width="110">�Ƿ�������˶�λ</td>
					<td>
						<select name="neighborPropAddr" id="neighborPropAddr" style="width:135px">
							<option value="0">��</option>
							<option value="1">��</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" id="footer" colspan="2">
						<input type="button" value="ȷ��" class="b_foot" id="btn4"/>
						<input type="reset" value="����" class="b_foot"/>
					</td>
				</tr>
			</table>
		</div>
		<%@ include file="/npage/include/footer_simple.jsp" %>
	</form>
</body>
</html>