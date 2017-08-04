<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 集团统一预存赠礼6949
   * 版本: 1.0
   * 日期: 2009/8/17
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="6949";
	String opName="集团统一预存赠礼";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String loginNoPass = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String preFlag = request.getParameter("preFlag");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");  	//数据格式为String[0][0]---String[n][0]
	String sqlStr="";
	int recordNum=0;
	int i=0;
	
	String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<%
	String  retFlag="",retMsg="";
	String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
	String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
	String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
	String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
	String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
	String  point_note="",open_time="",eff_time="",num="",count="";
	Date    date = new Date();
	SimpleDateFormat df  = new SimpleDateFormat("yyyy-MM");
	GregorianCalendar gc = new GregorianCalendar();
	gc.setTime(date); 
	gc.add(2,12);
	String  dateStr=df.format(gc.getTime());
	String  str[]  = dateStr.split("-");
	String  year   = str[0];
	String  month  = str[1]; 

	String iPhoneNo = request.getParameter("srv_no");
	String iOpCode  = request.getParameter("opcode");
	String cus_pass = request.getParameter("cus_pass");
	String payType[] = new String[2];
	
	if ("1".equals(preFlag)) {
			String sqlGetPayType = "select BASE_PAYTYPE, FREE_PAYTYPE" + 
				"  from wGrpProjectGift a, sGrpProjectCode b, dcustmsg c" + 
				" where a.id_no = c.id_no" + 
				"   and c.phone_no = '"+iPhoneNo+"'" + 
				"   and a.PROJECT_TYPE = b.PROJECT_TYPE" + 
				"   and a.PROJECT_CODE = b.PROJECT_CODE" + 
				"   and substr(a.BELONG_CODE, 1, 2) = b.REGION_CODE" + 
				"   and a.login_accept in" + 
				"       (select max(login_accept)" + 
				"          from wGrpProjectGift d ,sGrpProjectCode e " + 
				"           where  d.PROJECT_TYPE = e.PROJECT_TYPE" + 
				"           and e.PROJECT_CODE = e.PROJECT_CODE" + 
				"           and substr(d.BELONG_CODE, 1, 2) = e.REGION_CODE" + 
				"           and d.id_no = c.id_no" + 
				"           and d.op_code = '6949'" + 
				"           and d.back_flag = '0'" + 
				"           and sysdate between d.begin_time and case when e.pay_flag='1' then 	last_day(d.end_time)+1 else to_date(to_char(d.end_time,'YYYYMM')||'01 00:00:00','YYYYMMDD HH24:MI;SS') end)";
			payType[0] = "";
			payType[1] = "";
			System.out.println("====wanghfa====f6949_1.jsp==== sqlGetPayType = " + sqlGetPayType);
			
		%>
			<wtc:pubselect name="sPubSelect" outnum="2" routerKey="phone" retcode="retCode2" retmsg="retMsg2" routerValue="<%=iPhoneNo%>">
				<wtc:sql><%=sqlGetPayType%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="resultPayType" scope="end"/>	
		<% 
		  if(resultPayType != null && resultPayType.length > 0){
				System.out.println("====wanghfa====f6949_1.jsp====sPubSelect====  = " + resultPayType.length);
				System.out.println("====wanghfa====f6949_1.jsp====sPubSelect==== resultPayType[0][0] = " + resultPayType[0][0]);
				System.out.println("====wanghfa====f6949_1.jsp====sPubSelect==== resultPayType[0][1] = " + resultPayType[0][1]);
				payType[0] = resultPayType[0][0];
				payType[1] = resultPayType[0][1];
				
				System.out.println("====wanghfa====f6949_1.jsp====q_s6949Query====0==== inPhoneNo = " + iPhoneNo);
				System.out.println("====wanghfa====f6949_1.jsp====q_s6949Query====1==== iPreFlag = " + preFlag);
				System.out.println("====wanghfa====f6949_1.jsp====q_s6949Query====2==== basePaytype = " + payType[0]);
				System.out.println("====wanghfa====f6949_1.jsp====q_s6949Query====3==== freePaytype = " + payType[1]);
			%>
				<wtc:service name="q_s6949Query" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode3" retmsg="retMsg3">
					<wtc:param value="<%=iPhoneNo%>"/>
					<wtc:param value="<%=preFlag%>"/>
					<wtc:param value="<%=payType[0]%>"/>
					<wtc:param value="<%=payType[1]%>"/>
				</wtc:service>
				<wtc:array id="tempArr" scope="end"/>
			<%
				if (!"000000".equals(retCode3)) {
					%>
						<script language="JavaScript">
							rdShowMessageDialog("q_s6949Query：<%=retCode3%>，<%=retMsg3%>", 0);
							history.go(-1);
						</script>
					<%
				}
		  } else {
				%>
					<script language="JavaScript">
						rdShowMessageDialog("此用户没有办理过集团统一预存赠礼，不能办理预约的集团统一预存赠礼！", 1);
						history.go(-1);
					</script>
				<%
		  }
	}
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = preFlag;
	
	System.out.println("====wanghfa====f6949_1.jsp====s2289Qry====0==== inputParsm[0] = " + inputParsm[0]);
	System.out.println("====wanghfa====f6949_1.jsp====s2289Qry====1==== inputParsm[1] = " + inputParsm[1]);
	System.out.println("====wanghfa====f6949_1.jsp====s2289Qry====2==== inputParsm[2] = " + inputParsm[2]);
	System.out.println("====wanghfa====f6949_1.jsp====s2289Qry====3==== inputParsm[3] = " + inputParsm[3]);
	System.out.println("====wanghfa====f6949_1.jsp====s2289Qry====4==== inputParsm[4] = " + inputParsm[4]);
