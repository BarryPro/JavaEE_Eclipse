<%
/********************
 version v2.0
 ������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%
  response.setDateHeader("Expires", 0);
%>
<%
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%

  String loginNo = (String)session.getAttribute("workNo");
  String loginName =  (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String workNo = (String)session.getAttribute("workNo");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String notestr="����phoneNo==["+activePhone+"]���в�ѯ";
  String custname="";

%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="printAccept" />
			
					<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="confimAccept" />

<%
			String  inputParsm [] = new String[6];
			inputParsm[0] = printAccept;
			inputParsm[1] = "01";
			inputParsm[2] = opCode;
			inputParsm[3] = workNo;
			inputParsm[4] = password;
			inputParsm[5] = activePhone;
%>
		<wtc:service name="se382Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="8">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"  />
<%
if(retCode.equals("000000")) {
 if(result1.length<=0){
  	%>
 	<script language="javascript">
 	rdShowMessageDialog("�û���ǰû����Ч�Ļ�����ܰ���ȡ��ҵ��",0);
 	removeCurrentTab();
 	</script>
 	<%	
 }	
}
else {
 	%>
 	<script language="javascript">
 	rdShowMessageDialog("������룺<%=retCode%> ��������Ϣ��<%=retMsg%>",0);
 	removeCurrentTab();
 	</script>
 	<%	
}
%>
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="100" >
  <wtc:param value="0"/>
  <wtc:param value="01"/>
  <wtc:param value="<%=opCode%>"/>
  <wtc:param value="<%=loginNo%>"/>	
  <wtc:param value="<%=password%>"/>		
  <wtc:param value="<%=activePhone%>"/>	
  <wtc:param value=""/>
  <wtc:param value="<%=ipAddr%>"/>
  <wtc:param value="<%=notestr%>"/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
</wtc:service>
<wtc:array id="returnFlag" start="0" length="1" scope="end"/>
<wtc:array id="result2" start="1" length="5" scope="end"/>
		<%
		  if("000000".equals(RetCode1)){
        if(result2.length>0){
          if("00".equals(returnFlag[0][0])){
            custname = result2[0][4];
          }
        }
      }
 else {
 	%>
 	<script language="javascript">
 	rdShowMessageDialog("������룺" + RetCode1 + "��������Ϣ��" + RetMsg1,0);
 	removeCurrentTab()��
 	</script>
 	<%
	}
	%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<script language="JavaScript">

      $(function() {
        init();
       });
  function init() {
  	var radio1 = document.getElementsByName("statesRadio");
  	var sm= new Array();
        			for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
							 sm =opFlag.split("|");
							var ogins =sm[0];
							if(sm[1]=="0") {
							rdShowMessageDialog("ҵ�����뵱�ղ���ȡ�������Գ�����");
							var oButton = document.getElementById("next"); 
              oButton.disabled = true;
							return false;
							}
							var oButton = document.getElementById("next"); 
              oButton.disabled = false;
							var getdataPacket = new AJAXPacket("fe382_query.jsp","���ڻ�ò�������·�������Ժ�......");
							getdataPacket.data.add("phoneNo","<%=activePhone%>");
							getdataPacket.data.add("oldlogins",ogins);
							getdataPacket.data.add("projectType",sm[2]);
							getdataPacket.data.add("projectCode",sm[3]);
							core.ajax.sendPacket(getdataPacket);
							getdataPacket = null;
							$("#projectType").val(sm[2]);
							$("#projectCode").val(sm[3]);
							
				    }
		     }
  }
  		function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
			var bodefutypes1 = packet.data.findValueByName("bodefutypes");
			var bodefusamount1 = packet.data.findValueByName("bodefusamount");
			var acdefutypes1 = packet.data.findValueByName("acdefutypes");
			var acdefusamount1 = packet.data.findValueByName("acdefusamount");
			var giadefuntype1 = packet.data.findValueByName("giadefuntype");
			var gitdeamount1 = packet.data.findValueByName("gitdeamount");
			var prgitefutypes1 = packet.data.findValueByName("prgitefutypes");
			var prgiteconamount1 = packet.data.findValueByName("prgiteconamount");
			var codeamount1 = packet.data.findValueByName("codeamount");
			var prgitereamount1 = packet.data.findValueByName("prgitereamount");
			var fillcash1 = packet.data.findValueByName("fillcash");
		  document.frm.bodefutypes.value=bodefutypes1;
		  document.frm.bodefusamount.value=bodefusamount1;
		  document.frm.acdefutypes.value=acdefutypes1;
		  document.frm.acdefusamount.value=acdefusamount1;
		  document.frm.giadefuntype.value=giadefuntype1;
		  document.frm.gitdeamount.value=gitdeamount1;
		  document.frm.prgitefutypes.value=prgitefutypes1;
		  document.frm.prgiteconamount.value=prgiteconamount1;
		  if (prgitefutypes1 == "DL") {
		  	$("#prgitefutypes1Tr").hide();
		  	$("#prgitefutypes2Tr").show();
			  document.frm.prgitefutypes2.value=prgitefutypes1 + "---����ҵ��ר��";
			  document.frm.prgiteconamount2.value=prgiteconamount1;
		  } else if (prgitefutypes1 == "CZ") {
		  	$("#prgitefutypes1Tr").show();
		  	$("#prgitefutypes2Tr").hide();
			  document.frm.prgitefutypes1.value=prgitefutypes1 + "---Ԥ��������";
			  document.frm.prgiteconamount1.value=prgiteconamount1;
		  } else if (prgitefutypes1 == "T") {
		  	$("#prgitefutypes1Tr").show();
		  	$("#prgitefutypes2Tr").hide();
			  document.frm.prgitefutypes1.value=prgitefutypes1 + "---����Ԥ���";
			  document.frm.prgiteconamount1.value=prgiteconamount1;
		  }
		  document.frm.codeamount.value=codeamount1;
		  document.frm.prgitereamount.value=prgitereamount1;
		  document.frm.fillcash.value=fillcash1;
		  document.frm.prgitereamountsss.value=prgitereamount1;
		  		var oButton = document.getElementById("next"); 
          oButton.disabled = false;
			}else{
				rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
					var oButton = document.getElementById("next"); 
          oButton.disabled = true;
				return false;
			}
		}


  function frmCfm()
  {
    	var radio1 = document.getElementsByName("statesRadio");
    	var sm3= new Array();	
        			for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
									sm3=opFlag.split("|");
									var oldlgisw=sm3[0];
									document.frm.oldlogins.value=oldlgisw;
									if(sm3[1]=="0") {
									rdShowMessageDialog("ҵ�����뵱�ղ���ȡ�������Գ�����");
									return false;
									}
				    }
		     }
 	frm.submit();
	return true;
  }

  function printCommit()
  {
	//У��
	setOpNote();//Ϊ��ע��ֵ
 //��ӡ�������ύ��
  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
      {
	    frmCfm();
      }
	}
  }
  else
  {
     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     {
	   frmCfm();
     }
  }
  return true;
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���

	var h=210;
	var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";



     var pType="subprint";                  // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=confimAccept%>;       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                    //�ʷѴ���
     var fav_code=null;                     //�ط�����
     var area_code=null;                    //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = <%=activePhone%>;                            //�ͻ��绰
       /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    /* ningtn */

    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.phoneNo.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
}
function printInfo(printType)
{


		var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";


		cust_info+="�ֻ����룺"+"<%=activePhone%>"+"|";
		cust_info+="�ͻ�������"+document.frm.bp_name.value+"|";

		opr_info+="ҵ�����ͣ�����Ԥ���Ӫ����ȡ�� "+"|";
		//opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
		opr_info+="�ͻ��貹�����ѽ�"+document.frm.fillcash.value+"Ԫ|";

	note_info1+="����Ԥ�滰����δ�������ǰ�������ظ������ҵ��ͬʱ���ܰ�������Ԥ�����ͻ�����Ӫ��������ҵ����ǰ������ȡ������ΥԼ�涨��Ӧ���������ܵ�����Ԥ����������ʣ��Ԥ����30%����ΥԼ��"+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

    return retInfo;


}


