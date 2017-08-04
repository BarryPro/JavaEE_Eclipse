 <%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-01-09 页面改造,修改样式
********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%!
/*2014/10/08 10:03:04 gaopeng 关于完善BOSS和经分系统客户信息模糊化展示的函（201409） 
	模糊化公共方法 objType 1 客户名称 账户名称 2其他（各种地址等）
*/
private String vagueFunc(String objName,int objType,boolean pwrfFlag){
	if(!pwrfFlag){
		if(objName != null && !"".equals(objName) && !"NULL".equals(objName)){
			if(objType == 1){
				if(objName.length() == 2 ){
					objName = objName.substring(0,1)+"*";
				}
				if(objName.length() == 3 ){
					objName = objName.substring(0,1)+"**";
				}
				if(objName.length() == 4){
					objName = objName.substring(0,2)+"**";
				}
				if(objName.length() > 4){
					objName = objName.substring(0,2)+"******";
				}
			}else if(objType == 2){
				objName = "********";
			}
		}
	}
	
	return objName;
}
%>

<%
	String opCode = "1550";	
	String opName = "综合历史信息查询";	//header.jsp需要的参数   
	System.out.println("gaopengSeeLohg===1550===init!!");
	//输入参数 查询类型，查询条件，机构代码，工号，权限代码。
	String inStr  = request.getParameter("parStr");//得到传入参数
	int pos = inStr.indexOf("|");
	String phoneNo  = inStr.substring(0,pos);//手机号码
	String idNo  = inStr.substring(12,inStr.length());//ID号
	
	String workNo = (String)session.getAttribute("workNo");    //工号 
	String workName = (String)session.getAttribute("workName");//工号名称  			
	String deptCode = (String)session.getAttribute("regCode");
	String regionCode = deptCode.substring(0,2);
	String powerName = (String)session.getAttribute("powerRight");//角色权限
	String password = (String)session.getAttribute("password");
	String ip_Addr = "172.16.23.13";	
	String phonePwd  = (String)request.getAttribute("pwd");//得到传入参数
	if(phonePwd == null){
		phonePwd = (String)request.getParameter("pwd");
	}
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
<wtc:service name="s1550Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="8">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=phonePwd%>"/>
	<wtc:param value="<%=idNo%>"/>
</wtc:service>
<wtc:array id="mainQryArr" scope="end"/>

<%
/*gaopeng 2014/12/09 8:45:35 关于开通BOSS系统1550免密权限的函 获取权限*/
	boolean pwrf = false;
	String pubOpCode = opCode;
%>
<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>

