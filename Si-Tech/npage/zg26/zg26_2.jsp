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
	String opCode = "zg26";
    String opName = "��ֵ˰���ַ�Ʊ����";
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
	String seller_name="";
	String seller_bank="";	
	 
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaa regionCode is "+regionCode);
	if(regionCode=="01" ||regionCode.equals("01"))
		{
			s_kpserver="10.110.22.31";
			seller_name="�й��������й�����������֧��,23001866751050002577";
			seller_bank="���������㷻�������114��,13836103555";
		}
		else if(regionCode=="02"||regionCode.equals("02") )
		{
			s_kpserver="10.110.22.32";
			seller_name="�й��������йɷ����޹�˾�����������֧��,0902056129221003913";
			seller_bank="������ʡ�����������ɳ�������ϴ��������·����ڶ���1-14�����һ��,13904520600";
		}
		else if(regionCode=="03" ||regionCode.equals("03"))
		{
			s_kpserver="10.110.22.33";
			seller_name="�й��������йɷ����޹�˾ĵ����̫ƽ·֧��,0903021309221012679";
			seller_bank="ĵ�����������������129��,18845386648";
		}
		else if(regionCode=="04" ||regionCode.equals("04"))
		{
			s_kpserver="10.110.22.34";
			seller_name="��ľ˹��������֧��,0904021109221064645";
			seller_bank="��ľ˹�г���·766��,13845479099";
		}
		else if(regionCode=="05" ||regionCode.equals("05"))
		{
			s_kpserver="10.110.22.39";
			seller_name="�й��������йɷ����޹�˾˫Ѽɽ����֧��,0908020109221055844";
			seller_bank="˫Ѽɽ�м�ɽ����ƽ��·����·,13895897789";
		}
		else if(regionCode=="06" ||regionCode.equals("06"))
		{
			s_kpserver="10.110.22.38";
			seller_name="�й����йɷ����޹�˾��̨�ӷ���,172704758278";
			seller_bank="������ʡ��̨������ɽ�����Ͻ�,15946434488";
		}
		else if(regionCode=="07" ||regionCode.equals("07"))
		{
			s_kpserver="10.110.22.36";
			seller_name="�й��������м���������֧��,0907020219248263650";
			seller_bank="������ʡ�����м�����201����֧����,0467-8297088";
		}
		else if(regionCode=="08" ||regionCode.equals("08"))
		{
			s_kpserver="10.110.22.41";
			seller_name="�й��������к׸ڷ���Ӫҵ��,0906020109221029001";
			seller_bank="�׸��ж����·��������㳡��,04683855200";			
		}
		else if(regionCode=="09" ||regionCode.equals("09"))
		{
			s_kpserver="10.110.22.37";
			seller_name="�й�������������������·֧��,0909020429221073435";
			seller_bank="������ʡ�������������������´��Ļ���,0458-3616677";			
		}
		else if(regionCode=="10" ||regionCode.equals("10"))
		{
			s_kpserver="10.110.22.42";
			seller_name="�ںӹ������������֧��,0913023709221036589";
			seller_bank="������ʡ�ں��к���������ּ���վ����,13945721900";			
		}
		else if(regionCode=="11" ||regionCode.equals("11"))
		{
			s_kpserver="10.110.22.40";
			seller_name="������ֱ·֧��,0912034309221007810";
			seller_bank="�绯�б������϶���·,0455-8361007";			
		}
		else if(regionCode=="12" ||regionCode.equals("12"))
		{
			s_kpserver="10.110.22.43";
			seller_name="�й��������йɷ����޹�˾�Ӹ����֧��,0914041529221051070";
			seller_bank="���˰�������Ӹ��������������(����·5�ţ�,13846597800";			
		}
		else if(regionCode=="13" ||regionCode.equals("13"))
		{
			s_kpserver="10.110.22.35";
			seller_name="�й��������йɷ����޹�˾������ҵ֧��,0905063729221000361";
			seller_bank="����������ͼ�������´����㳡A��,04592616011";	//13936960018		
		}
		else
		{
			s_kpserver="";
			seller_name="���й�������ֱ֧��,3500040109005419855";
			seller_bank="������ʡ���������ɱ�������·168��,13936693030";	
		}
	System.out.println("bbbbbbbbbbbbbbbbbbbbbb regionCode is "+regionCode+" and s_kpserver is "+s_kpserver);

	//��ѯ ��������Ӫҵ�� ��Ϊ������
	String[] inParas_sp = new String[2];
	inParas_sp[0]="select login_no,login_name from dloginmsg where     login_no='aavt26'";
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
	<wtc:param value="0"/>
	<wtc:param value="<%=year_month%>"/>
