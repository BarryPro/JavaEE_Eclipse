<%
/********************
 version v2.0
开发商: si-tech
update:yanpx@2008-9-17
********************/
%> 
<%@ page contentType="text/html; charset=GBK" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">


<%@ page import="com.sitech.boss.pub.util.*" %>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="../../npage/public/fPubPrintNote.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String Role = (String)session.getAttribute("powerRight");
	String Department = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = Department.substring(0,2);
	String belongCode = Department.substring(0,7);
	/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
%>

<%
	String opName = "亲情号码变更";//模块名称
  String retFlag="",retMsg="";//存放是否校验失败的标志、信息
  /****************由移动号码得到密码、机主姓名、亲情号码申请情况等信息 s1239Init***********************/

	String iPhoneNo=request.getParameter("mphone_no");//手机号码
	String iLoginNo=workNo;	  //操作工号
	String iOrgCode=Department; //机构编码
	String opeType=request.getParameter("opFlag");//操作类型
	String serviceName = "s1239Init";
	String opeTypeFlag="";
	String opCode="";
	String outParaNums= "29";
	String radioView = "";
	String trOneView = "";
	String trOneViewa = "";
	String updateNewPhonenoView = "";
	String cSpan="";
	String op_code="1239";
	
	String jyButton = "";
	String flag = "true";
	System.out.println("--------------opeType---------------"+opeType);
	String g493ShowFlag = "";
	if(opeType.equals("新增"))
	{
	  opeTypeFlag="0";
	  opCode = "1239";
	  radioView = "display:none";//单选按钮的可见性
	  trOneView = "";//行的可见性
	  trOneViewa = "";
	  updateNewPhonenoView = "display:none";//修改亲情号码的可见性
	  cSpan="1";//控制手续费一行表格的显示
	  jyButton = "display:none";//校验按钮的可见性

	}else if(opeType.equals("删除")){
	  opeTypeFlag="1";
	  opCode = "g493";
	  opName = "亲情号码取消";
	  radioView = "";
	  trOneView = "";
	  trOneViewa = "display:none";
	  updateNewPhonenoView = "display:none";
	  jyButton = "display:none";
	  g493ShowFlag = "display:none";
	  cSpan="1";
	}else if(opeType.equals("修改")){
	  opeTypeFlag="2";
	  opCode = "123b";
	  radioView = "";
	  trOneView = "";
	  trOneViewa = "display:none";
	  updateNewPhonenoView = "";
	  cSpan="1";
	  jyButton = "";
	}

	String user_passwd = "",cust_name = "",sm_name = "",oOldMode = "",oOldModeName = "",grpbig_flag = "",grpbig_name = "",oNextMode = "",oNextModeName = "",vHandFee = "",vFavourCode = "",kin_count="",lack_fee="",prepay_fee="",idCard_type="",idCard_no="",print_note="",cust_id="";
	System.out.println("----------------serviceName--------------"+serviceName);
	
	
	System.out.println("-----------0----------0");
	System.out.println("-----------0----------01");
	System.out.println("-----------opCode----------"+opCode);
	System.out.println("-----------iLoginNo----------"+iLoginNo);
	System.out.println("---------------------");
	System.out.println("-----------iPhoneNo----------"+iPhoneNo);
	System.out.println("---------------------");
	System.out.println("-----------iOrgCode----------"+iOrgCode);
	
	
	%>
	<wtc:service  name="<%=serviceName%>"  routerKey="phone" routerValue="<%=iPhoneNo%>" outnum="<%=outParaNums%>"  retcode="errCode" retmsg="errMsg">
		<wtc:param  value="0"/>
		<wtc:param  value="01"/>
		<wtc:param  value="<%=opCode%>"/>
		<wtc:param  value="<%=iLoginNo%>"/>
		<wtc:param  value="<%=op_strong_pwd%>"/>
		<wtc:param  value="<%=iPhoneNo%>"/>
		<wtc:param  value=""/>
		<wtc:param  value="<%=iOrgCode%>"/>
  </wtc:service>
  <wtc:array id="list" start="0" length="22"  scope="end"/>
	<wtc:array id="tmpresult1"  start="23"  length="1" scope="end"></wtc:array>
 	<wtc:array id="tmpresult3"  start="24"  length="1" scope="end"></wtc:array>
	<wtc:array id="tmpresult2"  start="26"  length="1" scope="end"></wtc:array>  
 	<wtc:array id="tmpresult4"  start="27"  length="1" scope="end"></wtc:array>
 	<wtc:array id="tmpresult5"  start="28"  length="1" scope="end"></wtc:array>
	<%
	System.out.println("错误代码："+errCode);
	System.out.println("错误内容："+errMsg );

	int j=0;


	if(errCode.equals("0")||errCode.equals("000000")){
	 if(list==null){
		if(!retFlag.equals("1"))
	    {
			retFlag="1";
			retMsg="s1239Init查询基本信息为空!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
			System.out.println(retMsg);
		}
	 }
	 
	 System.out.println("---------------------------------");
	  user_passwd=list[0][2];		  	//用户密码
    cust_name=list[0][3];		  	//客户姓名
    sm_name=list[0][4]; 			  //业务种类
    oOldMode=list[0][5];    		//当月资费
    oOldModeName=list[0][6];		//当月资费名称


    oNextMode=list[0][7];			  //下月资费
    oNextModeName=list[0][8];		//下月资费名称
    grpbig_flag=list[0][9];			//大客户标志
    grpbig_name=list[0][10];			//大客户名称
    vHandFee=list[0][11];			  //手续费;
    vFavourCode=list[0][12];			//手续费优惠代码
    System.out.println("vFavourCode:"+vFavourCode);
    lack_fee=list[0][13];			  //总欠费
    prepay_fee=list[0][14];			//总预存
    idCard_type=list[0][15];			//证件类型

    idCard_no=list[0][16];			  //证件号码
    kin_count=list[0][17];			  //已经申请亲情号码数量
    print_note=list[0][19];			//工单广告词
    cust_id=list[0][21];		    	//用户id

	  //tmpresult1  亲情号码
	  //tmpresult2  亲情号码资费
	  //tmpresult3  操作工号
	  //tmpresult4  生效日期

	  //判断用户是否有亲情号码信息
		System.out.println("kin_count"+kin_count);
		System.out.println("kin_count"+kin_count);

	  //判断是否该号码时候已经申请了亲情号，如没有则不能进行修改和删除操作
		if(opeTypeFlag.equals("1")||opeTypeFlag.equals("2")){
			if(kin_count==null || kin_count.trim().equals("") || Integer.parseInt(kin_count)<1){
				if(!retFlag.equals("1"))
				{
					retFlag = "1";
					retMsg = "该号码没有对应的亲情号码，不能进行该业务!";
				}
			}
		}
		//判断是否申请了限制数量的亲情号码，如果达到限制，则不能进行新增操作
		if(opeTypeFlag.equals("0")){
			if(Integer.parseInt(kin_count)==9 && oOldMode.equals("0007p700")){
				if(!retFlag.equals("1")){
					retFlag = "1";
					retMsg = "该号码已经申请了9个亲情号码，不能再进行新增操作!";
				}
			}
		}
	}
	else{
		if(!retFlag.equals("1"))
		{
			retFlag = "1";
			retMsg = "s1239Init查询错误!errMsg: "+errMsg;
		}
	}

  //********************得到营业员权限，核对密码，并设置优惠权限*****************************//
  //优惠信息
  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
  String handFee_Favourable = "readonly";        //a230  手续费
  int infoLen = favInfo.length;
  String tempStr = "";

  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
	  if(tempStr.compareTo(vFavourCode) == 0)
    {
      handFee_Favourable = "readonly";           //手续费优惠权限时是否对手续费优惠　
    }
  }
  String passtrans=request.getParameter("pwd");

  String addr="";
  String sqlRateCode = "";
  String vLimitNum="";
  String printAccept="";
  String[][] rateCodeStr= new String[][]{};
  String groupId =(String)session.getAttribute("groupId");
  
  if(errCode.equals("0")||errCode.equals("000000"))
  {
    
   
    /******************得到下拉框数据***************************/
	if(opCode.equals("1239")){
		sqlRateCode = "select distinct e.offer_id, e.offer_id_name, f.hand_fee, e.limit_number, f.offer_comments from ( select a.member_id, b.serv_id, c.offer_id as offer_id, c.offer_id|| '--' ||trim(c.offer_name) as offer_id_name, d.offer_attr_value as limit_number, nvl(c.offer_comments, '@@@@') as offer_comments   from group_instance_member a, product_offer_instance b, product_offer c, product_offer_attr d  where a.group_id(+) = b.group_id     and b.exp_date > sysdate      and b.offer_id = c.offer_id     and c.offer_id = d.offer_id     and d.offer_attr_seq = '20001'     and b.serv_id = "+cust_id+") e, (select a.member_id, b.serv_id,  c.offer_id as offer_id, c.offer_id|| '--' ||trim(c.offer_name) as offer_id_name, d.offer_attr_value as hand_fee, nvl(c.offer_comments, '@@@@') as offer_comments    from group_instance_member a, product_offer_instance b, product_offer c, product_offer_attr d   where a.group_id(+) = b.group_id     and b.exp_date > sysdate      and b.offer_id = c.offer_id     and c.offer_id = d.offer_id     and d.offer_attr_seq = '20003'     and b.serv_id = "+cust_id+") f  where e.serv_id = f.serv_id    and e.offer_id = f.offer_id  ";
	}else{
		sqlRateCode = "select distinct e.offer_id, e.offer_id_name, f.hand_fee, e.limit_number, f.offer_comments from ( select a.member_id, b.serv_id, c.offer_id as offer_id, c.offer_id|| '--' ||trim(c.offer_name) as offer_id_name, d.offer_attr_value as limit_number, nvl(c.offer_comments, '@@@@') as offer_comments   from group_instance_member a, product_offer_instance b, product_offer c, product_offer_attr d  where a.group_id = b.group_id     and b.exp_date > sysdate      and b.offer_id = c.offer_id     and c.offer_id = d.offer_id     and d.offer_attr_seq = '20001'     and b.serv_id = "+cust_id+") e, (select a.member_id, b.serv_id,  c.offer_id as offer_id, c.offer_id|| '--' ||trim(c.offer_name) as offer_id_name, d.offer_attr_value as hand_fee, nvl(c.offer_comments, '@@@@') as offer_comments    from group_instance_member a, product_offer_instance b, product_offer c, product_offer_attr d   where a.group_id = b.group_id     and b.exp_date > sysdate      and b.offer_id = c.offer_id     and c.offer_id = d.offer_id     and d.offer_attr_seq = '20003'     and b.serv_id = "+cust_id+") f  where e.serv_id = f.serv_id    and e.offer_id = f.offer_id  ";
	}
	System.out.println("sqlRateCode="+sqlRateCode);
	
	%> 
 
	<wtc:pubselect name="sPubSelect" outnum="5" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:sql><%=sqlRateCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="arr" scope="end" />

	<%
	System.out.println("----------------1----------------");
		if(tmpresult5.length>0&&tmpresult5[0][0]!=null)
		addr = tmpresult5[0][0];
		System.out.println("**********addr="+addr);
	  rateCodeStr = arr;
    if(rateCodeStr.length==0)
    {
    	if(!retFlag.equals("1"))
	    {
			retFlag="1";
			retMsg="该套餐不能申请亲情号码!";
		}
    }

  if(rateCodeStr != null && rateCodeStr.length!=0)
  {
  	for(int ratelen=0; ratelen < rateCodeStr.length; ratelen++)
  	{ 
  	
  	System.out.println("--------rateCodeStr["+ratelen+"][0]------"+rateCodeStr[ratelen][0]);
	%>
	<wtc:service name="s9611Cfm3" routerKey="regionCode" routerValue="<%=regionCode%>" retmsg="msg4" retcode="code4"  outnum="4" >
	    <wtc:param value="<%=opCode%>"/>
	    <wtc:param value="1"/>
	    <wtc:param value="2"/>
	    <wtc:param value="<%=groupId%>"/>
	    <wtc:param value="<%=rateCodeStr[ratelen][0]%>"/>
	    <wtc:param value="10442"/>
	    <wtc:param value="<%=regionCode%>"/>
	    <wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result" scope="end" />	
	<%
	  System.out.println(rateCodeStr[ratelen][4]);
	  if(result.length==0){
	     rateCodeStr[ratelen][4]="";
	  }else{
	  	 rateCodeStr[ratelen][4]=result[0][0];
	  	}
   }
  }
  
    /****得到打印流水****/

    printAccept = getMaxAccept();
  }