%>
	<wtc:service name="s2289Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="32" retcode="retCode" retmsg="retMsg1">
		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNoPass%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=" "/>
		<wtc:param value="<%=orgCode%>"/>
		<wtc:param value="<%=preFlag%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String SqlStr = "select count(*) from dgrpnomebmsg a,dgrpusermsgadd b,sbillspcode c,dcustmsg d "+
					"where a.id_no=b.id_no and b.field_code='YWDM0' and b.field_value=c.bizcodeadd "+
					"and trim(c.enterprice_code)='408114' and a.member_id=d.id_no and d.phone_no='"+iPhoneNo+"'";  

%>
<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="phone" retcode="retCode2" retmsg="retMsg2" routerValue="<%=iPhoneNo%>">
	<wtc:sql><%=SqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray" scope="end"/>	
<% 
  //out.println("aa"+projectType+"aaa");
  if(retArray!=null&& retArray.length > 0){
  	num = retArray[0][0];
  }
  // 20091026 七台河营销案回馈赠礼
  //String sqlstr="select count(*) from dvpmnusrmsg a, dcustmsg b where a.id_no = b.id_no and substr(b.belong_code,1,2)='06' "+"and a.pkgtype in ('96','30','50','48','102') and b.phone_no = '"+iPhoneNo+"'";
  //String sqlstr = "SELECT COUNT (*)  FROM dcustmsgadd a, dcustmsg b WHERE a.id_no = b.id_no   AND SUBSTR (b.belong_code, 1, 2) = '06'   AND a.field_value IN ('96', '30', '50', '48', '102')   and a.field_code = '80004'   AND b.phone_no = '"+iPhoneNo+"'" ;
  /***update by diling for 申告：判断用户是不是七台河vpmn包月资费还是用的旧费率索引，智能网割接dcustmsgadd表资费已调整，需修改此查询语句。@2012/4/27 ***/
  String sqlstr ="SELECT count(*) FROM dcustmsgadd a, dcustmsg b, svpmnoffersimple c WHERE a.id_no = b.id_no AND SUBSTR(b.belong_code, 1, 2) = '06' AND trim(a.field_value) = to_char(c.offer_id) and c.offer_attr_type = 'VpG0' and c.feeindex in (96, 30, 50, 48, 102) and a.field_code = '80004' AND b.phone_no = '"+iPhoneNo+"'";
  %>
<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="phone" retcode="retCode2" retmsg="retMsg2" routerValue="<%=iPhoneNo%>">
	<wtc:sql><%=sqlstr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray1" scope="end"/>	
