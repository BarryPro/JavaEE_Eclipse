<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1502";
	String opName = "综合信息历史查询";
	
	String inStr  = request.getParameter("parStr");//得到传入参数
	int pos = inStr.indexOf("|");
	String phoneNo  = inStr.substring(0,pos);//手机号码
	String idNo  = inStr.substring(12,inStr.length());//ID号
	

	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String powerName = (String)session.getAttribute("powerRight");
	String deptCode = (String)session.getAttribute("orgCode");;
	String ip_Addr = "172.16.23.13";
	String regionCode = deptCode.substring(0,2);

  String password = (String)session.getAttribute("password"); //diling add for 安全加固
	
/**
	ArrayList arlist = new ArrayList();
	try
	{	//System.out.println("--------------5555555-------------");
		s1500View viewBean = new s1500View();//实例化viewBean
		arlist = viewBean.view_s1500Qry(phoneNo,idNo); 
		//System.out.println("--------------5555555-------------");
	}
	catch(Exception e)
	{
		//System.out.println("调用EJB发生失败！");
	}
	**/
	
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

	<wtc:service name="s1500Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=idNo%>"/>
	
	</wtc:service>
	<wtc:array id="mainQryArr" scope="end"/>	
<%
 System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
 String retCodeForCntt = retCode1;
 String loginAccept =""; 
 String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo;
 System.out.println("url="+url);
 System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");    
%>
<jsp:include page="<%=url%>" flush="true" />
<%
	if(!retCode1.equals("000000")){
%>
	<script language="javascript">
		rdShowMessageDialog("服务未能成功,服务代码<%=retCode1%><br>服务信息<%=retMsg1%>!");
		parent.removeTab("<%=opCode%>");
	</script>
<%
		return;
	}else if(mainQryArr==null||mainQryArr.length==0){
%>
	<script language="javascript">
		rdShowMessageDialog("查询结果为空,无此条件信息的相关内容!");
		parent.removeTab("<%=opCode%>");
	</script>
<%
		return;
	}
	
	//循环取值,并将结果储存在list中
	ArrayList arlist = new ArrayList();
	StringTokenizer resToken = null;
  for(int i = 0; i<mainQryArr.length; i++){
  	for(int j=0;j<mainQryArr[i].length;j++){
  		String value;
      for(resToken = new StringTokenizer(mainQryArr[i][j], "|"); resToken.hasMoreElements(); arlist.add(value)){
          value = (String)resToken.nextElement();
      }
  	}
  }

	//从这里开始取值了
	String return_code = (String)arlist.get(0);
	String return_message =(String)arlist.get(1);
	
	String sql="select trim(phone_no) from wPrepayPhoneSaleOpr where second_id=to_number('"+idNo+"') and op_code='8042' and back_flag='0'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="mainPhoneArr" scope="end" />
<%
	String mainPhone="";
	if(mainPhoneArr.length>0){
		mainPhone=mainPhoneArr[0][0];
	}else{
		mainPhone="无";
	}
	
	
	if (!return_code.equals("000000")){
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=return_message%><br>服务代码 :<%=return_code%>");
	history.go(-1);
</script>
<%	
	}else{
	String userInfo1 = (String)arlist.get(29);
	String highmsg=(String)arlist.get(30);
	String ss="中高段用户";
	int spos=highmsg.indexOf(ss,0);
%>
<script>
	if(<%=spos%>>=0){rdShowMessageDialog("该用户是中高端用户！");}
	var userInfo = "<%= userInfo1 %>" ;
	
	var userType = oneTok(userInfo,"~",1);
	var stopFlag = oneTok(userInfo,"~",2);
	var stopDesc = "";
	if ( stopFlag == "N" )
		stopDesc = "免停用户";
	else
		stopDesc = "非免停用户";
		
</script>
<%
}
%>

<script>
	x = screen.availWidth;
	y = screen.availHeight;
	window.innerWidth = x;
	window.innerHeight = y;
