   
<%
/********************
 version v2.0
 ������ si-tech
 create hejw@2009-4-20
********************/
%>

              
<%
/* zhangyan  window.location.replace ��ȡ����request�Ķ���,���д��
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
*/
String opName = "�ͷ�������֤����";
String opCode="6998";
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType= "text/html;charset=gb2312" %>
 
<HTML><HEAD><TITLE>�ͷ�������֤����</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<%
String regionCode = (String)session.getAttribute("regCode");
%>

<script language="JavaScript">
var kfFlag = "1";//�ͷ�ϵͳ��־���ڿͷ�ϵͳΪ1 �ڵ绰����ϵͳΪ0 ����ϵͳ����

function btcInsertInto(opType)
{
	var objKfFlag=document.all.sysFlag;
	
	var vKfFlag=objKfFlag.value;

	if(vKfFlag == "a"){
		rdShowMessageDialog("��ѡ����Ҫ���õ�ϵͳ��");	
		return false;
	}

	document.getElementById('opType').value=opType;
	var objDiv = document.all.selectFamdiv;
	objDiv.innerHTML = "";
	if(opType=="D"){
	  var strInnerHtml= "<div class=\"title\">"
		+"<div id=\"title_zi\">��������������֤��Ϣ</div></div>"
		+"<table id='sbtcAddTab'>"
		+"<tr>"
		+"<td align=\"left\">"
		+"<font class='orange'>"
		+"&nbsp&nbsp&nbsp&nbsp&nbspע�⣺�ϴ��ļ�������txt�ı���ʽ,ÿ��������֤������Ϣռһ��,"
		+"ÿ���а���������: ��ɫ���룬��������.������֮����\"|\"���зָ�,����ÿ�����Ҳ����\"||\"��Ϊ����. <br>"
		+"&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp�ļ�����ʾ��:<br>"
		+"&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp0101|1100||<br>"
		+"&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp0102|7983||<br>"
		+" </font>    "
		+"</td>"
		+"</tr>"
		+"<tr>"		
		+"<td align = \"center\">"	
		+"ѡ���ļ�: <input type=\"file\" id=\"cfg_file\"  name=\"cfg_file\" class=\"button\" "
		+" style='border-style:solid;border-color:#7F9DB9;border-width:1px; "
		+"font-size:12px;'/> &nbsp    <input type='button' value='����' class='b_text' "
		+"onclick=\"uploadFile()\"> "			
		+"</td>"
		+"</tr></table>";
	}else{
	  var strInnerHtml= "<div class=\"title\">"
		+"<div id=\"title_zi\">��������������֤��Ϣ</div></div>"
		+"<table id='sbtcAddTab'>"
		+"<tr>"
		+"<td align=\"left\">"
		+"<font class='orange'>"
		+"&nbsp&nbsp&nbsp&nbsp&nbspע�⣺�ϴ��ļ�������txt�ı���ʽ,ÿ��������֤������Ϣռһ��,"
		+"ÿ���а���������: ��ɫ����,����������Ƿ�����У���ʶ.ÿ������\"|\"���зָ�,����ÿ�����Ҳ����\"|\"��Ϊ����. "
		+"���е�������:�Ƿ�����У���ʶ��0,1��ʾ.0��ʾ��Ҫ����У��,1��ʾ����Ҫ����У��.<br>"
		+"&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp�ļ�����ʾ��:<br>"
		+"&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp0101|1100|0|<br>"
		+"&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp0101|7983|1|<br>"
		+" </font>    "
		+"</td>"
		+"</tr>"
		+"<tr>"		
		+"<td align = \"center\">"	
		+"ѡ���ļ�: <input type=\"file\" id=\"cfg_file\"  name=\"cfg_file\" class=\"button\" "
		+" style='border-style:solid;border-color:#7F9DB9;border-width:1px; "
		+"font-size:12px;'/> &nbsp    <input type='button' value='����' class='b_text' "
		+"onclick=\"uploadFile()\"> "			
		+"</td>"
		+"</tr></table>";
	}
	objDiv.innerHTML = strInnerHtml;
}

function uploadFile()
{
	document.form1.target="hidden_frame";
	document.form1.encoding="multipart/form-data";
	document.form1.action="f6998_upload.jsp";
	document.form1.method="post";
	document.form1.submit();
	loading();	
}

function doUnLoading()
{
	$("#sure").attr("disabled",false);
	unLoading();
}

function doFileCfm()
{
	document.form1.target="_self";
	document.form1.encoding="application/x-www-form-urlencoded";
	document.form1.action="f6998_fileCfm.jsp";
	form1.method="post";
	form1.submit();
	loading();
}