%>
<script language="javascript">
var vRateCodeStr = new Array(new Array(),new Array(),new Array(),new Array(),new Array());
<%
  if(rateCodeStr != null && rateCodeStr.length!=0)
  {
  	for(int first=0; first < rateCodeStr.length; first++ )
  	{
  		for(int secondd=0; secondd < rateCodeStr[first].length; secondd ++)
  		{
  		  System.out.println("rateCodeStr["+first+"]["+secondd+"]"+rateCodeStr[first][secondd]);
%>
			vRateCodeStr[<%=secondd%>][<%=first%>] = "<%=rateCodeStr[first][secondd]%>";
<%
  		}
  	}
  }
%>
</script>


<HTML><HEAD><TITLE>> <%=opName%> </TITLE>
</HEAD>

<SCRIPT type=text/javascript>
	var oOldMode="<%=oOldMode%>";
	var returnvalues="0";
	var addbendiphone="";
	var addshengneiphone="";
	var updatebendiphone="";
	var updateshengneiphone="";
  <%if(retFlag.equals("1")){%>
	  rdShowMessageDialog("<%=retMsg%>");
  	history.go(-1);
  <%}%>

 //***
  function frmCfm(){
//alert("document.all.rate_code_1.value|"+document.all.rate_code_1.value);  	
	  document.frm1239.submit();
		return true;
  }
//-------------------------------------------------
//验证
function isMadeOf(val,str)
{

	var jj;
	var chr;
	for (jj=0;jj<val.length;++jj){
		chr=val.charAt(jj);
		if (str.indexOf(chr,0)==-1)
			return false;			
	}
	
	return true;
}