</script>

<%--add by zhanghonga@20090107,版本合并时增加的新增内容--%>
<%
	String fee_return_code = "";//s1500_fee返回retCode
	String fee_return_msg = "";//s1500_fee返回retMsg
	String show_fee = ""; //当前预存;
	String prepayFee = "";//当前可划拨预存
	String nobillpay = ""; //未出账话费
	String now_prepayFee = "";//当前可用预存
%>

<%
	//System.out.println("###########################zhanghonga->feeRetCode->"+feeRetCode);
	
	//因为服务返回的retCode不规范,返回了只有一个"0",所以这样比较下
	/*if(Integer.parseInt(feeRetCode)==0){
		if(s1500FeeArr.length>0){
			fee_return_code = s1500FeeArr[0][0];
			fee_return_msg = s1500FeeArr[0][1];
			show_fee = s1500FeeArr[0][2]; //当前预存;
			prepayFee = s1500FeeArr[0][3];//当前可划拨预存
			nobillpay = s1500FeeArr[0][4]; //未出账话费
			now_prepayFee = s1500FeeArr[0][5];//当前可用预存
		}
	}*/
%>
<%--add by zhanghonga@20090107,版本合并时增加的新增内容到这里结束--%>

<HTML>
	<HEAD>
	<TITLE>综合信息查询</TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	
	<!---add by zhanghonga@20081225(圣诞节),应用户要求,修改&添加"其他信息"的样式,没放到公共css里,因为只有1500用到此样式--->
	<style>
	/*全局导航菜单定义*/
	#nav{
		list-style-type:none;
		padding:0px;
		margin-top: 2px;
		margin-right: 60px;
		margin-bottom: 0px;
		margin-left: 0px;
		float: right;
		line-height: 12px;
	 }
	 
	#nav dl {
		width: 68px;
		margin: 0;
		float: left;
		background-image: url(../../nresources/default/images/button_other.gif);
		background-repeat: no-repeat;
		height: 21px;
		padding-top: 4px;
		padding-right: 0;
		padding-bottom: 0;
		padding-left: 0px;
		color: #439337;
	}
	
	#nav dt {
		margin:0;
		padding-top: 0;
		padding-right: 0;
		padding-bottom: 0;
		padding-left: 0px;
		text-align: center;
	}

	#nav a{
		position:relative;
		text-decoration: none;
	}

	#nav a:hover{
		color: #FF9933;
		font-size: 12px;
		font-weight: normal;
		text-decoration: none;
	} 
 
	.showmenu_shadow{
		background:#e9e8e8;
		width:160px;
		position:absolute;
		z-index:500;
		display:none;
		text-align:left;
		right:0px;
	    filter: alpha(opacity=86);
	    -moz-opacity: .86;
	    margin-top:-8px;
	    font-size:12px;
		font-family:Tahoma,Arial, Helvetica, sans-serif;
	}
	.showmenu_shadow a,
	.showmenu_shadow a:link,
	.showmenu_shadow a:visited{
	 	display:block;
		padding:2px 0 0 5px;
		color:#289312;
		font-weight:bold;
		border-bottom:1px solid #addc61;
		height:22px;
		text-decoration:none;
	}	
	.showmenu_shadow a:hover{
		color:#cc0000;
		background:#FFFFFF;
		border-bottom:1px solid #999999;
	}
	.showmenu_shadow .showmenuBody{/*内容层*/
		z-index:100;
		border:solid 1px #999;
		position:relative;
		background:#dff6b3;
		margin:0 2px 2px 0;
		padding-left:3px;
		padding-right:3px;
	}
	</style>
	<!---add by zhanghonga@20081225(圣诞节)添加样式结束--->

	<!---add by zhanghonga@20081225(圣诞节):这段代码使用jquery编写,配合上面的样式,构成菜单效果;--->
	<!---如果不使用此菜单,删除这段代码即可,不对其他内容构成任何不良影响--->
	<script language="javascript">
		<!--
	    var showmua = false;
	    function showmenu(a, b) {
	        //强制hide()
	        for (i = 1; i <= 4; i++) {
	            var el = $('#mc' + i);
	            hid(el)
	        }
	        showmua = true;
	        var e = $('#' + a);
	        if (e.css("display") == "none") {
	            e.fadeIn('normal')
	        }
	        ;
	        if (b) {//默认不传入b参数
	            var mc_left = document.getElementById(b).offsetLeft;
	            e.css("left", mc_left);
	        }
	    }
	    function hidemenu(a) {
	        showmua = false
	        setTimeout('hid("' + a + '")', 1)
	        //hid(a)
	    }
	    function hid(a) {
	        var e = $('#' + a)
	        if (e.css("display") == "block" && showmua == false) {
	            e.fadeOut('normal')
	        }
	        showmua = true;
	    }
	    //-->
	</script>
	<!---add by zhanghonga@20081225(圣诞节):为菜单样式所添加js脚本结束--->

	</HEAD>
