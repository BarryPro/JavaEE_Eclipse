<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
 
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		//��ӡ�嵥�����Ƿ����
		 
		String opCode = "zg12";
		String opName = "��ֵ˰רƱ����";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
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
			seller_name="�й����м�������,173954320184";
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
			seller_bank="����������ͼ�������´����㳡A��,04592616011";			
		}
		else
		{
			s_kpserver="";
			seller_name="���й�������ֱ֧��,3500040109005419855";
			seller_bank="������ʡ���������ɱ�������·168��,13936693030";	
		}
		System.out.println("bbbbbbbbbbbbbbbbbbbbbb regionCode is "+regionCode+" and s_kpserver is "+s_kpserver);
%>
<HTML>
<HEAD>
<script src="control.js"  type="text/javascript" charset="utf8" ></script>
<script language="JavaScript">
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

/*******************************************************
 * ������ȫ�ؼ����屨��,Ŀǰ���÷������汾���� 
 function   window.alert1(str)
  {   
	document.getElementById("div1").value=str; 
  }
 ******************************************************/
  function   window.alert1(str)
  {   
	document.getElementById("div1").value=str; 
  }
	function doPrint(size,i_rate_count)
	{
		/*
		�ҵ��㷨:
		˰��ȫȡ���� 
		if =0.06 һ��
		else if =0.11
		else if=0.17
		else ����
		*/
		//xl add ��ѡ��
		var s_flag_check="";//�ж��Ƿ���50��
		var s_ListName="";
		var ckbox = document.getElementsByName("ckbox");               
		var check_flag="n";//n�������ڵ�״̬ q������Ҫ��ӡ�嵥
		var i_check=0;
		for(var i=0;i<ckbox.length;i++)
		{
			if(ckbox[i].checked)
			{
				i_check++;
				
			}	
		}
		//alert("i_check is "+i_check);
		if(i_check>50 || i_check==0)
		{
			s_ListName="(��������嵥)";
			check_flag="q";
			//alert("����50�������Բ��� ���涼��else����");
			s_flag_check="n";//��ʾ�����Դ�ӡ
			//document.all.tr_qd.style.display = ""; 
		}
		//alert("s_ListName is "+s_ListName);
		//end of ��ѡ��
		var  rate6_Arrays=[];  //˰��6��
		var  rate11_Arrays=[]; //˰��11��
		var  rate17_Arrays=[]; //˰��17��
		var ListTaxItem6=[]; //˰Ŀ��4λ���֣���Ʒ������𡾿ɿգ�����ȷ�ϡ�
		var ListGoodsName6=[];
		var ListStandard6=[];
		var ListUnit6=[];
		var ListNumber6=[];
		var ListPrice6=[];
		var ListAmount6=[];
		var ListPriceKind6=[];
		var ListTaxAmount6=[];
		var i_6="";
		//
		var ListTaxItem11=[];
		var ListGoodsName11=[];
		var ListStandard11=[];
		var ListUnit11=[];
		var ListNumber11=[];
		var ListPrice11=[];
		var ListAmount11=[];
		var ListPriceKind11=[];
		var ListTaxAmount11=[];
		var i_11="";
		//
		var ListTaxItem17=[];
		var ListGoodsName17=[];
		var ListStandard17=[];
		var ListUnit17=[];
		var ListNumber17=[];
		var ListPrice17=[];
		var ListAmount17=[];
		var ListPriceKind17=[];//��0
		var ListTaxAmount17=[];
		var i_17="";
		//alert("size is "+size);
		var List_tax_invoice_code=[];
		var List_tax_invoice_number=[];
		var List_tax_rate=[];

		var list_cy_phone=[];
		var list_cy_accept=[];
		var final_cy_phone=[];
		var final_cy_accept=[];
		for (i=0;i<size;i++)
		{
			var tax_rate = document.getElementById("tax_rate"+i).value;
			var ggxh = document.getElementById("ggxh"+i).value;
			var goods_name = document.getElementById("goods_name"+i).value; 
			var ListUnit = document.getElementById("dw"+i).value; 
			var sl = document.getElementById("sl"+i).value;  
			var dj = document.getElementById("dj"+i).value; 
			var je = document.getElementById("je"+i).value;
			var tax_money = document.getElementById("tax_money"+i).value;//ListTaxAmount17
			//xl add for cy_phone �� cy_accept
			var cy_phone = document.getElementById("cy_phone"+i).value;
			var cy_accept = document.getElementById("cy_accept"+i).value;
			//alert(tax_rate);
			if(tax_rate=="0.17")
		    {
			   ListGoodsName17.push(goods_name);
			   ListStandard17.push(ggxh);
			   ListUnit17.push(ListUnit);
			   ListNumber17.push(sl);
			   ListPrice17.push(dj);
			   ListAmount17.push(je);
			   ListTaxAmount17.push(tax_money);
			   list_cy_phone.push(cy_phone);
			   list_cy_accept.push(cy_accept);
			   i_17++;
			   //alert("0.17 "+ListGoodsName17);
		    }
		    else
		    {
			   alert("˰�ʲ�����");
		    }
		}
		//alert("ListGoodsName11 is "+ListGoodsName11+" and ListGoodsName6 is "+ListGoodsName6+" and i_11 is "+i_11+" and i_6 is "+i_6);
		
		//�򿪽�˰��
		
		var obAISINO = new ActiveXObject("InvSecCtrl.TaxCardEx");
		var strKEY =obAISINO.KEYMsg; //��ȡKEY��Ϣ
		if(strKEY == null){
			alert("111��ȡ��˰��ȫ�ؼ���ϢΪ�� ��");
		}
		var KEYString = decode64(strKEY.toString());
		var err_code ;
		var err_msg  ;
		
		var gf_tax_code=document.getElementById("tax_no1").value; // "240301201405999";//��crmpd��ȡ
		var TaxCode ;//"140301201405130"; //��˰��ʶ���
		var ServerNo;//="0"; //��Ʊ������
		var ClientNo;//="2"; //�ͻ���
		var fpzl="";
		var lz_fphm="";//��ѯ���ַ�Ʊ����
		var lz_fpdm="";//��ѯ���ַ�Ʊ���� 
		lz_fphm = document.getElementById("lz_fphm").value;
		lz_fpdm = document.getElementById("lz_fpdm").value;
		lz_fphm="";
		lz_fpdm="";//����ʱɾ�� Ϊ�˲��Լӵ�
		var dylb="0";//�����ӡ��� �ʹ�ӡ�嵥
		var s_sum_total=0.0;//xl add for xuxza
		
		var xmlDoc = loadXML(KEYString.toString());
		var elementsErr = xmlDoc.getElementsByTagName("err");
		var elementsData = xmlDoc.getElementsByTagName("data");
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
		}
		
		var sidType = "SID01";
		var strREQ ;
		fpzl="";
		strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,lz_fphm,lz_fpdm,"",dylb);
		obAISINO.SafeInvoke(strREQ);
		var strSIDMsg =obAISINO.SIDMsg; 
		var sidmsgDom = decode64(strSIDMsg);
		showMesgInfoDetail01(sidmsgDom.toString(),sidType);
		var s_flag="";//�жϴ�ӡ�Ƿ�ɹ��ı�ʶ ��ӡ���ŵ�ʱ�������
		if(showMesgInfoDetail01(sidmsgDom.toString(),sidType)=="SID01_true")
		{
		//	alert("here?");
			//ѭ�� ����xuxza�ӿ�˰�ʸ�������ѭ��
			s_flag="Y";//�״���Ϊ�ǿ��Դ�ӡ�� 
			
			if(ListGoodsName17.length>0)
			{
				//xl add sid05��ƱУ�� begin
				var sidType = "SID05";
				var sidType = "SID05";
				var str="";
				str=makes_data_17(sidType,"ServerNo","ClientNo",gf_tax_code,ListGoodsName17,ListStandard17,ListUnit17,ListNumber17,ListPrice17,ListAmount17,ListTaxAmount17,i_17,s_ListName,list_cy_phone,list_cy_accept);
				var strREQ ;
				fpzl="0";
				strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,lz_fphm,lz_fpdm,str);
				obAISINO.SafeInvoke(strREQ);
				var strSIDMsg =obAISINO.SIDMsg; 
				var sidmsgDom = decode64(strSIDMsg);
				if(showMesgInfoDetail01(sidmsgDom.toString(),sidType,TaxCode,ServerNo,ClientNo)==true)
				{
					var sidType = "SID14";
					var strREQ ;
					fpzl="0";
					
					strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,lz_fphm,lz_fpdm,"",dylb);
					obAISINO.SafeInvoke(strREQ);
					var strSIDMsg =obAISINO.SIDMsg; 
					var sidmsgDom = decode64(strSIDMsg);
					if(showMesgInfoDetail01(sidmsgDom.toString(),sidType,TaxCode,ServerNo,ClientNo)==true)
					{
						var invoice_code = document.getElementById("invoice_code").value;
						var invoice_number = document.getElementById("invoice_number").value;
						var str="";
						str=makes_data_17("sidType","ServerNo","ClientNo",gf_tax_code,ListGoodsName17,ListStandard17,ListUnit17,ListNumber17,ListPrice17,ListAmount17,ListTaxAmount17,i_17,s_ListName,list_cy_phone,list_cy_accept);
						var sidType = "SID11";//SID11����
						var strREQ_new = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,"","",str,dylb);
						alert1(strREQ_new);
						obAISINO.SafeInvoke(strREQ_new);
						var strSIDMsg =obAISINO.SIDMsg; 
						var sidmsgDom = decode64(strSIDMsg);
						if(showMesgInfoDetail01(sidmsgDom.toString(),sidType)==true &&(s_flag=="Y"))
						{
							var sidType = "SID12"; 
							var strREQ ;
							strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,invoice_number,invoice_code,"",dylb);
							obAISINO.SafeInvoke(strREQ);
							var strSIDMsg =obAISINO.SIDMsg; 
							var sidmsgDom = decode64(strSIDMsg);
							if(showMesgInfoDetail01(sidmsgDom.toString(),sidType)==true &&(s_flag=="Y"))
							{
								s_flag="Y";
								List_tax_invoice_code.push(invoice_code);
								List_tax_invoice_number.push(invoice_number);
								List_tax_rate.push("0.17");
								
							}
							
							else
							{
								alert("SID12��ӡʧ��!");
								s_flag="N";
							}
						}
						
						else
						{
							alert("SID11����ʧ��!");
							s_flag="N";
						}
						
					}
				}
				else
				{
					alert("sid05����~");
				}
				//end of SID05
				
				
				
			}
			
			var begin_tm = document.getElementById("begindate").value;
			var end_tm = document.getElementById("enddate").value;
			var phone_no = document.getElementById("phone_no").value;
			//alert("test?List_tax_invoice_number="+List_tax_invoice_number+",List_tax_invoice_code="+List_tax_invoice_code+",List_tax_rate="+List_tax_rate+" and ClientNo is "+ClientNo+" and begin_tm is "+begin_tm+" and end_tm is "+end_tm+" and phone_no is "+phone_no);
			//xl add for ��ѡ���ó�Ա�������ˮ begin
			var str_box=document.getElementsByName("ckbox");
			var objarray=str_box.length;
			
			for (i=0;i<objarray;i++)
			{
				if(str_box[i].checked == true)
				{
					/*
					��Ϊֻ��ӡһ�� ���Ը�Ϊֻ�ѽ���˰�����ܼ� �����Ļ������Ƶ����ݹ̶�дΪһ������
					*/
					final_cy_phone.push(list_cy_phone[i]);
					final_cy_accept.push(list_cy_accept[i]);
					s_sum_total+=parseFloat(je)+parseFloat(tax_money);
				}
			}
			//end of ��ѡ��
			//alert("s_flag_check is "+s_flag_check);
			//xl add for bianlili ����tax_no
			var tax_no1 = document.frm.tax_no1.value;
			if(s_flag_check=="n")
			{
				rdShowMessageDialog("��ѡ��Ԥ���ߵ�רƱ��Ŀ,�����ǿ��Ҳ��ܴ���50!");
				return false;
			}
			else
			{
				if(s_flag=="Y" )
				{
					window.location="zg12_kj.jsp?List_tax_invoice_number="+List_tax_invoice_number+"&List_tax_invoice_code="+List_tax_invoice_code+"&List_tax_rate="+List_tax_rate+"&kpd="+ClientNo+"&ClientNo="+ClientNo+"&begin_tm="+begin_tm+"&end_tm="+end_tm+"&phone_no="+phone_no+"&f_p="+final_cy_phone+"&f_a="+final_cy_accept+"&s_sum_total="+s_sum_total+"&tax_no1="+gf_tax_code; 
					//rdShowMessageDialog("˰�ػ�����רƱ�ɹ�!");
				}
				else
				{
					rdShowMessageDialog("˰�ػ�����רƱʧ��!");
				}
			}
			
			
		}
	}
	function makeStrs(sidType,key_kpfwq,key_kpd,key_nsrsbh,fpzl,lz_fphm,lz_fpdm,datastr,dylb){
		var xmlHeader = "<?xml version=\"1.0\" encoding=\"GBK\"?>" ;
		var send = new String();
		send += "<service>";
		//sid:�ӿڷ���ID�ţ�SID01-������˰����SID02-�رս�˰����SID03-����/�رտ�Ʊϵͳ�ֹ���Ʊ���ϣ�SID04-��Ʊ��ѯ��SID11-��Ʊ��SID12-��Ʊ��ӡ��SID13-��Ʊ���ϣ�SID14-��ѯ��淢Ʊ��SID22-����Զ�̳������ܣ�SID31-��ѯ��淢Ʊ(��������)��SID32-��ѯ��Ʊ������ʷ(��������)��SID33-��ѯ�ѿ���Ʊ����(��������) ��SID34-ȡ��������(��������)��SID35-ȡ��Ʊ���(��������)
		
		//����
		var s_kpserver = "<%=s_kpserver%>";
		//var s_kpserver ="http://skfpwssl.aisino.com:7067";
		var s_kpserver_new = "<%=s_kpserver%>"+":8001";
		send += "<sid>"+sidType+"</sid>";
		send += "<lx>"+"1"+"</lx>";
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
		//����
		send += "<slserver>"+"http://10.110.22.24:7003/dxslserver/slconsole.do"+"</slserver>";
		//send += "<slserver>"+"http://124.127.114.68:7070/dxslserver/slconsole.do"+"</slserver>";
		
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
		alert1("sidType is "+sidType+" and xml is "+sendXML);
		var value1 = encode64(sendXML);
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
				return "SID01_true";
			}
			else
			{
				//alert("SID01 false");
				return "SID01_false";
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
		/*xl add for SID05 ��ƱУ�� begin*/
		if(sidType=="SID05")
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
		/*end of ��ƱУ��*/
		if(sidType=="SID12")
		{
			if(showSID01(elementsErr,elementsData,sidType)==true)
			{
				//alert("SID12 true");
				return true;
			}
			else
			{
				//alert("SID12 false");
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
		if(sidType=="SID14")
		{
			if("3011"==errcode){//ԭ����0000
				for(var i=0;i<elementsData.length;i++){
					InfoTypeCode = elementsData[i].getElementsByTagName("InfoTypeCode")[0].firstChild.nodeValue;
					InfoNumber  = elementsData[i].getElementsByTagName("InfoNumber")[0].firstChild.nodeValue;
					InvStock = elementsData[i].getElementsByTagName("InvStock")[0].firstChild.nodeValue;
					TaxClock = elementsData[i].getElementsByTagName("TaxClock")[0].firstChild.nodeValue; 
					alert("��ֵ˰רƱ��ȡ�ɹ�����ǰ��Ʊ����:"+InfoNumber+",��Ʊ����:"+InfoTypeCode);
					document.getElementById("invoice_code").value=InfoTypeCode;
					document.getElementById("invoice_number").value=InfoNumber;
					return true;
				}
			}else{
				alert("������Ϣ��ʾ��ERROR������errcode="+errcode+";err_msg="+message);
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
		//xl add SID05 ��ƱУ�� begin
		if(sidType=="SID05")
		{
			if("4016"==errcode){ 
			// alert("SID05 У��ɹ�");
			 return true;
			}
			 else{
				alert("SID05 ������Ϣ��ʾ��ERROR������errcode="+errcode+";err_msg="+message);
				return false;
			}
		}
		//end of SID05
		if(sidType=="SID11")
		{
			if("4011"==errcode){ 
			 //alert("SID11 ��Ʊ�ɹ�");
			 return true;
			}
			 else{
				alert("SID11 ������Ϣ��ʾ��ERROR������errcode="+errcode+";err_msg="+message);
				return false;
			}
		}
		if(sidType=="SID12")
		{
			if("5011"==errcode){
			 //alert("SID12 ��ӡ�ɹ�");
			 return true;
			}
			 else{
				alert("SID12������Ϣ��ʾ��ERROR������errcode="+errcode+";err_msg="+message);
				return false;
			}
		} 
	}
	  
	//������� ����checkbox��ѡ���ж� 
	function makes_data_17(sidType,ServerNo,ClientNo,TaxCode,spmc,ggxh,dw,sl,dj,je,se,i_length,list_name,list_cy_phone,list_cy_accept)//˰��Ϊ17��
	{
		var final_cy_phone=[];
		var final_cy_accept=[];
		var str_box=document.getElementsByName("ckbox");
		var objarray=str_box.length;
		var chestr="";
		var xmlHeader = "<?xml version=\"1.0\" encoding=\"GBK\"?>";
		var send = new String();
		var client_name="˼������ֵ˰רƱ��ӡ����";//crmpd�ӿڴ� ��ǰ̨����ȡ Client�ļ���ֵ������ô����
		var seller_name="<%=seller_name%>";//�ӿؼ����Ǳ�ȡ? ��ȷ��
		var seller_bank="<%=seller_bank%>";
		var login_no="<%=workname%>";//��½���� for jiyu ��Ϊ����
		//��Ʊ���ǵ�½���� Checker������ Cashier�տ��˿ɿ�
		//��ȡ��˰����Ϣ
 
		/*------ƴװreq_��ȫ�ؼ�����Start----*/
		client_name = document.getElementById("tax_name").value;
		var tax_no1 = document.getElementById("tax_no1").value;
		var tax_address = document.getElementById("tax_address").value;
		var tax_phone = document.getElementById("tax_phone").value;
		var tax_khh = document.getElementById("tax_khh").value;
		var tax_contract_no = document.getElementById("tax_contract_no").value;
		//xl add for hanfeng���� ��Ϊ����չʾ��"��ַ���绰" ��"�����м��˺�" 
		tax_address=tax_address+" "+tax_phone;
		tax_khh=tax_khh+" "+tax_contract_no;
		send += "<data>";
		send += "<fp>";
		send += "<InfoKind>"+"0"+"</InfoKind>";
		send += "<ClientName>"+client_name+"</ClientName>";
		send += "<ClientTaxCode>"+TaxCode+"</ClientTaxCode>";
		send += "<ClientBankAccount>"+tax_khh+"</ClientBankAccount>";
		send += "<ClientAddressPhone>"+tax_address+"</ClientAddressPhone>";
		send += "<SellerBankAccount>"+seller_name+"</SellerBankAccount>";
		send += "<SellerAddressPhone>"+seller_bank+"</SellerAddressPhone>";
		send += "<TaxRate>"+"17"+"</TaxRate>";//˰���ǹ̶�һ��
		send += "<Notes></Notes>";
		send += "<Invoicer>"+login_no+"</Invoicer>";
		send += "<Checker></Checker>";
		send += "<Cashier></Cashier>";
		send += "<ListName>"+list_name+"</ListName>";
		send += "<BillNumber/>";
		send += "</fp>";
		send += "<group>";
		//xl add for xml���� ԭ����for(var i=0;i<i_length;i++)
		//xl add for xuxz ֻ���㵥�� ��� ˰����ܺ� ˰�ʹ̶�17%
		var s_sum_dj=0.0;
		var s_sum_je=0.0;
		var s_sum_se=0.0;
		var s_sum_sl=0;
		var s_sum_zje=0.0;//add  for xuxz 11���
		for (i=0;i<objarray;i++)
		{
			if(str_box[i].checked == true)
			{
				/*
				��Ϊֻ��ӡһ�� ���Ը�Ϊֻ�ѽ���˰�����ܼ� �����Ļ������Ƶ����ݹ̶�дΪһ������
				var ss = parseFloat(document.getElementById("s_money"+i).value);
				s_sum_money += ss;
				*/
				s_sum_dj+=parseFloat(dj[i]);
				s_sum_zje+=parseFloat(dj[i])+parseFloat(se[i]);
				//alert("dj[i] is "+dj[i]+" and s_sum_dj is "+s_sum_dj);
				s_sum_sl+=parseFloat(sl[i]);
				s_sum_je+=parseFloat(je[i]);
				s_sum_se+=parseFloat(se[i]);
				final_cy_phone.push(list_cy_phone[i]);
				final_cy_accept.push(list_cy_accept[i]);
			}
		}
		send += "<fpmx>";
		send += "<ListTaxItem></ListTaxItem>";
		send += "<ListGoodsName>������</ListGoodsName>";
		send += "<ListStandard></ListStandard>";
		send += "<ListUnit>̨</ListUnit>";
		send += "<ListNumber>"+s_sum_sl+"</ListNumber>";
		send += "<ListPrice>"+s_sum_dj+"</ListPrice>";
		//xl add TaxRate
		send += "<TaxRate>"+"17"+"</TaxRate>";
		send += "<ListAmount>"+s_sum_je+"</ListAmount>";
		send += "<ListPriceKind>"+"0"+"</ListPriceKind>";
		send += "<ListTaxAmount>"+s_sum_se+"</ListTaxAmount>";
		send += "</fpmx>";
		//xl end of ���ݵ�ѡ��ѡ������xml����
		
		//alert("i_length is "+i_length);
		/*
		for(var i=0;i<i_length;i++)
		{
			send += "<fpmx>";
			send += "<ListTaxItem>"+""+"</ListTaxItem>";
			send += "<ListGoodsName>"+spmc[i]+"</ListGoodsName>";
			send += "<ListStandard>"+ggxh[i]+"</ListStandard>";
			send += "<ListUnit>"+dw[i]+"</ListUnit>";
			send += "<ListNumber>"+sl[i]+"</ListNumber>";
			send += "<ListPrice>"+dj[i]+"</ListPrice>";
			send += "<ListAmount>"+je[i]+"</ListAmount>";
			send += "<ListPriceKind>"+"0"+"</ListPriceKind>";
			send += "<ListTaxAmount>"+se[i]+"</ListTaxAmount>";
			send += "</fpmx>";
			
		}
		*/
		send += "</group>";
		send += "</data>";
		var sendXML = xmlHeader + send;
	//	alert("s_sum_sl is "+s_sum_sl+" and s_sum_dj is "+parseFloat(s_sum_dj)+" and s_sum_je is "+s_sum_je+" and final_cy_phone is "+final_cy_phone+" and final_cy_accept is "+final_cy_accept+" and s_sum_zje is "+s_sum_zje);
		alert1("sidType is "+sidType+" and xml is "+sendXML);
		var value1 = encode64(sendXML);
		return value1;
	}
	 
	 
	//ȫѡ
	function doSelectAllNodes()
	{
		//document.all.sure.disabled=false;
		if(document.getElementById("check_all_id").checked)
		{
			var regionChecks = document.getElementsByName("ckbox");
			for(var i=0;i<regionChecks.length;i++){
				regionChecks[i].checked=true;
			}
		}
		
		 
	} 
	 
 </script> 
<%
	String nopass = (String)session.getAttribute("password");
	String phone_no = request.getParameter("phone_no");

	String begindate = request.getParameter("begindate");
	String enddate = request.getParameter("enddate");
	String dateStr="";
	String[] inParas2 = new String[11];
	//inParas2[0]="select substr(goodsname,0,10),trim(scales),trim(units),to_char(units_money),to_char(small_money),to_char(tax_rate),to_char(tax_money),to_char(tax_invoice_tax_count) from dinvoicecntt where tax_invoice_num='2' ";
	//phone_no="13503685502";
	inParas2[0]="";//��ˮ
	inParas2[1]="02";
	inParas2[2]="zg12";
	inParas2[3]=workno;
	inParas2[4]=nopass;
	inParas2[5]=phone_no;
	inParas2[6]="";
	inParas2[7]="רƱ����";
	inParas2[8]=dateStr;
	inParas2[9]=begindate;
	inParas2[10]=enddate;
%>
<wtc:service name="bs_yxPrintInit" retcode="retCode2" retmsg="retMsg2" outnum="15">
	<wtc:param value="<%=inParas2[0]%>"/> 
	<wtc:param value="<%=inParas2[1]%>"/>
	<wtc:param value="<%=inParas2[2]%>"/> 
	<wtc:param value="<%=inParas2[3]%>"/> 
	<wtc:param value="<%=inParas2[4]%>"/> 
	<wtc:param value="<%=inParas2[5]%>"/> 
	<wtc:param value="<%=inParas2[6]%>"/> 
	<wtc:param value="<%=inParas2[7]%>"/> 
	<wtc:param value="<%=inParas2[8]%>"/> 
	<wtc:param value="<%=inParas2[9]%>"/> 
	<wtc:param value="<%=inParas2[10]%>"/>
	<wtc:param value="1"/>
</wtc:service>
<wtc:array id="ret_code" scope="end" start="0"  length="4" />
<wtc:array id="ret_mx" scope="end" start="4"  length="10" />
<wtc:array id="ret_rate" scope="end" start="14"  length="1" /> 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
<textarea id="div1"></textarea>
<input type="hidden" name="tax_name" value="<%=tax_name%>">
<input type="hidden" name="tax_no1" value="<%=tax_no1%>">
<input type="hidden" name="tax_address" value="<%=tax_address%>">
<input type="hidden" name="tax_phone" value="<%=tax_phone%>">
<input type="hidden" name="tax_khh" value="<%=tax_khh%>">
<input type="hidden" name="tax_contract_no" value="<%=tax_contract_no%>">
<%
 
 
	
	if(retCode2=="000000" ||retCode2.equals("000000"))
	{
		%>
		 <!--xl add ��ѯ-->

		<input type="hidden" id="invoice_code">	
		<input type="hidden" id="invoice_number">
				<%@ include file="/npage/include/header.jsp" %>   
			<div class="title">
					<div id="title_zi">�������ѯ����</div>
				</div>
		 
		  <table cellSpacing="0">
			<tr>
				<th width="12.5%">����</th>
				<th width="12.5%">��������</th>
				<th width="12.5%">����ͺ�</th>
				<th width="12.5%">��λ</th>
				<th width="12.5%">����</th>
				<th width="12.5%">����</th>
				<th width="12.5%">���</th>
				<th width="12.5%">˰��</th>
				<th width="12.5%">˰��</th>
				<th width="12.5%">��Ա����</th>
				<th width="12.5%">ҵ����ˮ</th>
			</tr>
			<%
				int i_rate_count=Integer.parseInt(ret_rate[0][0]);//xuxza�ӿ��ṩ
				System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa test ret_mx.length is "+ret_mx.length);
				//xl add �ֶ�������
				//for(int k=0;k<2;k++)
				//{
					for(int i=0;i<ret_mx.length;i++)
					{
						%>
							<tr>
								<td width="12.5%"><input type="checkbox" name="ckbox" id="ckbox<%=i%>"></td>
								<td width="12.5%"><%=ret_mx[i][0]%></td>
								<td width="12.5%"><%=ret_mx[i][1]%></td>
								<td width="12.5%"><%=ret_mx[i][2]%></td>
								<td width="12.5%"><%=ret_mx[i][3]%></td>
								<td width="12.5%"><%=ret_mx[i][4]%></td>
								<td width="12.5%"><%=ret_mx[i][5]%></td>
								<td width="12.5%"><%=ret_mx[i][6]%></td>
								<td width="12.5%"><%=ret_mx[i][7]%></td>
								<td width="12.5%"><%=ret_mx[i][8]%></td>
								<td width="12.5%"><%=ret_mx[i][9]%></td>
						 
							</tr>
							<input type="hidden" id="goods_name<%=i%>" value="<%=ret_mx[i][0]%>">
							<input type="hidden" id="ggxh<%=i%>" value="<%=ret_mx[i][1]%>">
							<input type="hidden" id="dw<%=i%>" value="<%=ret_mx[i][2]%>">
							<input type="hidden" id="sl<%=i%>" value="<%=ret_mx[i][3]%>">
							<input type="hidden" id="dj<%=i%>" value="<%=ret_mx[i][4]%>">
							<input type="hidden" id="je<%=i%>" value="<%=ret_mx[i][5]%>">
							<input type="hidden" id="tax_rate<%=i%>" value="<%=ret_mx[i][6]%>">
							<input type="hidden" id="tax_money<%=i%>" value="<%=ret_mx[i][7]%>">
							<input type="hidden" id="cy_phone<%=i%>" value="<%=ret_mx[i][8]%>">
							<input type="hidden" id="cy_accept<%=i%>" value="<%=ret_mx[i][9]%>">
						<%
					}
				//}
						
			%>
			<input type="hidden" value="<%=i_rate_count%>">
			<input type="hidden" id="lz_fphm">
			<input type="hidden" id="lz_fpdm"> 
			<input type="hidden" id="begindate" value="<%=begindate%>">
			<input type="hidden" id="enddate" value="<%=enddate%>">
			<input type="hidden" id="phone_no" value="<%=phone_no%>">
			
			<tr> 
			  <td id="footer" colspan=11> 
			    <input type="checkbox" id="check_all_id" onclick="doSelectAllNodes()">ȫѡ &nbsp;&nbsp;&nbsp;&nbsp;
				  &nbsp;
				  <input type="button" name="return1" class="b_foot" value="רƱ��ӡ" onclick="doPrint('<%=ret_mx.length%>','<%=i_rate_count%>')" >
				  &nbsp;
				  <!--
				  <input type="button" name="return1"   class="b_foot" value="��ӡ�嵥" onclick="dyqd()" >
				  &nbsp;
				  -->
				  <input type="button" name="return1" class="b_foot" value="����" onclick="window.location.href='zg12_1.jsp'" >
				  &nbsp;
					  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
			  </td>
			</tr>

			 
		  </table>
		<%
	}
	else
	{
		%>
			<script>		
				rdShowMessageDialog('<%=retCode2%>:<%=retMsg2%>',0);
				document.location.replace('zg12_1.jsp');
			</script>
		<%
	}
%>

	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>