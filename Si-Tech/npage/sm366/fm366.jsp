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

onload=function()
{


}
			
    
function querinfo(data){
		//�ҵ���ӱ���div
		var markDiv=$("#showTab"); 
		markDiv.empty();
		markDiv.append(data);
		
}

	


 	function resetPage(){
 		window.location.href = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	
	
	
		function doquery()
		{
		
		  var custNamess = $("#custName").val();
		  var idIccidss = $("#idIccid").val();
		  var id_typesss = $("#id_typess").val();
		  
			if((custNamess.trim()=="" || idIccidss.trim()=="")&&(idIccidss=="0"||idIccidss=="D")){
				rdShowMessageDialog("���Ƚ��ж������ٽ��в�ѯ��",1);
				return false;
			}
    
        var myPacket = new AJAXPacket("fm366Qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
        myPacket.data.add("custName",custNamess);
        myPacket.data.add("idIccid",idIccidss);
        myPacket.data.add("id_type",id_typesss);
				core.ajax.sendPacketHtml(myPacket,querinfo,true);
				getdataPacket = null;		
		
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
		  var name = IdrControl1.GetName();
			var code =  IdrControl1.GetCode();
			var sex = IdrControl1.GetSex();
			var bir_day = IdrControl1.GetBirthYear() + "" + IdrControl1.GetBirthMonth() + "" + IdrControl1.GetBirthDay();
			var IDaddress  =  IdrControl1.GetAddress();
			var idValidDate_obj = IdrControl1.GetValid();

			document.all.custName.value =name;//����
			document.all.idIccid.value =code;//���֤��
			
		  
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
				var xm =CardReader_CMCC.MutiIdCardName;					
				var xb =CardReader_CMCC.MutiIdCardSex;
				var mz =CardReader_CMCC.MutiIdCardPeople;
				var cs =CardReader_CMCC.MutiIdCardBirthday;
				var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;
				var yxqx = CardReader_CMCC.MutiIdCardValidterm;//֤����Ч��
				var zz =CardReader_CMCC.MutiIdCardAddress; //סַ
				var qfjg =CardReader_CMCC.MutiIdCardOrgans; //ǩ������
				var zjhm =CardReader_CMCC.MutiIdCardNumber; //֤������
				var base64 =CardReader_CMCC.MutiIdCardPhoto;

				
					//֤�����롢֤�����ơ�֤����ַ����Ч��
					document.all.custName.value =xm;//����
					document.all.idIccid.value =zjhm;//���֤��
				
				
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

function pub_set_radio(bt){
	$(bt).prev().click();
}
function show_p_div(bt,val){
	if(val=="1"){
		location = "fm366_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
}

function set_iccid(){
	var id_typess = $("#id_typess").val();
	if(id_typess=="0"||id_typess=="D"){
		//���֤ �������֤�������
		$("input[name='scan_idCard_two']").show();
		$("input[name='scan_idCard_two222']").show();
		$("#idIccid").val("");
		$("#idIccid").attr("readOnly","readOnly");
		$("#idIccid").addClass("InputGrey");
	}else{
		$("input[name='scan_idCard_two']").hide();
		$("input[name='scan_idCard_two222']").hide();
		$("#idIccid").val("");
		$("#idIccid").removeAttr("readOnly");
		$("#idIccid").removeClass("InputGrey");
		
		
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
			<input type="radio" id="radio_0"  checked value="0" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'0')" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">��ʡ������Ϣ</span>
			&nbsp;&nbsp;
			<input type="radio" id="radio_1"  value="1" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'1')" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">ȫ��������Ϣ</span>
		</td>
	</tr>
</table>

       <table id="add" style="display:block">
       	        <tr>
					        <td class='blue' >֤������</td>
					        <td>
					        <select align="left" id="id_typess" name="id_typess"  width=50  onchange="set_iccid()">
					        		<option value="0">���֤</option>
					        		<option value="1">����֤</option>
					        		<option value="2">���ڲ�</option>
					        		<option value="3">�۰�ͨ��֤</option>
					        		<option value="4">����֤</option>
					        		<option value="5">̨��ͨ��֤</option>
					        		<option value="6">���������</option>
					        		<option value="8">Ӫҵִ��</option>
					        		<option value="A">��֯��������</option>
					        		<option value="B">��λ����֤��</option>
					        		<option value="C">��λ֤��</option>
					        		<option value="D">�������֤</option>
								 </select>

					        </td>		
					         <td class="blue" > 
                    <div align="left">֤������</div>
                  </td>
                  <td > 
                    <input name="idIccid"  id="idIccid"   value=""  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="20"   readOnly  class="InputGrey">
                    
                    &nbsp;<input type="button" name="scan_idCard_two" class="b_text"   value="����" onClick="Idcard()" >
                    &nbsp;<input type="button" name="scan_idCard_two222" id="scan_idCard_two222" class="b_text"   value="����(2��)" onClick="Idcard2('1')" >
                    </td> 			        

					        </tr>  
  				
              </table>

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              	<input  name="quchoose" id="quchoose" class="b_foot" type=button value=��ѯ  onclick="doquery()" >
              <input class="b_foot" type=button name=back value="���" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
        
        <div id="showTab" ></div>
</div>

        
        
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
      <input type="hidden" name="custName" id="custName" value=""  v_must=1 v_maxlength=60 v_type="string"   maxlength="60" size=20  readOnly  class="InputGrey">


    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
<OBJECT classid="clsid:341162BA-3754-448C-BE54-EC34D82D5105" id="objIDCard"  width="0" height="0"></OBJECT>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1" width="0" height="0"></OBJECT>
</html>