<script language=javascript>
function init(){
	document.all.attrCode.value = userType;
	document.all.stop.value = stopDesc;
	if (<%=request.getParameter("passFlag")%> == "1") {
		document.all.form1.custName.value="";
		document.all.form1.custName.value="";
		document.all.form1.custAddress.value="";
		document.all.form1.idIccid.value="";
		document.all.form1.idAddress.value="";
		document.all.form1.contactPerson.value="";
		document.all.form1.contactPhone.value="";
		document.all.form1.contactAddress.value="";
		document.all.form1.contactPost.value="";
		document.all.form1.contactAddress1.value="";
		document.all.form1.contactMailaddress.value="";
		document.all.form1.contactFax.value="";
		rdShowMessageDialog("密码不正确，只能显示部分信息。");
	} 
}


function  actionchk()
{
   var smCode = document.form1.smCode.value;
   if(smCode=="动感地带" || smCode=="dn")
	{
		document.form1.action="f1500_dnMarkMsg.jsp?idNo=<%=idNo%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>";
		document.form1.submit();
	}else{
		document.form1.action="f1500_dMarkMsg.jsp?idNo=<%=idNo%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>";
		document.form1.submit();
	}
	
	}
</script>
<body onLoad="init()">
  <form name="form1" method="post" action="">
  	<%@ include file="/npage/include/header.jsp" %>
  	
  		<div class="title">
			<div id="title_zi">客户信息</div>
	  		<div id="nav">
				<dl>
		  			<dt>
						<a href="#" id="mh1" onmouseover="showmenu('mc1','mh1')" onmouseout="hidemenu('mc1')">其他信息</a>
					</dt>
				</dl>
			</div>
		</div>
		<div class="showmenu_shadow" id="mc1" onmouseover="showmenu('mc1')" onmouseout="hidemenu('mc1')">
			<!--div class="showmenuBody">
			  <a href="f1502_custuser.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户-用户对应关系</font></a>
			  <a href="f1502_custcon.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户-帐户对应关系</font></a> 
			  <a href="f1502_custuserh.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户-用户对应关系历史</font></a> 
			  <a href="f1502_custhis01.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户历史记录</font></a> 
			  <a href="f1502_dCustDocInAdd.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户附加信息</font></a> 
			  <a href="fGetUserFavMsg.jsp?idNo=<%=idNo%>&openTime=<%=(String)arlist.get(28)%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">优惠信息查询</font></a>
			  <a href="f1502_CustManage.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>&custName=<%=(String)arlist.get(3)%>"> <font color="#3366CC"> 客户经理信息</font></a> 
			  <a href="f1502_RoamInfo.jsp?idNo=<%=idNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">边界漫游投诉信息</font></a></dd> 
			  <a href="f1502_sPubCustBillDet1.jsp?idNo=<%=idNo%>"><font color="#3366CC">详细资费信息</font></a></dd> 
			  <a href="f1534_1.jsp?phoneNo=<%=phoneNo%>"><font color="#3366CC">用户底线资费优惠查询</font></a></dd> 
			</div-->
				<div class="showmenuBody">
				  <a href="../queryhis/f1502_custhis01.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户历史记录</font></a> 
				</div>			
			<div class="showmenu_shadow" id="mca" onmouseover="showmenu('mca')" onmouseout="hidemenu('mca')">
				<div class="showmenuBody">
				  <a href="../queryhis/f1502_custhis01.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户历史记录</font></a> 
				</div>
			</div> 				
		</div> 
  <table id=tb1 cellspacing="0">
    <tr> 
      <td class="blue">客户标识</td>
      <td> 
        <input name=custId  class="InputGrey" maxlength="20" readonly value="<%=(String)arlist.get(2)%>">
      </td>
      <td class="blue">客户名称</td>
      <td> 
        <input name=custName class="InputGrey" readonly value="<%=(String)arlist.get(3)%>">
        </td>
      <td class="blue">归属地点</td>
      <td> 
        <input name=regionCode class="InputGrey" readonly value="<%=(String)arlist.get(4)%>">
      </td>
      <td class="blue">客户状态</td>
      <td class="blue"> 
        <input name=custStatus class="InputGrey" readonly value="<%=(String)arlist.get(5)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">状态时间</td>
      <td> 
        <input name=runTime class="InputGrey" readonly value="<%=(String)arlist.get(6)%>">
        </td>
      <td class="blue">客户级别</td>
      <td> 
        <input name=ownerGrade class="InputGrey" readonly value="<%=(String)arlist.get(7)%>">
        </td>
      <td class="blue">客户类别</td>
      <td> 
        <input name=ownerType class="InputGrey" readonly value="<%=(String)arlist.get(8)%>">
        </td>
      <td class="blue">客户地址</td>
      <td> 
        <input name=custAddress class="InputGrey" readonly value="<%=(String)arlist.get(9)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">证件类型</td>
      <td> 
        <input name=idType class="InputGrey" readonly value="<%=(String)arlist.get(10)%>">
        </td>
      <td class="blue">证件号码</td>
      <td> 
        <input name=idIccid class="InputGrey" readonly value="<%=(String)arlist.get(11)%>">
      </td>
      <td class="blue">证件地址</td>
      <td> 
        <input name=idAddress class="InputGrey" readonly value="<%=(String)arlist.get(12)%>">
      </td>
      <td class="blue">证件有效期</td>
      <td> 
        <input name=idValiddate class="InputGrey" readonly value="<%=(String)arlist.get(13)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">联系人</td>
      <td> 
        <input name=contactPerson class="InputGrey" readonly value="<%=(String)arlist.get(14)%>">
        </td>
      <td class="blue">联系电话</td>
      <td> 
        <input name=contactPhone class="InputGrey" readonly value="<%=(String)arlist.get(15)%>">
        </td>
      <td class="blue">联系地址</td>
      <td> 
        <input name=contactAddress class="InputGrey" readonly value="<%=(String)arlist.get(16)%>" >
      </td>
      <td class="blue">邮政编码</td>
      <td class="blue"> 
        <input name=contactPost class="InputGrey" readonly value="<%=(String)arlist.get(17)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">通讯地址</td>
      <td> 
        <input name=contactAddress1 class="InputGrey" readonly value="<%=(String)arlist.get(18)%>" >
        </td>
      <td class="blue">联系人传真</td>
      <td> 
        <input name=contactFax class="InputGrey" readonly value="<%=(String)arlist.get(19)%>" >
      </td>
      <td class="blue">电子邮箱</td>
      <td class="blue"> 
        <input name=contactMailaddress class="InputGrey" readonly value="<%=(String)arlist.get(20)%>">
      </td>
      <td class="blue">建档渠道标识</td>
      <td> 
        <input name=contact_emaill class="InputGrey" readonly value="<%=(String)arlist.get(21)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">建档时间</td>
      <td> 
        <input name=create_time class="InputGrey" readonly value="<%=(String)arlist.get(22)%>">
      </td>
      <td class="blue">销档时间</td>
      <td> 
        <input name=close_time class="InputGrey" readonly value="<%=(String)arlist.get(23)%>">
      </td>
      <td class="blue">上级客户ID</td>
      <td> 
        <input name=parent_id class="InputGrey" readonly value="<%=(String)arlist.get(24)%>">
      </td>
      <td class="blue">预存换手机话费共分享主卡</td>
      <td>
      	<input name=parent_id class="InputGrey" readonly value="<%=mainPhone%>">
     	</td>
    </tr>
  </table>
  </div>
  
