<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����ͨ��ԭ���������˷�����������ҵ��
   * �汾: 2.0
   * ����: 2011/1/5
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String phoneNo = request.getParameter("phoneNo");
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	//String custSql = "select doc.cust_name,doc.id_iccid from dcustmsg msg,dcustdoc doc where msg.cust_id = doc.cust_id and msg.phone_no='"+phoneNo+"'";
	String custSql = "   select doc.cust_name,doc.id_iccid,doc.id_type,sm.sm_name from dcustmsg msg,dcustdoc doc ,ssmcode sm where msg.cust_id = doc.cust_id and substr(msg.run_code,2,1) = 'A'  and msg.phone_no='"+phoneNo+"'  and substr(msg.belong_code,0,2)=sm.region_code and msg.sm_code=sm.sm_code";
	String custName = "";
	String propBirthday = "";
	String idNo = "";
	java.util.Date date = new java.util.Date();
	java.text.DateFormat format = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
	String todayTime = format.format(date);

	String chnSource		= "10";	//������ʶ
	String loginNo			= (String)session.getAttribute("workNo");	//��������
	String loginPwd			= (String)session.getAttribute("password");	//��������
	String userPwd			= "";	//��������
	String type_flag		= "";
	String offer_id			= "";
	String startTime		= "";
	String endTime			= "";
	//String custName			= "";
	String custSex			= "";
	//String propBirthday		= "";
	//String idNo		= "";
	String propDistrict		= "";
	String propAddress		= "";
	String propTelephone	= "";
	String feeFlag			= "";
	String feePhone			= "";
	String feePwd			= "";
	String userAccounts		= "";
	String propCommunity	= "";
	String propUrgentRoutes	= "";
	String propLifeStyle	= "";
	String isReportSafe		= "";
	String reportCycle		= "";
	String reportName		= "";
	String reportMobile		= "";
	String reportWay		= "";
	//20120921���� ���������Ϣ��
	String relaInfoStr = "";
	//20120921 gaopeng������ӡ��ˮ
	String PrintAccept="";
	PrintAccept = getMaxAccept();
	//20120921 gaopeng�����û�Ʒ��
	String sm_name      ="";

%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>����ͨ</title>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:sql><%=custSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result11" scope="end" />
<%
		if(result11.length <= 0){
%>
<script language="JavaScript">
			rdShowMessageDialog("���û����������û���״̬��������");
			window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
			return ;
		}else{
			custName = result11[0][0];
			idNo = result11[0][1];
			sm_name = result11[0][3];
			if(idNo.length() == 18){
				propBirthday = idNo.substring(6, 14);
			}else{
				propBirthday = "";
			}

		}