<% 
  if(retArray1!=null && retArray1.length > 0){
  	count = retArray1[0][0];
  }
   
  String errCode = retCode;
  String errMsg = retMsg1;

  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s2289Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else 
  {
	  if (errCode.equals( "000000") && tempArr.length>0){
	  	if(!(tempArr==null)){
		    bp_name = tempArr[0][3];            //机主姓名
		    bp_add = tempArr[0][4];             //客户地址
		    passwordFromSer = tempArr[0][2];    //密码
		    sm_code = tempArr[0][11];           //业务类别
		    sm_name = tempArr[0][12];           //业务类别名称
		    hand_fee = tempArr[0][13];     	    //手续费
		    favorcode = tempArr[0][14];     	//优惠代码
		    rate_code = tempArr[0][5];    		//资费代码
		    rate_name = tempArr[0][6];    		//资费名称
		    next_rate_code = tempArr[0][7];		//下月资费代码
		    next_rate_name = tempArr[0][8];		//下月资费名称
		    bigCust_flag = tempArr[0][9];		//大客户标志
		    bigCust_name = tempArr[0][10];		//大客户名称
		    lack_fee = tempArr[0][15];			//总欠费
		    prepay_fee = tempArr[0][16];		//总预交
		    cardId_type = tempArr[0][17];		//证件类型
		    cardId_no = tempArr[0][18];			//证件号码
		    cust_id = tempArr[0][19];			//客户id
		    cust_belong_code = tempArr[0][20];	//客户归属id
		    group_type_code = tempArr[0][21];	//集团客户类型
		    group_type_name = tempArr[0][22];	//集团客户类型名称
		    imain_stream = tempArr[0][23];		//当前资费开通流水
		    next_main_stream = tempArr[0][24];	//预约资费开通流水
		    print_note = tempArr[0][25];		//工单广告
		    contract_flag = tempArr[0][27];		//是否托收账户
		    high_flag = tempArr[0][28];			//是否中高端用户
		    point_note = tempArr[0][29];		//积分清零提示
		    open_time = tempArr[0][30];			//开户时间
		    eff_time = tempArr[0][31];			//生效时间
	 	}
	}else{%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
				history.go(-1);
			</script>
      <%}
 }

String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>集团统一预存赠礼</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
  //--------2---------验证按钮专用函数-------------

function frmCfm()
{
	frm.submit();
	return true;
}

 function chkType()
 {
 	document.all.Gift_Code.value ="";
 	document.all.Gift_Name.value ="";
 	document.all.Base_Fee.value ="";
 	document.all.Free_Fee.value ="";
 	document.all.Mark_Subtract.value ="";
 	document.all.Consume_Term.value ="";
 	document.all.Mon_Base_Fee.value ="";
 	document.all.Prepay_Fee.value ="";
 	document.all.New_Mode_Name.value ="";
 	document.all.do_note.value ="";
 }
 function getInfo_code()
{
	/*if(("<%=num%>" == 0) && (document.all.projectType.value =="0001"))
  	{
  		rdShowMessageDialog("该用户不是农信通用户，不能办理此业务!");
  		return false;
  	}*/
  	if(("<%=count%>" == 0) && (document.all.projectType.value =="0001"))
  	{
  		rdShowMessageDialog("该用户不是七台河VPMN包月业务的用户，不能办理此业务!");
  		return false;
  	}
  	if(document.all.projectType.value == "0111")
  	{
  		//调用公共js
	  	var regionCode = "<%=regionCode%>";
	    var pageTitle = "营销方案选择";
	    var fieldName = "方案代码|方案名称|底线预存|活动预存|扣减积分|消费期限|月底线|总预存|备注|";//弹出窗口显示的列、列名
	    var sqlStr = "select project_code,project_name,base_fee,free_fee,consume_mark,consume_term,mon_base_fee,prepay_fee,note from sGrpProjectCode where region_code='"+regionCode+"' and valid_flag='Y' and project_type='"+document.frm.projectType.value+"' and months_between(sysdate,to_date('"+document.frm.openTime.value+"','yyyy.mm.dd')) >= innet_lower and months_between(sysdate,to_date('"+document.frm.openTime.value+"','yyyy.mm.dd')) < innet_upper ";
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "9|0|1|2|3|4|5|6|7|8|";//返回字段
	    var retToField = "Gift_Code|Gift_Name|Base_Fee|Free_Fee|Mark_Subtract|Consume_Term|Mon_Base_Fee|Prepay_Fee|New_Mode_Name|";//返回赋值的域
	    if(MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,80));

		document.all.do_note.value = "集团统一预存赠礼，方案代码："+document.all.Gift_Code.value;
  	}else{
	  	//调用公共js
	  	var regionCode = "<%=regionCode%>";
	    var pageTitle = "营销方案选择";
	    var fieldName = "方案代码|方案名称|底线预存|活动预存|扣减积分|消费期限|月底线|总预存|备注|";//弹出窗口显示的列、列名
	    var sqlStr = "select project_code,project_name,base_fee,free_fee,consume_mark,consume_term,mon_base_fee,prepay_fee,note from sGrpProjectCode where region_code='"+regionCode+"' and valid_flag='Y' and project_type='"+document.frm.projectType.value+"'";
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "9|0|1|2|3|4|5|6|7|8|";//返回字段
	    var retToField = "Gift_Code|Gift_Name|Base_Fee|Free_Fee|Mark_Subtract|Consume_Term|Mon_Base_Fee|Prepay_Fee|New_Mode_Name|";//返回赋值的域
	   	var projectType = document.frm.projectType.value;
	    if(MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,80));
	
		document.all.do_note.value = "集团统一预存赠礼，方案代码："+document.all.Gift_Code.value;
	}
}