</wtc:service>
<wtc:array id="ret_code" scope="end" start="0"  length="2" />
<wtc:array id="ret_mx" scope="end" start="2"  length="8" />
<wtc:array id="ret_sum" scope="end" start="10"  length="3" />
<%
	if(retCode3=="000000" ||retCode3.equals("000000") )
	{
		%>
		<FORM method=post name="frm1508_2">
		<textarea id="div1"></textarea>
			<html xmlns="http://www.w3.org/1999/xhtml">
					<HEAD><TITLE>��ֵ˰���ַ�Ʊ����</TITLE>
<script src="../zg12/control.js"  type="text/javascript" charset="utf8" ></script>				
<script language="javascript">
function   window.alert1(str)
{   
document.getElementById("div1").value=str; 
}	
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
							
							function dohz()
							{
								//alert("���ߺ��� ");
								if(document.getElementById("kp_loginaccept").value=="")
								{
									rdShowMessageDialog("�����롶���ߺ�����ֵ˰ר�÷�Ʊ֪ͨ�������!");
									return false;
								}
								else
								{
									//�򿪽�˰��
									var obAISINO = new ActiveXObject("InvSecCtrl.TaxCardEx");
									var strKEY =obAISINO.KEYMsg; //��ȡKEY��Ϣ
									if(strKEY == null){
										alert("��ȡ��˰��ȫ�ؼ���ϢΪ�� ��");
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
										//alert("�򿪳ɹ�");
									}
									else
									{
										alert("������Ϣ��ʾ��ERROR������errcode="+err_code+";err_msg="+err_msg);
										window.location.href="zg26_1.jsp";
									}
									//ȡ����
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
										
										var sidType = "SID14";
										var strREQ ;
										fpzl="0";
										strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,lz_fphm,lz_fpdm,"");
										obAISINO.SafeInvoke(strREQ);
										var strSIDMsg =obAISINO.SIDMsg; 
										var sidmsgDom = decode64(strSIDMsg);
										showMesgInfoDetail01(sidmsgDom.toString(),sidType,TaxCode,ServerNo,ClientNo); //ȡ���ŷ�Ʊ
										var invoice_code = document.getElementById("invoice_code").value;
										var invoice_number = document.getElementById("invoice_number").value;
										
										//��ѯ
										var sidType = "SID04";
										var strREQ ;
										fpzl="0";
										lz_fphm=document.getElementById("lzhm").value;//"00638913";
										lz_fpdm=document.getElementById("lzdm").value;//"1400091170";
										//�Ȳ�ѯ ���ɸ��ַ�Ʊ
										fpzl="0";
										strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,lz_fphm,lz_fpdm,"");
										obAISINO.SafeInvoke(strREQ);
										var strSIDMsg =obAISINO.SIDMsg; 
										var sidmsgDom = decode64(strSIDMsg);
										showMesgInfoDetail01(sidmsgDom.toString(),sidType,TaxCode,ServerNo,ClientNo);
										
										//SID11���� ��ƴ��data������
										var strREQ_data = makes_data(sidType,ServerNo,ClientNo,TaxCode);//���ܵı���data
										 
									 
										var sidType = "SID11";
										
										var strREQ_new = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,"","",strREQ_data);
										alert1("SID11 test:"+strREQ_new);
										obAISINO.SafeInvoke(strREQ_new);
										var strSIDMsg =obAISINO.SIDMsg; 
										var sidmsgDom = decode64(strSIDMsg);
										//alert("14��ʾ �������ģ�"+sidmsgDom);
										showMesgInfoDetail01(sidmsgDom.toString(),sidType);
										//SID12��ӡ
										var sidType = "SID12";
										var strREQ ;
										strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,invoice_number,invoice_code,"");
										obAISINO.SafeInvoke(strREQ);
										var strSIDMsg =obAISINO.SIDMsg; 
										var sidmsgDom = decode64(strSIDMsg);
										showMesgInfoDetail01(sidmsgDom.toString(),sidType);
									}
									else
									{
										alert("��˰�̴�ʧ��!");
										//window.location.href="zg26_1.jsp";
									}
								}
								
							}
							       //makeStrs(sidType,ServerNo,ClientNo,TaxCode,"",invoice_number,invoice_code,"");
							function makeStrs(sidType,key_kpfwq,key_kpd,key_nsrsbh,fpzl,lz_fphm,lz_fpdm,datastr){
								var xmlHeader = "<?xml version=\"1.0\" encoding=\"GBK\"?>" ;
								var send = new String();
								send += "<service>";
								//����
								//var s_kpserver ="http://skfpwssl.aisino.com:7067";
								var s_kpserver = "<%=s_kpserver%>";
								var s_kpserver_new = "<%=s_kpserver%>"+":8001";
								//sid:�ӿڷ���ID�ţ�SID01-������˰����SID02-�رս�˰����SID03-����/�رտ�Ʊϵͳ�ֹ���Ʊ���ϣ�SID04-��Ʊ��ѯ��SID11-��Ʊ��SID12-��Ʊ��ӡ��SID13-��Ʊ���ϣ�SID14-��ѯ��淢Ʊ��SID22-����Զ�̳������ܣ�SID31-��ѯ��淢Ʊ(��������)��SID32-��ѯ��Ʊ������ʷ(��������)��SID33-��ѯ�ѿ���Ʊ����(��������) ��SID34-ȡ��������(��������)��SID35-ȡ��Ʊ���(��������)
								send += "<sid>"+sidType+"</sid>";
								send += "<lx>"+"1"+"</lx>";//
								//�°�SID01
								if(sidType=="SID01")
								{
									//alert("test add sid01");
									send += "<CertPassWord>"+s_kpserver_new+"</CertPassWord>";//����֤������? ò�ƴ����ǿ�Ʊ������ip+�˿�
									send += "<UploadAuto>"+"1"+"</UploadAuto>";//�ϴ�ģʽ 1=�Զ��ϴ�
								}

								send += "<data_pub>";
								send += "<key_kpd>"+key_kpd+"</key_kpd>";
								send += "<key_kpfwq>"+key_kpfwq+"</key_kpfwq>";
								send += "<key_nsrsbh>"+key_nsrsbh+"</key_nsrsbh>";
								
								send += "<slserver>"+"http://10.110.22.24:7003/dxslserver/slconsole.do"+"</slserver>";
								//����send += "<slserver>"+"http://124.127.114.68:7070/dxslserver/slconsole.do"+"</slserver>";

								//����var s_kpserver = "<%=s_kpserver%>";
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
								send += "<nsrsbh></nsrsbh>";
								send += "<kpfwqh></kpfwqh>";
								send += "<kpdh></kpdh>";
								send += "<qrq></qrq>";
								send += "<zrq></zrq>";
								send += "</data_cx>";
								send += "</service>";
								var sendXML = xmlHeader + send;
								
								var value1 = encode64(sendXML);
								//alert1("value1 "+value1);
								return value1;
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
										//alert("SID01 false");
										return false;
									}
								}
								if(sidType=="SID14")
								{
									if(showSID01(elementsErr,elementsData,sidType)==true)
									{
										//alert("SID14 true");
										return true;
									}
									else
									{
										//alert("SID14 false");
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
										//alert("SID04 false");
										return false;
									}
								}
								if(sidType=="SID11")
								{
									if(showSID01(elementsErr,elementsData,sidType)==true)
									{
										//alert("SID11 true");
										return true;
									}
									else
									{
										//alert("SID11 false");
										return false;
									}
								}
								if(sidType=="SID12")
								{
									if(showSID01(elementsErr,elementsData,sidType)==true)
									{
									//	alert("SID14 true");
										return true;
									}
									else
									{
									//	alert("SID14 false");
										return false;
									}
								}
										
							}
							//������˰�� ��������
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
								if(sidType=="SID14")
								{
									if("3011"==errcode){//3001=��˰���ɹ���������ȡ��Ϣ�ɹ�(������)     1011=��˰���ɹ�����
										for(var i=0;i<elementsData.length;i++){
											InfoTypeCode = elementsData[i].getElementsByTagName("InfoTypeCode")[0].firstChild.nodeValue;
											InfoNumber  = elementsData[i].getElementsByTagName("InfoNumber")[0].firstChild.nodeValue;
											InvStock = elementsData[i].getElementsByTagName("InvStock")[0].firstChild.nodeValue;
											TaxClock = elementsData[i].getElementsByTagName("TaxClock")[0].firstChild.nodeValue; 
											var prtFlag=0;
											prtFlag=rdShowConfirmDialog("��ֵ˰רƱ��ȡ�ɹ�����ǰ��Ʊ����:"+InfoNumber+",��Ʊ����:"+InfoTypeCode+",�Ƿ�ȷ�ϴ�ӡ?");
											if (prtFlag==1)
											{
												document.getElementById("invoice_code").value=InfoTypeCode;
												document.getElementById("invoice_number").value=InfoNumber;
												return true;
											}
											else
											{
												rdShowMessageDialog("ӪҵԱȡ��רƱ���߲���!");
												return false;
											}
											//alert("��ֵ˰רƱ��ȡ�ɹ�����ǰ��Ʊ����:"+InfoNumber+",��Ʊ����:"+InfoTypeCode+",�Ƿ�ȷ�ϴ�ӡ?");
											
										}
									}else{
										alert("SID14������Ϣ��ʾ��ERROR������errcode="+errcode+";err_msg="+message);
										return;
									}
								}
								if(sidType=="SID04")
								{
									if("7011"==errcode){//SID04 ��ѯ�ɹ�
										for(var i=0;i<elementsData.length;i++){
											InfoTypeCode = elementsData[i].getElementsByTagName("InfoTypeCode")[0].firstChild.nodeValue;//��Ʊ����
											InfoNumber  = elementsData[i].getElementsByTagName("InfoNumber")[0].firstChild.nodeValue;//��Ʊ����
											InfoAmount = elementsData[i].getElementsByTagName("InfoAmount")[0].firstChild.nodeValue;//�ܽ��
											InfoTaxAmount= elementsData[i].getElementsByTagName("InfoTaxAmount")[0].firstChild.nodeValue;//��˰�� 
											//alert("��췢Ʊ�ķ�Ʊ����:"+InfoNumber+",��Ʊ����:"+InfoTypeCode+",�ܽ��:"+InfoAmount+",��˰��:"+InfoTaxAmount);
											document.getElementById("InfoAmount").value=(-1)*InfoAmount;
											document.getElementById("InfoTaxAmount").value=(-1)*InfoTaxAmount;
										    return true;

										}
									}else{
										alert("SID04������Ϣ��ʾ��ERROR������errcode="+errcode+";err_msg="+message);
										return false;
									}
								}
								if(sidType=="SID11")
								{
									if("4011"==errcode){//���߳ɹ�
										return true;
									}else{
										alert("SID11���� ="+errcode+";err_msg="+message);
										return false;
									}
								}
								if(sidType=="SID12")
								{
									if("5011"==errcode){//3001=��˰���ɹ���������ȡ��Ϣ�ɹ�(������)     1011=��˰���ɹ�����
										//alert("��Ʊ���� ��Ʊ���� ����chenhu�ӿڸ�������");
										//���ַ�Ʊ���� ���ַ�Ʊ���� ���ַ�Ʊ���� ���ַ�Ʊ���� opcode ���� ����֪ͨ����ˮ��->hzls kpr kpd->ClientNo
										//��ȡ���ַ�Ʊ���� ��Ʊ����
										var lz_hm = document.getElementById("lzhm").value
										var lz_dm = document.getElementById("lzdm").value
										//��ȡ���ַ�Ʊ���� ��Ʊ����
										var invoice_code = document.getElementById("invoice_code").value;
										var invoice_number = document.getElementById("invoice_number").value;
										var kp_loginaccept = document.getElementById("kp_loginaccept").value;
										var year_month = document.all.year_month.value;
								 
										window.location="zg26_3.jsp?lz_hm="+lz_hm+"&lz_dm="+lz_dm+"&invoice_code="+invoice_code+"&invoice_number="+invoice_number+"&kp_loginaccept="+kp_loginaccept+"&year_month="+year_month;
										return true;
									}else{
										alert("SID11���� ="+errcode+";err_msg="+message);
										return false;
									}
								}
								//alert("�������룺"+errcode);
								
							}
							function makes_data(sidType,ServerNo,ClientNo,TaxCode)
							{
								var xmlHeader = "<?xml version=\"1.0\" encoding=\"GBK\"?>";
								var send = new String();
								//send += "<data_pub>";
								var client_name="˼�������";
								var kp_loginaccept = document.getElementById("kp_loginaccept").value;
								var s_note="���ߺ�����ֵ˰ר�÷�Ʊ֪ͨ����"+kp_loginaccept;
								var InfoAmount=document.getElementById("InfoAmount").value ;
								var InfoTaxAmount=document.getElementById("InfoTaxAmount").value;
								var list_price = (-1)*InfoAmount;
								//���ݲ�ͬ˰��ƴװ��ͬ�ĺ�������
								var tax_rate = parseInt(document.getElementById("tax_rate").value);
								//alert("tax_rate is "+tax_rate);
								var tax_rate_name ="";
								if(tax_rate=="6")
								{
									tax_rate_name="��ֵҵ���";
								}
								if(tax_rate=="11")
								{
									tax_rate_name="����ͨ�ŷ�";
								}
								if(tax_rate=="17")
								{
									tax_rate_name="������";
								}
								var nsrsbh1 = document.getElementById("nsrsbh").value;
								//nsrsbh1="240301201405182";
								var tax_name = document.getElementById("tax_name").value;
								var tax_contract_no = document.getElementById("tax_contract_no").value;
								var tax_address = document.getElementById("tax_address").value;
								var seller_name="<%=seller_name%>";//�ӿؼ����Ǳ�ȡ? ��ȷ��
								var seller_bank="<%=seller_bank%>";
								/*------ƴװreq_��ȫ�ؼ�����Start----*/
								send += "<data>";
								send += "<fp>";
								send += "<InfoKind>"+"0"+"</InfoKind>";
								send += "<ClientName>"+tax_name+"</ClientName>";
								send += "<ClientTaxCode>"+nsrsbh1+"</ClientTaxCode>";
								send += "<ClientBankAccount>"+tax_contract_no+"</ClientBankAccount>";
								send += "<ClientAddressPhone>"+tax_address+"</ClientAddressPhone>";
								send += "<SellerBankAccount>"+seller_name+"</SellerBankAccount>";
								send += "<SellerAddressPhone>"+seller_bank+"</SellerAddressPhone>";
								send += "<TaxRate>"+tax_rate+"</TaxRate>";//˰���ǹ̶�һ��
								send += "<Notes>"+s_note+"</Notes>";
								send += "<Invoicer>"+"<%=workno%>"+"</Invoicer>";
								send += "<Checker></Checker>";
								send += "<Cashier></Cashier>";
								send += "<ListName/>";
								send += "<BillNumber/>";
								send += "</fp>";
								send += "<group>";
								send += "<fpmx>";
								send += "<ListTaxItem>"+"1"+"</ListTaxItem>";
								send += "<ListGoodsName>"+tax_rate_name+"</ListGoodsName>";
								send += "<ListStandard>"+"��"+"</ListStandard>";
								send += "<ListUnit>"+"Ԫ"+"</ListUnit>";
								send += "<ListNumber>"+"-1"+"</ListNumber>";
								send += "<ListPrice>"+list_price+"</ListPrice>";
								send += "<ListAmount>"+InfoAmount+"</ListAmount>";
								send += "<ListPriceKind>"+"0"+"</ListPriceKind>";
								send += "<ListTaxAmount>"+InfoTaxAmount+"</ListTaxAmount>";
								send += "</fpmx>";
								send += "</group>";
								send += "</data>";
								//alert("send is "+send);
								var sendXML = xmlHeader + send;
								//alert("sendXML is "+sendXML);
								var value1 = encode64(sendXML);
								//alert1("value1 is "+value1);
								return value1;
							}

							 
					</script>
					
					</HEAD>



					<body>

					

					
					<%@ include file="/npage/include/header.jsp" %>
					<div class="title">
						<div id="title_zi">��ֵ˰���ַ�Ʊ����</div>
					</div>
						 
						  <table cellspacing="0" id = "PrintA">
									<tr> 
									   <td colspan="4">ԭ���ַ�Ʊ����<%=tax_number%></td>
									   <td colspan="4">ԭ���ַ�Ʊ����<%=tax_code%></td>	
									   <input type="hidden" id="lzhm" name="lzhm" value="<%=tax_number%>"> 
									   <input type="hidden" id="lzdm" name="lzdm" value="<%=tax_code%>">
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
									<tr> 
										
										<td colspan=8>
										���ַ�Ʊ����ԭ��:<%=ret_sum[0][2]%>
									    <input type="hidden" id="tax_rate" value="<%=ret_mx[0][6]%>">
									   </td>
									 
									</tr>
									<input type="hidden" name="year_month" value="<%=year_month%>">   
									<tr id="div1">
										<td colspan=8>
										�����ߺ�����ֵ˰ר�÷�Ʊ֪ͨ�������:<input type="text" id="kp_loginaccept" name="hzls" maxlength=16></td>
									</tr>
									 <input type="hidden" id="invoice_number" name="hz_number" readonly> 
									 <input type="hidden" id="invoice_code" name="hz_code" readonly> 
									 <input type="hidden" id="InfoAmount" readonly> 
									 <input type="hidden" id="InfoTaxAmount" readonly></td>
										
										
								 
										

									 
							  <tr id="footer"> 
								<td colspan="9">
								  <input class="b_foot" name=query onClick="dohz()" type=button value=���ַ�Ʊ����>
								  	
								  <!-- ret_sp
								  <input class="b_foot" name=query onClick="dohz1()" type=button value=����>
								  <input class="b_foot" name=doCfm onClick=" " type=button value=�Ƿ����ֱ�ӻ���?> 
								  -->
								  <input class="b_foot" name=back onClick="window.location.href='zg26_1.jsp'" type=button value=����>
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
				rdShowMessageDialog("���ַ�Ʊ��Ϣ������!");
				history.go(-1);
			</SCRIPT>
		<%
	}
%>


 