%>
<%
		if("d078".equals(opCode)){
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
		<wtc:service name="sD077Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="28">
			<wtc:param value="<%=loginAccept%>" />
			<wtc:param value="<%=chnSource%>" />
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginPwd%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="<%=userPwd%>" />
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
		if(!errCode.equals("000000")){
%>
<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
			window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
		}
		if(result1.length <= 0){
%>
<script language="JavaScript">
			rdShowMessageDialog("���û�δ�����������ͨҵ��");
</script>
<%
			return ;
		}else{

			//�ײ����ͣ�01�������ײͣ�02�������ײͣ�
			type_flag			= ("NULL".equals(result1[0][2]))?"":result1[0][2]; 
			//��ʼʱ��
			startTime			= ("NULL".equals(result1[0][3]))?"":result1[0][3];
			//����ʱ��
			endTime				= ("NULL".equals(result1[0][4]))?"":result1[0][4];
			//����������
			custName			= ("NULL".equals(result1[0][5]))?"":result1[0][5];
			//�������Ա�
			custSex				= ("NULL".equals(result1[0][6]))?"":result1[0][6];
			//��������
			propBirthday		= ("NULL".equals(result1[0][7]))?"":result1[0][7];
			//���֤��
			idNo			= ("NULL".equals(result1[0][8]))?"":result1[0][8];
			//������
			propDistrict		= ("NULL".equals(result1[0][9]))?"":result1[0][9];
			//��ס��ϸ��ַ
			propAddress			= ("NULL".equals(result1[0][10]))?"":result1[0][10];
			//�����˳�ס�̻�
			propTelephone		= ("NULL".equals(result1[0][11]))?"":result1[0][11];
			//�Ƿ��趨���Ѻ��루N-��Y-�ǣ�
			feeFlag				= ("NULL".equals(result1[0][12]))?"":result1[0][12];
			//���Ѻ���
			feePhone			= ("NULL".equals(result1[0][13]))?"":result1[0][13];
			//�û���¼�ʺ�
			userAccounts		= ("NULL".equals(result1[0][14]))?"":result1[0][14];
			//����
			propCommunity		= ("NULL".equals(result1[0][15]))?"":result1[0][15];
			//�������ȳ������ﳣס�ص�·��
			propUrgentRoutes	= ("NULL".equals(result1[0][16]))?"":result1[0][16];
			//�������������
			propLifeStyle		= ("NULL".equals(result1[0][17]))?"":result1[0][17];
			//�Ƿ���Ҫ��ƽ������
			isReportSafe		= ("NULL".equals(result1[0][18]))?"":result1[0][18];
			//��ƽ�����ڣ�ÿx�챨һ�Σ�
			reportCycle			= ("NULL".equals(result1[0][19]))?"":result1[0][19];
			//��ƽ�����շ�����
			reportName			= ("NULL".equals(result1[0][20]))?"":result1[0][20];
			//��ƽ�����շ��ƶ��绰
			reportMobile		= ("NULL".equals(result1[0][21]))?"":result1[0][21];
			//��ƽ����ʽѡ��01���绰+���ţ�02��ֻ�Ƕ��ţ�
			reportWay			= ("NULL".equals(result1[0][22]))?"":result1[0][22];
			//������Ϣ��
			relaInfoStr = ("NULL".equals(result1[0][23]))?"":result1[0][23];
			//�ʷѴ���
			offer_id 	= ("NULL".equals(result1[0][27]))?"":result1[0][27];
		}
%>
		<script type="text/javascript">
			$(document).ready(function(){
				/*====innet====*/
				/*alert("<%=propDistrict%>");*/
				$("#offerId").val("<%=offer_id%>");
				$("#startTime").val("<%=startTime%>");
				$("#endTime").val("<%=endTime%>");
				$("#custName").val("<%=custName%>");
				$("#idNo").val("<%=idNo%>");
				
				$("#propBirthday").val("<%=propBirthday%>");
				$("#propDistrict").val("<%=propDistrict%>");
				
				$("#propAddress").val("<%=propAddress%>");
				$("#propTelephone").val("<%=propTelephone%>");
	
				$("#feePhone").val("<%=feePhone%>");
				$("#feePhone1").val("<%=feePhone%>");
				$("#userAccounts").val("<%=userAccounts%>");
				$("#propCommunity").val("<%=propCommunity%>");
				$("#propUrgentRoutes").val("<%=propUrgentRoutes%>");
		

				$("#reportCycle").val("<%=reportCycle%>");
				$("#reportName").val("<%=reportName%>");
				$("#reportMobile").val("<%=reportMobile%>");

					if("<%=offer_id%>"=="34515")
					{
						$("#type_flag_del").val("����ͨҵ������ײ�--34515");
					}
					if("<%=offer_id%>"=="46865")
					{
						$("#type_flag_del").val("����ͨD�ײ�--46865");
					}
					if("<%=offer_id%>"=="34517")
					{
						$("#type_flag_del").val("����ͨҵ�������ײ�--34517");
					}
					if("<%=offer_id%>"=="36724")
					{
						$("#type_flag_del").val("����ͨA�ƻ�3Ԫ-0.50--36724");
					}
					if("<%=offer_id%>"=="36725")
					{
						$("#type_flag_del").val("����ͨB�ƻ�5Ԫ-0.40--36725");
					}
					if("<%=offer_id%>"=="36726")
					{
						$("#type_flag_del").val("����ͨC�ƻ�8Ԫ-0.20--36726");
					}

				if("<%=propLifeStyle%>"=="01")
				{
					$("#propLifestyle").val("����Ůͬס");
				}else if("<%=propLifeStyle%>"=="02"){
					$("#propLifestyle").val("����ż����");
				}else if("<%=propLifeStyle%>"=="03"){
					$("#propLifestyle").val("����������");
				}else if("<%=propLifeStyle%>"=="04"){
					$("#propLifestyle").val("��������");
				}else
				{
				$("#propLifestyle").val("����");
				}
				
				if("<%=custSex%>"=="0")
				{
					$("#custSex").val("��");
				}else{
					$("#custSex").val("Ů");					
				}

				if("<%=feeFlag%>"=="N")
				{
					$("#feeFlay").val("��");
				}else{
					$("#feeFlay").val("��");
					//ava $("#trd1").css("display","block");
				}

				if("<%=reportWay%>"=="01")
				{
					$("#reportWay").val("�绰+����");
				}else{
					$("#reportWay").val("����");
				}

				if("<%=type_flag%>" == "02"){//if �����ײ�
					$("#sq").css("display","block");
					$("#propCommunity").css("display","block");
					$("#t3").css("display","block");
					$("#t4").css("display","block");
					if("<%=isReportSafe%>"=="02")
					{
						$("#isReportSafe").val("��");
						$("#t1").css("display","none");
						$("#t2").css("display","none");
					}else{
					  $("#isReportSafe").val("��");						
						$("#t1").css("display","block");
						$("#t2").css("display","block");
					}
				}
			});
		</script>
<%
		}