/******Ϊ��ע��ֵ********/
  function setOpNote()
  {
	if(document.frm.opNote.value.trim()=="")
	{
	  	document.frm.opNote.value = "����Ԥ���Ӫ����ȡ��; �ֻ�����:<%=activePhone%>";
	}
		return true;
  }
 function sradios(obj) {
              var sm1= new Array();
              sm1=obj.value.split("|");
              var olgis=sm1[0];
             if(sm1[1]=="0") {
							rdShowMessageDialog("ҵ�����뵱�ղ���ȡ�������Գ�����");
							var oButton = document.getElementById("next"); 
              oButton.disabled = true;
							return false;
							}
							var oButton = document.getElementById("next"); 
              oButton.disabled = false;
 							var getdataPacket = new AJAXPacket("fe382_query.jsp","���ڻ�ò�������·�������Ժ�......");
							getdataPacket.data.add("phoneNo","<%=activePhone%>");
							getdataPacket.data.add("oldlogins",olgis);
							getdataPacket.data.add("projectType",sm1[2]);
							getdataPacket.data.add("projectCode",sm1[3]);
							core.ajax.sendPacket(getdataPacket);
							getdataPacket = null;
							$("#projectType").val(sm1[2]);
							$("#projectCode").val(sm1[3]);
 }
