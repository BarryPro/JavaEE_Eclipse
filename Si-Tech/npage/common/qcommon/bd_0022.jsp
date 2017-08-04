<%
  /*
   author:zhouyg
   date:2009-2-11
　*/
%>
<%
   String gs_PSite_Cur=(String)session.getAttribute("objectId")==null?"":((String)session.getAttribute("objectId")).trim();
   String siteId0022= (String)session.getAttribute("siteId");
	 String workNo0022=(String)session.getAttribute("workNo")==null?"":((String)session.getAttribute("workNo")).trim();
	 String cityId0022=(String)session.getAttribute("cityId")==null?"":((String)session.getAttribute("cityId")).trim();
	 System.out.println("..........................#############prodId =="+prodId);
	 System.out.println("..........................#############cityId0022 =="+cityId0022);
	 System.out.println("..........................#############siteId0022 =="+siteId0022);
	 String branchNo_8009 = "";//固话品牌为一号通时所要传入的局站号；
	 String branchName_8009 = "";//固话品牌为一号通时所要传入的局站名；
	 String belongCode_q =orgCode.substring(0,7);

%>
<wtc:pubselect  name="sPubSelect"  outnum="1" retval="val">
       	<wtc:sql>select d.branch_no from dLoginMsg a,dChnGroupMsg b, tcgav_object c,trm_mdf_branch d where a.login_no='?' and a.group_id = b.group_id and b.dist_code=c.object_id and c.city_id = d.bureau_id and d.branch_sign='YHT'</wtc:sql>
       	<wtc:param value="<%=workNo0022%>"/>
</wtc:pubselect>
	<wtc:array id="rows" property="val" scope="end"/>
	<%
		System.out.println("------rows.length-----------"+rows.length);
		if(rows.length==0||rows[0].length==0){
			System.out.println("------rows.length is zero-----------");
		}else{
			branchNo_8009=rows[0][0];
		}
		System.out.println("branchNo_8009 in bd_0022============="+branchNo_8009);
	%>
<wtc:pubselect  name="sPubSelect"  outnum="1" retval="val">
       	<wtc:sql>select branch_name from trm_mdf_branch where branch_no = '?'</wtc:sql>
       	<wtc:param value="<%=branchNo_8009%>"/>
</wtc:pubselect>
	<wtc:array id="rows" property="val" scope="end"/>
	<%
		System.out.println("------rows.length-----------"+rows.length);
		if(rows.length==0||rows[0].length==0){
			System.out.println("------rows.length is zero-----------");
		}else{
			branchName_8009=rows[0][0];
		}
		System.out.println("branchName_8009 in bd_0022============="+branchName_8009);
	%>

<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<script type="text/javascript">
 var branchNo_8009="<%=branchNo_8009%>";
 var branchName_8009="<%=branchName_8009%>";
 var selByWay ;
 $().ready(function(){
	 if(srcNum > 1){
	 	document.all.selNum.size = 13*srcNum;
	 }else if(srcNum > 8){
	 	document.all.selNum.size = "100";
	 }else{
	 	document.all.selNum.size = "16";
	 }
 	 if(masterServId == "8009"){
 	 	if(document.all.newbranchno_name != undefined){
 			document.all.newbranchno_name.value = branchName_8009;
 		}
 	 }
 	 var myPacket = new AJAXPacket("/npage/common/qcommon/qry_sel_type.jsp","正在查询号码获取方式，请稍候......");
   myPacket.data.add("regionCode","<%=cityId0022%>");
   myPacket.data.add("prodId",masterServId);
   core.ajax.sendPacket(myPacket,getSelType);
	 myPacket =null;
 	});

 	function stopSpe0022(ele)
	{
		var b=ele.value;
		if( selByWay == "3" && /[^0-9a-z]/.test(b)) ele.value=ele.value.replace(/[^0-9a-z]/g,'');
	}