%>
<script type="text/javascript">
  function doCommit(){
  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		if(typeof(ret)!="undefined")
						  {
						    if((ret=="confirm"))
						    {
						      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
						      {
							   		frmCfm1();
						      }
							}
							if(ret=="continueSub")
							{
						      if(rdShowConfirmDialog('�Ƿ�ȷ��������')==1)
						      {
							    	frmCfm1();
						      }
							}
						  }
						  else
						  {
						     if(rdShowConfirmDialog('�Ƿ�ȷ��������')==1)
						     {
							     frmCfm1();
						     }
						  }	
						  return true;
  }
  function frmCfm1()
  {
	  	document.f1.action="fd078Cfm.jsp";
			document.f1.submit();
			$("#confirm").attr("disabled",true);
			return true;
  }
  function showPrtDlg(printType,DlgMessage,submitCfm)
			{  //��ʾ��ӡ�Ի���
				var h=180;
				var w=350;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				
				var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
				var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
				var sysAccept ="<%=PrintAccept%>";
				var printStr =  printInfo(printType);
				var mode_code=null;           							//�ʷѴ���
				var fav_code=null;                				 		//�ط�����
				var area_code=null;             				 		//С������
				var opCode="d078" ;                   			 		//��������
				var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";  
				var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
				path+="&mode_code="+mode_code+
					"&fav_code="+fav_code+"&area_code="+area_code+
					"&opCode=<%=opCode%>&sysAccept="+sysAccept+
					"&phoneNo="+document.f1.phoneNo.value+
					"&submitCfm="+submitCfm+"&pType="+
					pType+"&billType="+billType+ "&printInfo=" + printStr; 
				var ret=window.showModalDialog(path,printStr,prop);
				return ret;   
			}
			
	function printInfo(printType)
			{
				/*20120921 gaopeng ȡ��Ȩ��λ�˺��루�����","�����*/
				var resultPhoneFA="";
				//������Ϣ�����ܶ�����
				var relaInfo = "<%=relaInfoStr%>";
				if(relaInfo.length!=0){
				//���ֻ��һ������
				if(relaInfo.indexOf("|")==-1)
				{
					resultPhoneFA = relaInfo.split("~")[2];
				}
				else if(relaInfo.indexOf("|")!=-1)
				{
					var relas = relaInfo.split("|");
					for(var i=0;i<relas.length;i++)
					{
						if(resultPhoneFA=="")
						{
							resultPhoneFA = relas[i].split("~")[2];
						}
						else{
						resultPhoneFA = resultPhoneFA +","+ relas[i].split("~")[2];
							}
					}
					
				}
			}
				
				var cust_info="";  				//�ͻ���Ϣ
				var opr_info="";   				//������Ϣ
				var note_info1=""; 				//��ע1
				var note_info2=""; 				//��ע2
				var note_info3=""; 				//��ע3
				var note_info4=""; 				//��ע4
				var retInfo = "";  				//��ӡ����
				
				cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
				cust_info+="�ͻ�������"+document.all.custName.value+"|";
				cust_info+="֤�����룺"+document.all.idNo.value+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
			  opr_info+="����ҵ������ͨҵ��ȡ��"+"|";
				opr_info+="������ˮ��"+document.all.loginAccept.value+"|";
				opr_info+="ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>"+"|";
				
				opr_info+="�û�Ʒ�ƣ�<%=sm_name%>"+"|";
				/* begin for ��������������ͨ���ײ��ʷѺ�����Ӫ�������ĺ� @2014/12/2 */
			  var note1 = "";
	   		var note2 = "";
        var chkPacket = new AJAXPacket ("fd076_ajax_getPrintNotes.jsp","��ȴ�������");
				chkPacket.data.add("type_flag" , "<%=offer_id%>");
				core.ajax.sendPacket(chkPacket,function(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					var note1 = packet.data.findValueByName("note1");
					var note2 = packet.data.findValueByName("note2");
					if(retCode!="000000"){
	          rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
	          return false;
          }else{
          	note_info1 += "ȡ���ײ����ƣ�"+ note1 + "|";
          	note_info1 += "ȡ���ײ�������"+ note2 + "|";
          }
				});
				chkPacket =null; 	
		    /* end for ��������������ͨ���ײ��ʷѺ�����Ӫ�������ĺ� @2014/12/2 */
		    /*
		    if("<%=offer_id%>" == "34515") {
		    	note_info1+="ȡ���ײ����ƣ�����ͨҵ������ײ�|";
		    	note_info1+="ȡ���ײ����������ܷ�8Ԫ/�£����������Ͳ��֣��򰴳�������ʷѱ�׼���շ��ã���������룺������6��������룬";
		    	note_info1+="ÿ�����ͱ��ز��������������ʱ��100���ӣ��������Ͳ���0.10Ԫ/���ӣ�������ѣ��������Ϊ���ص��й��ƶ��ֻ����룬�������ÿ��ֻ���޸�һ�Σ��޸ĺ�������Ч��";
		    	note_info1+="��λ��������ÿ��10�ζ�λ���񣬳�������1��/Ԫ��������������ĺ���Ȩ��λ�ֻ����뷢���";
		    	note_info1+="��λ�������������ձ�׼�ʷ���ȡ��|";	
		    	}	  
		    if("<%=offer_id%>" == "36724") {
		    	note_info1+="ȡ���ײ����ƣ�����ͨA�ƻ�3Ԫ-0.50|";
		    	note_info1+="ȡ���ײ��������¹��ܷ�3Ԫ�����������������������30���ӣ���������һ��������루�����ƶ������ʡ���ƶ����룩��";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.50Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";
					note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
		    	}  
		     if("<%=offer_id%>"== "36725") {
		     	note_info1+="ȡ���ײ����ƣ�����ͨB�ƻ�5Ԫ-0.40|";
		    	note_info1+="ȡ���ײ��������¹��ܷ�5Ԫ�����������������������50���ӣ�5�����鶨λ/�£���������3��������루�����ƶ������ʡ���ƶ����룬ʡ���ƶ����벻����1������";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.40Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";
		    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"	
		    	}
		    	if("<%=offer_id%>" == "36726") {
		    	note_info1+="ȡ���ײ����ƣ�����ͨC�ƻ�8Ԫ-0.20|";
		    	note_info1+="ȡ���ײ��������¹��ܷ�8Ԫ�����������������������150���ӣ���������6��������루�����ƶ������ʡ���ƶ����룬ʡ���ƶ����벻����2������";
		    	note_info1+="���򱾵��������0.05Ԫ/���ӣ�����ʡ���������0.15Ԫ/���ӣ�";
		    	note_info1+="���鶨λ0.20Ԫ/�Ρ��������ձ�׼�ʷ���ȡ��|";	
		    	note_info1+="�����������������Ч��ȡ������������Ч��ÿ�½�������һ�Σ�ÿ�α��1�����롣|"
		    	}		
		    	if("<%=offer_id%>" == "34517") {
		    	note_info1+="ȡ���ײ����ƣ�����ͨҵ�������ײ�|";
		    	note_info1+="ȡ���ײ��������¹��ܷ�15Ԫ/�£����������Ͳ��֣��򰴳�������ʷѱ�׼���շ��ã���������6��������룬ÿ�����ͱ��ز������������ʱ��100���ӣ��������Ͳ���0.10Ԫ/���ӣ�����";
		    	note_info1+="��ѣ��������Ϊ���ص��й��ƶ��ֻ����룬�������ÿ��ֻ���޸�һ�Σ��޸ĺ�������Ч������Ԯ������Ѱδ��˹�����ƽ̨9679566�����޴�����������ѯ��ÿ������30������ѽ����˹�����ƽ";
		    	note_info1+="̨967956ͨ��ʱ��������ʱ���ͳ�������ʱ���ļƷѣ��������ֱ��ػ����Σ����������Ͳ���0.1";
		    	note_info1+="Ԫ/���ӣ����е��˹���λ����������ն�λ�����ķ��á��������ձ�׼�ʷ���ȡ��|";	
		    	}*/
		    	if(resultPhoneFA.length!=0){
		    	note_info1+="ȡ����Ȩ��λ�˺��룺"+resultPhoneFA+"��|";
		  		}
		  		if(resultPhoneFA.length==0)
		  		{
		  			note_info1+="ȡ����Ȩ��λ�˺��룺�ޡ�|";
		  		}
		  		
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
			  return retInfo;
			}		
				