function checkOne(){
  if(document.frm1239.op_type.value=="新增")
  {
    var phoneNum=new Array();                         //亲情号码数组
    var phoneNo=document.frm1239.new_phoneno.value;   //输入的亲情号码字符串
    phoneNum=phoneNo.split("~");
    document.frm1239.all_kinphone.value=phoneNum;

	//标准神州行资费状态下，亲情号码合法性判断
	for(i=0;i<phoneNum.length;i++){
		if (!isMadeOf(phoneNum[i],"0123456789")){
			rdShowMessageDialog("新亲情号码的值不正确！请输入数字！");
			document.frm1239.new_phoneno.focus();
			return false;
		}
	    if(phoneNum[i].substr(0,2)=="13"||phoneNum[i].substr(0,2)=="15"||phoneNum[i].substr(0,2)=="18"||phoneNum[i].substr(0,2)=="14"){
	        if(phoneNum[i].length!=11){
	        	rdShowMessageDialog("手机号码只能是11位！");
	        	document.frm1239.new_phoneno.focus();
	          return false;
	        }
	    }
	    if(phoneNum[i].substr(0,1)=="0"){
	     	if(phoneNum[i].length!=11 && phoneNum[i].length!=12 && phoneNum[i].length!=13){
	     	  rdShowMessageDialog("新亲情号码的值不正确！长度有错误！");
	     	  document.frm1239.new_phoneno.focus();
	     	  return false;
	     	}
	    }
	    if(phoneNum[i].substr(0,1)!="0" && phoneNum[i].substr(0,2)!="13"&&phoneNum[i].substr(0,2)!="15"&&phoneNum[i].substr(0,2)!="18"&&phoneNum[i].substr(0,2)!="14"&&phoneNum[i].substr(0,2)!="17"){
	      rdShowMessageDialog("您输入的亲情号码有误！<br>您可以输入13或15或14或18或17开头的手机号码和0开头的固话号码!!!");
	      document.frm1239.new_phoneno.focus();
	      return false;
	    }
	}
	//其他资费状态只允许设置网内号码
	if(document.frm1239.rate_code_1.value=="")
	{
		rdShowMessageDialog("资费信息不能为空!");
		document.frm1239.rate_code_1.focus();
		return false;
	}
  }
  else if(document.frm1239.op_type.value=="删除"){
    var tempRadio = document.getElementsByName("radio1");
    var flag = "0";
    for(var i=0; i<tempRadio.length; i++)
    {
	    if(tempRadio[i].checked)
		  {
		    document.frm1239.newPhoneno.value=eval("document.frm1239.newPhoneno"+tempRadio[i].value+".value");
		    document.frm1239.rateCode.value=eval("document.frm1239.rateCode"+tempRadio[i].value+".value");
		    flag = "1";
		    break;
		  }
    }
    var cenPhoneList = "";
    //查找选中的亲情号码
    $("tr[id^='list']").each(function(){
    	var b = $(this).find("input[type='checkbox']").attr("checked");
    	if(b){
    		var phoneNo = $(this).find("td:eq(1)").text().trim();
    		cenPhoneList += phoneNo+"|";
    	}
    });
    if(cenPhoneList!=""){//去掉最后一个竖线
    	cenPhoneList = cenPhoneList.substring(0,cenPhoneList.length-1); 
    }
    $("#cenPhoneList").val(cenPhoneList);
    if(flag=="0"){
      rdShowMessageDialog("请选择要取消的亲情号码!");
	  return false;
    }
  }
  else if(document.frm1239.op_type.value=="修改"){
    var tempRadio = document.getElementsByName("radio1");
    var flag = "0";
	var selectedRowNum=-1;
    for(var i=0; i<tempRadio.length; i++)
    {
      if(tempRadio[i].checked)
	  　{
			document.frm1239.newPhoneno.value=eval("document.frm1239.newPhoneno"+tempRadio[i].value+".value");
			document.frm1239.rateCode.value=eval("document.frm1239.rateCode"+tempRadio[i].value+".value");
			flag = "1";
			var tempInput ,tempId;
			tempInput = eval("document.frm1239.update_newPhoneno"+i);
			tempInput.v_must = "1";
			tempInput.v_minlength = "11";
			var up_newPhoneno=tempInput.value;

			//对输入的手机号码的合法性进行判断，包括移动、联通和固话
			if(oOldMode=="0007p700"){
				if(up_newPhoneno.length==0){
					rdShowMessageDialog("修改的新亲情号码必须填写!");
					return false;
				}
				if(up_newPhoneno.substr(0,2)=="13"||up_newPhoneno.substr(0,2)=="15"||up_newPhoneno.substr(0,2)=="18"||up_newPhoneno.substr(0,2)=="14"){
          			tempInput.v_type="mobphone";
		         	if(!eval("checkElement(tempInput)"))
		         	{
		         		return false;
		         	}
          		}
				if(up_newPhoneno.substr(0,1)=="0"){
					if(!eval("forString(tempInput)"))
					{
					return false;
					}
				}
				if(up_newPhoneno.substr(0,1)!="0" && up_newPhoneno.substr(0,2)!="13"&&up_newPhoneno.substr(0,2)!="15"&&up_newPhoneno.substr(0,2)!="18"&&up_newPhoneno.substr(0,2)!="14"&&up_newPhoneno.substr(0,2)!="17"){
					rdShowMessageDialog("您输入的亲情号码有误！<br>您可以输入13或15或14或18或17开头的手机号码和0开头的固话号码！"); 
					return false;
				}
			}
			else{
				if(up_newPhoneno.length==0){
					rdShowMessageDialog("修改的新亲情号码必须填写!");
					return false;
				}
				if(up_newPhoneno.substr(0,1)!="0" && up_newPhoneno.substr(0,2)!="13"&&up_newPhoneno.substr(0,2)!="15"&&up_newPhoneno.substr(0,2)!="18"&&up_newPhoneno.substr(0,2)!="14"&&up_newPhoneno.substr(0,2)!="17"){
					rdShowMessageDialog("您输入的亲情号码有误！<br>您可以输入13或15或14或18或17开头的手机号码和0开头的固话号码！"); 
					return false;
				}
        	}
        	document.frm1239.update_newPhoneno.value = tempInput.value;
		　  break;
	    }
    }
    if(flag=="0"){
		rdShowMessageDialog("请选择要修改的亲情号码!");
	    return false;
    }
  }
  return true;
}
 