</script>


</head>


<body>
<form name="frm" action = "fe382Cfm.jsp" method="post"    >
<input name="prgitefutypes" type="hidden" id="prgitefutypes">
<input name="prgiteconamount" type="hidden" id="prgiteconamount">
<%@ include file="/npage/include/header.jsp" %> 
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0" >
		  <tr>
		    <td class="blue">�ֻ�����</td>
            <td>
			  <input name="phoneNo" type="text"   id="phoneNo" value="<%=activePhone%>"  Class="InputGrey" readonly>
			</td>
		    <td class="blue">�ͻ�����</td>
            <td>
			  <input name="bp_name" type="text"   id="bp_name" value="<%=custname%>"  Class="InputGrey" readonly>
			</td>
          </tr>

          <tr >
          
          	<td class="blue">��ȡ���Ļ</td>
            <td colspan="3" height="32">
              <table>
              	<tr>
              		<th width="4%"></th>
              		<th width="14%">��������</th>
              		<th width="21%">��������</th>
              		<th width="22%">���ʼʱ��</th>
              		<th width="22%">�����ʱ��</th>
              		<th>��ˮ</th>             		
              	</tr>
<%
								if(retCode.equals("000000")) {
									if(result1.length>0){
										 String smoren="";
                     for(int i=0;i<result1.length;i++) {
                     if(i==0) {
                     smoren=" checked";
                     }else {
                     	smoren="";
                     }
%>
							<tr> 
								<td ><input type="radio" name="statesRadio" value="<%=result1[i][4]%>|<%=result1[i][5]%>|<%=result1[i][6]%>|<%=result1[i][7]%>"  onclick="sradios(this)" <%=smoren%>></td>
								<td ><%=result1[i][0]%></td>
								<td ><%=result1[i][1]%></td>
								<td ><%=result1[i][2]%></td>
								<td ><%=result1[i][3]%></td>
								<td ><%=result1[i][4]%></td>
							</tr>
<%                   }
											
                   }	
                }