function selectFrom()
{
	var objOpCode=document.all.opCodei;
	var objPasFlag=document.all.pasFlag;
	var objKfFlag=document.all.sysFlag;
	
	var vKfFlag=objKfFlag.value;

	if(vKfFlag == "a"){
		rdShowMessageDialog("��ѡ����Ҫ���õ�ϵͳ��");	
		return false;
	}
  	ajaxGetSqlResult(objOpCode.value,objPasFlag.value,objKfFlag.value);
  	var divObj = document.all.selectFamdiv;
 	divObj.innerHTML ="";
  	var innerHTMLStr = "<div class=\"title\">"+
		"<div id=\"title_zi\">��ѯ����б�</div></div>"+
		"<table id='sfunKfTab'><tr>"+
		"<th width='20%'>ϵͳ����</th>"+
		"<th width='30%'>��ɫ����</th>"+
		"<th width='10%'>��������</th>"+
		"<th width='20%'>�Ƿ�����У��</th>"+
		"<th width='10%'>����</th>"+
		"</tr>";
  
  	var selObjHtml = "";
	for(var i=0;i<prodCompInfo.length;i++)
	{
		var roleCode=prodCompInfo[i][1].split("-")[0];
		var roleName=prodCompInfo[i][1].split("-")[1];
		if(prodCompInfo[i][3]=="1")
		{
			selObjHtml = "<select id = \"selPassFlag\" name =  \"selPassFlag\" ><option value=\"1\" selected>��</option>"
				+"<option value=\"0\">��</option></select>";
		}
		else
		{
			selObjHtml = "<select id = \"selPassFlag\"  name =  \"selPassFlag\" ><option value=\"1\" >��</option>"
				+"<option value=\"0\" selected>��</option></select>";
		}
	
		innerHTMLStr +=  "<tr>"
			+"<td>"+prodCompInfo[i][0]+"</td>"
			+"<td>"+prodCompInfo[i][1]+"</td>"
			+"<td>"+prodCompInfo[i][2]+"</td>"
			+"<td>"+selObjHtml+"</td>"
			+"<td><input type='button' value='ɾ��' class='b_text' "
			+"onclick=\"delThis('"+roleCode+"','"+roleName+"',"+prodCompInfo[i][2]+" , this)\"> "
			+"<input type='button' value='�޸�' class='b_text'  "
			+"onclick=\"updThis('"+roleCode+"','"+roleName+"','"+prodCompInfo[i][2]+"',this)\"> "
			+"</td></tr>";
	}
	innerHTMLStr+=
			""
			+" <tbody>   "
			+" 	<tr>   "
			+" 	<td id=\"footer\" colspan = \"5\">  "
			+" 	<input class=\"b_foot\" name=back   "
			+" 		onClick=\"printTable(sfunKfTab)\" type=button value=\"����EXCEL\">  "
			+" 	</td>  "
			+" 	</tr>  "
			+" </tbody>   "
      		+" </table>  ";
	divObj.innerHTML = innerHTMLStr;
										 
 }
var excelObj;
function printTable(obj)
{
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	excelObj = new ActiveXObject('excel.Application');
	excelObj.Visible = true;
	excelObj.WorkBooks.Add;
	rows=obj.rows.length;
	var selPassFlags = document.all.selPassFlag;

	if(rows>0)
	{
		try
		{
			for(i=0;i<rows;i++)
			{
				cells=obj.rows[i].cells.length-1;
				for(j=0;j<cells;j++)
				{
					if ( j==3&&i!=0 )
					{   
						excelObj.Cells(i+1,j+1).Value=selPassFlags[i-1].options[selPassFlags[i-1].selectedIndex].text;
					}
					else
					{
						excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
					}
					
				}
			}
		}
		catch(e)
		{
			//alert('����excelʧ��!');
		}
		total_row = eval(total_row+rows);
	}
	else
	{
		alert('no data');
	}
}
	

function delThis(roleCode,roleName,opCodev , bt )
{
	var passFlag = $(bt).parent().parent().find("td:eq(3) select").val();
	document.all.showMsgSu.value="ɾ���ɹ�";
	document.all.showMsgFi.value="ɾ��ʧ��";																						
	ajaxExe(roleCode,roleName ,opCodev , passFlag , kfFlag , 'D' );			
}
function updThis(roleCode,roleName,opCodev,bt)
{
	var passFlag = $(bt).parent().parent().find("td:eq(3) select").val();
	document.all.showMsgSu.value="�޸ĳɹ�";
	document.all.showMsgFi.value="�޸�ʧ��";	
	ajaxExe(roleCode,roleName ,opCodev , passFlag , kfFlag , 'U' );				
}