function printCommit()
{
			
	getAfterPrompt();
	//验证 add by wanglm 2010-8-26 方法提出
	 var code = $("#rate_code_1 option:selected").text();
     var codeText = code.substring(code.lastIndexOf("-")+1);
     if(codeText == "1元动感亲情号码" || codeText == "3元动感地带亲情号码" ){
     var flag = $("#flag").val();//这里相当于 是字符串 所以不能直接 &&
     if( doJudgePhone() && flag == "true"   ){
  	      doReport();//打印工单
       }
     }
      else{
      	if(doJudgePhone()){
      	   var new_phoneno = "";
      	    
		   if(<%=opeTypeFlag%> == "2"){
		       new_phoneno = $("#updatestrall").val();//或得输入的 手机号码(修改时)
		       
		       	var offerids1 = document.frm1239.rate_code_1.value; 
		       if(offerids1=="36725" || offerids1=="36726" || offerids1 == "36724")  {
		       var upnew1 = document.frm1239.updatestrall.value;
		       var upnestr="";
		       	var sm1= new Array();
		       	if(upnew1.length>0)  {//将所有号码组织拼成一条数据---已经办理的号码+新增的号码
				    sm1 =upnew1.split("~");
		        for(i=0;i <sm1.length;i++) 
						{
						if(sm1[i]=="") {
						break;
						}
		  				upnestr+=sm1[i]+",";
						}
				   			   	
				   	}
				   	//alert(upnestr);
				   			var getdataPacket = new AJAXPacket("f1239_checkInner.jsp","正在获得数据，请稍候......");
								getdataPacket.data.add("phone_no",<%=iPhoneNo%>);
								getdataPacket.data.add("flagtype","01");
								getdataPacket.data.add("offerid",offerids1);
								getdataPacket.data.add("updatenestr",upnestr);
								core.ajax.sendPacket(getdataPacket,checkReturnValue);
								getdataPacket = null;
						
  	   	}
		       
		   	}else{
		   	   new_phoneno = $("#new_phoneno").val();	//或得输入的 手机号码(增加时)
		   	   
		   	var offerids1 = document.frm1239.rate_code_1.value; 
		   	
		   	if(offerids1=="36725" || offerids1=="36726" || offerids1 == "36724")  {//资费代码是36725和36726的则校验省内号码
		   	var upnew1 =document.frm1239.updatestrall.value; 
		   	var upnew2 =document.frm1239.all_kinphone.value; 
		   	var upnestr="";
		   	var sm1= new Array();
		   	var sm2= new Array();
      	
		   	if(upnew1.length>0)  {//将所有号码组织拼成一条数据---已经办理的号码+新增的号码		 
 
        sm1 =upnew1.split("~");
        for(i=0;i <sm1.length;i++) 
				{
				if(sm1[i]=="") {
				break;
				}
  				upnestr+=sm1[i]+",";
				}
		   			   	
		   	}
		   //upnestr+=upnew2+",";
		     //upnew2+=",";
				//alert(upnew2);
				//alert(upnestr);
				
		var getdataPacket = new AJAXPacket("f1239_checkInner.jsp","正在获得数据，请稍候......");
		getdataPacket.data.add("phone_no",<%=iPhoneNo%>);
		getdataPacket.data.add("flagtype","00");
		getdataPacket.data.add("offerid",offerids1);
		getdataPacket.data.add("addnestr2",upnestr);
		getdataPacket.data.add("addnestr",upnew2);
		core.ajax.sendPacket(getdataPacket,checkReturnValue);
		getdataPacket = null;
						
  	   	}
		   	}
		   	
		   	if(returnvalues=="0") {
		   	doReport();//打印工单
		   	}else {
		   	}
		   	returnvalues="0";
       }
      }
}
function checkReturnValue(packet) {
 var flagtype = packet.data.findValueByName("flagtype");
 var booleanflag = packet.data.findValueByName("booleanflag");
 //alert(booleanflag); 
 		if(flagtype=="00") {
 		if(booleanflag=="no") {
 		var offerid = packet.data.findValueByName("offerid");
 		if(offerid=="36725") {
 		rdShowMessageDialog("亲情号码中最多可设置一个省内移动号码，请确认后再输入！");	
 		}
 		if(offerid=="36726") {
 		rdShowMessageDialog("亲情号码中最多可设置二个省内移动号码，请确认后再输入！");	
 		}
 		returnvalues="1";
 		 document.frm1239.updatestrall.value="";
 		}
 		if(booleanflag=="yes") {
 			var bendihaoma = packet.data.findValueByName("bendihaoma");
 			var changtuhaoma = packet.data.findValueByName("changtuhaoma");
 			
 			//alert(bendihaoma);
 			//alert(changtuhaoma);
       addbendiphone=bendihaoma;
	     addshengneiphone=changtuhaoma;

 		}
 		}
 		else {
 		 		if(booleanflag=="no") {
		 		 		var offerid = packet.data.findValueByName("offerid");
			 		if(offerid=="36725") {
			 		rdShowMessageDialog("亲情号码中最多可设置一个省内移动号码，请确认后再输入！");	
			 		}
			 		if(offerid=="36726") {
			 		rdShowMessageDialog("亲情号码中最多可设置二个省内移动号码，请确认后再输入！");	
			 		}	
		 		returnvalues="1";
		 		 document.frm1239.updatestrall.value="";
 		 }
 		if(booleanflag=="yes") {
 			var bendiupdate = packet.data.findValueByName("bendiupdate");
 			var changtuupdate = packet.data.findValueByName("changtuupdate");
 			//alert(bendiupdate);
 			//alert(changtuupdate);
       updatebendiphone=bendiupdate;
	     updateshengneiphone=changtuupdate;

 		}
 		

 		}
}
function doReport(){
   setOpNote();//为备注赋值
     //打印工单并提交表单
     var ret = showPrtdlg("Detail","确实要进行电子免填单打印吗？","Yes");
     document.frm1239.updatestrall.value="";
     if(typeof(ret)!="undefined")
     {
        if((ret=="confirm"))
        {
          if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
          {
          	document.all.printcount.value="1";
	          frmCfm();
          }
	      }
	      if(ret=="continueSub")
	      {
          if(rdShowConfirmDialog('确认要提交信息吗？')==1)
          {
          	document.all.printcount.value="0";
	          frmCfm();
          }
	      }
   }
   else
   {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
       	   document.all.printcount.value="0";
	       frmCfm();
       }
    }	
}
function doJudgePhone(){
     if(!checkOne()) return false;
	var tempRadio = document.getElementsByName("radio1");
	if("<%=opeTypeFlag%>"=="2"){
		document.frm1239.updatestr.value="";
		document.frm1239.oldstr.value="";
		document.frm1239.newstr.value="";
		document.frm1239.updatestrprn.value="";
		document.frm1239.updatestrall.value="";
		document.frm1239.updatecount.value="";
		var updatecount=0;
		
		if(document.frm1239.rate_code_1.value=="")
		{
			rdShowMessageDialog("资费信息不能为空!");
			document.frm1239.rate_code_1.focus();
			return false;
		}
	
		for(var i=0;i<tempRadio.length;i++)
	    {
			if(tempRadio[i].checked)
		  　{
				var updatephone=eval("document.frm1239.update_newPhoneno"+tempRadio[i].value+".value");
				
				if(updatephone==""){rdShowMessageDialog("请输入新亲情号码");return;}
				var oldphone=eval("document.frm1239.newPhoneno"+tempRadio[i].value+".value");
		  		if (!isMadeOf(updatephone,"0123456789")){
	    			rdShowMessageDialog("新亲情号码的值不正确！请输入数字！");
	    			return false;
	    		}
				if(updatephone.substr(0,1)!="0" && updatephone.substr(0,2)!="13"&&updatephone.substr(0,2)!="15"&&updatephone.substr(0,2)!="18"&&updatephone.substr(0,2)!="14"&&updatephone.substr(0,2)!="17"){
					rdShowMessageDialog("您输入的亲情号码有误！<br>您可以输入13或15或14或18或17开头的手机号码和0开头的固话号码!!!");
					return false;
				}
				if((updatephone.length!=11)&&(updatephone.length!=12)&&(updatephone.length!=13)){
					rdShowMessageDialog("亲情号码只能是11、12或13位！");
					return false;
				}
				updatecount=updatecount+1;
				document.frm1239.updatestr.value=(document.frm1239.updatestr.value).trim()+(oldphone).trim()+"~"+(updatephone).trim()+"|";
				document.frm1239.oldstr.value=(document.frm1239.oldstr.value).trim()+(oldphone).trim()+"|";
				document.frm1239.newstr.value=(document.frm1239.newstr.value).trim()+(updatephone).trim()+"|";
				document.frm1239.updatestrprn.value=(document.frm1239.updatestrprn.value).trim()+"修改前"+(oldphone).trim()+"修改后"+(updatephone).trim()+"~";
				document.frm1239.updatestrall.value=(document.frm1239.updatestrall.value).trim()+(updatephone).trim()+"~";
			}else{
				if(document.frm1239.rate_code_1.value.substring(0,8)==eval("document.frm1239.rateCode"+tempRadio[i].value+".value").substring(0,eval("document.frm1239.rateCode"+tempRadio[i].value+".value").indexOf("("))){
					
					document.frm1239.updatestrall.value=(document.frm1239.updatestrall.value).trim()+(eval("document.frm1239.newPhoneno"+tempRadio[i].value+".value")).trim()+"~";
				}
			}
	    }
		  var vUpdateHandFee=document.frm1239.handfeeshow.value * updatecount;
		  document.frm1239.hand_fee.value=vUpdateHandFee;
		  //rdShowMessageDialog("本次亲情号码修改收取的 "+document.frm1239.hand_fee.value+" 元手续费将在预存款中扣除！");
		  document.frm1239.updatecount.value=updatecount;
	   
	}else{//alert(tempRadio.length);
	 for(var i=0;i<tempRadio.length;i++)
    {    	
    	//alert("document.frm1239.rate_code_1.value|"+document.frm1239.rate_code_1.value);
    	//alert(eval("document.frm1239.rateCode"+tempRadio[i].value+".value"));
    	
    	if(document.frm1239.rate_code_1.value.substring(0,8)==eval("document.frm1239.rateCode"+tempRadio[i].value+".value").substring(0,eval("document.frm1239.rateCode"+tempRadio[i].value+".value").indexOf("("))){
				    document.frm1239.updatestrall.value=(document.frm1239.updatestrall.value).trim()+(eval("document.frm1239.newPhoneno"+tempRadio[i].value+".value")).trim()+"~";
				    
				}
    }
}
  //判断亲情号码数量
  var phoneNum=new Array();                         //输入的亲情号码数组
  var phoneNo=document.frm1239.new_phoneno.value;   //输入的亲情号码串
  phoneNum=phoneNo.split("~");
  var kinCount=document.frm1239.kin_count.value;　
  var totalCount=parseInt(kinCount)+phoneNum.length;
  if(totalCount>9 && document.frm1239.op_type.value=="新增" && oOldMode=="0007p700"){
  	rdShowMessageDialog("您的亲情号码总数不能超过９个！");
  	return false;
  }	
  
  return true;
}
function showPrtdlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
	var h=210;
	var w=400;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;

     //var printStr = printInfo(printType);
     var pType="subprint";             
	   var billType="1";              
	   var sysAccept="<%=printAccept%>";              
	   var printStr = printInfo(printType); 
	   var mode_code=null;              
	   var fav_code=null;                 
	   var area_code=null;            
     var opCode="1239";                  
     var phoneNo=document.frm1239.mphone_no.value;                 


     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);

 
	 return ret;
}
var offerComment = "";
//删除亲情号码免填单
function printInfo123a(printType){
		var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  
	  	cust_info+="手机号码："+document.frm1239.mphone_no.value+"|";
      cust_info+="客户姓名：" +document.frm1239.cust_name.value+"|";
      
				
      opr_info+="用户品牌：<%=sm_name%>"+"  "+"办理业务：随意畅聊业务取消亲情号|";
      opr_info+="操作流水：<%=printAccept%>"+"  "+"业务操作时间：<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>|";
 			opr_info+="业务办理号码：<%=iPhoneNo%>"+"|";
 			
 			
 			$("tr[id^='list']").each(function(){
    	var b = $(this).find("input[type='checkbox']").attr("checked");
	    	if(b){
	    		var phoneNo = $(this).find("td:eq(1)").text().trim();
	    		opr_info+="取消亲情号码1："+phoneNo+"|";
	    	}
	    });
     
    opr_info+="指定资费："+$("#rate_code_1").find("option:selected").text()+"|";
    note_info3+="指定资费描述："+ajaxGetOffDet($("#rate_code_1").val())+"|";
    note_info4+="|";
		note_info4 += "注意事项：" + "|";
		note_info4 += "1、取消亲情号码次月失效。"+"|";     
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
 
}