function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
	return true;
}

function printCommit()
{
	getAfterPrompt();
 	if(!checkElement(document.all.phoneNo)) return;
	if(document.all.Gift_Code.value==""){
		rdShowMessageDialog("请输入营销代码!");
		document.all.Gift_Code.focus();
		return false;
	}
	if(parseFloat(document.all.Base_Fee.value)+parseFloat(document.all.Free_Fee.value)>parseFloat(document.all.oPrepayFee.value))
	{
		rdShowMessageDialog("账户预存款小于扣减费用，请先交费后再来办理此业务！");
		return false;
	}
	document.all.commit.disabled=true;
 //打印工单并提交表单
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
      {
	    frmCfm();
      }
	}
  }
  else
  {
     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
     {
	   frmCfm();
     }
  }
  return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="6949" ;                   			 		//操作代码
	var phoneNo="<%=iPhoneNo%>";                  	 		//客户电话

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo(printType)
{
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
	
	//opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phoneNo.value+"|";
	cust_info+="客户姓名："+document.all.oCustName.value+"|";
	cust_info+="客户地址："+document.all.i5.value+"|";
	cust_info+="证件号码："+document.all.i7.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="用户品牌："+document.all.oSmName.value;
	opr_info+="   业务流水："+document.all.login_accept.value+"|";
	//opr_info+="办理业务：预存12个月农信通包月费用赠礼营销活动，您办理的营销活动截至到<%=year%>"+"年<%=month%>"+"月";
	opr_info+="办理业务："+document.all.Gift_Name.value + "|";
	<%
		if ("1".equals(preFlag)) {
		%>
	  	opr_info+="您预约申请" + document.getElementById("Gift_Name").value + "营销案，将于<%=eff_time.substring(0,4)%>年<%=eff_time.substring(4,6)%>月<%=eff_time.substring(6,8)%>日生效。|";
		<%
		}
	%>
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	note_info2=" "+"|";
	note_info3=" "+"|";
	note_info4=" "+"|";

	var gift_code = Number(document.all.Gift_Code.value);
	if (document.all.projectType.value == "0001" )
	{
		note_info1+="备注：1、参与本活动60元费用从客户预存款中扣除，作为专款帐户此费用只能支付集团V网5元月使用费（VPMN月使用费）。"+
					"2、本活动当月办理下月生效，预存专款不退不转。"+
					"3、每月固定返还5元，连续返还12个月，活动期内若客户拆除或更改集团V网费用停止返还，重新加入集团V网费用继续返还。"+
					"4、客户在此专款费用未使用完前拆机、销号，剩余费用一次性收回。"+"|";
	}
	else
	{
		note_info1+="备注：专款费用不退不转"+"|";
	}
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;
}