var bt = ""; 
function doQuery(bt1)
{
	  bt = bt1;
		var path = "roletree.jsp";
  	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
function setValue()
{
	$(bt).parent().parent().find("td:eq(1)  :text").val(document.all.roleCode.value+"-"+document.all.roleName.value)
	bt = "";
	document.all.roleCode.value = "";
	document.all.roleName.value = "";
} 
 function insertInto(){
    kfFlag = document.all.sysFlag.value;
	if(kfFlag == "a"){
		rdShowMessageDialog("��ѡ����Ҫ���õ�ϵͳ��");	
		return false;
	} 	
	var sysname ="";
	if(kfFlag == "1"){
		sysname = "�ͷ�ϵͳ";
	}else{
		sysname = "�绰����ϵͳ";
	}
 	var divObj = document.all.selectFamdiv;
 	var innerHTMLStr = "";
 	
  	
 	if($("#sfunKfTab").length==0){
      innerHTMLStr = "<div class=\"title\"><div id=\"title_zi\">��ѯ����б�</div></div>"+
      							 "<table id='sfunKfTab'><tr>"+
      							 		 "<th width='20%'>ϵͳ����</th>"+
										 "<th width='30%'>��ɫ����</th>"+
										 "<th width='10%'>��������</th>"+
										 "<th width='20%'>�Ƿ�����У��</th>"+
										 "<th width='10%'>����</th>"+
										 "</tr>";
										 
		 innerHTMLStr += "<tr>"+
		 							"<td>"+sysname+"</td>"+
  									 "<td><input type=\"text\" v_must='1'  readOnly class='InputGrey'><input type='button' class='b_text' onclick=\"doQuery(this)\" value=\" ��ѯ \"></td>"+
										 "<td><input type=\"text\" v_must='1' maxlength='5'></td>"+
										 "<td><select><option value=\"1\" >��</option><option value=\"0\" selected>��</option></select></td>"+
										 "<td><input type='button' value='ɾ��' class='b_text' onclick='delByadd(this)'>&nbsp;<input type='button' value='����' class='b_text' onclick='saveThis(this)'></td>"+
										 "</tr>";
		divObj.innerHTML = innerHTMLStr;								 						 
 	}else{
  var innerHTMLStr1 ="<tr>"+
  									"<td>"+sysname+"</td>"+
  									 "<td><input type=\"text\" v_must='1'  readOnly class='InputGrey'><input type='button' class='b_text'  onclick=\"doQuery(this)\" value=\" ��ѯ \"></td>"+
										 "<td><input type=\"text\" v_must='1' maxlength='5'></td>"+
										 "<td><select><option value=\"1\" >��</option><option value=\"0\" selected>��</option></select></td>"+
										 "<td><input type='button' value='ɾ��' class='b_text' onclick='delByadd(this)'>&nbsp;<input type='button' value='����' class='b_text' onclick='saveThis(this)'></td>"+
										 "</tr>";
										 
		$("#sfunKfTab tr:eq(0)").append(innerHTMLStr1);								 
 	}
 }
 

function delByadd(bt)
{
	$(bt).parent().parent().remove();
}
function saveThis(bt)
{
	var roleCode = $(bt).parent().parent().find("td:eq(1)  :text").val().split("-")[0];
	var roleName = $(bt).parent().parent().find("td:eq(1)  :text").val().split("-")[1];
	if(roleCode.trim()=="")
	{
		rdShowMessageDialog("��ɫ���벻��Ϊ��");	
		return false;
	}
 	var opCodej =  $(bt).parent().parent().find("td:eq(2) input").val().trim();
 	if(opCodej.trim()=="")
 	{
 		rdShowMessageDialog("�������벻��Ϊ��");	
 		return false;
 	}
 	var regu = "^[0-9a-zA-Z_]+$";
	var re = new RegExp(regu);
 	if(!re.test(opCodej))
 	{
 		rdShowMessageDialog("��������ȷ�Ĳ�������");	
 		$(bt).parent().parent().find("td:eq(2) input").val("");
 		return false;
 	}
 	var passFlag = $(bt).parent().parent().find("td:eq(3) select").val();
 	document.all.showMsgSu.value="����ɹ�";
 	document.all.showMsgFi.value="����ʧ��";	 	
 	/*���÷���*/																					
	ajaxExe(roleCode,roleName ,opCodej , passFlag , kfFlag , 'I' );		
																			
 }
  
function ajaxExe(roleCode,roleName ,opCodej , passFlag , kfFlag , opType )
{
	var packet1 = new AJAXPacket("ajaxAdd.jsp","���Ժ�...");
	packet1.data.add("roleCode",roleCode);
	packet1.data.add("roleName",roleName);
	packet1.data.add("opCodej",opCodej);
	packet1.data.add("passFlag",passFlag);
	packet1.data.add("kfFlag",kfFlag);
	packet1.data.add("opType",opType);
	core.ajax.sendPacket(packet1,doAjaxExe);
	packet1 =null;			
}
 
function doAjaxExe(packet){
	var error_code = packet.data.findValueByName("errCode");
	var error_msg =  packet.data.findValueByName("errMsg");
	if(error_code!="000000")
	{
		rdShowMessageDialog(document.all.showMsgFi.value,0);	
	}
	else
	{
		rdShowMessageDialog(error_code+":"+error_msg , 0);
	}
}
   //	ajaxGetSqlResult(objOpCode.value,objPasFlag.value,objKfFlag.value);
 function ajaxGetSqlResult(opCode , pasFlag , kfFlag){
	var packet1 = new AJAXPacket("ajaxGetSqlResult.jsp","���Ժ�...");
	packet1.data.add("opCode",opCode);
	packet1.data.add("pasFlag",pasFlag);		
	packet1.data.add("kfFlag",kfFlag);		
	core.ajax.sendPacket(packet1,doAjaxGetSqlResult);
	packet1 =null;			
 }
 
function doAjaxGetSqlResult(packet)
{
	var error_code = packet.data.findValueByName("errCode");
	var error_msg =  packet.data.findValueByName("errMsg");
	if ( error_code!="000000" )
	{
	rdShowMessageDialog(error_code+":"+error_msg , 0);
	return false;
	}
	prodCompInfo = packet.data.findValueByName("vArrS6998Qry");	
}
 
function resetBf(){
	location = location ;	
}  
function setdis(){
	document.all.sysFlagFile.value=document.all.sysFlag.value;
	document.all.sysFlag.disabled = true;	
}
</script>

</HEAD>
<BODY>
<FORM  method=post name="form1" >
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">�ͷ�������֤����</div>
	</div> 
	<input type=hidden name=opCode id=opCode value="<%=opCode%>">
	<input type=hidden name=opName id=opName value="<%=opName%>">
	<input type="hidden" id="showMsgSu" name="showMsg" value="">
	<input type="hidden" id="showMsgFi" name="showMsg" value="">
	<input type="hidden" id="roleCode" name="roleCode" value="">
	<input type="hidden" id="roleName" name="roleName" value="">
	<input type="hidden" id="opType" name="opType" value="">
	<input type="hidden" id="fileName" name="fileName" value="">
	<input type="hidden" id="sysFlagFile" name="sysFlagFile" value="">
		
	<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	<table cellspacing="0">
		<tr>
			<td class="blue">��������</td>
			<td class="blue"><input type="text" name="opCodei" id="opCodei"></td>
			<td class="blue">ϵͳ��־</td>
			<td class="blue">
				<select name="sysFlag" onchange="setdis()">
					<option value="a" selected>--��ѡ��--</option>
					<option value="1" >�ͷ�ϵͳ</option>
					<option value="0">�绰����ϵͳ</option>
				</select>
			</td>			
			<td class="blue">����У���־</td>					  
			<td class="blue">
				<select name="pasFlag">
					<option value="2" selected>ȫ��</option>
					<option value="0" >��</option>
					<option value="1" >��</option>
				</select>
			</td>
		</tr>	
	</table>
	<table cellspacing="0">
		<tr> 
			<td  id="footer"> 
				<input class="b_foot" name=selectb type=button value="��ѯ" 
					onClick="selectFrom()">
				<input class="b_foot" name=insertb type=button value="����" 
					onClick="insertInto()">
				<input class="b_foot" name=btcInsert type=button value="��������" 
					onClick="btcInsertInto('I')">
				<input class="b_foot" name=btcUpd type=button value="�����޸�" 
					onClick="btcInsertInto('U')">		
				<input class="b_foot" name=btcUpd type=button value="����ɾ��" 
					onClick="btcInsertInto('D')">										
				<input class="b_foot" name="reset" type=button value="����" 
					onClick="resetBf()" >
				<input class="b_foot" name=closeb  type=button value=�ر� 
					onClick="removeCurrentTab()">
			</td>
		</tr>
	</table>
<div id="selectFamdiv"></div>
<p>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
						
  					
  					