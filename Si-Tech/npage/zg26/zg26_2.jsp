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
    String opName = "增值税红字发票开具";
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
	//获取纳税人信息
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
			seller_name="中国建设银行哈尔滨开发区支行,23001866751050002577";
			seller_bank="哈尔滨市香坊区进乡街114号,13836103555";
		}
		else if(regionCode=="02"||regionCode.equals("02") )
		{
			s_kpserver="10.110.22.32";
			seller_name="中国工商银行股份有限公司齐齐哈尔卜奎支行,0902056129221003913";
			seller_bank="黑龙江省齐齐哈尔市龙沙区卜奎南大街与南马路交叉口东侧1-14层地下一层,13904520600";
		}
		else if(regionCode=="03" ||regionCode.equals("03"))
		{
			s_kpserver="10.110.22.33";
			seller_name="中国工商银行股份有限公司牡丹江太平路支行,0903021309221012679";
			seller_bank="牡丹江市西安区爱民街129号,18845386648";
		}
		else if(regionCode=="04" ||regionCode.equals("04"))
		{
			s_kpserver="10.110.22.34";
			seller_name="佳木斯工行中心支行,0904021109221064645";
			seller_bank="佳木斯市长安路766号,13845479099";
		}
		else if(regionCode=="05" ||regionCode.equals("05"))
		{
			s_kpserver="10.110.22.39";
			seller_name="中国工商银行股份有限公司双鸭山鑫兴支行,0908020109221055844";
			seller_bank="双鸭山市尖山区东平行路五马路,13895897789";
		}
		else if(regionCode=="06" ||regionCode.equals("06"))
		{
			s_kpserver="10.110.22.38";
			seller_name="中国银行股份有限公司七台河分行,172704758278";
			seller_bank="黑龙江省七台河市桃山区桃南街,15946434488";
		}
		else if(regionCode=="07" ||regionCode.equals("07"))
		{
			s_kpserver="10.110.22.36";
			seller_name="中国工商银行鸡西市永昌支行,0907020219248263650";
			seller_bank="黑龙江省鸡西市鸡冠区201国道支线南,0467-8297088";
		}
		else if(regionCode=="08" ||regionCode.equals("08"))
		{
			s_kpserver="10.110.22.41";
			seller_name="中国工商银行鹤岗分行营业部,0906020109221029001";
			seller_bank="鹤岗市东解放路东侧人民广场南,04683855200";			
		}
		else if(regionCode=="09" ||regionCode.equals("09"))
		{
			s_kpserver="10.110.22.37";
			seller_name="中国工商银行伊春区新兴路支行,0909020429221073435";
			seller_bank="黑龙江省伊春市伊春区红升办事处文化街,0458-3616677";			
		}
		else if(regionCode=="10" ||regionCode.equals("10"))
		{
			s_kpserver="10.110.22.42";
			seller_name="黑河工商银行中央街支行,0913023709221036589";
			seller_bank="黑龙江省黑河市合作区中央街加油站西侧,13945721900";			
		}
		else if(regionCode=="11" ||regionCode.equals("11"))
		{
			s_kpserver="10.110.22.40";
			seller_name="工行西直路支行,0912034309221007810";
			seller_bank="绥化市北林区南二西路,0455-8361007";			
		}
		else if(regionCode=="12" ||regionCode.equals("12"))
		{
			s_kpserver="10.110.22.43";
			seller_name="中国工商银行股份有限公司加格达奇支行,0914041529221051070";
			seller_bank="大兴安岭地区加格达奇区红旗社区(人民路5号）,13846597800";			
		}
		else if(regionCode=="13" ||regionCode.equals("13"))
		{
			s_kpserver="10.110.22.35";
			seller_name="中国工商银行股份有限公司大庆兴业支行,0905063729221000361";
			seller_bank="大庆市萨尔图区东风新村程宇广场A座,04592616011";	//13936960018		
		}
		else
		{
			s_kpserver="";
			seller_name="工行哈尔滨大直支行,3500040109005419855";
			seller_bank="黑龙江省哈尔滨市松北区新湾路168号,13936693030";	
		}
	System.out.println("bbbbbbbbbbbbbbbbbbbbbb regionCode is "+regionCode+" and s_kpserver is "+s_kpserver);

	//查询 工号所在营业厅 作为审批人
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
					<HEAD><TITLE>增值税红字发票开具</TITLE>