</script>
	</head>
	<body>
		<form method="post" id="f1" name="f1" onKeyUp="chgFocus(f1)">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">����ͨҵ�������Ϣ</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td width="10%" class="blue">�ײ�����</td>
					<td width="20%" class="blue">
		      	<input type="text" value="" name="type_flag_del" id="type_flag_del" readonly  class="InputGrey" style="width:145px"/>
					</td>
					<td width="10%" class="blue">��������</td>
					<td width="20%" class="blue">
						<input type="text" value="����ͨҵ��" readonly class="InputGrey"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">��ͨ����</td>
					<td width="20%" class="blue">
						<input class="InputGrey" readonly  type="text"  name="phoneNo" id="phoneNo" value="<%=phoneNo%>">
					</td>
					<td width="10%" class="blue">�û���¼�ʺ�</td>
					<td width="20%" class="blue">
						<input type="text"  id="userAccounts" name="userAccounts"  value="<%=phoneNo%>" readonly class="InputGrey" />
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">�ͻ�����</td>
					<td width="20%" class="blue">
						<input type="text" name="custName" id="custName" value="<%=custName%>" readonly class="InputGrey"/>
					</td>
					<td width="10%" class="blue">�û�ID</td>
					<td width="20%" class="blue">
						<input type="text" name="idNo" id="idNo" value="<%=idNo%>" readonly class="InputGrey"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">�Ա�</td>
					<td width="20%" class="blue">
						<input type="text" value="" name="custSex" id="custSex" readonly class="InputGrey" />
					</td>
					<td width="10%" class="blue">��������</td>
					<td width="20%" class="blue">
						<input type="text" name="propBirthday" id="propBirthday" value="<%=propBirthday%>" readonly class="InputGrey"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">������</td>
					<td width="20%" class="blue">
						<input type="text" name="propDistrict" id="propDistrict" readonly class="InputGrey"/>
					</td>
					<td width="10%" class="blue"><span id="sq" style="display:none">����</span></td>
					<td width="20%" class="blue">
						<input type="text" name="propCommunity" onblur="checkElement(this)" id="propCommunity" readonly class="InputGrey" style="display:none"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">��ס�ع̻�</td>
					<td width="20%" class="blue">
						<input type="text" name="propTelephone" id="propTelephone" readonly class="InputGrey"/>
					</td>
					<td width="10%" class="blue">��ס����ϸ��ַ</td>
					<td width="20%" class="blue">
						<input type="text" name="propAddress" id="propAddress" size="40" readonly class="InputGrey"/>
					</td>
				</tr>
				<tr id="t3" style="display:none">
					<td width="10%" class="blue">���ȳ������ﳣס�ص�·��</td>
					<td width="20%" class="blue">
						<input type="text" name="propUrgentRoutes" id="propUrgentRoutes" readonly  class="InputGrey" />
					</td>
					<td width="10%" class="blue">�������������</td>
					<td width="20%" class="blue">
						<input type="text" value="" name="propLifestyle" id="propLifestyle" readonly  class="InputGrey" />
					</td>
				</tr>
				<tr id="t4" style="display:none">
					<td width="10%" class="blue">�Ƿ���Ҫ��ƽ������</td>
					<td width="20%" class="blue">
						<input type="text" value="" name="isReportSafe" id="isReportSafe" readonly  class="InputGrey" />
					</td>
					<td width="10%" class="blue">&nbsp;</td>
					<td width="20%" class="blue">
							&nbsp;
					</td>
				</tr>
				<tr id="t1" style="display:none">
					<td width="10%" class="blue">��ƽ������</td>
					<td width="20%" class="blue">
						<input type="text" name="reportCycle" id="reportCycle" readonly  class="InputGrey"/>��
					</td>
					<td width="10%" class="blue">����������</td>
					<td width="20%" class="blue">
						<input type="text" name="reportName" id="reportName" readonly  class="InputGrey"/>
					</td>
				</tr>
				<tr id="t2" style="display:none">
					<td width="10%" class="blue">�������ƶ��绰</td>
					<td width="20%" class="blue">
						<input type="text" name="reportMobile" id="reportMobile" readonly  class="InputGrey"/>
					</td>
					<td width="10%" class="blue">���ܷ�ʽ</td>
					<td width="20%" class="blue">
						<input type="text" value="" name="reportWay" id="reportWay" readonly class="InputGrey" />
					</td>
				</tr>
				<tr style="display:none">
					<td width="10%" class="blue">�Ƿ��趨���Ѻ���</td>
					<td width="20%" class="blue" >
						<input type="text" value="" name="feeFlay" id="feeFlay" readonly  class="InputGrey" />
					</td>
					<td>&nbsp;</td><td>&nbsp;</td>
				</tr>


				<tr style="display:none" id="trd1">
					<td width="10%" class="blue">���Ѻ���</td>
					<td width="20%" class="blue">
						<input type="text" name="feePhone1"  id="feePhone1" readonly  class="InputGrey"/>
					</td>
					<td>&nbsp;</td><td>&nbsp;</td>
				</tr>


				<tr>
					<td width="10%" class="blue">��ʼʱ��</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 id="startTime" value="<%=todayTime%>" name="startTime" readonly class="InputGrey" />
					</td>
					<td width="10%" class="blue">����ʱ��</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 id="endTime" value="20500101235959" name="endTime" readonly class="InputGrey"/>
					</td>
				</tr>
			</table>



			<table cellspacing="0">
				<tr>
					<td colspan="4" id="footer">
			           <div align="center">
	                 <input class="b_foot" name="print"  onClick="doCommit()" type=button id="confirm" value=ȷ��> &nbsp;
						     	 <input class="b_foot" type="button" name="qryP" value="����" onClick="history.go(-1)">
			            </div>
			        </td>
				</tr>
			</table>
			<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>"/>
			<input type="hidden" name="opName" id="opName" value="<%=opName%>"/>
			<input type="hidden" name="loginAccept" id="loginAccept" value="<%=PrintAccept%>"/>
			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>