//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f6949_2.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
		<input type="hidden" name="openTime" value="<%=open_time%>">
		<input type="hidden" name="preFlag" id="preFlag" value="<%=preFlag%>">
	<div class="title">
		<div id="title_zi">业务明细</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">方案类型</td>
		<td width="30%">
			<select id="projectType" name="projectType" onChange="chkType()">
		    <%	
		    	sqlStr ="select trim(project_type),trim(type_name) from sGrpProjectType where region_code='"+regionCode+"'";
		    	String[] inParas1 = new String[2];
		    	inParas1[0] = "select trim(project_type),trim(type_name) from sGrpProjectType where region_code=:region_code";
				inParas1[1] = "region_code="+regionCode;
				System.out.println("sqlStr === "+ sqlStr);
%>
			<wtc:service name="TlsPubSelCrm"  outnum="2" retcode="retCode1" retmsg="regMsg1">
				<wtc:param value="<%=inParas1[0]%>"/>
				<wtc:param value="<%=inParas1[1]%>"/> 
			</wtc:service>
			<wtc:array id="result" scope="end"/>
<%
				recordNum = result.length;
				for(i=0;i<recordNum;i++)
				{
					out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][0]+"-->"+result[i][1] + "</option>");
				}
		   %>
		   </select>
		</td>
		<td class="blue" width="20%">办理类型</td>
		<td width="30%">
<%
	if ("0".equals(preFlag)) {
		out.print("申请");
	} else if ("1".equals(preFlag)) {
		out.print("预约申请");
	}
%>
		</td>
	</tr>
	<tr>
		<td class="blue">手机号码</td>
		<td>
			<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
		</td>
		<td class="blue">机主姓名</td>
		<td>
			<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">业务品牌</td>
		<td>
			<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
		</td>
		<td class="blue">资费名称</td>
		<td>
			<input name="oModeName" type="text" class="InputGrey" size="35" id="oModeName" value="<%=rate_name%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">帐号预存</td>
		<td>
			<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
		</td>
		<td class="blue">当前积分</td>
		<td>
			<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="<%=print_note%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">方案代码</td>
		<td>
			<input class="InputGrey" type="text" name="Gift_Code" id="Gift_Code" readonly>
			<input class="b_text" type="button" name="qryId_No" value="查询" onClick="getInfo_code()" >
				<font color="orange">*</font>
		</td>
		<td class="blue">方案名称</td>
		<td>
			<input name="Gift_Name" type="text" class="InputGrey" size="35" id="Gift_Name" v_type="string" v_must=1 value="" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">底线预存</td>
		<td>
			<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly>
		</td>
		<td class="blue">活动预存</td>
		<td>
			<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"   readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">扣减积分</td>
		<td>
			<input name="Mark_Subtract" type="text" class="InputGrey" id="Mark_Subtract"   readonly>
		</td>
		<td class="blue">消费期限</td>
		<td>
			<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"   readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">月底线</td>
		<td>
			<input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" readonly>
		</td>
		<td class="blue">应收金额</td>
		<td >
			<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee"   readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">备    注</td>
		<td colspan="3" >
			<input name="do_note" type="text" class="button" id="do_note" value="" size="60" maxlength="60" >
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="foot">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="确认&打印" onClick="printCommit();">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="清除" >
			&nbsp;
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
			&nbsp;
		</td>
	</tr>
</table>
	
<div name="licl" id="licl">
			<input type="hidden" name="iOpCode" value="6949">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<input type="hidden" name="i2" value="<%=cust_id%>">
			<input type="hidden" name="i16" value="<%=rate_code%>">
			<input type="hidden" name="ip" value="">

			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="">
			<input type="hidden" name="i4" value="<%=bp_name%>">
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">
			<input type="hidden" name="i9" value="<%=contract_flag%>">

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">

			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="New_Mode_Name" value=" ">
			<input type="hidden" name="return_page" value="/npage/s1141/f6949_login.jsp">
			<input type="hidden" name="login_accept" value="<%=printAccept%>">
			<input type="hidden" name="cus_pass" value="<%=cus_pass%>">
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
