<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workno = (String)session.getAttribute("workNo");
	String groupId = (String)session.getAttribute("groupId");
	String workname = (String)session.getAttribute("workName");
 
	String opCode = "zg29";
    String opName = "��ֵ˰��Ʊ���Ͽ���";
	String s_good_name=request.getParameter("s_good_name");
	String s_ggxh = request.getParameter("s_ggxh");
	String s_dw =  request.getParameter("s_dw");
	String s_sl =  request.getParameter("s_sl");
	String s_dj =  request.getParameter("s_dj");
	String s_je =  request.getParameter("s_je");
	String s_tax_rate =  request.getParameter("s_tax_rate");
	String s_se =  request.getParameter("s_se");
	String tax_code = request.getParameter("tax_code");
	String tax_number = request.getParameter("tax_number");
	String year_month = request.getParameter("year_month");
	//��ȡ��˰����Ϣ
	String tax_name = request.getParameter("tax_name");
	String tax_no1 = request.getParameter("tax_no1");
	String tax_address = request.getParameter("tax_address");
	String tax_phone = request.getParameter("tax_phone");
	String tax_khh = request.getParameter("tax_khh");
	String tax_contract_no = request.getParameter("tax_contract_no");
	
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String s_kpserver="";
	 
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaa regionCode is "+regionCode);
	if(regionCode=="01" ||regionCode.equals("01"))
	{
		s_kpserver="10.110.22.31";
	}
	else if(regionCode=="02"||regionCode.equals("02") )
	{
		s_kpserver="10.110.22.32";
	}
	else if(regionCode=="03" ||regionCode.equals("03"))
	{
		s_kpserver="10.110.22.33";
	}
	else if(regionCode=="04" ||regionCode.equals("04"))
	{
		s_kpserver="10.110.22.34";
	}
	else if(regionCode=="05" ||regionCode.equals("05"))
	{
		s_kpserver="10.110.22.39";
	}
	else if(regionCode=="06" ||regionCode.equals("06"))
	{
		s_kpserver="10.110.22.38";
	}
	else if(regionCode=="07" ||regionCode.equals("07"))
	{
		s_kpserver="10.110.22.36";
	}
	else if(regionCode=="08" ||regionCode.equals("08"))
	{
		s_kpserver="10.110.22.41";
	}
	else if(regionCode=="09" ||regionCode.equals("09"))
	{
		s_kpserver="10.110.22.37";
	}
	else if(regionCode=="10" ||regionCode.equals("10"))
	{
		s_kpserver="10.110.22.42";
	}
	else if(regionCode=="11" ||regionCode.equals("11"))
	{
		s_kpserver="10.110.22.40";
	}
	else if(regionCode=="12" ||regionCode.equals("12"))
	{
		s_kpserver="10.110.22.43";
	}
	else if(regionCode=="13" ||regionCode.equals("13"))
	{
		s_kpserver="10.110.22.35";
	}
	else
	{
		s_kpserver="";
	}
	System.out.println("bbbbbbbbbbbbbbbbbbbbbb regionCode is "+regionCode+" and s_kpserver is "+s_kpserver);

	//��ѯ ��������Ӫҵ�� ��Ϊ������
	String[] inParas_sp = new String[2];
	inParas_sp[0]="select login_no,login_name from dloginmsg where   login_no='aavt26'";
	//inParas_sp[1]="s_group_id="+groupId;
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:param value="<%=inParas_sp[0]%>"/>
 
</wtc:service>
<wtc:array id="ret_sp" scope="end" />

<wtc:service name="bs_zg26init" retcode="retCode3" retmsg="retMsg3" outnum="13">
	<wtc:param value="<%=tax_number%>"/> 
	<wtc:param value="<%=tax_code%>"/>
	<wtc:param value="<%=opCode%>"/> 
	<wtc:param value="<%=workno%>"/> 
	<wtc:param value="1"/>
	<wtc:param value="<%=year_month%>"/>