<script src="../zg12/control.js"  type="text/javascript" charset="utf8" ></script>				
<script language="javascript">
function   window.alert1(str)
{   
document.getElementById("div1").value=str; 
}	
function loadXML(xmlString){
	var xmlDoc=null;
	//判断浏览器的类型
	//支持IE浏览器
	if(!window.DOMParser && window.ActiveXObject){ //window.DOMParser 判断是否是非ie浏览器
		var xmlDomVersions = ['MSXML.2.DOMDocument.6.0','MSXML.2.DOMDocument.3.0','Microsoft.XMLDOM'];
		for(var i=0;i<xmlDomVersions.length;i++){
		try{
		xmlDoc = new ActiveXObject(xmlDomVersions[i]);
		xmlDoc.async = false;
		xmlDoc.loadXML(xmlString); //loadXML方法载入xml字符串
		break;
		}catch(e){
			}
		}
	}
	//支持Mozilla浏览器
	else if(window.DOMParser && document.implementation && document.implementation.createDocument){
	try{
	/* DOMParser 对象解析 XML 文本并返回一个 XML Document 对象。
	* 要使用 DOMParser，使用不带参数的构造函数来实例化它，然后调用其 parseFromString() 方法
	* parseFromString(text, contentType) 参数text:要解析的 XML 标记 参数contentType文本的内容类型
	* 可能是 "text/xml" 、"application/xml" 或 "application/xhtml+xml" 中的一个。注意，不支持 "text/html"。
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
								//alert("开具红字 ");
								if(document.getElementById("kp_loginaccept").value=="")
								{
									rdShowMessageDialog("请输入《开具红字增值税专用发票通知单》编号!");
									return false;
								}
								else
								{
									//打开金税盘
									var obAISINO = new ActiveXObject("InvSecCtrl.TaxCardEx");
									var strKEY =obAISINO.KEYMsg; //获取KEY信息
									if(strKEY == null){
										alert("获取金税安全控件信息为空 ！");
									}
									var KEYString = decode64(strKEY.toString());
									var err_code ;
									var err_msg  ;
									var TaxCode ;//"140301201405130"; //纳税人识别号
									var ServerNo;//="0"; //开票服务器
									var ClientNo;//="2"; //客户端
									var fpzl="";
									var lz_fphm="";//查询蓝字发票号码
									var lz_fpdm="";//查询蓝字发票代码 
									
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
										//alert("打开成功");
									}
									else
									{
										alert("反馈信息提示有ERROR，其中errcode="+err_code+";err_msg="+err_msg);
										window.location.href="zg26_1.jsp";
									}
									//取下张
									var sidType = "SID01";//打开金税盘
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
										//alert("继续");
										
										var sidType = "SID14";
										var strREQ ;
										fpzl="0";
										strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,lz_fphm,lz_fpdm,"");
										obAISINO.SafeInvoke(strREQ);
										var strSIDMsg =obAISINO.SIDMsg; 
										var sidmsgDom = decode64(strSIDMsg);
										showMesgInfoDetail01(sidmsgDom.toString(),sidType,TaxCode,ServerNo,ClientNo); //取下张发票
										var invoice_code = document.getElementById("invoice_code").value;
										var invoice_number = document.getElementById("invoice_number").value;
										
										//查询
										var sidType = "SID04";
										var strREQ ;
										fpzl="0";
										lz_fphm=document.getElementById("lzhm").value;//"00638913";
										lz_fpdm=document.getElementById("lzdm").value;//"1400091170";
										//先查询 生成负字发票
										fpzl="0";
										strREQ = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,lz_fphm,lz_fpdm,"");
										obAISINO.SafeInvoke(strREQ);
										var strSIDMsg =obAISINO.SIDMsg; 
										var sidmsgDom = decode64(strSIDMsg);
										showMesgInfoDetail01(sidmsgDom.toString(),sidType,TaxCode,ServerNo,ClientNo);
										
										//SID11开具 先拼接data并加密
										var strREQ_data = makes_data(sidType,ServerNo,ClientNo,TaxCode);//加密的报文data
										 
									 
										var sidType = "SID11";
										
										var strREQ_new = makeStrs(sidType,ServerNo,ClientNo,TaxCode,fpzl,"","",strREQ_data);
										alert1("SID11 test:"+strREQ_new);
										obAISINO.SafeInvoke(strREQ_new);
										var strSIDMsg =obAISINO.SIDMsg; 
										var sidmsgDom = decode64(strSIDMsg);
										//alert("14显示 反馈报文："+sidmsgDom);
										showMesgInfoDetail01(sidmsgDom.toString(),sidType);
										//SID12打印
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
										alert("金税盘打开失败!");
										//window.location.href="zg26_1.jsp";
									}
								}
								
							}
							       //makeStrs(sidType,ServerNo,ClientNo,TaxCode,"",invoice_number,invoice_code,"");
							function makeStrs(sidType,key_kpfwq,key_kpd,key_nsrsbh,fpzl,lz_fphm,lz_fpdm,datastr){
								var xmlHeader = "<?xml version=\"1.0\" encoding=\"GBK\"?>" ;
								var send = new String();
								send += "<service>";
								//测试
								//var s_kpserver ="http://skfpwssl.aisino.com:7067";
								var s_kpserver = "<%=s_kpserver%>";
								var s_kpserver_new = "<%=s_kpserver%>"+":8001";
								//sid:接口服务ID号，SID01-开启金税卡；SID02-关闭金税卡；SID03-开启/关闭开票系统手工开票作废；SID04-发票查询；SID11-开票；SID12-发票打印；SID13-发票作废；SID14-查询库存发票；SID22-启动远程抄报功能；SID31-查询库存发票(服务器版)；SID32-查询发票分配历史(服务器版)；SID33-查询已开发票数据(服务器版) ；SID34-取服务器表(服务器版)；SID35-取开票点表(服务器版)
								send += "<sid>"+sidType+"</sid>";
								send += "<lx>"+"1"+"</lx>";//
								//新版SID01
								if(sidType=="SID01")
								{
									//alert("test add sid01");
									send += "<CertPassWord>"+s_kpserver_new+"</CertPassWord>";//数字证书密码? 貌似传的是开票服务器ip+端口
									send += "<UploadAuto>"+"1"+"</UploadAuto>";//上传模式 1=自动上传
								}

								send += "<data_pub>";
								send += "<key_kpd>"+key_kpd+"</key_kpd>";
								send += "<key_kpfwq>"+key_kpfwq+"</key_kpfwq>";
								send += "<key_nsrsbh>"+key_nsrsbh+"</key_nsrsbh>";
								
								send += "<slserver>"+"http://10.110.22.24:7003/dxslserver/slconsole.do"+"</slserver>";
								//生产send += "<slserver>"+"http://124.127.114.68:7070/dxslserver/slconsole.do"+"</slserver>";

								//生产var s_kpserver = "<%=s_kpserver%>";
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
								//需要遍历根节点数据	
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
							//开启金税盘 反馈报文
							function showSID01(elementsErr,elementsData,sidType){
								var errcode;
								var message;
								var InvLimit;//开票限额，金税卡发票开具价税合计限额
								var TaxCode;//本单位税号
								var TaxClock;//金税卡时钟
								var MachineNo;//开票机号码，主开票机为0。
								var IsInvEmpty;//有票标志，0-金税卡中无可开发票，1-有票。
								var IsRepReached;//抄税标志，0-未到抄税期，1-已到抄税期。
								var IsLockReached;//锁死标志，0-未到锁死期，1-已到锁死期。

								//SID14的
								var InfoTypeCode;// 发票代码
								var InfoNumber;  // 发票号码
								var InvStock;
								var InfoAmount;//总金额
								var InfoTaxAmount;//总税率
								for(var i=0;i<elementsErr.length;i++){
									errcode = elementsErr[i].getElementsByTagName("err_code")[0].firstChild.nodeValue;
									message = elementsErr[i].getElementsByTagName("err_msg")[0].firstChild.nodeValue;
								}
								if(sidType=="SID01")
								{
									if("1011"==errcode){//3001=金税卡成功开启，获取信息成功(单机版)     1011=金税卡成功开启
									for(var i=0;i<elementsData.length;i++){
									InvLimit = elementsData[i].getElementsByTagName("InvLimit")[0].firstChild.nodeValue;
									TaxCode  = elementsData[i].getElementsByTagName("TaxCode")[0].firstChild.nodeValue;
									TaxClock = elementsData[i].getElementsByTagName("TaxClock")[0].firstChild.nodeValue;
									MachineNo = elementsData[i].getElementsByTagName("MachineNo")[0].firstChild.nodeValue;
									IsInvEmpty = elementsData[i].getElementsByTagName("IsInvEmpty")[0].firstChild.nodeValue;
									IsRepReached =  elementsData[i].getElementsByTagName("IsRepReached")[0].firstChild.nodeValue;
									IsLockReached =  elementsData[i].getElementsByTagName("IsLockReached")[0].firstChild.nodeValue;
									//alert("正常反馈信息如下：InvLimit:"+InvLimit+";TaxCode:"+TaxCode+";TaxClock:"+TaxClock+";MachineNo:"+MachineNo+";IsInvEmpty:"+IsInvEmpty+";IsRepReached:"+IsRepReached+";IsLockReached"+IsLockReached);
									//alert("开启金税盘成功，打印完后需要关闭金税盘！");
									return true;
									}
									}else{
										alert("SID01反馈信息提示有ERROR，其中errcode="+errcode+";err_msg="+message);
										return false;
									}
								}
								if(sidType=="SID14")
								{
									if("3011"==errcode){//3001=金税卡成功开启，获取信息成功(单机版)     1011=金税卡成功开启
										for(var i=0;i<elementsData.length;i++){
											InfoTypeCode = elementsData[i].getElementsByTagName("InfoTypeCode")[0].firstChild.nodeValue;
											InfoNumber  = elementsData[i].getElementsByTagName("InfoNumber")[0].firstChild.nodeValue;
											InvStock = elementsData[i].getElementsByTagName("InvStock")[0].firstChild.nodeValue;
											TaxClock = elementsData[i].getElementsByTagName("TaxClock")[0].firstChild.nodeValue; 
											var prtFlag=0;
											prtFlag=rdShowConfirmDialog("增值税专票获取成功！当前发票号码:"+InfoNumber+",发票代码:"+InfoTypeCode+",是否确认打印?");
											if (prtFlag==1)
											{
												document.getElementById("invoice_code").value=InfoTypeCode;
												document.getElementById("invoice_number").value=InfoNumber;
												return true;
											}
											else
											{
												rdShowMessageDialog("营业员取消专票开具操作!");
												return false;
											}
											//alert("增值税专票获取成功！当前发票号码:"+InfoNumber+",发票代码:"+InfoTypeCode+",是否确认打印?");
											
										}
									}else{
										alert("SID14反馈信息提示有ERROR，其中errcode="+errcode+";err_msg="+message);
										return;
									}
								}
								if(sidType=="SID04")
								{
									if("7011"==errcode){//SID04 查询成功
										for(var i=0;i<elementsData.length;i++){
											InfoTypeCode = elementsData[i].getElementsByTagName("InfoTypeCode")[0].firstChild.nodeValue;//发票代码
											InfoNumber  = elementsData[i].getElementsByTagName("InfoNumber")[0].firstChild.nodeValue;//发票号码
											InfoAmount = elementsData[i].getElementsByTagName("InfoAmount")[0].firstChild.nodeValue;//总金额
											InfoTaxAmount= elementsData[i].getElementsByTagName("InfoTaxAmount")[0].firstChild.nodeValue;//总税额 
											//alert("冲红发票的发票号码:"+InfoNumber+",发票代码:"+InfoTypeCode+",总金额:"+InfoAmount+",总税额:"+InfoTaxAmount);
											document.getElementById("InfoAmount").value=(-1)*InfoAmount;
											document.getElementById("InfoTaxAmount").value=(-1)*InfoTaxAmount;
										    return true;

										}
									}else{
										alert("SID04反馈信息提示有ERROR，其中errcode="+errcode+";err_msg="+message);
										return false;
									}
								}
								if(sidType=="SID11")
								{
									if("4011"==errcode){//开具成功
										return true;
									}else{
										alert("SID11报错 ="+errcode+";err_msg="+message);
										return false;
									}
								}
								if(sidType=="SID12")
								{
									if("5011"==errcode){//3001=金税卡成功开启，获取信息成功(单机版)     1011=金税卡成功开启
										//alert("发票号码 发票代码 调用chenhu接口更新数据");
										//蓝字发票号码 蓝字发票代码 红字发票号码 红字发票代码 opcode 工号 红字通知单流水号->hzls kpr kpd->ClientNo
										//获取蓝字发票号码 发票代码
										var lz_hm = document.getElementById("lzhm").value
										var lz_dm = document.getElementById("lzdm").value
										//获取红字发票号码 发票代码
										var invoice_code = document.getElementById("invoice_code").value;
										var invoice_number = document.getElementById("invoice_number").value;
										var kp_loginaccept = document.getElementById("kp_loginaccept").value;
										var year_month = document.all.year_month.value;
								 
										window.location="zg26_3.jsp?lz_hm="+lz_hm+"&lz_dm="+lz_dm+"&invoice_code="+invoice_code+"&invoice_number="+invoice_number+"&kp_loginaccept="+kp_loginaccept+"&year_month="+year_month;
										return true;
									}else{
										alert("SID11报错 ="+errcode+";err_msg="+message);
										return false;
									}
								}
								//alert("反馈编码："+errcode);
								
							}
							function makes_data(sidType,ServerNo,ClientNo,TaxCode)
							{
								var xmlHeader = "<?xml version=\"1.0\" encoding=\"GBK\"?>";
								var send = new String();
								//send += "<data_pub>";
								var client_name="思特奇测试";
								var kp_loginaccept = document.getElementById("kp_loginaccept").value;
								var s_note="开具红字增值税专用发票通知单号"+kp_loginaccept;
								var InfoAmount=document.getElementById("InfoAmount").value ;
								var InfoTaxAmount=document.getElementById("InfoTaxAmount").value;
								var list_price = (-1)*InfoAmount;
								//根据不同税率拼装不同的红字名称
								var tax_rate = parseInt(document.getElementById("tax_rate").value);
								//alert("tax_rate is "+tax_rate);
								var tax_rate_name ="";
								if(tax_rate=="6")
								{
									tax_rate_name="增值业务费";
								}
								if(tax_rate=="11")
								{
									tax_rate_name="基础通信费";
								}
								if(tax_rate=="17")
								{
									tax_rate_name="购机款";
								}
								var nsrsbh1 = document.getElementById("nsrsbh").value;
								//nsrsbh1="240301201405182";
								var tax_name = document.getElementById("tax_name").value;
								var tax_contract_no = document.getElementById("tax_contract_no").value;
								var tax_address = document.getElementById("tax_address").value;
								var seller_name="<%=seller_name%>";//从控件还是表取? 再确认
								var seller_bank="<%=seller_bank%>";
								/*------拼装req_安全控件报文Start----*/
								send += "<data>";
								send += "<fp>";
								send += "<InfoKind>"+"0"+"</InfoKind>";
								send += "<ClientName>"+tax_name+"</ClientName>";
								send += "<ClientTaxCode>"+nsrsbh1+"</ClientTaxCode>";
								send += "<ClientBankAccount>"+tax_contract_no+"</ClientBankAccount>";
								send += "<ClientAddressPhone>"+tax_address+"</ClientAddressPhone>";
								send += "<SellerBankAccount>"+seller_name+"</SellerBankAccount>";
								send += "<SellerAddressPhone>"+seller_bank+"</SellerAddressPhone>";
								send += "<TaxRate>"+tax_rate+"</TaxRate>";//税率是固定一个
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
								send += "<ListStandard>"+"无"+"</ListStandard>";
								send += "<ListUnit>"+"元"+"</ListUnit>";
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
						<div id="title_zi">增值税红字发票开具</div>
					</div>
						 
						  <table cellspacing="0" id = "PrintA">
									<tr> 
									   <td colspan="4">原蓝字发票号码<%=tax_number%></td>
									   <td colspan="4">原蓝字发票代码<%=tax_code%></td>	
									   <input type="hidden" id="lzhm" name="lzhm" value="<%=tax_number%>"> 
									   <input type="hidden" id="lzdm" name="lzdm" value="<%=tax_code%>">
									</tr>
									<tr>
								 <input type="hidden" id="nsrsbh" value="<%=tax_no1%>">
								 <input type="hidden" id="tax_name" value="<%=tax_name%>">
								 <input type="hidden" id="tax_contract_no" value="<%=tax_contract_no%>,<%=tax_khh%>">
								 <input type="hidden" id="tax_address" value="<%=tax_address%>,<%=tax_phone%>">
										<td colspan="2">发票客户纳税人识别号：<%=tax_no1%></td>
										<td colspan="2">发票客户名称：<%=tax_name%></td>
										<td colspan="2">地址、电话：<%=tax_address%>,<%=tax_phone%></td>
										<td colspan="2">开户行及账号：<%=tax_khh%>,<%=tax_contract_no%></td>
									</tr>
									<tr>
										<th>货物或应税劳务名称</th>
										<th>规格型号</th>
										<th>单位</th>
										<th>数量</th>
										<th>单价</th>
										<th>金额</th>
										<th>税率</th>
										<th>税额</th>
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
										红字发票开具原因:<%=ret_sum[0][2]%>
									    <input type="hidden" id="tax_rate" value="<%=ret_mx[0][6]%>">
									   </td>
									 
									</tr>
									<input type="hidden" name="year_month" value="<%=year_month%>">   
									<tr id="div1">
										<td colspan=8>
										《开具红字增值税专用发票通知单》编号:<input type="text" id="kp_loginaccept" name="hzls" maxlength=16></td>
									</tr>
									 <input type="hidden" id="invoice_number" name="hz_number" readonly> 
									 <input type="hidden" id="invoice_code" name="hz_code" readonly> 
									 <input type="hidden" id="InfoAmount" readonly> 
									 <input type="hidden" id="InfoTaxAmount" readonly></td>
										
										
								 
										

									 
							  <tr id="footer"> 
								<td colspan="9">
								  <input class="b_foot" name=query onClick="dohz()" type=button value=红字发票开具>
								  	
								  <!-- ret_sp
								  <input class="b_foot" name=query onClick="dohz1()" type=button value=开具>
								  <input class="b_foot" name=doCfm onClick=" " type=button value=是否可以直接划拨?> 
								  -->
								  <input class="b_foot" name=back onClick="window.location.href='zg26_1.jsp'" type=button value=返回>
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
				rdShowMessageDialog("红字发票信息不存在!");
				history.go(-1);
			</SCRIPT>
		<%
	}
%>


 