<div id="Operation_Table">	
  	<div class="title">
		  <div id="title_zi">用户信息</div>
			<div id="nav">
				<dl>
		  			<dt>
						<a href="#" id="mh2" onmouseover="showmenu('mc2','mh2')" onmouseout="hidemenu('mc2')">其他信息</a>
					</dt>
				</dl>
			</div>
		</div>
		<div class="showmenu_shadow" id="mc2" onmouseover="showmenu('mc2')" onmouseout="hidemenu('mc2')">
			<!--div class="showmenuBody">
			  <a href="f1502_uConQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&busy_type=1&count=<%=(String)arlist.get(46)%>"><font color="#3366CC">用户帐单</font></a>
			  <a href="f1502_dBillCustDetail.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">详细优惠信息</font></a> 
			  <a href="f1502_wChgQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">变更记录</font></a> 
			  <a href="f1502_dCustSimHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">换卡记录</font></a> 
			  <a href="f1502_dCustMsgHis01.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户历史</font></a> 
			  <a href="f1502_dAssuMsg.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">入网担保信息</font></a> 
			  <a href="assuNote.jsp?id_no=<%=idNo%>"><font color="#3366CC">用户业务备注</font></a> 
			  <a href="f1502_dCustInnet.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">入网信息</font></a> 
			  <a href="f1502_wPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户交费信息</font></a> 
			  <a href="f1502_dCustFuncHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC"> 特服变更明细</font></a> 
			  <a href='javascript:actionchk()'><font color="#3366CC">用户积分</font></a> 
			  <a href="f1550_dConUserMsg.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">用户-帐户对应关系</font></a> 
			  <a href="f1502_sPubCustColorRing.jsp?phoneNo=<%=phoneNo%>"><font color="#3366CC">彩铃信息查询</font></a> 
			</div-->
				<div class="showmenuBody">
				  <a href="../queryhis/f1502_wChgQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">变更记录</font></a> 
				  <a href="../queryhis/f1502_dCustSimHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">换卡记录</font></a> 
				  <a href="../queryhis/f1502_dCustMsgHis01.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户历史</font></a> 
				  <a href="../queryhis/f1502_wPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户交费信息</font></a> 
				  <a href="../queryhis/f1502_dCustFuncHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC"> 特服变更明细</font></a> 
				</div>
			<div class="showmenu_shadow" id="mcb" onmouseover="showmenu('mcb')" onmouseout="hidemenu('mcb')">
				<div class="showmenuBody">
				  <a href="../queryhis/f1502_wChgQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">变更记录</font></a> 
				  <a href="../queryhis/f1502_dCustSimHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">换卡记录</font></a> 
				  <a href="../queryhis/f1502_dCustMsgHis01.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户历史</font></a> 
				  <a href="../queryhis/f1502_wPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户交费信息</font></a> 
				  <a href="../queryhis/f1502_dCustFuncHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC"> 特服变更明细</font></a> 
				</div>
			</div>			
		</div> 		
		
		