%>
 
							</table>
            </td>

          <tr>

			<td class="blue">����Ԥ��ר������</td>
            <td>
			  <input name="bodefutypes" type="text"   id="bodefutypes"   value=""  Class="InputGrey" readonly>
			</td>
			<td class="blue">����Ԥ��ר��ʣ����</td>
            <td>
			   <input name="bodefusamount" type="text"    id="bodefusamount" value="" Class="InputGrey" readonly>
			</td>
          </tr>
                    <tr>

			<td class="blue">�Ԥ��ר������</td>
            <td>
			  <input name="acdefutypes" type="text"   id="acdefutypes"   value=""  Class="InputGrey" readonly>
			</td>
			<td class="blue">�Ԥ��ר��ʣ����</td>
            <td>
			   <input name="acdefusamount" type="text"    id="acdefusamount" value="" Class="InputGrey" readonly>
			</td>
          </tr>
      
      <tbody name="prgitefutypes1Tr" id="prgitefutypes1Tr">
				<tr>
					<td class="blue">Ԥ��������ר��</td>
					<td>
						<input name="prgitefutypes1" type="text"    id="prgitefutypes1" value="" Class="InputGrey" readonly>
					</td>
					<td class="blue">Ԥ��������ʣ����</td>
					<td>
						<input name="prgiteconamount1" type="text"    id="prgiteconamount1" maxlength="60" Class="InputGrey" readonly>
					</td>
				</tr>
      </tbody>
      <tbody name="prgitefutypes2Tr" id="prgitefutypes2Tr">
				<tr>
					<td class="blue">����ҵ��ר��</td>
					<td >
						<input name="prgitefutypes2" type="text"    id="prgitefutypes2" maxlength="60" Class="InputGrey" readonly>
					</td>
					<td class="blue">����ҵ��ר��ʣ����</td>
					<td>
						<input name="prgiteconamount2" type="text"    id="prgiteconamount2" maxlength="60" Class="InputGrey" readonly>
					</td>
				</tr>
			</tbody>
			<tr>
				<td class="blue">��תԤ����</td>
				<td>
					<input name="codeamount" type="text"    id="codeamount" value="" Class="InputGrey" readonly>
				</td>
				<td class="blue">Ԥ��������Ӧ�����ۼƽ��</td>
				<td>
					<input name="prgitereamount" type="text"    id="prgitereamount" maxlength="60" Class="InputGrey" readonly>
				</td>
			</tr>
                    
			<tr>
				<td class="blue">�û�Ӧ�����ֽ�</td>
				<td >
					<input name="fillcash" type="text"    id="fillcash" maxlength="60" Class="InputGrey" readonly>
				</td>
				<td class="blue">Ԥ���������������ۼƽ��</td>
				<td>
					<input name="prgitereamountsss" type="text"    id="prgitereamountsss" maxlength="60" Class="InputGrey" readonly>
				</td>
			</tr>
          <tr  >
            <td class="blue">��ע</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"   id="opNote" size="60" maxlength="60" value="" >
            </td>
          </tr>
         
          	<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=confimAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
         
          </table>
<table cellspacing="0">
		  <tr >

            <td colspan="4"> <div align="center">
                &nbsp;
			       	<input name="next" id="next" type="button" class="b_foot"   value="ȷ��&��ӡ" onClick="printCommit()" >
                &nbsp;
                <input name="back" onClick="history.go(-1)" type="button" class="b_foot"  value="����">
                &nbsp;
                <input name="closedd" onClick="removeCurrentTab();" type="button" class="b_foot"  value="�ر�">

				</div>
			</td>
          </tr>
          </table >
      
		<input type="hidden" name="oldlogins" id="oldlogins" >
		<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
		<input type="hidden" name="opName" id="opName" value="<%=opName%>">
		<input type="hidden" name="giadefuntype" id="giadefuntype" ><%//����Ԥ���ר������(���ֶ�ǰ̨���أ�����Ϊȡ��ʱ�����ƷѵĲ���)%>
		<input type="hidden" name="gitdeamount" id="gitdeamount" ><%//����Ԥ�����(���ֶ�ǰ̨���أ�����Ϊȡ��ʱ�����ƷѵĲ���)%>
		<input type="hidden" name="confimAccept" id="confimAccept" value="<%=confimAccept%>">
		<input type="hidden" name="projectType" id="projectType" value="">
		<input type="hidden" name="projectCode" id="projectCode" value="">
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>