</wtc:service>
<wtc:array id="ret_code" scope="end" start="0"  length="2" />
<wtc:array id="ret_mx" scope="end" start="2"  length="8" />
<wtc:array id="ret_sum" scope="end" start="10"  length="3" />

<%
	//retCode3="000000";
	if(retCode3=="000000" ||retCode3.equals("000000") )
	{
		%>
		<FORM method=post name="frm1508_2">
		<textarea id="div1"></textarea>
			<html xmlns="http://www.w3.org/1999/xhtml">
					<HEAD><TITLE>��ֵ˰ר�÷�Ʊ���Ͽ�������</TITLE>
	<script src="../zg12/control.js"  type="text/javascript" charset="utf8" ></script>			
						<script language="javascript">
 
 
 		
function loadXML(xmlString){
	var xmlDoc=null;
	//�ж������������
	//֧��IE�����
	if(!window.DOMParser && window.ActiveXObject){ //window.DOMParser �ж��Ƿ��Ƿ�ie�����
		var xmlDomVersions = ['MSXML.2.DOMDocument.6.0','MSXML.2.DOMDocument.3.0','Microsoft.XMLDOM'];
		for(var i=0;i<xmlDomVersions.length;i++){
		try{
		xmlDoc = new ActiveXObject(xmlDomVersions[i]);
		xmlDoc.async = false;
		xmlDoc.loadXML(xmlString); //loadXML��������xml�ַ���
		break;
		}catch(e){
			}
		}
	}
	//֧��Mozilla�����
	else if(window.DOMParser && document.implementation && document.implementation.createDocument){
	try{
	/* DOMParser ������� XML �ı�������һ�� XML Document ����
	* Ҫʹ�� DOMParser��ʹ�ò��������Ĺ��캯����ʵ��������Ȼ������� parseFromString() ����
	* parseFromString(text, contentType) ����text:Ҫ������ XML ��� ����contentType�ı�����������
	* ������ "text/xml" ��"application/xml" �� "application/xhtml+xml" �е�һ����ע�⣬��֧�� "text/html"��
	*/
		domParser = new DOMParser();
		xmlDoc = domParser.parseFromString(xmlString, 'text/xml');
	}catch(e){
		}
	}
	else{
		return null;
		}
	return xmlDoc;
	}
	  function   window.alert1(str)
	  {   
		document.getElementById("div1").value=str; 
	  }						
							function sptg1()
							{
								//alert("רƱ����");
								//�򿪽�˰��
								var obAISINO = new ActiveXObject("InvSecCtrl.TaxCardEx");
								var strKEY =obAISINO.KEYMsg; //��ȡKEY��Ϣ
								if(strKEY == null){
									alert("111��ȡ��˰��ȫ�ؼ���ϢΪ�� ��");
								}
								var KEYString = decode64(strKEY.toString());
								var err_code ;
								var err_msg  ;
								var TaxCode ;//"140301201405130"; //��˰��ʶ���
								var ServerNo;//="0"; //��Ʊ������
								var ClientNo;//="2"; //�ͻ���
								var fpzl="";
								var lz_fphm="";//��ѯ���ַ�Ʊ����
								var lz_fpdm="";//��ѯ���ַ�Ʊ���� 
								lz_fphm = document.getElementById("lz_fphm").value;
								lz_fpdm = document.getElementById("lz_fpdm").value;
								//lz_fphm="00638921";
								//lz_fpdm="1400091170";//����ʱɾ�� Ϊ�˲��Լӵ�
								var xmlDoc = loadXML(KEYString.toString());
								var elementsErr = xmlDoc.getElementsByTagName("err");
								var elementsData = xmlDoc.getElementsByTagName("data");
								//alert("5"+elementsData);
								for (var i = 0; i < elementsErr.length; i++) {
									 err_code = elementsErr[i].getElementsByTagName("err_code")[0].firstChild.nodeValue;
									 err_msg = elementsErr[i].getElementsByTagName("err_msg")[0].firstChild.nodeValue;  
								}

								if(err_code=="0000"){ 
									for(var i=0;i<elementsData.length;i++){
										TaxCode = elementsData[i].getElementsByTagName("TaxCode")[0].firstChild.nodeValue;
										ServerNo = elementsData[i].getElementsByTagName("ServerNo")[0].firstChild.nodeValue;
										ClientNo = elementsData[i].getElementsByTagName("ClientNo")[0].firstChild.nodeValue;
									}
									alert("��˰�̴򿪳ɹ�");
								}
								else
								{
									alert("������Ϣ��ʾ��ERROR������errcode="+err_code+";err_msg="+err_msg);
									window.location.href="zg29_1.jsp";
								}
								var sidType = "SID01";//�򿪽�˰��
								fpzl="";
								var strREQ ;
								       
								strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,lz_fphm,lz_fpdm,"");
								obAISINO.SafeInvoke(strREQ);
								var strSIDMsg =obAISINO.SIDMsg; 
								var sidmsgDom = decode64(strSIDMsg);
								var ret_value="";
								ret_value=showMesgInfoDetail01(sidmsgDom.toString(),sidType);
								if(showMesgInfoDetail01(sidmsgDom.toString(),sidType)==true)
								{
									//alert("����");
									//��ѯ ����
									var sidType = "SID04";
									var strREQ ;
									fpzl="0";
									lz_fphm = document.getElementById("lz_fphm").value;
									lz_fpdm = document.getElementById("lz_fpdm").value;
									//lz_fphm="00638921";
									//lz_fpdm="1400091170";//д��ֵ�Ǽٵ� ����Ӧ����ǰ̨����
									fpzl="0";
									strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,lz_fphm,lz_fpdm,"");
									obAISINO.SafeInvoke(strREQ);
									var strSIDMsg =obAISINO.SIDMsg; 
									var sidmsgDom = decode64(strSIDMsg);
									showMesgInfoDetail01(sidmsgDom.toString(),sidType,TaxCode,ServerNo,ClientNo);
									var sidType = "SID13";
									strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,lz_fphm,lz_fpdm,"");
									obAISINO.SafeInvoke(strREQ);
									var strSIDMsg =obAISINO.SIDMsg; 
									var sidmsgDom = decode64(strSIDMsg);
									showMesgInfoDetail01(sidmsgDom.toString(),sidType,TaxCode,ServerNo,ClientNo);
									 
								}
							}
							function showMesgInfoDetail01(sidmsgDom,sidType){
								//��Ҫ�������ڵ�����	
								var xmlInfoDoc = loadXML(sidmsgDom.toString());
								var elementsErr = xmlInfoDoc.getElementsByTagName("err");
								var elementsData = xmlInfoDoc.getElementsByTagName("data");
								if(sidType=="SID01")
								{
									if(showSID01(elementsErr,elementsData,sidType)==true)
									{
										//alert("SID01 true");
										return true;
									}
									else
									{
										alert("��˰�̴�ʧ��!");
										return false;
									}
								}
								if(sidType=="SID04")
								{
									if(showSID01(elementsErr,elementsData,sidType)==true)
									{
										//alert("SID04 true");
										return true;
									}
									else
									{
										alert("רƱ��Ϣ��ѯʧ��!");
										return false;
									}
								} 
								if(sidType=="SID13")
								{
									if(showSID01(elementsErr,elementsData,sidType)==true)
									{
										//alert("SID13 true");
										return true;
									}
									else
									{
										alert("����ʧ��");
										return false;
									}
								} 
										
							}
							function showSID01(elementsErr,elementsData,sidType){
								var errcode;
								var message;
								var InvLimit;//��Ʊ�޶��˰����Ʊ���߼�˰�ϼ��޶�
								var TaxCode;//����λ˰��
								var TaxClock;//��˰��ʱ��
								var MachineNo;//��Ʊ�����룬����Ʊ��Ϊ0��
								var IsInvEmpty;//��Ʊ��־��0-��˰�����޿ɿ���Ʊ��1-��Ʊ��
								var IsRepReached;//��˰��־��0-δ����˰�ڣ�1-�ѵ���˰�ڡ�
								var IsLockReached;//������־��0-δ�������ڣ�1-�ѵ������ڡ�

								//SID14��
								var InfoTypeCode;// ��Ʊ����
								var InfoNumber;  // ��Ʊ����
								var InvStock;
								var InfoAmount;//�ܽ��
								var InfoTaxAmount;//��˰��
								for(var i=0;i<elementsErr.length;i++){
									errcode = elementsErr[i].getElementsByTagName("err_code")[0].firstChild.nodeValue;
									message = elementsErr[i].getElementsByTagName("err_msg")[0].firstChild.nodeValue;
								}
								//alert("sidType is "+sidType+" and errcode is "+errcode);
								if(sidType=="SID01")
								{
									if("1011"==errcode){//3001=��˰���ɹ���������ȡ��Ϣ�ɹ�(������)     1011=��˰���ɹ�����
									for(var i=0;i<elementsData.length;i++){
									InvLimit = elementsData[i].getElementsByTagName("InvLimit")[0].firstChild.nodeValue;
									TaxCode  = elementsData[i].getElementsByTagName("TaxCode")[0].firstChild.nodeValue;
									TaxClock = elementsData[i].getElementsByTagName("TaxClock")[0].firstChild.nodeValue;
									MachineNo = elementsData[i].getElementsByTagName("MachineNo")[0].firstChild.nodeValue;
									IsInvEmpty = elementsData[i].getElementsByTagName("IsInvEmpty")[0].firstChild.nodeValue;
									IsRepReached =  elementsData[i].getElementsByTagName("IsRepReached")[0].firstChild.nodeValue;
									IsLockReached =  elementsData[i].getElementsByTagName("IsLockReached")[0].firstChild.nodeValue;
									//alert("����������Ϣ���£�InvLimit:"+InvLimit+";TaxCode:"+TaxCode+";TaxClock:"+TaxClock+";MachineNo:"+MachineNo+";IsInvEmpty:"+IsInvEmpty+";IsRepReached:"+IsRepReached+";IsLockReached"+IsLockReached);
									//alert("������˰�̳ɹ�����ӡ�����Ҫ�رս�˰�̣�");
									return true;
									}
									}else{
										alert("SID01������Ϣ��ʾ��ERROR������errcode="+errcode+";err_msg="+message);
										return false;
									}
								}
								if(sidType=="SID04")
								{
									//alert("SID04�ķ����� "+errcode);
									if("7011"==errcode){//SID04 ��ѯ�ɹ�
										for(var i=0;i<elementsData.length;i++){
											InfoTypeCode = elementsData[i].getElementsByTagName("InfoTypeCode")[0].firstChild.nodeValue;//��Ʊ����
											InfoNumber  = elementsData[i].getElementsByTagName("InfoNumber")[0].firstChild.nodeValue;//��Ʊ����
											InfoAmount = elementsData[i].getElementsByTagName("InfoAmount")[0].firstChild.nodeValue;//�ܽ��
											InfoTaxAmount= elementsData[i].getElementsByTagName("InfoTaxAmount")[0].firstChild.nodeValue;//��˰�� 
											//alert("��췢Ʊ�ķ�Ʊ����:"+InfoNumber+",��Ʊ����:"+InfoTypeCode+",�ܽ��:"+InfoAmount+",��˰��:"+InfoTaxAmount);
											//alert("��ѯ�ɹ�");
											return true;

										}
									}else{
										alert("SID04������Ϣ��ʾ��ERROR������errcode="+errcode+";err_msg="+message);
										return false;
									}
								}
								if(sidType=="SID13")
								{
									if("6011"==errcode){//���ϳɹ�
										var lz_fphm="";//��ѯ���ַ�Ʊ����
										var lz_fpdm="";//��ѯ���ַ�Ʊ���� 
										lz_fphm = document.getElementById("lz_fphm").value;
										lz_fpdm = document.getElementById("lz_fpdm").value;
										//lz_fphm="00638921";
										//lz_fpdm="1400091170";//����ʱɾ�� Ϊ�˲��Լӵ�
										//alert("���ϳɹ� lz_fphm is "+lz_fphm+" and InfoTypeCode is "+lz_fpdm);
										window.location="zg29_3.jsp?tax_invoice_number="+lz_fphm+"&tax_invoice_code="+lz_fpdm;
										return true;
									}else{
										alert("SID13 ���� ="+errcode+";err_msg="+message);
										//��Ҫע��
										 
										return false;
									}
								} 
								 
								 
								//alert("�������룺"+errcode);
								
							}
							function   window.alert1(str)
							  {   
								document.getElementById("div1").value=str; 
							  }
							function makeStrs(sidType,key_kpfwq,key_kpd,key_nsrsbh,fpzl,lz_fphm,lz_fpdm,datastr){
								var xmlHeader = "<?xml version=\"1.0\" encoding=\"GBK\"?>" ;
								//����
								//var s_kpserver ="http://skfpwssl.aisino.com:7067";

								var s_kpserver = "<%=s_kpserver%>";
								var s_kpserver_new = "<%=s_kpserver%>"+":8001";
								var send = new String();
								send += "<service>";
								//sid:�ӿڷ���ID�ţ�SID01-������˰����SID02-�رս�˰����SID03-����/�رտ�Ʊϵͳ�ֹ���Ʊ���ϣ�SID04-��Ʊ��ѯ��SID11-��Ʊ��SID12-��Ʊ��ӡ��SID13-��Ʊ���ϣ�SID14-��ѯ��淢Ʊ��SID22-����Զ�̳������ܣ�SID31-��ѯ��淢Ʊ(��������)��SID32-��ѯ��Ʊ������ʷ(��������)��SID33-��ѯ�ѿ���Ʊ����(��������) ��SID34-ȡ��������(��������)��SID35-ȡ��Ʊ���(��������)
								send += "<sid>"+sidType+"</sid>";
								//�°�SID01
								if(sidType=="SID01")
								{
									//alert("test add sid01");
									send += "<CertPassWord>"+s_kpserver_new+"</CertPassWord>";//����֤������? ò�ƴ����ǿ�Ʊ������ip+�˿�
									send += "<UploadAuto>"+"1"+"</UploadAuto>";//�ϴ�ģʽ 1=�Զ��ϴ�
								}
								send += "<lx>"+"1"+"</lx>";//
								send += "<data_pub>";
								send += "<key_kpd>"+key_kpd+"</key_kpd>";
								send += "<key_kpfwq>"+key_kpfwq+"</key_kpfwq>";
								send += "<key_nsrsbh>"+key_nsrsbh+"</key_nsrsbh>";
								//����
								send += "<slserver>"+"http://10.110.22.24:7003/dxslserver/slconsole.do"+"</slserver>";
								//send += "<slserver>"+"http://124.127.114.68:7070/dxslserver/slconsole.do"+"</slserver>";
								//����
						 
								send += "<kpserver>"+s_kpserver+"</kpserver>";
					
								send += "</data_pub>";
								send += "<data_fp>";
								send += "<HandMade></HandMade>";
								send += "<fpzl>"+fpzl+"</fpzl>";
								send += "<fpdm>"+lz_fpdm+"</fpdm>";
								send += "<fphm>"+lz_fphm+"</fphm>";
								send += "<dylb></dylb>";
								send += "<dybk></dybk>";
								send += "<data>"+datastr+"</data>";
								send += "</data_fp>";
								send += "<data_cx>";
								send += "<qjlh></qjlh>";
								send += "<jls></jls>";
								send += "<nsrsbh>"+key_nsrsbh+"</nsrsbh>";
								send += "<kpfwqh>"+key_kpfwq+"</kpfwqh>";
								send += "<kpdh>"+key_kpd+"</kpdh>";
								send += "<qrq></qrq>";
								send += "<zrq></zrq>";
								send += "</data_cx>";
								send += "</service>";
								var sendXML = xmlHeader + send;
								//alert1("sidType is "+sidType+" and xml is "+sendXML);
								var value1 = encode64(sendXML);
								return value1;
							} 

					</script>
					
					</HEAD>



					<body>


					

					
					<%@ include file="/npage/include/header.jsp" %>
					<div class="title">
						<div id="title_zi">��ֵ˰��Ʊ���Ͽ�������</div>
					</div>
 
						  <table cellspacing="0" id = "PrintA">
									<tr> 
									<input type="hidden" id="lz_fphm" value="<%=tax_number%>">
									<input type="hidden" id="lz_fpdm" value="<%=tax_code%>">
									   <td colspan="4">ԭ���ַ�Ʊ����<%=tax_number%></td>
									   <td colspan="4">ԭ���ַ�Ʊ����<%=tax_code%></td>	
									   <input type="hidden" name="tax_number" value="<%=tax_number%>">
									   <input type="hidden" name="tax_code" value="<%=tax_code%>">
									   <input type="hidden" name="year_month" value="<%=year_month%>">
									  
									</tr>
									<tr>
								 <input type="hidden" id="nsrsbh" value="<%=tax_no1%>">
								 <input type="hidden" id="tax_name" value="<%=tax_name%>">
								 <input type="hidden" id="tax_contract_no" value="<%=tax_contract_no%>,<%=tax_khh%>">
								 <input type="hidden" id="tax_address" value="<%=tax_address%>,<%=tax_phone%>">
										<td colspan="2">��Ʊ�ͻ���˰��ʶ��ţ�<%=tax_no1%></td>
										<td colspan="2">��Ʊ�ͻ����ƣ�<%=tax_name%></td>
										<td colspan="2">��ַ���绰��<%=tax_address%>,<%=tax_phone%></td>
										<td colspan="2">�����м��˺ţ�<%=tax_khh%>,<%=tax_contract_no%></td>
									</tr>
									<tr>
										<th>�����Ӧ˰��������</th>
										<th>����ͺ�</th>
										<th>��λ</th>
										<th>����</th>
										<th>����</th>
										<th>���</th>
										<th>˰��</th>
										<th>˰��</th>
									</tr>
									<%
										for(int i=0;i<ret_mx.length;i++)
										{
											%>
												<tr>
													<td><%=ret_mx[i][0]%></td>
													<td><%=ret_mx[i][1]%></td>
													<td><%=ret_mx[i][2]%></td>
													<td><%=ret_mx[i][3]%></td>
													<td><%=ret_mx[i][4]%></td>
													<td><%=ret_mx[i][5]%></td>
													<td><%=ret_mx[i][6]%></td>
													<td><%=ret_mx[i][7]%></td>
												</tr>
											<%
										}
									%>
									 
									
									 
								 
							  <tr id="footer"> 
								<td colspan="9">
								  <input class="b_foot" name=tjsq onClick="sptg1()" type=button value=���Ϸ�Ʊ����>
						 
								  <!-- ret_sp
								  <input class="b_foot" name=doCfm onClick=" " type=button value=�Ƿ����ֱ�ӻ���?> 
								  -->
								  <input class="b_foot" name=back onClick="window.location.href='zg29_1.jsp'" type=button value=����>
								</td>
							  </tr>
							  
						  </table>
						  
						  <tr id="footer"> 
							   
							  </tr>
						
							
					<input type="hidden" id="id_contractNo">			
							

					<%@ include file="/npage/include/footer.jsp" %>
					
					</BODY>
				</HTML>

			</FORM>
		<%
	}
	else
	{
		%>
			<SCRIPT LANGUAGE="JavaScript">
				rdShowMessageDialog("רƱ��Ϣ������!");
				history.go(-1);
			</SCRIPT>
		<%
	}
%>