//取亲情套餐的资费描述
function ajaxGetOffDet(offId){
	var getOffDetPacket = new AJAXPacket("ajax_getOffDet.jsp","请等待...");
		  getOffDetPacket.data.add("offId" ,offId);
		  core.ajax.sendPacket(getOffDetPacket,doAjaxGetOffDet);
		  chkPacket =null;
	return 	offerComment;	   
}
function doAjaxGetOffDet(packet){
	offerComment = packet.data.findValueByName("offerComment");
}
function printInfo(printType)
{
	//删除情况的免填单
	if("<%=opeTypeFlag%>"=="1"){
		return printInfo123a(printType);
	}
    /**对用户输入的手机号码（可能是多个）进行处理**/
    var tmpLoc="";
	  var tmpLen="";
    var phoneNo=document.frm1239.new_phoneno.value;
	  var tmpstr=phoneNo;
	  var j=phoneNo.length;
	  var w=Math.round(j/11);
	  var tmpstraft="";
	  for(i=0;i<w;i++){
      tmpLoc=tmpstr.indexOf("~");
      tmpLen=tmpstr.length;
      if(tmpLoc==-1){
      	tmpstraft=tmpstr;
      }
      else{
      	tmpstraft+=tmpstr.substring(0,tmpLoc-1)+",";
      }
	    tmpstr=tmpstr.substring(tmpLoc+1,tmpLen);
	    if(tmpLoc==-1) break;
	 	}


	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  	cust_info+="手机号码："+document.frm1239.mphone_no.value+"|";
      cust_info+="客户姓名：" +document.frm1239.cust_name.value+"|";
      cust_info+="证件号码："+"<%=idCard_no%>"+"|";
      cust_info+="客户地址："+"<%=addr%>"+"|";
      
      opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+"<%=sm_name%>"+ "|";
      opr_info+="办理业务：亲情号码－"+document.frm1239.op_type.value+"亲情号码"+"  操作流水："+"<%=printAccept%>"+"|";
      if("<%=opeTypeFlag%>"=="0"){
     	var offerids1 = document.frm1239.rate_code_1.value; 
		  if(offerids1=="36725" || offerids1=="36726" || offerids1=="36724")  {//资费代码是36725和36726的则增加免填单内容
      opr_info+=addbendiphone+"|";
      opr_info+=addshengneiphone+"|";
      }
      else {
      opr_info+="本次新增亲情号码："+document.frm1239.all_kinphone.value+"|";
      }
      opr_info+="生效时间："+document.frm1239.send_note.value+"|";
      
	  }else{
	  	
	  	//opr_info+="生效时间："+document.frm1239.send_note.value+"|";
	  	
      }
      if("<%=opeTypeFlag%>"=="0"){
      	opr_info+="本次业务办理生效后，用户该资费下的所有亲情号码为："+document.frm1239.updatestrall.value+document.frm1239.all_kinphone.value+"|";

      }else{
      	opr_info+="本次修改亲情号码："+document.frm1239.updatestrprn.value+"|";
      	opr_info+="本次业务办理生效后，用户该资费下的所有亲情号码为："+document.frm1239.updatestrall.value+"|";     	
	      var offerids1 = document.frm1239.rate_code_1.value; 
			  if(offerids1=="36725" || offerids1=="36726" || offerids1=="36724")  {//资费代码是36725和36726的则增加免填单内容
      	opr_info+=updatebendiphone+"|";
				opr_info+=updateshengneiphone+"|";
	      }
      }
      /* yanpx 20120504 客户测试要求去掉
      note_info1 +="亲情号码资费描述："+document.frm1239.mode_note.value+"|";
      */
	  note_info3+="备注："+document.all.note.value+"|";
      document.all.cust_info.value=cust_info+"#";
	  document.all.opr_info.value=opr_info+"#";
	  document.all.note_info1.value=note_info1+"#";
	  document.all.note_info2.value=note_info2+"#";
	  document.all.note_info3.value=note_info3+"#";
	  document.all.note_info4.value=note_info4+"#";
	  
	 		var offerids3 = document.frm1239.rate_code_1.value; 	
			if(offerids3=="37075" || offerids3=="37076") {
			note_info4 += "注意事项：" + "|";
			note_info4 += "1、资费月功能费整月收取。"+"|";
			note_info4 += "2、此资费与智能VPMN网互斥，不能同时办理，用户办理时进行提示。"+"|";
			note_info4 += "3、资费有效期为12个月，到期后自动取消。"+"|";
			note_info4 += "4、客户在有效期内每月允许修改一次亲情号。"+"|";
			}
	  //retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}


function replaceSpacialCharacter(source)
{
	source = source.replace("#","%23");
	source = source.replace("&","%26");
	source = source.replace("+","%2b");
	source = source.replace("?","%3f");
	source = source.replace("_","%5f");
	source = source.replace('"',"%22");
	source = source.replace("'","%27");
	return source;
}


function change_mode()
{
	document.frm1239.hand_fee.value     = "待定";
	document.frm1239.limit_number.value = "待定";
	//alert("mode_code="+document.all.rate_code_1.options[document.all.rate_code_1.options.selectedIndex].value);
	for(var fi = 0; fi < vRateCodeStr.length; fi++ )
	{
		for(var se=0; se < vRateCodeStr[fi].length; se++ )
		{
			if (vRateCodeStr[0][se] == document.all.rate_code_1.options[document.all.rate_code_1.options.selectedIndex].value)
			{
				//alert("vRateCodeStr["+fi+"]["+se+"]="+vRateCodeStr[fi][se]);
				document.frm1239.limit_number.value = vRateCodeStr[3][se];
				document.frm1239.mode_note.value = vRateCodeStr[4][se];
				document.frm1239.mode_note.value = replaceSpacialCharacter(document.frm1239.mode_note.value);
				if(document.frm1239.op_type.value=="修改")
					document.frm1239.hand_fee.value = vRateCodeStr[2][se];
				else
					document.frm1239.hand_fee.value = "0.00";
			}
		}
	}
	document.frm1239.handfeeshow.value=document.frm1239.hand_fee.value;
}
//分解字符串
function oneTokSelf(str,tok,loc)
  {
  var temStr=str;
	var temLoc;
	var temLen;
    for(ii=0;ii<loc-1;ii++)
	{
       temLen=temStr.length;
       temLoc=temStr.indexOf(tok);
       temStr=temStr.substring(temLoc+1,temLen);
 	}
	if(temStr.indexOf(tok)==-1){
	  return temStr;
	}else{
      return temStr.substring(0,temStr.indexOf(tok));
      }
  }	
 



/**由套餐资费代码动态得到生效标志**/
function getSendFlag(){
	
	//add by wanglm 2010-8-26 让让按钮显示或者隐藏
   var code = $("#rate_code_1 option:selected").text();
   var codeText = code.substring(code.lastIndexOf("-")+1);
   if(codeText == "1元动感亲情号码" || codeText == "3元动感地带亲情号码" ){
   	//删除时按钮可用
   	if("<%=opeTypeFlag%>"!="1"){
    	document.getElementById("print").disabled=true;
  	}
   	document.getElementById("jy").style.display="block";
   }else{
   	 document.getElementById("jy").style.display="none";
   	  document.getElementById("print").disabled=false;
   	}
   	
   	 	if(<%=opeTypeFlag%> == "2" ){
   	 		if(codeText == "1元动感亲情号码" || codeText == "3元动感地带亲情号码" ){
   	 			showTD();
         	}else{
         		yinTD();
   	     }
   	 }
  if("<%=opeTypeFlag%>"=="1"&&$("#rate_code_1").val()!=""){//删除时也隐藏列表先
		$("tr[id^='list']").show();
	}else{
		$("tr[id^='list']").hide();
	}
   	 
  var tempStr = document.frm1239.rate_code_1.value;
  var rateCode = oneTokSelf(tempStr,"~",1);//新资费号码
  var addCode =  oneTokSelf(tempStr,"~",2);//用于判断生效标志   
  var sendFlag = "";//生效标志  
  var sendNote = "";//生效标志  
  change_mode();
  sendNote = "当日";//生效标志
  document.all.send_flag.value = sendFlag;
  document.frm1239.send_note.value = sendNote;
  document.frm1239.rate_code.value = rateCode;
	if("<%=opeTypeFlag%>"=="2"){
<% 
  		String kinratecode="";
  		if(tmpresult1.length==1){
			if(tmpresult2[0][0].trim().length()>8){
				if(tmpresult2[j][0].trim().indexOf("(")!=-1){
		  				kinratecode=tmpresult2[j][0].trim().substring(0,tmpresult2[j][0].trim().indexOf("(")).trim();
		  			}
				System.out.println("kinratecode="+kinratecode);
			}else {
				kinratecode=" ";
			}%>
			if (document.frm1239.rate_code_1.value.substring(0,8)=="<%=kinratecode%>"){
				document.all.list0.style.display="";
				document.all.radio1.checked=false;
			}else{
				document.all.list0.style.display="none";
				document.all.radio1.checked=false;
			}
<%
	  	}else{
	  		for(j=0;j<tmpresult1.length;j++){
		  		System.out.println("tmpresult1.length="+tmpresult1.length);
		  		System.out.println("tmpresult2[j][0].trim().length()="+tmpresult2[j][0].trim().length());
		  		if(tmpresult2[j][0].trim().length()>8){
		  		
		  			if(tmpresult2[j][0].trim().indexOf("(")!=-1){
		  				kinratecode=tmpresult2[j][0].trim().substring(0,tmpresult2[j][0].trim().indexOf("(")).trim();
		  			}
		  			System.out.println("kinratecode="+kinratecode);
		  		}else{
					kinratecode=" ";
				}
%>
				if (document.frm1239.rate_code_1.value.substring(0,8)=="<%=kinratecode%>"){
					document.all.list<%=j%>.style.display="";
					document.all.radio1[<%=j%>].checked=false;
				}else{
					document.all.list<%=j%>.style.display="none";
					document.all.radio1[<%=j%>].checked=false;
				}
<%
	 		}
	 	}
%>
	}
  
  return true;
}
function doProcess(packet)
  {
  	 var errCode = packet.data.findValueByName("errCode");
     var retMsg = packet.data.findValueByName("errMsg");
     if(errCode.equals("0")||errCode.equals("000000")){
     		document.all.difftime.value=packet.data.findValueByName("difftime");
     		document.all.begintime.value=packet.data.findValueByName("begintime");;
    }else{
    		rdShowMessageDialog("错误:"+ errCode + "->" + retMsg);
				return;
    }
  }
/*********修改时，动态改变新亲情号码输入域的可用性************/
function setUpdateNewPhoneNo(index){
    var objStr = "#rad" + index;
    var codeText = $("#rate_code_1>option:selected").text();
    if(codeText.indexOf("亲情畅聊") != -1){
	    var checkBoxObj = $(":checkbox[name='radio1']");
	    checkBoxObj.attr("checked",false);
	    $(objStr).attr("checked",true);
		return true;
	}
}
/******为备注赋值********/
function setOpNote(){
	  <%if(opeType.equals("新增")){%>
	      document.frm1239.note.value = "亲情号码"+"<%=opeType%>"+";号码:"+document.frm1239.new_phoneno.value;
	  <%}else if(opeType.equals("修改")){%>
	      document.frm1239.note.value = "亲情号码"+"<%=opeType%>";
	  <%}else if(opeType.equals("删除")){%>
	      document.frm1239.note.value = "<%=workNo%>为<%=cust_name%>做亲情号码取消";
	  <%}%>
	return true;
}
$(document).ready(function(){
	if("<%=opeTypeFlag%>"=="1"){//删除时也隐藏列表先
		$("tr[id^='list']").hide();
	}
});
/*2013/07/04 17:11:24 gaopeng 增加自适应长度*/
function autoSize(ojbId,defaultSize)
{
		var size = $("#"+ojbId).attr("size");
		var inputVal = $("#"+ojbId).val();
		var inputLength = inputVal.length;
		/*如果输入的长度大于目前的长度*/
		if(inputLength > defaultSize)
		{
			$("#"+ojbId).attr("size",inputLength+5)
		}
		else
		{
			$("#"+ojbId).attr("size",defaultSize)
		}
		
}
</SCRIPT>

<body >
<FORM method="post" name="frm1239" action="../../npage/bill/f1239_2.jsp">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">用户信息</div>
	</div>
  <table cellspacing="0" >
    <tr>
      <td class="blue">操作类型</td>
		  <td colspan="3">
		     <input name="op_type" value="<%=opeType%>" readonly Class="InputGrey"/>
		  </td>
		</tr>
		<tr>
		  <td class="blue">亲情主卡</td>
      <td>
          <input name="mphone_no" id="mphone_no" v_must=1  value="<%=iPhoneNo%>" readonly Class="InputGrey"/>
      </td>
      <td class="blue"> 客户名称</td >
		  <td >
		     <input name="cust_name"  v_must=1  value="<%=cust_name%>" readonly Class="InputGrey"/>
		  </td>
		</tr>
		<tr>
      <td class="blue"> 证件类型</td>
		  <td >
		     <input name="idCard_type"  v_must=1   value="<%=idCard_type%>" readonly Class="InputGrey"/>
		  </td>
		  <td class="blue"> 证件号码</td>
      <td>
         <input name="idCard_no"  v_must=1   value="<%=idCard_no%>" readonly Class="InputGrey"/>
      </td>
		</tr>
		<tr>
      <td class="blue"> 总欠费</td>
		  <td>
		     <input name="lack_fee"  v_must=1  value="<%=lack_fee%>" readonly Class="InputGrey"/>
		  </td>
		  <td class="blue"> 总预存</td>
      <td>
         <input name="prepay_fee"  v_must=1  value="<%=prepay_fee%>" readonly Class="InputGrey"/>
      </td>
		</tr>
		<tr>
       <td class="blue"> 大客户标志 </td>
		  <td>
		     <input name="grpbig_flag"  v_must=1  value="<%=grpbig_flag+"--"+grpbig_name%>"  readonly Class="InputGrey"/>
		  </td>
		  <td class="blue">业务品牌</td>
      <td>
         <input name="sm_name"  v_must=1   value="<%=sm_name%>" readonly Class="InputGrey"/>
      </td>
		</tr>
		<tr>
		  <td class="blue"> 当前主套餐 </td>
      <td>
         <input name="oOldMode"  size="30" value="<%=oOldMode+"--"+oOldModeName%>"  readonly Class="InputGrey"/>
      </td>
      <td class="blue"> 下月主套餐 </td >
		  <td >
		     <input name="oNextMode"  size="30" value="<%=oNextMode+"--"+oNextModeName%>" readonly Class="InputGrey"/>
		  </td>
		</tr>
		<tr>
		  <td class="blue" style=<%=trOneView%>> 亲情套餐代码</td>
      <td style=<%=trOneView%> >
		     <select  name="rate_code_1" id="rate_code_1" onChange="getSendFlag();">
			    	<option value="">--请选择--</option>
                <%for(int i = 0 ; i < rateCodeStr.length ; i ++){
                	if(i==0){%>
                			<option value="<%=rateCodeStr[i][0]%>"><%=rateCodeStr[i][1]%></option>
                	<%}
                  if(i>0){
                  	if(rateCodeStr[i][1].equals(rateCodeStr[i-1][1])){
                  
                	}else{
                  	%>
                			<option value="<%=rateCodeStr[i][0]%>"><%=rateCodeStr[i][1]%></option>                			

                	<%}
                  }
                }%>
             </select>
             <font class="orange">*</font>
          </td>
			 
			<%
			if(!"".equals(g493ShowFlag)){
			%>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<%
			}
			%>	
		  <td class="blue" style="<%=g493ShowFlag%>">手续费单价</td>
      <td colspan=<%=cSpan%> style="<%=g493ShowFlag%>">
       <input name="handfeeshow"  v_type="money" maxlength=12 type="text" v_must=1  maxlength="12" value="待定" <%=handFee_Favourable%> Class="InputGrey"/>
       <font class="orange">(元/个)</font>
      </td>
		</tr>
		<tr style="<%=g493ShowFlag%>">
		  <td class="blue" nowrap> 可申请亲情号码个数</td>
	    <td colspan=<%=cSpan%>>
	     <input name="limit_number"  v_type="" maxlength=2 type="text"   maxlength="12" value="待定" readonly Class="InputGrey">
	    </td>
		  <td class="blue"> 手续费总额</td>
      <td colspan=<%=cSpan%>>
       <input name="hand_fee"  v_type="money" maxlength=12 type="text" v_must=1  maxlength="12" value="待定" <%=handFee_Favourable%> Class="InputGrey">
       <font class="orange">(元)</font>
      </td>
		</tr>
		<tr style="<%=trOneViewa%>">
      		<td class="blue"> 新亲情号码 </td >
		  	<td colspan="3">
		     	<!--<input name="new_phoneno"  type="text" id="new_phoneno" v_must=1 v_type=""  v_minlength=11 maxlength="160"/>-->
		    <jsp:include page="/npage/common/text_1.jsp">
	      <jsp:param name="width1" value="300px"  />
	      <jsp:param name="width2" value="34%"  />
	      <jsp:param name="size1" value="20"  />
	      <jsp:param name="pname" value="new_phoneno"  />
	      <jsp:param name="btnName" value="继续输入"  />
        </jsp:include>
         		<font class="orange">*</font>
         		<input type="button" name="jy" id="jy" class="b_text" value="校验" onclick="doJudge()"/>
         		<font class="orange">
         				<br/>
         			（营业员如同时增加多个号码，号码间用~分隔，如13912345678~13923456789~13934567890）
         				<br />
         			（用户使用密码小键盘如同时增加多个号码，号码间用确认键分隔，如13912345678（确认）13923456789（确认）13934567890）
         			</font>
		  	</td>
      
		</tr>
		<tr>
      <td class="blue"> 备注 </td >
		  <td colspan="3">
		     <input  name="note" size=60 maxlength="60" value="" onFocus="if(checkOne()) setOpNote();" readonly/>
		  </td>
		  
		</tr>
  </table>
  <table cellspacing="0">
    <tr>
      <td align=center>
        <input class="b_foot" name="print" id="print" onClick="printCommit()"  type=button  value="确认&打印" />
        <input class="b_foot" name=reset1 type=button onClick="frm1239.reset();" value="清除" />
        <input class="b_foot" name=close  onClick="parent.removeTab('<%=op_code%>');" type=button value="关闭" />
        <input class="b_foot" name=back   onClick="history.go(-1);" type="button" value="返回"/>			  
      </td>
    </tr>
  </table>
</div>
<div id="Operation_Table"> 
	
	<div class="title">
		<div id="title_zi">亲情号码</div>
	</div>  
  <table cellspacing="0">
		<tr align="middle" >
				<th align=center style="<%=radioView%>">选择</th>
				<th align=center >亲情号码</th>
				<th align=center >亲情号码资费</th>
				<th align=center >操作工号</td>
				<th align=center >亲情号码生效时间</th>
				<th align=center style="<%=updateNewPhonenoView%>">新亲情号码</th>
				<th align=center style="<%=jyButton%>"  >校验</th>
		</tr>
				<%
				  String total_phone="";
				  String tbclass="";

				  for(j=0;j<tmpresult1.length;j++){
				  	if(j%2==0){
				  		tbclass="Grey";
				  	}else{
				  		tbclass="";	
				  	}
				  	
					  total_phone = total_phone + tmpresult1[j][0].trim()+",";
					  
				%>
				<tr id='list<%=j%>'>
				  <td align=center style="<%=radioView%>" class="<%=tbclass%>">
				  	<input type="checkbox"  name="radio1" id="rad<%=j%>" value="<%=j%>"
				  		 <%if(opeTypeFlag.equals("2")){%> onClick="setUpdateNewPhoneNo('<%=j%>')" <%}%> >
				  </td>
				  <td align=center class="<%=tbclass%>"><%=tmpresult1[j][0]%></td>
				  <td align=center class="<%=tbclass%>"><%=tmpresult2[j][0]%></td>
				  <td align=center class="<%=tbclass%>"><%=tmpresult3[j][0]%></td>
				  <td align=center class="<%=tbclass%>"><%=tmpresult4[j][0]%></td>
				  <td align=center style="<%=updateNewPhonenoView%>" class="<%=tbclass%>">
            <!-- <input name="update_newPhoneno<%=j%>"  type="text" id="update_newPhoneno<%=j%>"  maxlength="13"   > -->
			        <input name="update_newPhoneno<%=j%>" id="update_newPhoneno<%=j%>" type="text" maxlength="13" />
							<input class="b_text" onclick="showTextDialog(document.all.update_newPhoneno<%=j%>);" type=button  value="输入">

				  </td>
                        <td align=center style="<%=jyButton%>" class="<%=tbclass%>"  >
                        	<input type="button" name="jyth" style="display:none" value="校验" class="b_text" onclick="doJudge(<%=j%>)" />
				  	     </td>
      
				  <input name="newPhoneno<%=j%>" type="hidden" value="<%=tmpresult1[j][0]%>">
				  <input name="rateCode<%=j%>" type="hidden" value="<%=tmpresult2[j][0]%>">
				</tr>
				<%}%>
        </table>
<br>


  <input type="hidden" name="unitCode" value="<%=Department%>">
  <input type="hidden" name="workno" value="<%=workNo%>">
  <input type="hidden" name="workName" value="<%=workName%>">
  <input type="hidden" name="opCode" value="<%=opCode%>">
  <input type="hidden" name="belongCode" value="<%=belongCode%>">
  <input type="hidden" name="ipAddr" value="<%=ip_Addr%>">	
  <input type="hidden" name="opeTypeFlag" value="<%=opeTypeFlag%>">
  <input type="hidden" name="kin_count" value="<%=kin_count%>">
  <input name="vFavourCode" type="hidden" value="<%=vFavourCode%>">
  <input name="total_phone" type="hidden" value="<%=total_phone%>">
  <input name="all_kinphone" type="hidden" value="">
  <input name="send_flag" type="hidden" value="">
  <input name="send_note" type="hidden" value="">
  <input name="newPhoneno" type="hidden" value="">
  <input name="rateCode" type="hidden" value="">
  <input name="rate_code" type="hidden" value="">
  <input name="difftime" type="hidden" value="">
  <input name="begintime" type="hidden" value="">
  <input name="updatestr" type="hidden" value="">
  <input name="updatestrprn" type="hidden" value="">
  <input name="updatestrall" id="updatestrall" type="hidden" value="">
  <input name="update_newPhoneno" type="hidden" value="">
  <input name="updatecount" type="hidden" value="">
  <input name="oldstr" type="hidden" value="">
  <input name="newstr" type="hidden" value="">
  <input type="hidden" name="cust_info">
  <input type="hidden" name="opr_info">
  <input type="hidden" name="note_info1">
  <input type="hidden" name="note_info2">
  <input type="hidden" name="note_info3">
  <input type="hidden" name="note_info4">
  <input type="hidden" name="printcount">
  <input type="hidden" name="mode_note">
  <input type="hidden" name="flag" id="flag" />
  <input name="printAccept" type="hidden" value="<%=printAccept%>">
  <input type="hidden" name="cenPhoneList" id="cenPhoneList" />
  <%@ include file="/npage/include/footer.jsp" %> 
</form>
<script>
	$().ready(function(){
	    $("#flag").val("true");	
	});
     function yinTD(){
		var tharr =  document.getElementsByName("jyth");
	     for(var j=0;j<tharr.length;j++){
	     	tharr[j].style.display="none";
	     }
	}
	
	function showTD(){
		var tharr =  document.getElementsByName("jyth");
	     for(var i=0;i<tharr.length;i++){
	     	tharr[i].style.display="block";
	     }
	}
	getSendFlag();
	//add by wanglm 2010-8-24 
	function doJudge(j){
		   var new_ph = "";
		   if(<%=opeTypeFlag%> == "2"){
		   	   var newP = 'update_newPhoneno'+j;
		       new_ph = $("#"+newP+"").val();//或得输入的 手机号码(修改时)
		   	}else{
		   	   new_ph = $("#new_phoneno").val();	//或得输入的 手机号码(增加时)
		   	}
		   if(doJudgePhone()){
		  
	     var chkPacket = new AJAXPacket("ajax_judge.jsp","请等待。。。。");
		   chkPacket.data.add("iPhoneNo" , "<%=iPhoneNo%>");	
		   chkPacket.data.add("new_phoneno" , new_ph);
		   chkPacket.data.add("flag" , j);
		   core.ajax.sendPacket(chkPacket,doPD);
		   chkPacket =null; 
		}
	}
	function doPD(packet){
		var retStr = packet.data.findValueByName("ret");
		var j = packet.data.findValueByName("flag");
	  	var atr = packet.data.findValueByName("atr");
	  	var untilName = packet.data.findValueByName("untilName");
	  	var untilId = packet.data.findValueByName("untilId");
	  	if(retStr){
	  		rdShowMessageDialog(retStr+"没有此号码信息！");
	  		document.getElementById("print").disabled=true;
	  		if(<%=opeTypeFlag%> == "2"){
	  		   var ra = 'rad'+j;
	  		   document.getElementById(ra).checked=null;
	  		}
	  		$("#flag").val("false");
	  	}
	  	else if(atr){
	  		rdShowMessageDialog("主号码："+$("#mphone_no").val()+"与 "+atr+" 为同一V网号码，不能办理亲情号！errorMsg 集团编码："+untilId+" 集团名称："+untilName);
	  		document.getElementById("print").disabled=true;
	  		if(<%=opeTypeFlag%> == "2"){
	  		   var ra = 'rad'+j;
	  		   document.getElementById(ra).checked=null;
	  		}
	  		$("#flag").val("false");
	  	}else{
	  		//wanghyd--增加校验
	  	 var chkPacket = new AJAXPacket("ajax_checkPhones.jsp","请等待。。。。");
		   chkPacket.data.add("opeTypeFlag" ,document.frm1239.opeTypeFlag.value);	
		   chkPacket.data.add("send_flag" , document.all.send_flag.value);
		   chkPacket.data.add("mphone_no" , $("#mphone_no").val());
		   if(<%=opeTypeFlag%> == "0"){
		   chkPacket.data.add("new_phoneno" , $("#new_phoneno").val());  
		   }	   
		   chkPacket.data.add("rate_code_1" , document.frm1239.rate_code_1.value); 	
		   if(<%=opeTypeFlag%> == "2"){	   
		   chkPacket.data.add("newPhoneno" , document.frm1239.newPhoneno.value); 
		   chkPacket.data.add("update_newPhoneno" , document.frm1239.update_newPhoneno.value); 
		   }
		   chkPacket.data.add("hand_fee" , document.frm1239.hand_fee.value);
		   chkPacket.data.add("vFavourCode" , document.frm1239.vFavourCode.value);
		   chkPacket.data.add("note" , document.all.note.value);
		   chkPacket.data.add("workno" , document.frm1239.workno.value);
		   chkPacket.data.add("workName" , document.frm1239.workName.value);
		   chkPacket.data.add("unitCode" , document.frm1239.unitCode.value);
		   chkPacket.data.add("opCode" , document.frm1239.opCode.value);
		   chkPacket.data.add("ipAddr" , document.frm1239.ipAddr.value);
		   chkPacket.data.add("printAccept" , document.frm1239.printAccept.value);
		   chkPacket.data.add("kin_count" , document.frm1239.kin_count.value);
		   chkPacket.data.add("updatecount" , document.frm1239.updatecount.value);
		   chkPacket.data.add("oldstr" , document.frm1239.oldstr.value);
		   chkPacket.data.add("newstr" , document.frm1239.newstr.value);
		   chkPacket.data.add("cust_name" , document.frm1239.cust_name.value);
		   core.ajax.sendPacket(chkPacket,checkPhones);
		   chkPacket =null; 
		   
		   

	  	}
	}
		function checkPhones(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
			if(retcode=="000000") {
				rdShowMessageDialog("恭喜您，校验通过！");
	  		document.getElementById("print").disabled=false;
	  		var new_p = $("#new_phoneno").val();
	  		document.getElementById("new_phoneno").readonly=true;
	  		$("#flag").val("true");
			}
			else {
				rdShowMessageDialog("验证不通过:"+ retcode + "->" + retmsg);
			}
	  }
	 
	//13936438096   13804537470
	
</script>
</body>

</html>