<%
	System.out.println("gaopengSeeLogpwrf============pwrf=="+pwrf);
	if (!retCode1.equals("000000")){
%>
	<script language="JavaScript">				
		rdShowMessageDialog("错误信息：<%=retCode1%>，错误代码：<%=retMsg1%>");	
		history.go(-1);
	</script>
<%	
	return;
	}else if(mainQryArr==null||mainQryArr.length==0){
%>
		<script language="javascript">
			rdShowMessageDialog("查询结果为空,无此条件信息的相关内容!");
			history.go(-1);
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
	String userInfo1 = (String)arlist.get(29);
%>
<script>
	var userInfo = "<%= userInfo1 %>" ;	
	var userType = oneTok(userInfo,"~",1);
	var stopFlag = oneTok(userInfo,"~",2);
	var stopDesc = "";
	if ( stopFlag == "N" )
		stopDesc = "免停用户";
	else
		stopDesc = "非免停用户";
		
</script>
<script>
	x = screen.availWidth;
	y = screen.availHeight;
	window.innerWidth = x;
	window.innerHeight = y;
</script>

<HTML>
 <HEAD>
  <TITLE>综合历史信息查询</TITLE>
<HEAD>
	<TITLE>综合信息查询</TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
  </HEAD>
<script language=javascript>
	function init(){
		document.all.attrCode.value = userType;
		document.all.stop.value = stopDesc;
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
			<div class="showmenuBody">
			  <a href="f1500_custuser.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户-用户对应关系</font></a> 
  		  	  <a href="f1500_custuserh.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户-用户对应关系历史</font></a> 
  		  	  <a href="f1500_custhis01.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户历史记录</font></a> 
 		  	  <a href="f1500_dCustDocInAdd.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户附加信息</font></a> 
			</div>
		</div> 

  <TABLE id=tb1 cellspacing="0" >
   <TR> 
      <td class="blue">客户标识</td>
      <td>
        <input name=custId  class="InputGrey" maxlength="20" readonly value="<%=(String)arlist.get(2)%>" >        
      </td>
      <td class="blue">客户名称</td>
      <td>
        <input name=custName class="InputGrey" readonly value="<%=vagueFunc((String)arlist.get(3),1,pwrf)%>" >
      </td>
      <td class="blue">归属地点</td>
      <td>
        <input name=regionCode class="InputGrey" readonly value="<%=(String)arlist.get(4)%>" >
      </td>
      <td class="blue">客户状态</td>
      <td> 
        <input name=custStatus class="InputGrey" readonly value="<%=(String)arlist.get(5)%>" >
      </td>
    </TR>
    <TR > 
      <td class="blue">状态时间</td>
      <td>
        <input name=runTime class="InputGrey" readonly value="<%=(String)arlist.get(6)%>" >
      </td>
      <td class="blue">客户级别</td>
      <td>
        <input name=ownerGrade class="InputGrey" readonly value="<%=(String)arlist.get(7)%>" >
      </td>
      <td class="blue">客户类别</td>
      <td> 
        <input name=ownerType class="InputGrey" readonly value="<%=(String)arlist.get(8)%>" >
      </td>
      <td class="blue">客户地址</td>
      <td> 
        <input name=custAddress class="InputGrey" readonly value="<%=vagueFunc((String)arlist.get(9),2,pwrf)%>" >
      </td>
    </TR>
    
    <TR> 
      <td class="blue">证件类型</td>
      <td>
        <input name=idType class="InputGrey" readonly value="<%=(String)arlist.get(10)%>" >
      </td>
      <td class="blue">证件号码</td>
      <td>
        <input name=idIccid class="InputGrey" readonly value="<%=vagueFunc((String)arlist.get(11),2,pwrf)%>" >
      </td>
      <td class="blue">证件地址</td>
      <td>
        <input name=idAddress class="InputGrey" readonly value="<%=vagueFunc((String)arlist.get(12),2,pwrf)%>" >
      </td>
      <td class="blue">证件有效期</td>
      <td>
        <input name=idValiddate class="InputGrey"  readonly value="<%=(String)arlist.get(13)%>" >
      </td>
    </TR>
    <TR> 
      <td class="blue">联系人</td>
      <td>
        <input name=contactPerson class="InputGrey"  readonly value="<%=vagueFunc((String)arlist.get(14),1,pwrf)%>" >
      </td>
      <td class="blue">联系电话</td>
      <td>
        <input name=contactPhone class="InputGrey"  readonly value="<%=(String)arlist.get(15)%>" >
      </td>
      <td class="blue">联系地址</td>
      <td>
        <input name=contactAddress class="InputGrey" readonly value="<%=vagueFunc((String)arlist.get(16),2,pwrf)%>"  >
      </td>
      <td class="blue">邮政编码</td>
      <td>
        <input name=contactPost class="InputGrey"  readonly value="<%=(String)arlist.get(17)%>" >
      </td>
    </TR>
    <TR> 
      <td class="blue">通讯地址></td>
      <td>
        <input name=contactAddress class="InputGrey" readonly value="<%=vagueFunc((String)arlist.get(18),2,pwrf)%>"  >
      </td>
      <td class="blue">联系人传真</td>
      <td>
        <input name=contactFax class="InputGrey" readonly value="<%=(String)arlist.get(19)%>"  >
      </td>
      <td class="blue">电子邮箱</td>
      <td>
        <input name=contactMailaddress class="InputGrey" readonly value="<%=(String)arlist.get(20)%>" >
      </td>
      <td class="blue">建档渠道标识</td>
      <td>
        <input name=contact_emaill class="InputGrey" readonly value="<%=(String)arlist.get(21)%>" >
      </td>
    </TR>
    <TR> 
      <td class="blue">建档时间</td>
      <td>
        <input name=create_time class="InputGrey" readonly value="<%=(String)arlist.get(22)%>" >
      </td>
      <td class="blue">销档时间</td>
      <td>
        <input name=close_time class="InputGrey" readonly value="<%=(String)arlist.get(23)%>" >
      </td>
      <td class="blue">上级客户ID</td>
      <td>
        <input name=parent_id class="InputGrey" readonly value="<%=(String)arlist.get(24)%>" >
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </TR>
  </TABLE>
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
			<div class="showmenuBody">
			  <a href="f1550_dBillCustDetail.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">详细优惠信息</font></a> 
	  		  <a href="f1500_wChgQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">变更记录</font></a> 
	 		  <a href="f1500_dCustSimHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">换卡记录</font></a> 
	  		  <a href="f1500_dCustMsgHis01.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户历史</font></a> 
			  <a href="f1550_dAssuMsg.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">担保信息</font></a> 
			  <a href="assuNote.jsp?id_no=<%=idNo%>"><font color="#3366CC">用户业务备注</font></a> 
			  <a href="f1550_dCustInnet.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC"> 入网信息</font></a> 
	  		  <a href="f1500_wPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户交费信息</font></a> 
	  		  <a href="f1500_dCustFuncHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"> <font color="#3366CC"> 特服变更明细</font></a>
	  		  <a href="f1500_dMarkMsg.jsp?idNo=<%=idNo%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户积分</font></a> 
	 		  <a href="f1550_dConUserMsg.jsp?idNo=<%=idNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">用户-帐户对应关系</font></a> 
	 		</div> 	
 		</div>	
  
<TABLE id=tb2 cellspacing="0" >
  <TR> 
    <td width="7%" class="blue">服务号码</td>
    <td width="16%">
      <input name="phone_no"   maxlength="20" class="InputGrey" readonly value="<%=phoneNo%>" >
    </td>
    <td width="10%" class="blue">业务品牌</td>
    <td width="16%">
      <input name="smCode"  class="InputGrey" readonly value="<%=(String)arlist.get(26)%>" >
    </td>
    <td width="10%" class="blue">服务类型</td>
    <td width="16%">
      <input name=serviceType  class="InputGrey" readonly value="<%=(String)arlist.get(27)%>" >
    </td>
    <td width="8%" class="blue">入网时间 </td>
    <td width="17%">
      <input name=openTime  class="InputGrey" readonly value="<%=(String)arlist.get(28)%>" >
    </td>
  </TR>
  
  <TR> 
    <td width="7%" class="blue">用户属性</td>
    <td width="16%">
      <input name=attrCode   class="InputGrey" readonly value=userType >
     </td>
    <td width="10%" class="blue">信用度等级</td>
    <td width="16%"> 
      <input name=creditCode class="InputGrey" readonly value="<%=(String)arlist.get(30)%>" >
      </td>
    <td width="10%" class="blue">信用度</td>
    <td width="16%"> 
      <input name=creditValue class="InputGrey" readonly value="<%=(String)arlist.get(31)%>" >
      </td>
    <td width="8%" class="blue">旧运行状态</td>
    <td width="17%"> 
      <input name=runName1 class="InputGrey"  readonly value="<%=(String)arlist.get(32)%>" >
      </td>
  </TR>
  
  <TR> 
    <td width="7%" class="blue">当前状态</td>
    <td width="16%"> 
      <input name=runName2 class="InputGrey" readonly value="<%=(String)arlist.get(33)%>" >
    </td>
    <td width="10%" class="blue">状态修改时间</td>
    <td width="16%">
      <input name=runTime class="InputGrey" readonly value="<%=(String)arlist.get(34)%>" >
    </td>
    <td width="10%" class="blue">出帐时间</td>
    <td width="16%">
      <input name=billDate class="InputGrey" readonly value="<%=(String)arlist.get(35)%>" >
    </td>
    <td width="8%" class="blue">出帐周期></td>
    <td width="17%">
      <input name=billUnit class="InputGrey" readonly value="<%=(String)arlist.get(36)%>" >
   </td>
  </TR>
  
  <TR> 
    <td width="7%" class="blue" >套餐类型</td>
    <td width="16%" class="blue">
      <input name=idAddress class="InputGrey" readonly value="<%=(String)arlist.get(37)%>" >
    </td>
    <td width="10%" class="blue">下月套餐</td>
    <td width="16%">
      <input name=idValiddate class="InputGrey" readonly value="<%=(String)arlist.get(38)%>" >
    </td>
    <td width="10%" class="blue">套餐起始时间</td>
    <td width="16%">
      <input name=contactPerson class="InputGrey" readonly value="<%=(String)arlist.get(39)%>" >
    </td>
    <td width="8%" class="blue">生效时间</td>
    <td width="17%">
      <input name=contactPhone class="InputGrey" readonly value="<%=(String)arlist.get(40)%>" >
    </td>
  </TR>
  
  <tr> 
    <td width="7%" class="blue">SIM卡号</td>
    <td width="16%">
      <input name=simNo class="InputGrey" readonly value="<%=(String)arlist.get(41)%>" >
    </td>
    <td width="10%" class="blue">IMSI号</td>
    <td width="16%">
      <input name=imsiNo class="InputGrey" readonly value="<%=(String)arlist.get(42)%>" >
    </td>
    <td width="10%" class="blue">免停标志  </td>
    <td width="16%">
      <input name="stop" class="InputGrey" readonly >&nbsp; 
    </td>
    <td width="8%">&nbsp;</td>
    <td width="17%">&nbsp;</td>
  </tr>
  
  <tr bgcolor="649ECC"> 
    <td colspan="5">
      <div align="center">特服明细列表</div>
    </td>
    <td colspan="3">
      <div align="center">用户业务属性列表</div>
    </td>
  </tr>
  <tr>
  	<td colspan="5">
  		<textarea name="textarea" rows=6 cols='' readonly style="width:98%"><%=(String)arlist.get(43)%><%=(String)arlist.get(44)%><%=(String)arlist.get(45)%></textarea>
  	</td>
  	<td colspan="3">
  		<textarea name="textarea2" rows=6 cols='' readonly style="width:95%"><%=(String)arlist.get(60)%></textarea>
  	</td>
 </tr>
</TABLE>
</DIV>

<!-- 表单title -->
<DIV id="Operation_Table">
		<div class="title">
			<div id="title_zi">帐户信息</div>
			<div id="nav">
				<dl>
		  			<dt>
						<a href="#" id="mh3" onmouseover="showmenu('mc3','mh3')" onmouseout="hidemenu('mc3')">其他信息</a>
					</dt>
				</dl>
			</div>
		</div>
		<div class="showmenu_shadow" id="mc3" onmouseover="showmenu('mc3')" onmouseout="hidemenu('mc3')">
		  <div class="showmenuBody">
	  	   <a href="f5431_2.jsp?userid=<%=idNo%>&phone_no=<%=phoneNo%>&title_name=付费计划信息&check_type=100012"><font color="#3366CC">付费计划信息</font></a> 
 		   <a href="f1500_wConPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(45)%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">帐户交费信息</font></a><font color="#3366CC"> 
  		   <a href="f1500_dConMsgHis01.jsp?contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">帐户历史记录</font></a> 
  		   <a href=" f1550_dConMsgPre.jsp?contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">预存分类信息</font></a> 
  		   <a href="f1500_dDepositQry.jsp?contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">帐户押金信息</font></a>  	
		  </div>
		</div>		
  
  <TABLE id=tb3 cellspacing="0" >
    <TR> 
      <td class="blue">帐户号</td>
      <td>
        <input name=contractNo class="InputGrey" readonly value="<%=(String)arlist.get(46)%>" >
       </td>
      <td class="blue">帐户名称</td>
      <td>
        <input name=bankCust class="InputGrey" readonly value="<%=vagueFunc((String)arlist.get(47),1,pwrf)%>" >
        </td>
      <td class="blue">帐户零头</td>
      <td>
        <input name=oddment class="InputGrey" readonly value="<%=(String)arlist.get(48)%>" >
      </td>
      <td class="blue">预存款 </td>
      <td>&nbsp;
<% 
	String preFee = (String)arlist.get(49);
	if (  preFee.length()==3 && preFee.substring(0,1).equals(".") ) { preFee = "0"+preFee;  }
%>      
        <input name=prepay_fee class="InputGrey" readonly value="<%=preFee%>" >
       </td>
    </TR>
        
    <TR> 
      <td class="blue">预存时间</td>
      <td>
        <input name=prepayTime class="InputGrey" readonly value="<%=(String)arlist.get(50)%>" >
      </td>
      <td class="blue">帐号类型</td>
      <td>
        <input name=accountType class="InputGrey" readonly value="<%=(String)arlist.get(51)%>" >
      </td>
      <td class="blue">欠费标志</td>
      <td>
        <input name=status class="InputGrey" readonly value="<%=(String)arlist.get(52)%>" >
      </td>
      <td class="blue">状态改变时间</td>
      <td>
        <input name=statusTime class="InputGrey" readonly value="<%=(String)arlist.get(53)%>" >
      </td>
    </TR>
    
    <TR> 
      <td class="blue">邮寄标志</td>
      <td>
        <input name=postFlag class="InputGrey" readonly value="<%=(String)arlist.get(54)%>" >
      </td>
      <td class="blue">押 金</td>
      <td>
        <input name=deposit class="InputGrey" readonly value="<%=(String)arlist.get(55)%>" >
      </td>
      <td class="blue">最小欠费年月</td>
      <td>
        <input name=minYM class="InputGrey" readonly value="<%=(String)arlist.get(56)%>" >
      </td>      
	  <td class="blue">最后一次使用时欠费金额</td>
      <td>
      	<%	
      	String tabIdNo=idNo.substring(idNo.length()-1,idNo.length());					  
		String getMsgSql = "select nvl (sum (should_pay-favour_fee-payed_prepay-payed_later ) ,0)"
			+"	from dcustowedeadtotal"+tabIdNo+" where id_No=:idNo and payed_status='1'";
		
		String[] inParams = new String[2];
		inParams[0] = getMsgSql;
		inParams[1] = "idNo=" + idNo;
		%>
		<wtc:service name="TlsPubSelBoss" 
			routerKey="region" routerValue="<%=regionCode%>" 
		retmsg="msg0" retcode="code0" outnum="5">
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/>
		</wtc:service>
		<wtc:array id="rstPay" scope="end" />

    	<input name=prepay_fee class="InputGrey" readonly value="<%=rstPay[0][0]%>" >
      </td>
    </TR>    
    <TR> 
      <td class="blue">欠 费</td>
      <td>
        <input name=oweFee class="InputGrey" readonly value="<%=(String)arlist.get(57)%>" >   
      </td>
      <td class="blue">帐户信誉度</td>
      <td>
        <input name=accountLimit class="InputGrey" readonly value="<%=(String)arlist.get(58)%>" >
      </td>
      <td class="blue">付款方式</td>
      <td>
        <input name=payCode class="InputGrey" readonly value="<%=(String)arlist.get(59)%>" >
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>      
    </TR>
  </TABLE>
  
  <table cellspacing="0">
    <tr> 
    	<td id="footer"> 
	    	<input class="b_foot" name=back onClick="location='f1550_1.jsp'" type=button value="  返  回  ">
	        <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="  关  闭  ">	       
   	</td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer.jsp" %>
  </form>
 </BODY>
</HTML>

