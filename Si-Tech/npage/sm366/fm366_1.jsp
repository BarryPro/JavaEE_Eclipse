<%
/********************
 version v2.0
������: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		String regionCode= (String)session.getAttribute("regCode");
		String loginNoPass = (String)session.getAttribute("password");
		String ipAddrss = (String)session.getAttribute("ipAddr");

%>
  
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
		
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script type="text/javascript">
	var v_printAccept = "<%=printAccept%>";
 
function pub_set_radio(bt){
	$(bt).prev().click();
}
function show_p_div(bt,val){
	if(val=="0"){
		location = "fm366.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
}



function Idcard()
{
	//��ȡ�������֤	

	var picName = getCuTime();
	var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
	var tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
	var strtemp= tmpFolder+"";
	var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
	var cre_dir = filep1+":\\custID";//����Ŀ¼
	//�ж��ļ����Ƿ���ڣ��������򴴽�Ŀ¼
	if(!fso.FolderExists(cre_dir)) {
	var newFolderName = fso.CreateFolder(cre_dir);  
	}
	var picpath_n = cre_dir +"\\"+picName+".jpg";
	
		
	var result;
	var result2;
	var result3;
	
	result=IdrControl1.InitComm("1001");
	if (result==1)
	{
		result2=IdrControl1.Authenticate();
		if ( result2>0)
		{              
			result3=IdrControl1.ReadBaseMsgP(picpath_n); 
			if (result3>0)           
			{     
				var code = IdrControl1.GetCode();
				var xm   = IdrControl1.GetName();
				document.all.idIccid.value  = code;//���֤��
		  	document.all.custName.value = xm;
			}
			else
			{
				rdShowMessageDialog(result3); 
				IdrControl1.CloseComm();
			}
		}
		else
		{
			IdrControl1.CloseComm();
			rdShowMessageDialog("�����½���Ƭ�ŵ���������");
		}
	}
	else
	{
		IdrControl1.CloseComm();
		rdShowMessageDialog("�˿ڳ�ʼ�����ɹ�",0);
	}
	IdrControl1.CloseComm();
}

function getCuTime(){
 var curr_time = new Date(); 
 with(curr_time) 
 { 
 var strDate = getYear()+"-"; 
 strDate +=getMonth()+1+"-"; 
 strDate +=getDate()+" "; //ȡ��ǰ���ڣ�������ġ��ա��ֱ�ʶ 
 strDate +=getHours()+"-"; //ȡ��ǰСʱ 
 strDate +=getMinutes()+"-"; //ȡ��ǰ���� 
 strDate +=getSeconds(); //ȡ��ǰ���� 
 return strDate; //������ 
 } 
}


  function Idcard2(str){
			//ɨ��������֤
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		var tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
	var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
	if(ret_open!=0){
		ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
	}	
	var cardType ="11";
	if(ret_open==0){

			//�๦���豸RFID��ȡ
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_head_"+v_printAccept+str+".jpg");

			if(ret_getImageMsg==0){
				//����֤������ϳ�
				var zjhm = CardReader_CMCC.MutiIdCardNumber; //֤������
				var xm   = CardReader_CMCC.MutiIdCardName;		
					document.all.idIccid.value  = zjhm;//���֤��
					document.all.custName.value = xm;//���֤��
				
			}else{
					rdShowMessageDialog("��ȡ��Ϣʧ��");
					return ;
			}
	}else{
					rdShowMessageDialog("���豸ʧ��");
					return ;
	}
	//�ر��豸
	var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
	if(ret_close!=0){
		rdShowMessageDialog("�ر��豸ʧ��");
		return ;
	}
	
}


function set_iccidIpt(){
	$("#idIccid").val("");
	if($("#id_typess").val()=="00"){//���ֻ֤�ܶ���
		$("#idIccid").attr("readOnly","readOnly");
		$("#idIccid").addClass("InputGrey");
		
		//$("#custName").attr("readOnly","readOnly");
		//$("#custName").addClass("InputGrey");
		
		
		$("#scan_idCard_two222").show();
		$("#scan_idCard_two").show();
	}else{
		$("#idIccid").removeAttr("readOnly");
		$("#idIccid").removeClass("InputGrey");
		
		//$("#custName").removeAttr("readOnly");
		//$("#custName").removeClass("InputGrey");
		
		$("#scan_idCard_two222").hide();
		$("#scan_idCard_two").hide();
	}
}


function go_Query(){
	if($("#idIccid").val().trim()==""){
		rdShowMessageDialog("������֤������");
		return;
	}
	
	 
 	var pactket = new AJAXPacket("fm366_PhonQuery.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("id_typess",$("#id_typess").val().trim());
			pactket.data.add("idIccid",$("#idIccid").val().trim());
			//pactket.data.add("custName",$("#custName").val().trim());
			core.ajax.sendPacket(pactket,do_Query);
			pactket=null;
}
// �ص�
function do_Query(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#upgMainTab tr:gt(0)").remove();
			
			var idType = "";
			
			var phoneQryNum = packet.data.findValueByName("phoneQryNum");
			$("#phoneQryNum").text("  �ֻ�����������"+phoneQryNum);
			
			if(phoneQryNum!="0"){
					for(var i=0;i<retArray.length;i++){
						
							if(retArray[i][2]=="00"){
								idType = "���֤";
							}
							
							if(retArray[i][2]=="02"){
								idType = "���������";
							}
							
							if(retArray[i][2]=="04"){
								idType = "����֤";
							}
							
							if(retArray[i][2]=="05"){
								idType = "��װ�������֤";
							}
							
							if(retArray[i][2]=="10"){
								idType = "��ʱ�������֤";
							}
							
							if(retArray[i][2]=="11"){
								idType = "���ڲ�";
							}
							
							if(retArray[i][2]=="12"){
								idType = "�۰�ͨ��֤";
							}
							
							if(retArray[i][2]=="13"){
								idType = "̨��ͨ��֤";
							}
							
							if(retArray[i][2]=="99"){
								idType = "����֤��";
							}
							
							
							var j_province_code = retArray[i][4];
							var j_province_name = "";
							
							if(j_province_code == "100" ) j_province_name = "����";
							if(j_province_code == "471" ) j_province_name = "���ɹ�";
							if(j_province_code == "220" ) j_province_name = "���";
							if(j_province_code == "531" ) j_province_name = "ɽ��";
							if(j_province_code == "311" ) j_province_name = "�ӱ�";
							if(j_province_code == "351" ) j_province_name = "ɽ��";
							if(j_province_code == "551" ) j_province_name = "����";
							if(j_province_code == "210" ) j_province_name = "�Ϻ�";
							if(j_province_code == "250" ) j_province_name = "����";
							if(j_province_code == "571" ) j_province_name = "�㽭";
							if(j_province_code == "591" ) j_province_name = "����";
							if(j_province_code == "898" ) j_province_name = "����";
							if(j_province_code == "200" ) j_province_name = "�㶫";
							if(j_province_code == "771" ) j_province_name = "����";
							if(j_province_code == "971" ) j_province_name = "�ຣ";
							if(j_province_code == "270" ) j_province_name = "����";
							if(j_province_code == "731" ) j_province_name = "����";
							if(j_province_code == "791" ) j_province_name = "����";
							if(j_province_code == "371" ) j_province_name = "����";
							if(j_province_code == "891" ) j_province_name = "����";
							if(j_province_code == "280" ) j_province_name = "�Ĵ�";
							if(j_province_code == "230" ) j_province_name = "����";
							if(j_province_code == "290" ) j_province_name = "����";
							if(j_province_code == "851" ) j_province_name = "����";
							if(j_province_code == "871" ) j_province_name = "����";
							if(j_province_code == "931" ) j_province_name = "����";
							if(j_province_code == "951" ) j_province_name = "����";
							if(j_province_code == "991" ) j_province_name = "�½�";
							if(j_province_code == "431" ) j_province_name = "����";
							if(j_province_code == "240" ) j_province_name = "����";
							if(j_province_code == "451" ) j_province_name = "������";	

							
						  //�����һ���ռ�¼��չʾ�����񷵻�����Ϊ���ַ���������Ľ�����߼���ɾ��
								trObjdStr += "<tr>"+
																 "<td>"+retArray[i][0]+"</td>"+ //
																 "<td>"+retArray[i][1]+"</td>"+ //
																 "<td>"+idType+"</td>"+ //
																 "<td>"+$("#idIccid").val().trim()+"</td>"+ //��������������һ�µ�
																 "<td>"+j_province_name+"</td>"+ //
																 "<td>"+retArray[i][5]+"</td>"+ //
														 "</tr>";
					}
					//��ƴ�ӵ��ж�̬��ӵ�table��
					$("#upgMainTab tr:eq(0)").after(trObjdStr);
			}

	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}
</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>

<table cellSpacing="0">
	<tr>
		<td class="blue" align="center">
			<input type="radio" id="radio_0"  value="0" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'0')" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">��ʡ������Ϣ</span>
			&nbsp;&nbsp;
			<input type="radio" id="radio_1" checked value="1" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'1')" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">ȫ��������Ϣ</span>
		</td>
	</tr>
</table>

<table  cellSpacing="0">
  <tr>
    <td class='blue' width="15%">֤������</td>
    <td   width="35%">
    	<!-- ��֤������Ϊ���Ź�˾�淶������һ�°��չ淶����д�����������ݿ��е����� -->
	    <select align="left" id="id_typess" name="id_typess"  width=50 onchange="set_iccidIpt()">

					<option value="00" selected>���֤</option>
					<option value="02">���������</option>
		    	<option value="04">����֤</option>
		    	<option value="05">��װ�������֤</option>
		    	<option value="11">���ڲ�</option>
		    	<option value="12">�۰�ͨ��֤</option>
		    	<option value="13">̨��ͨ��֤</option>
		    	<option value="99">����֤��</option>
		    	
			</select>
			
			 &nbsp;<input type="button" id="scan_idCard_two" class="b_text"   value="����" onClick="Idcard()" >
      &nbsp;<input type="button" id="scan_idCard_two222"   class="b_text"   value="����(2��)" onClick="Idcard2('1')" >
      
      
    	</td> 
     
    		<td class="blue"  width="15%">֤������</td>
    		<td>
      		<input name="idIccid"  id="idIccid"   value=""   readOnly class="InputGrey" />
      	</td> 		
		        
    </tr>  

</table> 

<div class="title"><div id="title_zi">��ѯ����б�<span id="phoneQryNum"></span></div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th>�ֻ�����</th>
        <th>�ͻ�����</th>
        <th>֤������</th>
        <th>֤������</th>
        <th>����ʡ����</th>
        <th>ҵ����Чʱ��</th>
    </tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="��ѯ" onclick="go_Query()"          />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>


    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
<OBJECT classid="clsid:341162BA-3754-448C-BE54-EC34D82D5105" id="objIDCard"  width="0" height="0"></OBJECT>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1" width="0" height="0"></OBJECT>
</html>