<%
/********************
 version v2.0
开发商: si-tech
update:zhaohaitao@2009-1-7
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
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
	String ipAddrss = (String)session.getAttribute("ipAddr");
  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
%>

<%
	/**在下面赋值**/
	String opCode = "";
	String opName = "";
		
    String retFlag="",retMsg="";//存放是否校验失败的标志、信息
  /****************由移动号码得到密码、机主姓名、亲情号码申请情况等信息 s1239Init***********************/

	String iPhoneNo=request.getParameter("mphone_no");//手机号码
	String iLoginNo=workNo;	  //操作工号
	String iOrgCode=Department; //机构编码
	String opeType=request.getParameter("opFlag");//操作类型
	String serviceName = "s1239Init";
	String opeTypeFlag="";
	String outParaNums= "30";
	String radioView = "";
	String trOneView = "";
	String trOneViewa = "";
	String updateNewPhonenoView = "";
	String cSpan="";
	String op_code="1239";
	if(opeType.equals("新增"))
	{
	  opeTypeFlag="0";
	  opCode = "7127";
	  opName = "家庭服务计划亲情号码申请";
	  radioView = "display:none";//单选按钮的可见性
	  trOneView = "";//行的可见性
	  trOneViewa = "";
	  updateNewPhonenoView = "display:none";//修改亲情号码的可见性
	  cSpan="1";//控制手续费一行表格的显示

	}else if(opeType.equals("修改")){
	  opeTypeFlag="2";
	  opCode = "7128";
	  opName = "家庭服务计划亲情号码变更";
	  radioView = "";
	  trOneView = "";
	  trOneViewa = "display:none";
	  updateNewPhonenoView = "";
	  cSpan="1";
	}
	else if(opeType.equals("取消")){
	  opeTypeFlag="3";
	  opCode = "g581";
	  opName = "家庭服务计划亲情号码取消";
	  radioView = "";
	  trOneView = "";
	  trOneViewa = "display:none";
	  updateNewPhonenoView = "display:none";
	  cSpan="1";
	}

	String user_passwd = "",cust_name = "",sm_name = "",oOldMode = "",oOldModeName = "",grpbig_flag = "",grpbig_name = "",oNextMode = "",oNextModeName = "",vHandFee = "",vFavourCode = "",kin_count="",lack_fee="",prepay_fee="",idCard_type="",idCard_no="",print_note="",cust_id="";
	%>
	<wtc:service  name="<%=serviceName%>" routerKey="phone" routerValue="<%=iPhoneNo%>" outnum="<%=outParaNums%>"  retcode="errCode" retmsg="errMsg">
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
 	<wtc:array id="tmpresult6"  start="29"  length="1" scope="end"></wtc:array>
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
	 /**
	 for(int i=0;i<list.length;i++){
	 	for(int m=0;m<list[i].length;m++){
	 		System.out.println("##################list["+i+"]["+m+"]--->"+list[i][m]);
	 	}
	 }*/
	 
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
		if(opeTypeFlag.equals("1")||opeTypeFlag.equals("2")||opeTypeFlag.equals("3")){
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

  String sqlRateCode1 = "";
  String addr="";
  String sqlRateCode = "";
  String vLimitNum="";
  String printAccept="";
  String[][] rateCodeStr= new String[][]{};
  String groupId =(String)session.getAttribute("groupId");
  
  if(errCode.equals("0")||errCode.equals("000000"))
  {
    /*************************得到用户地址********************/
    sqlRateCode1 = " select nvl(cust_address,'无') from dcustdoc a,dcustmsg b where b.phone_no='"+iPhoneNo+"' and a.cust_id=b.cust_id ";
    
    String[] paramIn = new String[2]; 
    paramIn[0] = " select nvl(cust_address,'无') from dcustdoc a,dcustmsg b where b.phone_no=:iPhoneNo and a.cust_id=b.cust_id ";
    paramIn[1] = "iPhoneNo="+iPhoneNo;
    
     String beizhussdese="根据phoneNo=["+iPhoneNo+"]进行查询";
%>  
   <wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=regionCode%>" retmsg="msg1" retcode="code1">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param  value="<%=iLoginNo%>"/>
			<wtc:param  value="<%=op_strong_pwd%>"/>
			<wtc:param  value="<%=iPhoneNo%>"/>
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
</wtc:service>
<wtc:array id="arr1" scope="end"/>
<%
    System.out.println("mylog  sqlRateCode111==="+sqlRateCode1);
   
   
    /******************得到下拉框数据***************************/
	//sqlRateCode = "select a.mode_code,a.mode_code|| '--' ||trim(a.mode_name),a.hand_fee,a.limit_number,nvl(c.mode_note, '@@@@') from sRelationCfg a,dBillCustDetail b,sBillModeDes c where b.id_no="+ cust_id +" and b.mode_code like 'fj@@jt%' and b.mode_time='Y' and b.end_time>sysdate  and b.region_code=a.region_code  and b.mode_code=a.mode_code and a.region_code=c.region_code(+)  and a.mode_code=c.mode_code(+) order by a.mode_code" ;
	
	//sqlRateCode = "select e.offer_id, e.offer_id_name, f.hand_fee, e.limit_number, f.offer_comments  from ( select a.member_id, b.serv_id, c.offer_id as offer_id, c.offer_id|| '--' ||trim(c.offer_name) as offer_id_name, d.offer_attr_value as limit_number, nvl(c.offer_comments, '@@@@') as offer_comments    from group_instance_member a, product_offer_instance b, product_offer c, product_offer_attr d   where a.group_id = b.group_id    and b.exp_date > sysdate     and b.offer_id = c.offer_id    and c.offer_id = d.offer_id    and substr(c.offer_code, 3, 8) like 'fj@@jt%'     and d.offer_attr_seq = '20001'    and b.serv_id = "+cust_id+") e,(select a.member_id, b.serv_id,  c.offer_id as offer_id, c.offer_id|| '--' ||trim(c.offer_name) as offer_id_name, d.offer_attr_value as hand_fee, nvl(c.offer_comments, '@@@@') as offer_comments   from group_instance_member a, product_offer_instance b, product_offer c, product_offer_attr d  where a.group_id = b.group_id    and b.exp_date > sysdate     and b.offer_id = c.offer_id    and c.offer_id = d.offer_id    and substr(c.offer_code, 3, 8) like 'fj@@jt%'     and d.offer_attr_seq = '20003'    and b.serv_id = "+cust_id+") f where e.serv_id = f.serv_id   and e.offer_id = f.offer_id";
	/* 
	 sqlRateCode="SELECT d.offer_id, d.offer_id_name, d.hand_fee, e.limit_number, d.offer_comments"
							+" FROM (SELECT a.serv_id, b.offer_id, b.offer_id|| '--' ||trim(b.offer_name) AS offer_id_name, c.offer_attr_value AS hand_fee, NVL(b.offer_comments, '@@@@') AS offer_comments"
							+" FROM product_offer_instance a, product_offer b, product_offer_attr c"
							+" WHERE a.offer_id = b.offer_id"
							+" AND b.offer_id = c.offer_id "
							+" and b.group_type_id = 4 "  
							+" and b.offer_code <> '01fj@@Gxxq'"       
							+" AND c.offer_attr_seq = '20001' "
							+" AND a.serv_id ="+cust_id+") d,"
							+" (SELECT a.serv_id, b.offer_id, b.offer_id|| '--' ||trim(b.offer_name), c.offer_attr_value AS limit_number, NVL(b.offer_comments, '@@@@')"
							+" FROM product_offer_instance a, product_offer b, product_offer_attr c"
							+" WHERE a.offer_id = b.offer_id"
							+" AND b.offer_id = c.offer_id"
						  +" and b.group_type_id = 4 "  
							+" and b.offer_code <> '01fj@@Gxxq'"
							+" AND c.offer_attr_seq = '20003'"
							+" AND a.serv_id = "+cust_id+" ) e"
							+" WHERE d.serv_id = e.serv_id";
		*/					
	 sqlRateCode=	"select b.offer_id,b.offer_id || '--' || trim(b.offer_name) as offer_id_name,c.offer_attr_value as hand_fee,d.offer_attr_value as limit_number,NVL(b.offer_comments, '@@@@') AS offer_comments" 
								+" from product_offer_relation a,product_offer  b,product_offer_attr c, product_offer_attr  d "
								+" where c.offer_attr_seq = '20001' and d.offer_attr_seq = '20003'    "
								+" and b.offer_id = c.offer_id          "
								+" and b.offer_id = d.offer_id    "
								+" and a.offer_z_id = b.offer_id    "
								+" and relation_type_id = 3    "
								+" and offer_a_id in ("
								+" select t1.offer_id   from product_offer_instance t1, product_offer t2  "
								+" where t2.group_type_id in (10)                      "    
								+" and t1.offer_id = t2.offer_id                        "  
								+" AND t1.exp_date > sysdate                          "
								+" and t1.serv_id = "+cust_id+""
								+" ) ";
	System.out.println("mylog  ---  sqlRateCode="+sqlRateCode);

	%> 
	
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="code2" retmsg="msg2" outnum="5">
		<wtc:sql><%=sqlRateCode%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="arr" scope="end" />

	<%
		if(arr1.length>0)
		addr = arr1[0][11];
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


<HEAD>
	<TITLE>> <%=opName%> </TITLE>
</HEAD>

<SCRIPT type=text/javascript>
	var oOldMode="<%=oOldMode%>";
  <%if(retFlag.equals("1")){%>
	  rdShowMessageDialog("<%=retMsg%>");
  	window.location="f7124.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
  <%}%>

 //***
  function frmCfm(){
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
	    if(phoneNum[i].substr(0,1)!="0" && phoneNum[i].substr(0,2)!="13"&&phoneNum[i].substr(0,2)!="15"&&phoneNum[i].substr(0,2)!="18"&&phoneNum[i].substr(0,2)!="14"){
	      rdShowMessageDialog("您输入的亲情号码有误！<br>您可以输入13或15或14或18开头的手机号码和0开头的固话号码!!!");
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
  else if(document.frm1239.op_type.value=="取消"){
    var tempRadio = document.getElementsByName("radio1");
    var flag = "0";
    for(var i=0; i<tempRadio.length; i++)
    {
    if(tempRadio[i].checked)
	  {
	    flag = "1";
	  }
    }
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
          			tempInput.v_type="mobphone2";
		         	if(!eval("checkElement('"+"update_newPhoneno"+i+"')"))
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
				if(up_newPhoneno.substr(0,1)!="0" && up_newPhoneno.substr(0,2)!="13"&&up_newPhoneno.substr(0,2)!="15"&&up_newPhoneno.substr(0,2)!="18"&&up_newPhoneno.substr(0,2)!="14"){
					rdShowMessageDialog("您输入的亲情号码有误！<br>您可以输入13或15开头的手机号码和0开头的固话号码！");
					return false;
				}
			}
			else{
				if(up_newPhoneno.length==0){
					rdShowMessageDialog("修改的新亲情号码必须填写!");
					return false;
				}
				if(up_newPhoneno.substr(0,1)!="0" && up_newPhoneno.substr(0,2)!="13"&&up_newPhoneno.substr(0,2)!="15"&&up_newPhoneno.substr(0,2)!="18"&&up_newPhoneno.substr(0,2)!="14"){
					rdShowMessageDialog("您输入的亲情号码有误！<br>您可以输入13或15开头的手机号码和0开头的固话号码！");
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

/*diling add for 如果“新增亲情号码”中有用户办理了集团V网业务，请提示！@2012/6/19 */
function vMemberCheck(){
  var mainPhoneNo = document.frm1239.mphone_no.value;
  var newPhoneNos = document.frm1239.new_phoneno.value; //输入的亲情号码串
  var myPacket = new AJAXPacket("f7127_ajax_vMemberCheck.jsp","正在获取信息，请稍候......");
  myPacket.data.add("mainPhoneNo",mainPhoneNo);
  myPacket.data.add("newPhoneNos",newPhoneNos);
  myPacket.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacket(myPacket,dovMemberCheck);
  myPacket=null; 
}

function dovMemberCheck(packet){
  var retCode = packet.data.findValueByName("retcode");
  var retMsg = packet.data.findValueByName("retmsg");
  var vMemberCount = packet.data.findValueByName("vMemberCount");
  var vMemberPhoneNos = packet.data.findValueByName("vMemberPhoneNos");
  if(retCode!="000000"){
       rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
       goBack();
  }else{
    if(vMemberCount>0){
      rdShowMessageDialog("新增亲情号码中，"+vMemberPhoneNos+"用户是集团V网用户！",1);
    }
  }
}
/*end diling add*/

function printCommit()
{
	getAfterPrompt();
	//验证
	if(!checkOne()) return false;
	/*gaopeng 2013/4/2 星期二 14:33:50 判断如果不是取消，调用原有方法，因为取消不加入新增的亲情号码*/
	if("<%=opeTypeFlag%>"!="3"){
	vMemberCheck();/*diling add for 如果“新增亲情号码”中有用户办理了集团V网业务，请提示！@2012/6/19 */
	}
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
				if(updatephone.substr(0,1)!="0" && updatephone.substr(0,2)!="13"&&updatephone.substr(0,2)!="15"&&updatephone.substr(0,2)!="18"&&updatephone.substr(0,2)!="14"){
					rdShowMessageDialog("您输入的亲情号码有误！<br>您可以输入13或15开头的手机号码和0开头的固话号码!!");
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
				if(document.frm1239.rate_code_1.value.substring(0,8)==eval("document.frm1239.rateCode"+tempRadio[i].value+".value").substring(0,8)){
					document.frm1239.updatestrall.value=(document.frm1239.updatestrall.value).trim()+(eval("document.frm1239.newPhoneno"+tempRadio[i].value+".value")).trim()+"~";
				}
			}
	    }
		  var vUpdateHandFee=document.frm1239.handfeeshow.value * updatecount;
		  document.frm1239.hand_fee.value=vUpdateHandFee;
		  //rdShowMessageDialog("本次亲情号码修改收取的 "+document.frm1239.hand_fee.value+" 元手续费将在预存款中扣除！");
		  document.frm1239.updatecount.value=updatecount;
	   
	}
	else if("<%=opeTypeFlag%>"=="3")
		{
			for(var i=0;i<tempRadio.length;i++)
	    {
			if(tempRadio[i].checked)
		  　{
		  		var oldphone=eval("document.frm1239.newPhoneno"+tempRadio[i].value+".value");
		  		
		  		if(document.frm1239.oldstr.value.length==0)
		  		{
		  			document.frm1239.oldstr.value = (oldphone).trim();
		  			document.frm1239.newstr.value = (oldphone).trim();
		  		}
		  		else
		  			{
		  				document.frm1239.oldstr.value=(document.frm1239.oldstr.value).trim()+"|"+(oldphone).trim();
		  				document.frm1239.newstr.value=(document.frm1239.newstr.value).trim()+","+(oldphone).trim();
		  			}
		  			
		  	}
			}
			//alert(document.frm1239.oldstr.value+"--->准备要取消的号码串");
			//alert(document.frm1239.newstr.value+"--->准备要打印的号码串");
			
		}
	else{//alert(tempRadio.length);
	 for(var i=0;i<tempRadio.length;i++)
    {    	if(document.frm1239.rate_code_1.value.substring(0,8)==eval("document.frm1239.rateCode"+tempRadio[i].value+".value").substring(0,8)){
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
  }
  else{
  	//alert("准备进入打印方法");
  	 setOpNote();//为备注赋值
     //打印工单并提交表单
     var ret = showPrtdlg("Detail","确实要进行电子免填单打印吗？","Yes");
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

			/* ningtn */
			var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
			var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
			/* ningtn */
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);

 
	 return ret;
}

function printInfo(printType)
{
	//alert("进入打印方法");
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
      //opr_info+="手续费："+document.frm1239.hand_fee.value+" 元|";   20081120市场部来文封掉手续费相关
      if("<%=opeTypeFlag%>"=="0"){
      opr_info+="本次新增亲情号码："+document.frm1239.all_kinphone.value+"|";
      opr_info+="生效时间："+document.frm1239.send_note.value+"|";
      
	  }else if("<%=opeTypeFlag%>"=="2"){
	  	
	  	opr_info+="生效时间："+document.frm1239.send_note.value+"|";
	  	
      }
      else if("<%=opeTypeFlag%>"=="3"){
	  	
	  	opr_info+="失效时间："+document.frm1239.send_note.value+"|";
	  	
      }
      if("<%=opeTypeFlag%>"=="0"){
      	opr_info+="本次业务办理生效后，用户该资费下的所有亲情号码为："+document.frm1239.updatestrall.value+document.frm1239.all_kinphone.value+"|";
      }
      else if("<%=opeTypeFlag%>"=="2"){
      	opr_info+="本次修改亲情号码："+document.frm1239.updatestrprn.value+"|";
      	opr_info+="本次业务办理生效后，用户该资费下的所有亲情号码为："+document.frm1239.updatestrall.value+"|";
      }
      else{
      	opr_info+="本次取消亲情号码："+document.frm1239.newstr.value+"|";
      	//opr_info+="本次业务办理生效后，用户该资费下的所有亲情号码为："+document.frm1239.updatestrall.value+"|";
      }
      note_info1 +="亲情号码资费描述："+document.frm1239.mode_note.value+"|";
	  note_info2+="您设定的亲情号码为联通、固网号码时，如遇号码升位，请您及时到移动营业厅办理修改亲情号码手续。"+"|";
	  note_info2+="注意：亲情号码为异地所有运营商号码，可最多设定三个，变更次数不受限制。 "+"|";
	  note_info3+="备注："+document.all.note.value+"|";
      document.all.cust_info.value=cust_info+"#";
	  document.all.opr_info.value=opr_info+"#";
	  document.all.note_info1.value=note_info1+"#";
	  document.all.note_info2.value=note_info2+"#";
	  document.all.note_info3.value=note_info3+"#";
	  document.all.note_info4.value=note_info4+"#";
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
				if(document.frm1239.op_type.value=="修改"){
					document.frm1239.hand_fee.value = vRateCodeStr[2][se];
				}
				else{
					document.frm1239.hand_fee.value = "0.00";
				}
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
  var tempStr = document.frm1239.rate_code_1.value;
  document.frm1239.rateCodedel.value=tempStr;
  var rateCode = oneTokSelf(tempStr,"~",1);//新资费号码
  var addCode =  oneTokSelf(tempStr,"~",2);//用于判断生效标志   
  var sendFlag = "";//生效标志  
  var sendNote;//生效标志  
  change_mode();
  sendNote = "24小时内生效";//生效标志
  if("<%=opeTypeFlag%>"=="3")
  {
  	sendNote="次月失效";
  }
  document.frm1239.send_flag.value = sendFlag;
  document.frm1239.send_note.value = sendNote;
  document.frm1239.rate_code.value = rateCode;
	if("<%=opeTypeFlag%>"=="2"||"<%=opeTypeFlag%>"=="3"||"<%=opeTypeFlag%>"=="0"){
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
				/*alert("<%=kinratecode%>"+"-----"+document.frm1239.rate_code_1.value.substring(0,8));
				gaopeng 2013/4/2 星期二 15:11:25 这里是下拉列表选择的资费与列表中资费对应之后，控制亲情号码的显示。
				*/
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
    getMidPrompt("10442",codeChg(rateCode),"ipTd");
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
    
	return true;
}
/******为备注赋值********/
function setOpNote(){
	if(document.frm1239.note.value=="")
	{
	  <%if(opeType.equals("新增")){%>
	      document.frm1239.note.value = "亲情号码"+"<%=opeType%>"+";号码:"+document.frm1239.new_phoneno.value;
	  <%}else if(opeType.equals("修改")||opeType.equals("取消")){%>
	      document.frm1239.note.value = "亲情号码"+"<%=opeType%>";
	  <%}%>
	}
	return true;
}

function goBack(){
	window.location="f7124.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
}
</SCRIPT>

<body >
<FORM method="post" name="frm1239" action="../../npage/bill/f7124Cfm.jsp">
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
          <input name="mphone_no"  v_must=1  value="<%=iPhoneNo%>" readonly Class="InputGrey"/>
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
      <td style="<%=trOneView%>" id="ipTd">
		     <select  name="rate_code_1" onChange="getSendFlag();">
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
		  <td class="blue">手续费单价</td>
      <td colspan=<%=cSpan%>>
       <input name="handfeeshow"  v_type="money" maxlength=12 type="text" v_must=1  maxlength="12" value="待定" <%=handFee_Favourable%> Class="InputGrey"/>
       <font class="orange">(元/个)</font>
      </td>
		</tr>
		<tr>
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
		  <td colspan="3" >
		     <input name="new_phoneno"  type="text" id="new_phoneno" v_must=1 v_type=""  v_minlength=11 maxlength="160"/>
         <font class="orange">*</font>
         <font class="orange">（如同时增加多个号码，号码间用~分隔，如13912345678~13923456789~13934567890）</font>
		  </td>
      
		</tr>
		<tr>
      <td class="blue"> 备注 </td >
		  <td colspan="3">
		     <input  name="note" size=60 maxlength="60" value="" onFocus="if(checkOne()) setOpNote();" readonly class="InputGrey">
		  </td>
		  
		</tr>
  </table>
	<!-- ningtn 2011-8-3 09:58:25 扩大电子工单 -->
	<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
	</jsp:include>
  <table cellspacing="0">
    <tr>
      <td align=center>
        <input class="b_foot" name=print  onClick="printCommit()"  type=button value="确认&打印" />
        <input class="b_foot" name=reset1 type=button onClick="frm1239.reset();" value="清除" />
        <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value="关闭" />
        <input class="b_foot" name=back   onClick="goBack()" type="button" value="返回"/>			  
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
				<th align=center >亲情号码失效时间</th>
				<th align=center style="<%=updateNewPhonenoView%>">新亲情号码</th>
		</tr>
				<%
				  String total_phone="";
				  System.out.println("tmpresult1.length="+tmpresult1.length);
				  String tbclass="";
				  for(j=0;j<tmpresult1.length;j++){
				  	if(j%2==0){
				  		tbclass="Grey";
				  	}else{
				  		tbclass="";	
				  	}
					  total_phone = total_phone + tmpresult1[j][0].trim()+",";
				%>
				<tr id="list<%=j%>">
				  <td align=center style="<%=radioView%>" class="<%=tbclass%>"><input type="checkbox"  name="radio1" value="<%=j%>"<%if("N".equals(tmpresult6[j][0])){out.print("disabled");}%> <%if(opeTypeFlag.equals("2")||opeTypeFlag.equals("3")){%> onClick="setUpdateNewPhoneNo(<%=j%>)" <%}%> ></td>
				  <td align=center class="<%=tbclass%>"><%=tmpresult1[j][0]%></td>
				  <td align=center class="<%=tbclass%>"><%=tmpresult2[j][0]%></td>
				  <td align=center class="<%=tbclass%>"><%=tmpresult3[j][0]%></td>
				  <td align=center class="<%=tbclass%>"><%=tmpresult4[j][0]%></td>
				  <td align=center class="<%=tbclass%>"><%=tmpresult5[j][0]%></td>
				  
				  <td align=center style="<%=updateNewPhonenoView%>" class="<%=tbclass%>">
             	    <input name="update_newPhoneno<%=j%>"  type="text" id="update_newPhoneno<%=j%>"  maxlength="13"   >
				  </td>
				  <input name="newPhoneno<%=j%>" type="hidden" value="<%=tmpresult1[j][0]%>">
				  <input name="rateCode<%=j%>" type="hidden" value="<%=tmpresult2[j][0]%>">
				</tr>
				
				<%}%>
        </table>



  <input type="hidden" name="unitCode" value=<%=Department%>>
  <input type="hidden" name="workno" value=<%=workNo%>>
  <input type="hidden" name="workName" value=<%=workName%>>
  <input type="hidden" name="opCode" value=<%=opCode%>>
  <input type="hidden" name="opName" value=<%=opName%>>
  <input type="hidden" name="belongCode" value=<%=belongCode%>>
  <input type="hidden" name="ipAddr" value=<%=ip_Addr%>>
  <input type="hidden" name="opeTypeFlag" value=<%=opeTypeFlag%>>
  <input type="hidden" name="kin_count" value=<%=kin_count%>>
  <input name="vFavourCode" type="hidden" value="<%=vFavourCode%>">
  <input name="total_phone" type="hidden" value="<%=total_phone%>">
  <input name="all_kinphone" type="hidden" value="">
  <input name="send_flag" type="hidden" value="">
  <input name="send_note" type="hidden" value="">
  <input name="newPhoneno" type="hidden" value="">
  <input name="rateCode" type="hidden" value="">
  <input name="rateCodedel" type="hidden" value="">
  <input name="rate_code" type="hidden" value="">
  <input name="difftime" type="hidden" value="">
  <input name="begintime" type="hidden" value="">
  <input name="updatestr" type="hidden" value="">
  <input name="updatestrprn" type="hidden" value="">
  <input name="updatestrall" type="hidden" value="">
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

  <input name="printAccept" type="hidden" value="<%=printAccept%>">
  <%@ include file="/npage/include/footer.jsp" %> 
</form>
<script>
	getSendFlag();
</script>
</body>
<!-- ningtn 2011-8-3 09:59:10 电子化工单扩大范围 -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>
