   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-15
********************/
%>
              
<%
  String opCode = "5517";
  String opName = "�������Ȩ������";
  String sWorkNo = (String)session.getAttribute("workNo");
 	String dNopass = (String)session.getAttribute("password");
 	String chnSource="01";
 	String phoneNo = "";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/common/serverip.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String serverIp=realip.trim();
	String regionCode = (String)session.getAttribute("regCode");
	String sqlString = " select op_code,op_display_name from sHighOpr order by op_code";
	String resultList[][] = new String[][]{};
%>


		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlString%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%	
		
		if(code.equals("000000"))
		resultList = result_t2;
	
	int iCodeIndex =0;
%>
<!--ȡ��ˮ�ŷ��� -->
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		String printAccept = seq;
		String haveAccess = "false";
%>
<wtc:service name="sCommonCheck" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeXXYH" retmsg="retMsgXXYH" outnum="1">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="1500"/>
		<wtc:param value="<%=sWorkNo%>"/>
		<wtc:param value="<%=dNopass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="2"/>
		</wtc:service>
	<wtc:array id="XXYHRet" scope="end"/>	
		
<%
	if("000000".equals(retCodeXXYH) && XXYHRet.length > 0){
		if("0".equals(XXYHRet[0][0])){
			haveAccess = "true";
		}else{
			haveAccess = "false";
		}
	}else{
		haveAccess = "false";
	}
	System.out.println("gaopengSeeLog1500-------haveAccess===="+haveAccess);
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�������Ȩ������</title>
<script language=javascript>
	
	$(document).ready(function(){
		
		});
var isHave = "no";

function doSearch() {
	
	if(document.frm.iLoginNo.value.length == 0){
		rdShowMessageDialog("�����빤�ţ�",0);
	} else {
	    document.frm.search.disabled =true;
	    var myPacket = new AJAXPacket("s5517Search.jsp","���ڲ�ѯ�����Ժ�......");

	    myPacket.data.add("login_no",document.frm.iLoginNo.value);
	    myPacket.data.add("op_code",document.frm.iOpCode.value);
	    
        core.ajax.sendPacket(myPacket);
        myPacket = null;
	}
}

function doProcess(packet){
	var errcode = packet.data.findValueByName("errcode");
	//alert("RPC����״ֵ̬"+errcode);
    
	if (errcode == null) {
	   var backGroupInfo = packet.data.findValueByName("backGroupInfo");

	   rdShowMessageDialog(backGroupInfo);
	   document.frm.submit1.disabled =true;
	   document.frm.iLoginNo.value ="";
	  
    } else {
    		var ret_msg;
	    switch(errcode)
	    {
	    	case "0":
	    		rdShowMessageDialog("�˹��Ų����ڣ����޸ĺ����ԣ�",0);
	    		isHave = "nothing";
	    		ret_msg = "";
	    		break;
	    		
	    	case "1":
	    		ret_msg = "����["+document.frm.iLoginNo.value+"]������["+document.frm.iOpCode.value+"]ִ��Ȩ��,���������ӣ�<font color";
	    		isHave = "no";
	    		break;
	    	case "2":
	    		ret_msg = "����["+document.frm.iLoginNo.value+"]�Ѿ���["+document.frm.iOpCode.value+"]ִ��Ȩ��,������ɾ����";
	    		isHave = "yes";
	    		break;
	    	default:
	    		rdShowMessageDialog("RPC����ֵ��������ϵϵͳ����Ա��",0);
	    		isHave = "nothing";
	    }
	    //alert(packet.data.findValueByName("ret_msg"));
	    	document.all.retmsg.innerHTML = "<p><font class='orange'>"+ret_msg+"</font></p>";
	    	onChangeOpType();
	}
}

function onChangeOpCode()
{
	document.frm.submit1.disabled = true;
	document.frm.search.disabled = false;
}

function onChangeOpType()
{
	var opType = document.frm.opType.value;
	var result=$("input[name='LoginRadio']:checked").val();
	if(result=="1")
	{
		document.frm.submit1.disabled = false;
	}
	else{
	document.frm.submit1.disabled = true;
	switch(opType)
	{
		case "a":
			document.frm.submit1.value = "����";
			if(isHave == "no") 
			{
				document.frm.submit1.disabled = false;
				
			}
			break;
		case "d":
			document.frm.submit1.value = "ɾ��";
			if(isHave == "yes")
			{
				document.frm.submit1.disabled = false;
				
			}
			break;
		default:
			break;
	}	
}
}

