<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ȫ��ͨVIP�򳵷���
   * �汾: 2.0
   * ����: 2011/11/16
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");	
	String IDType = request.getParameter("IDType");	
	String custPWD = request.getParameter("custPWD");	
	
	System.out.println("-------------custPWD-----------------"+custPWD);	
	String cardType = request.getParameter("cardType");		
	String cardID = request.getParameter("cardID");			

	String opName = "ȫ��ͨVIP�򳵷���";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String tri_detailMsg = "";
	String cust_attribute = "";
	String cust_breed = "";
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	//huangrong add ��ȡ������Ϣ 2011-7-1 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] temfavStr=(String[][])arrSession.get(3);
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
	favStr[i]=temfavStr[i][0].trim();
	boolean pwrf=false;
	if(Pub_lxd.haveStr(favStr,"a272"))
	pwrf=true;
	String ICCID = "";
	System.out.println("-------------pwrf-----------------"+pwrf);	
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%!
		    public static String createArray(String aimArrayName, int xDimension) {
		        String stringArray = "var " + aimArrayName + " = new Array(";
		        int flag = 1;
		        for (int i = 0; i < xDimension; i++) {
		            if (flag == 1) {
		                stringArray = stringArray + "new Array()";
		                flag = 0;
		                continue;
		            }
		            if (flag == 0) {
		                stringArray = stringArray + ",new Array()";
		            }
		        }
		
		        stringArray = stringArray + ");";
		        return stringArray;
		    }
		%>
							
		<%
			//��ȡһ��BOSS������ʡ��
			String proSql = "select substr(node_code,0,3),node_name from oneboss.sobexchgnode where domain_id = 'BOSS' order by node_code";
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:sql><%=proSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
		<%
		if(result.length > 0){
			for(int i=0;i<result.length;i++){
				System.out.println("node_code="+result[i][0]+"--------->node_name="+result[i][1]);
			}
		}else{
		%>
			rdShowMessageDialog("��ȡʡ����Ϣʧ�ܣ�");
		<%	
		}
				String printAccept="";
		%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=phoneNo%>" id="sLoginAccept"/>
		<%
			printAccept = sLoginAccept;
			//��ȡ�����б�
			String servSql = "select a.avc_code,a.item_code,a.item_name,a.item_price,a.item_score,b.avc_name from SVIPSvcItemCode a,SVIPSvcCode b where a.avc_code = b.avc_code";
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
		<wtc:sql><%=servSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
		<%
			if(result1.length <= 0){
		%>
				rdShowMessageDialog("��ȡ������Ϣʧ�ܣ�");
		<%
			}else{
				tri_detailMsg = createArray("servArr", result1.length);
			}
		%>
		
		<%
			//��ѯ�ͻ�����
			String custSql = " select b.card_name, c.sm_name from dcustmsg a, sBigCardCode b, ssmcode c where a.sm_code = c.sm_code and substr(belong_code, 0, 2) = c.region_code and substr(attr_code, 3, 2) = b.card_type and a.phone_no = '"+phoneNo+"'" ;    
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:sql><%=custSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result_cust" scope="end" />
		<%
		if(retCode2.equals("000000"))
		{	
			if(result_cust.length <= 0){
		%>
		<script language='jscript'>
							rdShowMessageDialog("��ȡ�ͻ���Ϣʧ�ܣ�");
    </script>
		<%
			}else{
				cust_attribute = result_cust[0][0];
				cust_breed = result_cust[0][1];
			}
		}
		%>
		
		<%
			//��ѯ�ͻ����֤��
			String custICCIDSql = "select a.id_iccid from dcustdoc a,dcustmsg b where a.cust_id = b.cust_id and b.phone_no=:phoneNoNew" ;
			String srv_param = "phoneNoNew=" + phoneNo;    
			
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retICCIDCode" retmsg="retICCIDCMsg" outnum="1">
			<wtc:param value="<%=custICCIDSql%>"/>
			<wtc:param value="<%=srv_param%>"/>
		</wtc:service>
		<wtc:array id="result_ICCID" scope="end" />
		<%
		if(retICCIDCode.equals("000000"))
		{	
			if(result_ICCID.length <= 0){
		%>
		<script language='jscript'>
				rdShowMessageDialog("��ȡ�ͻ���Ϣʧ�ܣ�");
    	</script>
		<%
			}else{
				ICCID = result_ICCID[0][0];
			}
		}
		%>
		
		
		<title>ȫ��ͨVIP�򳵷���</title>
		<script type="text/javascript">
		<%=tri_detailMsg%>	
			<%
			    for (int p = 0; p < result1.length; p++) {
			        for (int q = 0; q < result1[p].length; q++) {
			%>
						servArr[<%=p%>][<%=q%>]="<%=result1[p][q]%>";
			<%
			        }
			    }
			%>
				
			$(document).ready(function () {
				document.all.IDType.value="<%=IDType%>";
				document.all.cardType.value="<%=cardType%>";
				
									
				if (""!="<%=custPWD%>")
				{
					document.all.cardNo.value="<%=ICCID%>"
				}

				//չʾ�����б�
				for(var i=0;i<servArr.length;i++){
					if(servArr[i][0] != "03"){
						tr1=dyntb.insertRow();
						tr1.id=i;
						tr1.insertCell().innerHTML = '<div align="center"><input id="oneCode'+i+'" type=text size=8  value="'+ servArr[i][0]+'"  readonly></input><input id="oneName'+i+'" type="hidden" value="'+servArr[i][5]+'"/></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="twoCode'+i+'" type=text size=8  value="'+ servArr[i][1]+'"  readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="twoNameCode'+i+'" type=text   value="'+ servArr[i][2]+'"  readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input type=text   value="'+ servArr[i][2]+'"  maxlength="200" readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="price'+i+'" type=text align="right" size=9  style="text-align:right" value="'+ servArr[i][3]+'"  v_type=cfloat v_maxlength="12.2"  v_name="���" maxlength="9" readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="score'+i+'" type=text  align="right" size=12 style="text-align:right"  value="'+ servArr[i][4]+'"  v_type=0_9 v_minlength="1" v_name="�ۺ�Ӧ�ۻ���" maxlength="9" readonly></input></div>';
					}
				}
				//��Ȩ
				$("#vallidateBtn").bind("click",function(){
					if($("#custPhone").val()==""){
						rdShowMessageDialog("������ͻ���ʶ��");
						return;
					}
						
					/*
					//liujian 2013-4-2 16:44:40 ȥ����������֤��֤
					if("<%=pwrf%>"=="false")
					{
						if($("#custPwd").val()==""){
							rdShowMessageDialog("������ͻ����룡");
							return;
						}						
					}
					if($("#cardNo").val()==""){
						rdShowMessageDialog("������֤�����룡");
						return;
					}
					*/
					var packet = new AJAXPacket("ajaxChkCust.jsp?sheng_flag=n","���Ժ�...");
					packet.data.add("custPhone",$("#custPhone").val());
					packet.data.add("cardType",$("#cardType").val());
					packet.data.add("custPwd",$("#custPwd").val());
					packet.data.add("cardNo",$("#cardNo").val());
					packet.data.add("servLevel",$("#servLevel").val());
					packet.data.add("personNum",$("#personNum").val());
					core.ajax.sendPacket(packet,function(packet){
							var	errCode = packet.data.findValueByName("errCode");
							var	errMsg = packet.data.findValueByName("errMsg");
							var	flag = packet.data.findValueByName("flag");
							var oRejectReason = packet.data.findValueByName("oRejectReason");
							if(flag == "false"){//���ṩ����ʱ
								rdShowMessageDialog("������룺"+errCode+"��������Ϣ��"+errMsg);
								$("#custPhone").val("");
								$("#cardNo").val("");
								$("#custPwd").val("");
								$("#personNum").val("0");
								return ;
							}
							$("#custName").val(packet.data.findValueByName("oCustName"));//�ͻ�����
							$("#iccNo").val($("#cardNo").val());
							$("#oRejectReason").val(oRejectReason);//�ܾ�����
							var oUserStatus = packet.data.findValueByName("oUserStatus");//�ͻ�״̬
							$("#oUserStatus").val(oUserStatus);
							var oUserRank = packet.data.findValueByName("oUserRank");//�ͻ�����
							$("#oUserRank").val(oUserRank);
							$("#oSvcPhNum").val(packet.data.findValueByName("oSvcPhNum"));//��ͻ�������ϵ�绰
							$("#oUserScore").val(packet.data.findValueByName("oUserScore"));//�ͻ����û������
							var oUserScore=packet.data.findValueByName("oUserScore");
							if(oRejectReason == "00"){
								$("#confirm").attr("disabled",false);
								$("#countBtn").attr("disabled",false);
								var oRemainTimes= packet.data.findValueByName("oRemainTimes");//ʣ����Ѵ���
								var oUsedNu= packet.data.findValueByName("oUsedNu");//����ʹ�õ���Ѵ���
								var oUsedScor= packet.data.findValueByName("oUsedScor");//������Ҫ�Ļ�����	
								document.all.oUsedScor.value=oUsedScor;
								document.all.oUsedNu.value=oUsedNu;							
							  /*
								if((oUsedNu=="0" || oUsedNu == null) &&  (oUsedScor=="0" || oUsedScor==null))
								{
		            				rdShowMessageDialog("����VIP�û������л��ֿۼ�������ѽ���ʹ�ã�");	
		            				document.all.oResultNu.value=oRemainTimes;									
								}else
									{*/
								  	var resultNu =Number(oRemainTimes)-Number(oUsedNu);
										var resultScor =Number(oUserScore)-Number(oUsedScor);
										document.all.oResultNu.value=oRemainTimes;
										rdShowMessageDialog("����Ԥ�ƿۼ������ʹ�ô�����"+oUsedNu+"<br>����Ԥ�ƿۼ��Ļ�������"+oUsedScor+"<br>����ʹ�ú�ʣ����Ѵ�����"+resultNu+"<br>����ʹ�ú�ʣ��Ļ�������"+resultScor);			
									//}
							}else{
								rdShowMessageDialog("��֤ʧ�ܣ�ʧ��ԭ�������������ܾ����ɡ�");			
								$("#confirm").attr("disabled",true);
								$("#countBtn").attr("disabled",true);		
							}

						});
					packet = null;
				});
				//ȷ���ύ
				$("#confirm").bind("click",function(){
				  getAfterPrompt();
					document.all.servLeve.value=document.all.servLevel.value;
				  document.f1.confirm.disabled=true;//��ֹ����ȷ��
					 //��ӡ�������ύ��
					if(check(f1)){
					  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 			
					}

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
					  }else{
					     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
					     {
						  	 frmCfm();
					     }
					  }
					  return true;
				});
			});
			
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";   
	var billType="1";  
	var sysAccept = document.all.login_accept.value;   
	var printStr = printInfo(printType);
	var mode_code=null;
	var fav_code=null;
	var area_code=null;   
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;    
}