function 	getSelType(packet){
		var retCode = packet.data.findValueByName("retCode");
		if(retCode != "0"){
			rdShowMessageDialog("获取选号方式失败！请联系管理员",0)	;
			return false;
		}
		var  inner_no_rule= packet.data.findValueByName("inner_no_rule");
		var  inner_no_seq= packet.data.findValueByName("inner_no_seq");
		g("inner_no_rule").value=inner_no_rule;
		g("inner_no_seq").value=inner_no_seq;
		selByWay = packet.data.findValueByName("selByWay");
		if(g("selByWay")!= false){
			g("selByWay").value = 	selByWay;
		}
		if(selByWay == "1"){
			//g("selNum").readOnly = true;
			g("selNum").v_fp = "";
			g("selNum").v_lp = "";
			//g("getPhoneNum").style.display = "";
			g("getSequenceNo").style.display = "none";
		}else if(selByWay == "2"){
			//g("selNum").readOnly = true;
			g("selNum").v_fp =  packet.data.findValueByName("fPrefix");
			g("selNum").v_lp =  packet.data.findValueByName("lPrefix");
			//g("getPhoneNum").style.display = "none";
			g("getSequenceNo").style.display = "";
			g("getSequenceNo").v_para = packet.data.findValueByName("sequencePara");
		}else if(selByWay == "3"){
			//g("selNum").readOnly = false;
			g("selNum").v_fp =  packet.data.findValueByName("fPrefix");
			g("selNum").v_lp =  packet.data.findValueByName("lPrefix");
			g("selNum").value = g("selNum").v_fp + g("selNum").v_lp;
			//g("getPhoneNum").style.display = "none";
			g("getSequenceNo").style.display = "none";
		}else{
			//g("selNum").readOnly = false;
			g("selNum").v_fp = "";
			g("selNum").v_lp = "";
		}
}
function releaseGUNum(NUM){
//NUM为需要释放的号码或号码串；
  var myPacket = new AJAXPacket("/npage/common/qcommon/middle_1.jsp","正在释放号码信息，请稍候......");
  myPacket.data.add("retType","releaseGUNum");
  myPacket.data.add("NUM",NUM);
  myPacket.data.add("BRANCH_ID",branchNo);
  myPacket.data.add("STAFF_ID",'<%=session.getAttribute("workNo")%>');
  myPacket.data.add("SITE_ID",objectId);
  myPacket.data.add("NUM_TYPE","06");
  myPacket.data.add("OBJECT_TYPE","1");
  myPacket.data.add("CITY_ID",'<%=session.getAttribute("cityId")%>');
  core.ajax.sendPacket(myPacket,doProcess);
	chkPacket =null;
}
function releaseADSLNum(NUM)
{
//NUM为需要释放的号码或号码串；
	NUM=NUM.replace('~','|');
	var myPacket = new AJAXPacket("/npage/common/qcommon/okFreeNum.jsp","正在提交，请稍候......");
	myPacket.data.add("retType","releaseADSLNum");
	myPacket.data.add("account",NUM);
	myPacket.data.add("city_id",'<%=session.getAttribute("cityId")%>');
	myPacket.data.add("work_form_id","<%=workFormId%>");
	myPacket.data.add("conn_flag",selType);
	myPacket.data.add("staff_id","<%=workNo0022%>");
	myPacket.data.add("lastaccount","");
	myPacket.data.add("branch_no",branchNo);
	myPacket.data.add("prod_id",prodId.trim());
	myPacket.data.add("svc_inst_id","<%=svcInstId%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	}
function	release3GNum(NUM)
{
	//alert("release3GNum");
	//NUM为需要释放的号码或号码串；
	var myPacket = new AJAXPacket("/npage/common/qcommon/3GmiddleCancel.jsp","正在释放号码信息，请稍候......");
	myPacket.data.add("retType","release3GNum");
	myPacket.data.add("cancelStr",NUM);
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}
var preCancelState=1;
function cancelFun(packet){
		var errCode_1 = packet.data.findValueByName("errCode_1");
		if(jtrim(errCode_1)!="000000")
		{
			rdShowMessageDialog("号码释放失败,请与管理员联系！");
			preCancelState=0;
			return false;
		}
		else
		{
			document.all.selNum.value="";
			preCancelState=1;
		}
	}
	function cancelFun1(packet){
		var retCode = packet.data.findValueByName("retCode");
		if(retCode!="000000")
		{
			rdShowMessageDialog("释放号码失败！请与管理员联系。",0);
	   	preCancelState=0;
		  return false;
		}
		else
		{
			document.all.selNum.value="";
			preCancelState=1;
		}
	}
	function cancelFun2(packet){
		var retCode = packet.data.findValueByName("errCode");
		if(retCode!="000000")
		{
			rdShowMessageDialog("释放号码失败！请与管理员联系。",0);
	   	preCancelState=0;
		  return false;
		}
		else
		{
			document.all.selNum.value="";
			preCancelState=1;
		}
	}
function getSelectPhone(packet)
{

		var rePath  = packet.data.findValueByName("path");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg  = packet.data.findValueByName("retMsg");
		if(rePath == "")
		{
			rdShowMessageDialog("没有返回选号页面路径，请确认参数传入正确！",0);
	    return false;
		}
		else
		{
					//alert("branchNo_8009"+branchNo_8009);
					if(masterServId == "8009" && branchNo_8009!=''){
								branchNo = branchNo_8009;//如果是一号通，据站号设置成固定值；
								//alert("branchNo"+branchNo);
					}

				var path = "";
				//var prodId = prodId.trim();
				var cancelStr="";
				if((typeof prodId == 'undefined')||prodId==""||prodId==null){ rdShowMessageDialog("prodId传值错误",0);return false;}
				if(prodId=="1"&&document.all.selNum.value)//固话
				{
					if(srcNum>1&&document.all.multiNum)// 多选号码情况
					{
						var numGroup=document.all.multiNum.value.split("|");
						for(var i=0;i<numGroup.length;i++)
						{
								cancelStr+=((numGroup[i].split("~")[0])+"~");
						}
					}
					else if(srcNum==1)
					{
						cancelStr+=(document.all.selNum.value+"~");
					}
						var myPacket1 = new AJAXPacket("/npage/common/qcommon/middle_1.jsp","正在释放号码信息，请稍候......");
						myPacket1.data.add("retType","delNum");
						myPacket1.data.add("NUM",cancelStr);
						myPacket1.data.add("CITY_ID","<%=cityId0022%>");
						myPacket1.data.add("BRANCH_ID",branchNo);
						myPacket1.data.add("STAFF_ID","<%=workNo0022%>");
						myPacket1.data.add("SITE_ID","<%=siteId0022%>");
						if(prodId=="1")
						{
							myPacket1.data.add("NUM_TYPE","06");
						}
						core.ajax.sendPacket(myPacket1,cancelFun);
						myPacket1=null;
				}
				else if(prodId=="2"&&document.all.selNum.value)//ADSL
				{
						cancelStr+=(document.all.selNum.value);
						var myPacket2 = new AJAXPacket("/npage/common/qcommon/okFreeNum.jsp","正在提交，请稍候......");
						myPacket2.data.add("retType","delNum");
						myPacket2.data.add("account",cancelStr);
						myPacket2.data.add("city_id","<%=cityId0022%>");
						myPacket2.data.add("work_form_id","<%=workFormId%>");
						myPacket2.data.add("conn_flag",selType);
						myPacket2.data.add("staff_id","<%=workNo0022%>");
						myPacket2.data.add("lastaccount","");
						myPacket2.data.add("branch_no",branchNo);
						myPacket2.data.add("prod_id",prodId);
						myPacket2.data.add("svc_inst_id","<%=svcInstId%>");
						core.ajax.sendPacket(myPacket2,cancelFun1);
						myPacket2=null;
				}
				else if(prodId=="0"&&document.all.selNum.value)//移动
				{
						cancelStr+=(document.all.selNum.value)+"~";
						var myPacket3 = new AJAXPacket("/npage/common/qcommon/3GmiddleCancel.jsp","正在提交，请稍候......");
						myPacket3.data.add("cancelStr",cancelStr);
						core.ajax.sendPacket(myPacket3,cancelFun2);
						myPacket2=null;
				}
				if(preCancelState)
				{
															 vasProds =""; //增值产品串,主页面里要定义，到时删除 ,
															selType=1;//连入类型，主页面要定义，到时删除
												/********************此处为变量接口，现在写死******************************/
															 vasProds =prodId.trim()+"~";
																if (prodId.trim() == "2" || prodId.trim() =="1"||prodId.trim()=="0")//固话、ADSL、移动
															{
														    path = rePath+"?workNo=<%=workNo0022%>&cityId=<%=cityId0022%>&workFormId=<%=workFormId%>";
																path += "&svcInstId=<%=svcInstId%>&prodId="+prodId+"&branchNo="+branchNo + "&selType="+selType;
																path += "&objectId="+objectId+"&siteId=<%=siteId0022%>&svcId="+svcId+"&srcNum="+srcNum+"&vasProds="+vasProds+"&orderId=<%=custOrderId%>&masterServId="+masterServId;
																var ret = window.showModalDialog(path,"选择号码","dialogWidth:48;dialogHeight:35;");
											       			document.all.multiNum.value=ret;

															if (ret == "" || ret == undefined)
																{
																	 return false;
																}
																else
																{
																	var tempStr = ret;

																	//单,多号相同

															  	document.all.switchNo.value = "";
															  	//document.all.selNum.value = retNumInfo[0].trim();
															  	var numGroup=document.all.multiNum.value.split("|");
															  	var mulSelNum = "";
																for(var i=0;i<numGroup.length;i++)
																{
																		if(i==numGroup.length-1){
																			mulSelNum  = mulSelNum + ((numGroup[i].split("~")[0]));
																		}else{
																			mulSelNum  = mulSelNum + ((numGroup[i].split("~")[0])+"~");
																		}
																}
															  	if(prodId=="0")
															  	{
															  		if(g("cfmBtn") != false){
															  			g("cfmBtn").disabled = true;
															  		}
															  		var retNumInfo = ret.split("~");
															  		if(retNumInfo[1].trim())document.getElementById("simCode").value=retNumInfo[1].trim();
															  		//else alert("sim卡信息为空！");
															  		if(retNumInfo[2].trim())document.getElementById("simType").value=retNumInfo[2].trim();
															  		//else alert("sim卡状态信息为空！");
															  		if(retNumInfo[3].trim() && g("billDate")!=null) g("billDate").value= retNumInfo[3].substring(0,8);
															  		var open_type = g("openType");
																	/* 分销商返单原来是在选号后实现的,现在又资源校验来判断
																	if(open_type != null){
															  			selCInWay(retNumInfo[0].trim());
															  		}*/
															  	}
															  	//document.all.num2.value   = retNumInfo[0].trim();
															  	/*******************需传入局站**********************/
															  	document.all.num2.v_branch = branchNo;
															  	document.all.selNum.value = mulSelNum;
															  	//validateElement(document.all.selNum);
																}
														}
														else rdShowMessageDialog("产品id传入错误！",0);
						}
						else rdShowMessageDialog("号码释放失败！",0);
			}
}
/*
function selCInWay(phone_no){
	var myPacket = new AJAXPacket("/npage/common/qcommon/selcinway.jsp","正在C网号码属性，请稍候......");
	myPacket.data.add("phone_no",phone_no);
	core.ajax.sendPacket(myPacket,getCInWay);
	myPacket=null;
}

function getCInWay(packet){
	var retCode = packet.data.findValueByName("errorCode");
	if(retCode != "000000"){
		rdShowMessageDialog("获取号码属性失败！请联系管理员",0)	;
		return false;
	}
	var resCode = packet.data.findValueByName("resCode");
	var phoneNoGroupId = packet.data.findValueByName("groupId");
	var open_type = g("openType");
	if(open_type != null  && $("#openType").val() != "03" && $("#openType").val() != "04"){ //入网方式不为空, 入网方式不为租机和靓号入网
		if(resCode == "x"){
			$("#openType").html("<option value='02'>分销商返单</option>");
		}else{
			$("#openType").html("<option selected value='01'>普通开户</option><option value='02'>分销商返单</option>");
		}
	}
	g("maintainGroupId").value = phoneNoGroupId;
}
*/
function selectPhoneNum()//调用服务选择选号页面
{
	var myPacket = new AJAXPacket("/npage/common/qcommon/bd_0022ajaxSelectNum.jsp","正在查询序号页面路径，请稍候......");
	myPacket.data.add("prodId",prodId.trim());
	var tmpStr=prodId.trim()+"~";
	myPacket.data.add("vasProds",tmpStr);
	core.ajax.sendPacket(myPacket,getSelectPhone);
	myPacket=null;
}

function selSequenceNo()//调用服务选择选号页面
{
	var myPacket = new AJAXPacket("/npage/common/qcommon/get_sequence_no.jsp","正在获取序列值，请稍候......");
	myPacket.data.add("seqPara",g("getSequenceNo").v_para);
	core.ajax.sendPacket(myPacket,retSequenceNo);
	myPacket=null;
}
function retSequenceNo(packet){
		var retCode = packet.data.findValueByName("errorCode");
		if(retCode != "0"){
			rdShowMessageDialog("获取序列号失败！请联系管理员",0)	;
			return false;
		}
		var retSequenceNo = packet.data.findValueByName("sequenceNo");
		var obj = g("selNum");
		obj.value= retSequenceNo;
		var objvalue = obj.value;
		if(typeof(obj.v_fp) != "undefind" && obj.v_fp != "")
			obj.value = obj.v_fp + obj.value;
		if(typeof(obj.v_lp) != "undefind" && obj.v_lp != "")
			obj.value = obj.value + obj.v_lp;
		var VPNTypeId = "10";
		if(prodId == VPNTypeId){
			var s_20009obj = g("s_20009");
			if(s_20009obj != null){
				s_20009obj.value = retSequenceNo;
			}
		}
}
function changeInputNum(){
	if(selByWay != "3" ){
		return false;
	}
	var obj = g("selNum");
	var objvalue = g("selNum").value;
	if(typeof(obj.v_fp) != "undefind" && obj.v_fp != "" && objvalue.indexOf(obj.v_fp) != 0)
		obj.value = obj.v_fp + obj.value;
	if(typeof(obj.v_lp) != "undefind" && obj.v_lp != "" && objvalue.lastIndexOf(obj.v_lp) != (objvalue.length - obj.v_lp.length ))
		obj.value = obj.value + obj.v_lp;
	var myPacket = new AJAXPacket("/npage/common/qcommon/chk_sel_num.jsp","正在验证号码，请稍候......");
  myPacket.data.add("user_no_0022",g("selNum").value);
  core.ajax.sendPacket(myPacket,chkSelNum0022);
	myPacket =null;
}
function chkSelNum0022(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode != "0"){
			rdShowMessageDialog("所输号码验证失败！请联系管理员",0)	;
			g("selNum").value = "";
			return false;
	}
	var checkFlag0022 = packet.data.findValueByName("checkFlag0022");
	if(checkFlag0022 == "1"){
			rdShowMessageDialog("所输号码已经被占用,请重新输入！")	;
			g("selNum").value = "";
	}
}
function QryForeSimNo()
{
	//自动查询预先开通的sim卡号
    if((document.all.selNum.value).trim().length > 0)
    {
	  if(!checkElement(document.all.selNum))
	  {
	    return false;
	  }
      var QryForeSimNo_Packet = new AJAXPacket("/npage/common/qcommon/f1108_3.jsp","正在判断是否是预开通号码，请稍候......");
	    QryForeSimNo_Packet.data.add("retType","QryForeSimNo");
      QryForeSimNo_Packet.data.add("Phone_no",document.all.selNum.value);
		  core.ajax.sendPacket(QryForeSimNo_Packet);
		  QryForeSimNo_Packet=null;

	}
}
 	//-------------------------------------
 	function doProcess(packet)
{
		var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMessage = packet.data.findValueByName("retMessage");
	if(retType == "QryForeSimNo")
	{
		if(retCode=="000000")
    	{
			var foreFlag = packet.data.findValueByName("foreFlag");
			var simNo = packet.data.findValueByName("simNo");
			var simType = packet.data.findValueByName("simType");
			var simTypeName = packet.data.findValueByName("simTypeName");
			if(foreFlag != "N")
			{
				document.all.simCode.value = simNo;
				preFlag=true;
			    document.all.simType.value = simType;
			    if( simTypeName.trim()=="null"){
			    	}else{
				document.all.simTypeName.value = simTypeName.trim();
			       }
			}
			else
			{
        preFlag=false;
			}

 			//================
			var QryForeSimNo_Packet = new AJAXPacket("/npage/common/qcommon/fGetBindAddi.jsp","正在获得绑定附加资费，请稍候......");
 			QryForeSimNo_Packet.data.add("retType","fGetBindAddi");
 			QryForeSimNo_Packet.data.add("Phone_no",document.all.selNum.value);
 			QryForeSimNo_Packet.data.add("org_code","<%=belongCode_q%>");
 			QryForeSimNo_Packet.data.add("Sm_code",document.all.smCodeList.value);
 			core.ajax.sendPacket(QryForeSimNo_Packet);
 			QryForeSimNo_Packet=null;
    	}
    	else
    	{
    	  retMessage = retMessage + "[errorCode0:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			return false;
    	}
	}
		if(retType == "fGetBindAddi")
	{
		//得到绑定附加资费信息
        if(retCode=="000000")
    	{
		  var bindModeCode = packet.data.findValueByName("bindModeCode");
		  var bindModeName = packet.data.findValueByName("bindModeName");

		  //document.all.bindModeName.value=bindModeName;
		  //document.all.bindModeCode.value=bindModeCode;
		}
		else
		{
		     retMessage = retMessage + "[errorCode12:" + retCode + "]";
    	   rdShowMessageDialog(retMessage,0);
		     return false;
		}
	}
}




function isGoodNoF(obj){
	
	var open_type =$("#innetType").val();
	//if(!forMobil(obj))  return false;	//验证输入的手机号码的有效性
		var selNumValue = document.all.selNum.value;
		if(open_type!="04"){
			if((selNumValue.substring(0,3)=="147" || selNumValue.substring(0,3)=="157"|| selNumValue.substring(0,3)=="184") && ("<%=opCode%>"=="g784" || "<%=opCode%>"=="g785" || "<%=opCode%>"=="m028" ||"<%=opCode%>"=="1104" || "<%=opCode%>"=="m094")){
				
				var isGoddNo_Packet = new AJAXPacket("/npage/common/qcommon/isGoodNo.jsp","正在校验号码，请稍候......");
	 			isGoddNo_Packet.data.add("selNumValue",selNumValue);
	 			var ifGoodPhone = false;
	 			core.ajax.sendPacket(isGoddNo_Packet,function(packet){
	 				var countGoodNo = packet.data.findValueByName("countGoodNo");
					if(countGoodNo!=0){
							rdShowMessageDialog("此号码只能从靓号入网开户",0);
							document.all.selNum.value = "";
							
							ifGoodPhone = true;
				   		return false;
					}
	 			});
	 			isGoddNo_Packet=null;
	 			if(ifGoodPhone){
	 				return false;
	 			}
			}
			if(selNumValue.substring(0,3)=="188"){
					if("<%=opCode%>"=="m028" || "<%=opCode%>"=="m094") {
						  //判断188号段中是否为优良号码 
							var isGoddNo_Packet = new AJAXPacket("/npage/common/qcommon/isGoodNo.jsp","正在校验号码，请稍候......");
						 			isGoddNo_Packet.data.add("selNumValue",selNumValue);
						 			core.ajax.sendPacket(isGoddNo_Packet,doIsGoodNo);
						 			isGoddNo_Packet=null;
							
					}else {
						//关于“校园营销预开户”界面增加188号段开户功能的函 修改 增加校验 hejwa 2013年9月11日9:59:01
						if("<%=opCode%>"=="g784"||"<%=opCode%>"=="g785"){
							//判断188号段中是否为优良号码 
							var isGoddNo_Packet = new AJAXPacket("/npage/common/qcommon/isGoodNo.jsp","正在校验号码，请稍候......");
						 			isGoddNo_Packet.data.add("selNumValue",selNumValue);
						 			core.ajax.sendPacket(isGoddNo_Packet,doIsGoodNo);
						 			isGoddNo_Packet=null;
						}else{
							/*2014/09/28 10:57:27 gaopeng 关于完善自助换卡功能和188号码开户界面的函 
								普通开户时，其他的opcode对188号段也进行判断，不是特殊号码的可以开户，而不是直接就搞成必须去特殊号码开户。
							*/
							var isGoddNo_Packet = new AJAXPacket("/npage/common/qcommon/isGoodNo.jsp","正在校验号码，请稍候......");
						 			isGoddNo_Packet.data.add("selNumValue",selNumValue);
						 			core.ajax.sendPacket(isGoddNo_Packet,doIsGoodNo);
						 			isGoddNo_Packet=null;
							
				  	}
		  	}
			}
			/* 20120914 gaopeng 加入157TD的业务限制 begin*/
			else if(selNumValue.substring(0,3)=="157")	
			{
				
				var packet = new AJAXPacket("/npage/bill/check157SuperTD.jsp","正在验证，请稍后。。。");
				packet.data.add("phoneNo",document.all.selNum.value);
	      core.ajax.sendPacket(packet,doPro12);
	      packet =null;
	      if($("#flags").val() == "TD")
	         {
	         	rdShowMessageDialog("此号码只能从靓号入网开户",0);
						document.all.selNum.value = "";
				   	return false;
	         	
	      		}
	      else
	      	{
	      		return true;
	      	}
	      
	      
			}
			else if(selNumValue.substring(0,3)=="184")	
			{
				
				var packet = new AJAXPacket("/npage/bill/check184SuperTD.jsp","正在验证，请稍后。。。");
				packet.data.add("phoneNo",document.all.selNum.value);
	      core.ajax.sendPacket(packet,doPro12);
	      packet =null;
	      if($("#flags").val() == "TD")
	         {
	         	rdShowMessageDialog("此号码只能从靓号入网开户",0);
						document.all.selNum.value = "";
				   	return false;
	         	
	      		}
	      else
	      	{
	      		return true;
	      	}
	      
	      
			}
			/* 20120914 gaopeng 加入157TD的业务限制 end*/
			/* 20120914 gaopeng 加入147TD的业务限制 begin*/
			else if(selNumValue.substring(0,3)=="147")	
			{
				
				var packet = new AJAXPacket("/npage/bill/check147SuperTD.jsp","正在验证，请稍后。。。");
				packet.data.add("phoneNo",document.all.selNum.value);
	      core.ajax.sendPacket(packet,doPro12);
	      packet =null;
	      if($("#flags").val() == "TD")
	         {
	         	rdShowMessageDialog("此号码只能从靓号入网开户",0);
						document.all.selNum.value = "";
				   	return false;
	         	
	      		}
	      else
	      	{
	      		return true;
	      	}
	      
	      
			}
			/* 20120914 gaopeng 加入147TD的业务限制 end*/
			else{  
				
					var isGoddNo_Packet = new AJAXPacket("/npage/common/qcommon/isGoodNo.jsp","正在获得绑定附加资费，请稍候......");
				 			isGoddNo_Packet.data.add("selNumValue",selNumValue);
				 			core.ajax.sendPacket(isGoddNo_Packet,doIsGoodNo);
				 			isGoddNo_Packet=null;
			}
		}

	if(selOfferType=="08"){
			ajaxSetSimNo(selNumValue.substring(0,7));
	  }
	}
	function doPro12(packet)
{
	var result = packet.data.findValueByName("result");
	if(result == "true")
	{
		$("#flags").val("TD");
		return ;
	}
}
	function ajaxSetSimNo(phHd){
		var getSimNo_packet = new AJAXPacket("/npage/common/qcommon/ajaxGetSimNo.jsp","正在获得sim卡号码，请稍候......");
				getSimNo_packet.data.add("phHd",phHd);
				core.ajax.sendPacket(getSimNo_packet,doAjaxSetSimNo);
				getSimNo_packet=null;
	}

	function doAjaxSetSimNo(packet){
		var retSimNo = packet.data.findValueByName("retSimNo");
		if(retSimNo!=""){
				document.all.simCode.value=retSimNo;
		}else{
				document.all.simCode.value="";
				rdShowMessageDialog("没有查到sim卡号码");
		}
	}
	function doIsGoodNo(packet){
			var countGoodNo = packet.data.findValueByName("countGoodNo");
			if(countGoodNo!=0){
					rdShowMessageDialog("此号码只能从靓号入网开户",0);
					document.all.selNum.value = "";
		   		return false;
				}
		}
</script>
<input name="selNum" value="" type="text" v_fp="" v_lp=""  id="selNum"  size="16"  maxLength="13" onblur="isGoodNoF(this)"/>
<!--<input name="selNum" value="" type="text" v_fp="" v_lp=""  id="selNum"  size="16"  maxLength="13" />-->
<!--input type="button" name="getPhoneNum" value="选号" style="display:none" onmouseup="selectPhoneNum()" onkeyup="if(event.keyCode==13)selectPhoneNum()"  class="b_text"/-->
<input type="hidden" name="getSequenceNo" v_para="" value="获得" style="display:none" onmouseup="selSequenceNo()" onkeyup="if(event.keyCode==13)selSequenceNo()"  class="b_text"/>
<input type="hidden" name="multiNum" id="hideNum" value="">
<input type="hidden" name="simType" id="simType">
<input type="hidden" name="num2" v_branch="" value="">
<input type="hidden" name="switchNo" value="">
<input type="hidden" name="inner_no_rule" value=""/>
<input type="hidden" name="inner_no_seq" value=""/>
<input type="hidden" name="smCodeList" value="dn"/>
<input type="hidden" id="flags" name="flags" value=""/>