function onChangeLoginNo()
{
	document.frm.search.disabled = false;
	
}
//�ϴ����������ļ����� 2012-8-1 gaopeng
function uploadWorkNoList(){

			document.frm.target="hidden_frame";
	    document.frm.encoding="multipart/form-data";
	    document.frm.action="s5517_upload.jsp";
	    document.frm.method="post";
	    document.frm.submit();
		}
//��ֵ�ϴ����ļ���ȫ·�����Լ���ֵ�ϴ��ļ��еĹ����ܸ���
	function doSetFileName(fileName1,lines){
			$("input[name='serviceFileName']").val(fileName1);
			//�����ϴ�txt�ļ���һ���ж���������
			var arrys = lines.split(",").length-1;
			$("input[name='uploadLine']").val(arrys);
			rdShowMessageDialog("�ϴ��ļ��ɹ���",2);
			
		}
	//�ϴ�����Ч
		function setdisabled()
		{
			$("#workNoList").attr("disabled","disabled");
			$("#uploadFile").attr("disabled","disabled");
		}
function doSubmit()
{
	var result=$("input[name='LoginRadio']:checked").val();
	/*
		2015/05/18 8:39:27 gaopeng R_CMI_HLJ_guanjg_2015_2233990@������BOSSϵͳ����������ѯ����������֤���ܵ���ʾ
		���ѡ�����1500�Ż���Ϣ��ѯȨ�ޣ��ж��Ƿ���1500����Ȩ�ޣ��������ύ
	*/
	var iopCode = $.trim($("select[name='iOpCode']").find("option:selected").val());
	if(iopCode == "1500"){
		if("<%=haveAccess%>" != "true"){
			rdShowMessageDialog("�ù���û��1500����Ȩ�ޣ�������ӡ�1500�Ż���Ϣ��ѯȨ�ޡ���",1);
			return false;
		}
	}
	
	if(result=="1")
	{
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("���ϴ�BOSS�����ļ���",1);
				return false;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ��BOSS�����ļ���");
				document.frm.workNoList.focus();
				return false;
			}
			else
			{
					doajax();
					return true;
			}
	}
	else if(result=="0")
		{
			getAfterPrompt();
			document.frm.action="s5517Cfm.jsp";
			document.frm.method="post";
			document.frm.submit();
		}
	
}
//ajax���÷��񷽷�
function doajax()
		{
			var fileName1 = $("input[name='serviceFileName']").val();
			//�õ���������
			var opType = document.frm.opType.value;
			var MydataPacket = new AJAXPacket("/npage/codeManage/s5517Cfm2.jsp","���ڴ����������ţ����Ժ�......");
			//ҵ����ˮ
			MydataPacket.data.add("iLoginAccept","0");
			//������ʶ
			MydataPacket.data.add("iChnSource","<%=chnSource%>");
			//��������
			MydataPacket.data.add("OpCode","<%=opCode%>");
			//����
			MydataPacket.data.add("iLoginNo","<%=sWorkNo%>");
			//��������
			MydataPacket.data.add("iLoginPwd","<%=dNopass%>");
			//�ֻ���
			MydataPacket.data.add("iPhoneNo","<%=phoneNo%>");
			//��������
			MydataPacket.data.add("iUserPwd","");
			//�����ļ�ȫ·����
			MydataPacket.data.add("iInputFile",fileName1);
			//IP��ַ
			MydataPacket.data.add("iServerIp","<%=serverIp%>");
			//��������
			MydataPacket.data.add("iDelayType",opType);
			//ѡ��Ĳ�������
			var iopCode = $("select[name='iOpCode']").find("option:selected").val();
			//alert(iopCode);
			MydataPacket.data.add("iopCode",iopCode);
			core.ajax.sendPacket(MydataPacket,doProcess22);
			MydataPacket = null;
			
		}
	//Ajax�ص�����	
	function doProcess22(packet){
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
function typechange()
{
		var result=$("input[name='LoginRadio']:checked").val();
			 	//������������� ��ʾmutiInfo ���ص�һ�еĹ��š�������Լ���ѯ��ť
			 	if(result=="1")
			 	{
			 		document.frm.submit1.disabled = false;
			 		$("#retmsg").html("");
			 		$("#mutiInfo").show();
			 		$("#displayNo").hide();
			 		$("#displayIn").hide();
			 		$("#displayBtn").hide();
			 		//������Ԫ��
			 		$("#changewidth").attr("width","9%");
			 		var successNos = $("#suc_noinfo").html();
			 		if(successNos.length!=0)
			 		{
			 			$("#sucessMsg").show();
			 			$("#errorMsg").show();
			 		}
			 	}
			 	else if(result=="0")
		 		{
		 			document.frm.submit1.disabled = true;
		 			$("#mutiInfo").hide();
			 		$("#displayNo").show();
			 		$("#displayIn").show();
			 		$("#displayBtn").show();
			 		//������Ԫ��
			 		$("#changewidth").attr("width","10%");
			 		$("#retmsg").html("");
			 		$("#sucessMsg").hide();
			 		$("#errorMsg").hide();
		 			
		 		}
}
	//�鿴�����ĵ�����
		function seeInformation()
		{
			var filename=$("input[name='printAccept']").val();
			var path = "<%=request.getContextPath()%>/npage/codeManage/s5517_error.jsp?fileName="+filename+".txt";
			window.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		}
</script>
</head>
<body>

 <form  method="post" name="frm" >
     <%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">�������Ȩ������</div>
	</div>

			<table>
						<tr>
							<td  width="9%" class="blue">
								��������
							</td>
							<td colspan="6">
							<input type="radio"   name="LoginRadio" onclick="typechange()" value="0" checked>��һ����</input> 
							<input type="radio"   name="LoginRadio" onclick="typechange()" value="1">��������</input> 
							</td>
						</tr>
			</table>


		  <table  cellpadding="0">
			  <tbody>
				  <tr> 
					  <td id="changewidth" width="10%" class="blue">��������					  </td>
					  <td width="8">
					  	<select name="opType" onChange="onChangeOpType()">
							<option value="a" selected="selected">����</option>
							<option value="d">ɾ��</option>
						</select>
				    </td>
					  	
					  <td width="10%" class="blue">
					 	 ��������					  </td>
					  <td width="32%">
					  	<select name="iOpCode">
<%
				for(int iii=0;iii<result_t2.length;iii++){
				for(int jjj=0;jjj<result_t2[iii].length;jjj=jjj+2){
%>

							<option value="<%=result_t2[iii][jjj-1>0?jjj:0]%>" selected="selected"><%=result_t2[iii][jjj-1>0?jjj:0]+"-->"+result_t2[iii][jjj+1]%></option>
<%					
					
				}
				}

%>					  		
						</select>
				    </td>
					  <td id="displayNo" width="10%" class="blue" >
					  	����					  </td>
					  <td id="displayIn" width="20%" >
					  	<input type="text" name="iLoginNo" width="7"  onFocus="onChangeLoginNo()"/>
				    </td>
					  <td id="displayBtn" width="10%" >
					  	<input type="button" name="search" value="��ѯ" class="b_foot" onClick="doSearch();"/>
				    </td>
				  </tr>
			  </tbody>
		  </table>
<!--2012-8-1���� �����������빤�Ŵ���ķ��� gaopeng  begin--> 
		  <table id="mutiInfo" style="display:none">
			<tr>
				<td  width="9%" class="blue">
					�������ŵ���
				</td>
				<td colspan="6">
					<input type="file" name="workNoList" id="workNoList" class="button"
					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
					&nbsp;&nbsp;
					<input type="button" name="uploadFile" id="uploadFile"
					class="b_text" value="�ϴ�" onclick="uploadWorkNoList()"/>
				</td>
			</tr>
			<tr>
				<td width="9%" class="blue">
					�ļ���ʽ˵��
				</td>
        <td colspan="6"> 
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
<!--2012-8-1���� �����������빤�Ŵ���ķ��� gaopeng end-->


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
 		  
		  <table cellpadding="0">
		  	<tbody id="msg" style="display:block">
			  	<tr>
					<td>
						<div id="retmsg"></div>
					</td>
				</tr>
			  </tbody>
		  </table>

		  <table cellpadding="0">
		  		<tr><td align="center"id="footer">
		  		<input type="button" name="submit1" onClick="doSubmit()" class="b_foot" value="�ύ" disabled >
		  		&nbsp;
		  			<input  name="resetsd"  class="b_foot" type="button" value="���" onclick="javascript:window.location.href='/npage/codeManage/s5517.jsp'" id="Button3">&nbsp;
				<input type="submit" onClick="removeCurrentTab();" class="b_foot" value="�ر�">
				</td></tr>
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