<table id=tb2 cellspacing="0">
  <tr> 
    <td class="blue" nowrap>服务号码</td>
    <td> 
      <input name="phone_no"   maxlength="20" class="InputGrey" readonly value="<%=phoneNo%>">
    </td>
    <td class="blue" nowrap>业务品牌</td>
    <td> 
      <input name="smCode"  class="InputGrey" readonly value="<%=(String)arlist.get(26)%>">
    </td>
    <td class="blue" nowrap>服务类型</td>
    <td> 
      <input name=serviceType  class="InputGrey" readonly value="<%=(String)arlist.get(27)%>">
    </td>
    <td class="blue" nowrap>入网时间</td>
    <td> 
      <input name=openTime  class="InputGrey" readonly value="<%=(String)arlist.get(28)%>">
    </td>
  </tr>
  <tr> 
    <td class="blue">用户属性</td>
    <td> 
      <input name=attrCode   class="InputGrey" readonly value=userType>
    </td>
    <td class="blue">大客户标志</td>
    <td> 
      <input name=creditCode class="InputGrey" readonly value="<%=(String)arlist.get(30)%>">
      </td>
    <td class="blue">信用度</td>
    <td> 
      <input name=creditValue class="InputGrey" readonly value="<%=(String)arlist.get(31)%>">
    </td>
    <td class="blue" nowrap>旧运行状态</td>
    <td> 
      <input name=runName1 class="InputGrey" readonly value="<%=(String)arlist.get(32)%>">
    </td>
  </tr>
  <tr> 
    <td class="blue">当前状态</td>
    <td> 
      <input name=runName2 class="InputGrey" readonly value="<%=(String)arlist.get(33)%>">
    </td>
    <td class="blue">状态修改时间</td>
    <td> 
      <input name=runTime class="InputGrey" readonly value="<%=(String)arlist.get(34)%>">
    </td>
    <td class="blue">出帐时间</td>
    <td> 
      <input name=billDate class="InputGrey" readonly value="<%=(String)arlist.get(35)%>">
    </td>
    <td class="blue">出帐周期</td>
    <td> 
      <input name=billUnit class="InputGrey" readonly value="<%=(String)arlist.get(36)%>">
    </td>
  </tr>
  <tr> 
    <td class="blue">套餐类型</td>
    <td> 
      <input name=idAddress1 class="InputGrey" readonly value="<%=(String)arlist.get(37)%>">
      </td>
    <td class="blue">下月套餐</td>
    <td> 


      </td>
    <td class="blue">套餐起始时间</td>
    <td> 
      <input name=contactPerson1 class="InputGrey" readonly value="<%=(String)arlist.get(39)%>">
      </td>
    <td class="blue">生效时间</td>
    <td> 
      <input name=contactPhone1 class="InputGrey" readonly value="<%=(String)arlist.get(40)%>">
      </td>
  </tr>
  <tr> 
    <td class="blue">SIM卡号</td>
    <td> 
      <input name=simNo class="InputGrey" readonly value="<%=(String)arlist.get(41)%>">
      </td>
    <td class="blue">IMSI号</td>
    <td> 
      <input name=imsiNo class="InputGrey" readonly value="<%=(String)arlist.get(42)%>">
      </td>
    <td class="blue">免停标志</td>
    <td> 
      <input name="stop" class="InputGrey" readonly>&nbsp;
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <th colspan="5" class="blue"><span style="padding-left:250px;">特服明细列表</span></th>
    <th colspan="3" class="blue"><span style="padding-left:90px;">用户业务属性列表</span></th>
  </tr>
  <tr>
  	<td colspan="5">
  		<textarea name="textarea" rows=6 cols='' readonly style="width:98%"><%=(String)arlist.get(43)%><%=(String)arlist.get(44)%><%=(String)arlist.get(45)%></textarea>
  	</td>
  	<td colspan="3">
  		<textarea name="textarea2" rows=6 cols='' readonly style="width:95%"><%=(String)arlist.get(60)%></textarea>
  	</td>
	</tr>