function printInfo(printType)
{
	var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	cust_info+="�ͻ�������"+document.all.custName.value+"|";
	cust_info+="�ֻ����룺"+document.all.custPhone.value+"|";
	
	opr_info+="�ͻ����ԣ�<%=cust_attribute%>"+"|";
	opr_info+="�ͻ�Ʒ�ƣ�<%=cust_breed%>"+"|";	
	opr_info+="���οۼ���Ѵ�����"+document.all.oUsedNu.value+"|";
	opr_info+="���οۼ����֣�"+document.all.oUsedScor.value+"|";
	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
	opr_info+="ҵ�����ƣ���վ���������"+"|";
  
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;	
}	

function frmCfm()
{
  var personNum = $("#personNum").val(); //��������
  if($("#servLevel").val()=="1"){ //�����ۿ۽�һ�����30Ԫ/�˴�
    $("#priceArr").val("30");
  }else{    //�������50Ԫ/�˴Ρ�
    $("#priceArr").val("50");
  }
  //�ܽ�� = �����ۿ۽�� * (��������+����)
  var v_totalPrice = parseFloat($("#priceArr").val())*(parseFloat(personNum)+1);
  //alert(v_totalPrice+"="+parseFloat($("#priceArr").val())+"*"+(parseFloat(personNum)+1));
  $("#totalPrice").val(v_totalPrice);
	$("#f1").submit(); 
}
		</script>
	</head>
	<body>
		<form method="post" id="f1" name="f1" action="fb878Cfm.jsp?sheng_flag=n" onKeyUp="chgFocus(f1)">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">ȫ��ͨVIP�򳵷���</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td width="10%" class="blue">��ͨ��ʽ</td>
					<td width="20%" class="blue" colspan="3">
						<select disabled>
							<option checked>��ʽ</option>	
							<option>����</option>	
						</select>	
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">��������</td>
					<td width="20%" class="blue">
						<input type="text" value="ȫ��ͨVIP�򳵷���" Class="InputGrey"  readonly/>
					</td>
					<td width="20%" class="blue" colspan="2">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">�ͻ���ʶ����</td>
					<td width="20%" class="blue">
						<select name="IDType" disabled>
            <option value="01">01--&gt;���ӿ���֤</option>
            <option value="02">02--&gt;vipʵ�忨��֤</option>
            <option value="03">03--&gt;�ֻ�����+���֤������֤</option>
            </select>
					</td>
					<td width="10%" class="blue">�ֻ�����</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 v_name="�ͻ���ʶ" value="<%=phoneNo%>" id="custPhone" name="custPhone" Class="InputGrey"  readonly/>
						<font class="orange">*</font>	
					</td>	
				</tr>
				<tr>
					<td width="10%" class="blue">�ͻ�����</td>
					<td width="20%" class="blue" colspan="3">
					<!-- liujian 2013-4-2 16:45:37 ��������֤���ɸ��� -->
						
            <%if(pwrf) {%>
						<input type="password" id="custPwd" name="custPwd" v_name="�ͻ�����" value="<%=custPWD%>" disabled/>	
			 <% } else { %>

						<input type="password" id="custPwd" name="custPwd" v_name="�ͻ�����" value="<%=custPWD%>" disabled/>	
					<!--	<font class="orange">*</font> -->
			 <%}%>						
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">֤������</td>
					<td width="20%" class="blue">
						<select name="cardType" id="cardType" disabled>
							<option value="00">00--&gt;���֤</option>
			        <option value="01">01--&gt;VIP��</option>	
						</select>	
					</td>
					<td width="10%" class="blue">֤������</td>
					<td width="20%" class="blue">
						<input type="text" id="cardNo" name="cardNo" v_name="֤������" value="<%=cardID%>" disabled/>
						<!-- <font class="orange">*</font> -->
					</td>	
				</tr>
				<tr>
					<td width="10%" class="blue">���񼶱�</td>
					<td width="20%" class="blue">
						<select id="servLevel" name="servLevel">
							<!--huangrong ɾ���Թ��������񼶱�����Ϊֻ���Ƕ����������������-->
							<!--liujian 2013-2-26 10:21:43 
								��ʡ�û��ڹ���������ֻ����ѡ�������񣬶������ۼ�500���֣�
								��ʡ�û��ڷǹ��������ҿ���ѡ��һ�����Ͷ������(Ĭ��)��һ�����ۼ�300���֣��������ۼ�500���֣�
							-->
							<!--diling update for ����ת���г����������Ż���������վ���������淶��֪ͨ����֪ͨ@ 2013-9-24 
								��ʡ�û��ڹ��������ң�һ�����Ͷ�����񶼿���ѡ��˵��������ϵͳֻ����ѡ��һ����񣩣�
                һ�����ۼ�300��/�˴Σ��������ۼ�500��/�˴Σ�
							-->
								<option value="1">һ������</option>	
								<option value="2" selected>��������</option>	
						</select>	
					</td>
					<td width="10%" class="blue">��Ա����</td>
					<td width="20%" class="blue">
						<input type="text" value="0" id="personNum" name="personNum"/>(��������)
						<input type="button" class="b_text"  value="��֤" id="vallidateBtn"/>	
					</td>	
				</tr>
				<tr>
					<td width="10%" class="blue">�ͻ�����</td>
					<td width="20%" class="blue">
						<input type="text" readonly Class="InputGrey"  id="custName" name="custName"/>	
					</td>
					<td width="10%" class="blue">֤�����ͼ�����</td>
					<td width="20%" class="blue">
						<input type="text" readonly Class="InputGrey"  id="iccNo" name="iccNo"/>	
					</td>	
				</tr>
				<tr>
					<td width="10%" class="blue">�û�״̬</td>
					<td width="20%" class="blue">
						<select id="oUserStatus" disabled name="oUserStatus">
							<option value="00">����</option>	
							<option value="01">����ͣ��</option>	
							<option value="02">ͣ��</option>	
							<option value="03">Ԥ����</option>	
							<option value="04">����</option>	
							<option value="05">����</option>	
							<option value="06">�ĺ�</option>	
							<option value="90">�������û�</option>	
							<option value="99">�˺��벻����</option>	
						</select>	
					</td>
					<td width="10%" class="blue">�ͻ�����</td>
					<td width="20%" class="blue">
						<select id="oUserRank" disabled name="oUserRank">
							<option value="000">����</option>	
							<option value="100">��ͨ�ͻ�</option>	
							<option value="200">��Ҫ�ͻ�</option>	
							<option value="201">�������ؿͻ�</option>	
							<option value="202">����������ȫ���ؿͻ�</option>	
							<option value="203">��ͨ�������ͻ�</option>	
							<option value="204">Ӣ�ۡ�ģ����������ͻ�</option>	
							<option value="300">��ͨ��ͻ�</option>	
							<option value="301">��ʯ����ͻ�</option>	
							<option value="302">�𿨴�ͻ�</option>
							<option value="303">������ͻ�</option>	
							<option value="304">�������ͻ�</option>		
						</select>	
					</td>	
				</tr>
				<tr>
					<td width="10%" class="blue">�ͻ�����</td>
					<td width="20%" class="blue">
						<input type="text" readonly Class="InputGrey"  id="oUserScore" name="oUserScore"/>	
					</td>
					<td width="10%" class="blue">ʣ����Ѵ���</td>
					<td width="20%" class="blue">
						<input type="text" readonly Class="InputGrey"  id="oResultNu" name="oResultNu"/>	
					</td>					
				</tr>
				<tr>
					<td width="10%" class="blue">��ͻ�����绰</td>
					<td width="20%" class="blue">
						<input type="text" readonly Class="InputGrey"  id="oSvcPhNum" name="oSvcPhNum"/>
					</td>
					<td width="10%" class="blue">����ܾ�����</td>
					<td width="20%" class="blue">
						<select id="oRejectReason" name="oRejectReason" style="width:200px" disabled>	
							<option value="00">��Ȩ�ɹ�</option>
							<option value="01">�ͻ����ֲ���</option>
							<option value="02">�ͻ����𲻹�</option>
							<option value="03">�ͻ��������</option>
							<option value="04">�ͻ����֤�����vip���Ŵ���</option>
							<option value="05">�޴��û�</option>
							<option value="06">�ͻ�״̬������,�޷��ṩ����</option>
							<option value="07">���ſͻ�,�޸��������Ϣ,����VIP����ȷ��</option>
							<option value="99">��������,��ʡ��˾���н���</option>
						</select>
					</td>
				</tr>
			</table>
			<div id="serviceList">
				<div class="title">
					<div id="title_zi">�����б�</div>
				</div>
				<table id="dyntb" name="dyntb">
					<tr>
						<td class="blue">һ������</td>
						<td class="blue">��������</td>
						<td class="blue">������������</td>
						<td class="blue">��������</td>
						<td class="blue">���</td>
						<td class="blue">�ۺ�Ӧ�ۻ���</td>	
					</tr>	
				</table>
			</div>
			<table cellspacing="0">
				<tr>
					<td colspan="4" id="footer"> 
			           <div align="center"> 
			              <input class="b_foot" type="button" id="confirm" name="confirm" value="ȷ��&��ӡ" index="2" disabled >    
			              <input class="b_foot" type="button" name=back value="���" onClick="f1.reset()">
					          <input class="b_foot" type="button" name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>');">
					          <input class="b_foot" type="button" name=comeback value="����" onClick="history.go(-1);">
			            </div>
			        </td>	
				</tr>
			</table>
			<input type="hidden" name="oneCodeArr" id="oneCodeArr" />
			<input type="hidden" name="oneNameArr" id="oneNameArr" />
			<input type="hidden" name="twoCodeArr" id="twoCodeArr" />
			<input type="hidden" name="twoNameArr" id="twoNameArr" />
			<input type="hidden" name="priceArr" id="priceArr" />
			<input type="hidden" name="scoreArr" id="scoreArr" />
			<input type="hidden" name="flag" id="scoreArr" value="inner"/>
			<input type="hidden" id="totalPrice" v_must=1 name="totalPrice"/> <!--�ܼƽ��-->
			<input type="hidden" id="totalScore" v_must=1 name="totalScore"/>	 <!--�ܿۻ���-->
			<input type="hidden" name="enterTime"/>	<!--����ʱ��-->
			<input type="hidden" name="leaveTime" />	<!--�뿪ʱ��-->
			<input type="hidden" name="proCode" />	<!--ʡ��-->
			<input type="hidden" name="cityCode" />	<!--����-->						
			<input type="hidden" name="destDate" />	<!--Ŀ�ĵص�������Ԥ������-->			
			<input type="hidden" name="morrowFlag" />	<!--�Ƿ�Ԥ���ڶ�������Ԥ����ʶ-->		
			<input type="hidden" name="servLeve" />	<!--�Ƿ�Ԥ���ڶ�������Ԥ����ʶ-->		
			<input type="hidden" name="oUsedScor" />	<!--������Ҫ�Ļ�����	-->			
			<input type="hidden" name="oUsedNu" />	<!-- ��ʡ�û����ӱ���ʹ�õ���Ѵ���	-->						
			
			
		  <input type="hidden" name="login_accept" value="<%=printAccept%>">
			
												

			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>