</table>
</DIV>


<!-- 表单title -->
<DIV id="Operation_Table">
		<div class="title">
			<!--div id="title_zi">帐户信息</div>
			<div id="nav">
				<dl>
		  			<dt>
						<a href="#" id="mh3" onmouseover="showmenu('mc3','mh3')" onmouseout="hidemenu('mc3')">其他信息</a>
					</dt>
				</dl>
			</div-->
		</div>
		<div class="showmenu_shadow" id="mc3" onmouseover="showmenu('mc3')" onmouseout="hidemenu('mc3')">
			<div class="showmenuBody">
	  		  <a href="f1502_dConUserMsg.jsp?idNo=<%=idNo%>&contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">付费计划信息</font></a> 
			  <a href="f1502_cConQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&busy_type=2&count=<%=(String)arlist.get(46)%>"><font color="#3366CC">帐户帐单</font></a> 
			  <a href="f1502_dConMsg.jsp?idNo=<%=idNo%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">托收帐号信息</font></a> 
			  <a href="f1502_wConPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(45)%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">帐户交费信息</font></a>
			  <a href="f1502_dConMsgHis01.jsp?contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">帐户历史记录</font></a> 
			  <a href="f1502_dConMsgPre.jsp?contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">预存分类信息</font></a> 
			  <a href="f1502_dDepositQry.jsp?contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">帐户押金信息</font></a> 
			</div>
		</div>
  <table id=tb3 cellspacing="0">
    <tr> 
      <td class="blue">帐户号</td>
      <td> 
        <input name=contractNo class="InputGrey" readonly value="<%=(String)arlist.get(46)%>">
        </td>
      <td class="blue">帐户名称</td>
      <td> 
        <input name=bankCust class="InputGrey" readonly value="<%=(String)arlist.get(47)%>">
      </td>
      <td class="blue">帐户零头</td>
      <td> 
        <input name=oddment class="InputGrey" readonly value="<%=(String)arlist.get(48)%>">
      </td>
      <td class="blue">预存时间</td>
      <td> 
        <input name=prepayTime class="InputGrey" readonly value="<%=(String)arlist.get(50)%>">
      </td>
    </tr>
    <tr>
      <td class="blue">帐号类型</td>
      <td> 
        <input name=accountType class="InputGrey" readonly value="<%=(String)arlist.get(51)%>">
      </td>
      <td class="blue">欠费标志</td>
      <td> 
        <input name=status class="InputGrey" readonly value="<%=(String)arlist.get(52)%>">
      </td>
      <td class="blue">状态改变时间</td>
      <td> 
        <input name=statusTime class="InputGrey" readonly value="<%=(String)arlist.get(53)%>">
      </td>
      <td class="blue">邮寄标志</td>
      <td> 
        <input name=postFlag class="InputGrey" readonly value="<%=(String)arlist.get(54)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">押 金</td>
      <td> 
        <input name=deposit class="InputGrey" readonly value="<%=(String)arlist.get(55)%>">
      </td>
      <td class="blue">最小欠费年月</td>
      <td> 
        <input name=minYM class="InputGrey" readonly value="<%=(String)arlist.get(56)%>">
      </td>
      <td class="blue">帐户信誉度</td>
      <td> 
        <input name=accountLimit class="InputGrey" readonly value="<%=(String)arlist.get(58)%>">
      </td>
      <td class="blue">付款方式</td>
      <td> 
        <input name=payCode class="InputGrey" readonly value="<%=(String)arlist.get(59)%>">
      </td>
    </tr>
    <tr>
      <td>&nbsp;<td>
      <td>&nbsp;<td>
      <td>&nbsp;<td>
      <td>&nbsp;<td>

							
    </tr>
  </table>
  
  <table>
    <tr> 
    	 <td id="footer">
					<input class="b_foot" name=back onClick="location='f1500_1.jsp'" type=button value="  返  回  ">
	        <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value="  关  闭  ">
       </td>
    </tr>
  </table>
  
  <%@ include file="/npage/include/footer.jsp" %>
  </form>
</BODY>

</HTML>
<!--***********************************************************************-->
