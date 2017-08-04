<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>集团信息查询</TITLE>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
	String opCode = "5082";
	String opName = "集团信息查询";
	
	String cfm_login = request.getParameter("phoneNo");//查询条件
	String phoneNos="";
	
	String v_isDirectManageCust = "0";
	String v_directManageCustNo = "";
	String v_groupNo = "";
	String password = (String)session.getAttribute("password"); //diling add for 安全加固
	String custLevelVal = "";//客户等级
	String custLevelStartTime = "";//客户等级开始时间
	String custLevelEndTime = "";//客户等级结束时间
	String innetYear = ""; /*用户入网的总年份数（取整数）*/ 
	String innetDay =""; /*用户入网除去整年之后剩余的天数（取整数）*/ 
	String innetInfo = "";
	String id_noss="";
	
	
		/* ningtn@20100707 修改页面数据显示方式 start */
	String custNameStr 			 = "";
	String custAddressStr 		 = "";
	String idIccidStr 			 = "";
	String idAddressStr 		 = "";
	String contactPersonStr      = "";
	String contactPhoneStr       = "";
	String contactAddressStr     = "";
	String contactPostStr        = "";
	String contactAddress1Str    = "";
	String contactMailaddressStr = "";
	String contactFaxStr         = "";
	String conNameStr = "";
	String pwdcheck = "N";
	/* ningtn@20100707 修改页面数据显示方式 end */
	
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
	
	/* gaopeng 2014/01/14 10:12:18  关于实名登记BOSS审批增加报表的需求 加入经办人信息的展示*/
	String gestoresName = "";
	String gestoresAddr = "";
	String gestoresIccId = "";
	String gestoresIdType = "";
	String gestoresIdTypeName = "";
	
	String responsibleName="";
	String responsibleAddr="";
	String responsibleType="";
	String responsibleIccId="";
	String responsibleTypeName="";
	
	/* begin add for 关于开发智能终端CRM模式APP的函 - 第三批@2015/3/30 */
	String realUserName = "";
	String realUserAddr = "";
	String realUserIdType = "";
	String realUserIccId = "";
	
%>
 	
  	
	<wtc:service  name="sGetBroadPhone"  routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="1"  retcode="errCode" retmsg="errMsg">
		<wtc:param  value="0"/>
		<wtc:param  value="01"/>
		<wtc:param  value=""/>
		<wtc:param  value="<%=workNo%>"/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value="<%=cfm_login%>"/>
  </wtc:service>
  <wtc:array id="list" scope="end"/>
<%
			if("000000".equals(errCode)){
				if(list != null && list.length > 0){
				System.out.println("=== list[0][0] ===" + list[0][0]);
					phoneNos = list[0][0];
				}
			}
%>
		<wtc:service name="s1500PhoneQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9" >
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="0"/>
		<wtc:param value="<%=phoneNos%>"/>
		<wtc:param value="<%=regionCode%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
			
			<%
			if(result.length>0) {
			id_noss=result[0][3];
			}
			%>
			
			
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

	<wtc:service name="s1500Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="28">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneNos%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=id_noss%>"/>
	</wtc:service>
	<wtc:array id="mainQryArr" scope="end"/>	
<%

	String xq_info_old = "";
	String xq_info_new = "";
	
	if(mainQryArr.length>0){
		xq_info_old = mainQryArr[0][25]+"--"+mainQryArr[0][23];
		xq_info_new = mainQryArr[0][26]+"--"+mainQryArr[0][24];
	}
		
	String oBroadBand = "";
	if(mainQryArr.length>0){
		oBroadBand = mainQryArr[0][27];
	}

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
          System.out.println("gaopengSeeLog20151207===="+arlist.size()+"wanghyd-----------"+value);
      }
    }
  }
  
  String ifVolte = "否";
  String arr44 = (String)arlist.get(44);
  String arr45 = (String)arlist.get(45);
  String arr46 = (String)arlist.get(46);
  if(arr44.indexOf("volte") != -1){
  	ifVolte = "是";
  }
  if(arr45.indexOf("volte") != -1){
  	ifVolte = "是";
  }
  if(arr46.indexOf("volte") != -1){
  	ifVolte = "是";
  }

		String userInfo1 = (String)arlist.get(29);
	String highmsg=(String)arlist.get(30);
	String ss="中高段用户";
	int spos=highmsg.indexOf(ss,0);
	
%>	
	
	
	<wtc:service name="sCustOprMsgQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeC1" retmsg="retMsgC1" outnum="8" >
    <wtc:param value="0"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>	
    <wtc:param value="<%=password%>"/>		
    <wtc:param value="<%=phoneNos%>"/>	
    <wtc:param value=""/>
    <wtc:param value="查询客户经办人信息"/>
    <wtc:param value="<%=(String)arlist.get(2)%>"/>
  </wtc:service>
  <wtc:array id="resultC1" scope="end"/>


<%
	
	if("000000".equals(retCodeC1)){
		System.out.println("gaopengSeeLog=================调用sCustOprMsgQry服务成功！");
		
		gestoresName = resultC1[0][0];    
		gestoresAddr = resultC1[0][3];    
		gestoresIccId = resultC1[0][2];   
	  gestoresIdType = resultC1[0][1]; 
	  
	  responsibleName=resultC1[0][6];
	  responsibleAddr=resultC1[0][7];
	  responsibleType=resultC1[0][4];
	  responsibleIccId=resultC1[0][5];
	  
	  
	  System.out.println("gaopengSeeLog=================gestoresName="+gestoresName);
	  System.out.println("gaopengSeeLog=================gestoresAddr="+gestoresAddr);
	  System.out.println("gaopengSeeLog=================gestoresIccId="+gestoresIccId);
	  System.out.println("gaopengSeeLog=================gestoresIdType="+gestoresIdType);
	  
	  /*gaopeng 关于在BOSS入网界面增加单位客户经办人信息的函 调用TlsPubSelCrm 查询经办人证件类型名称展示在页面上，经办人证件类型不进行模糊校验。*/
	  String[] inParamsss1 = new String[2];
	  
		inParamsss1[0] = "select t.id_name from sidtype t where t.id_type=:s_idType";
		inParamsss1[1] = "s_idType="+gestoresIdType;
		
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeidTyp" retmsg="retMsgidTyp" outnum="1">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
		</wtc:service>

		<wtc:array id="s_idType0" scope="end" />
		
		
		<%
	  if("000000".equals(retCodeidTyp) && s_idType0.length > 0){
	  	gestoresIdTypeName = s_idType0[0][0];
	  	 System.out.println("gaopengSeeLog=================gestoresIdTypeName="+gestoresIdTypeName);
	  }
	  
	  
	 	  String[] inParamsss333 = new String[2];
	  
		inParamsss333[0] = "select t.id_name from sidtype t where t.id_type=:s_idType";
		inParamsss333[1] = "s_idType="+responsibleType;
		
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeidTypsdf" retmsg="retMsgidTypsdf" outnum="1">			
		<wtc:param value="<%=inParamsss333[0]%>"/>
		<wtc:param value="<%=inParamsss333[1]%>"/>	
		</wtc:service>

		<wtc:array id="s_idType33333" scope="end" />
		
		
		<%
	  if( s_idType33333.length > 0){
	  	responsibleTypeName = s_idType33333[0][0];
	  	System.out.println("gaopengSeeLog=================responsibleTypeName="+responsibleTypeName);
	  } 
	  
	  
	  
	}else{
		System.out.println("gaopengSeeLog=================调用sCustOprMsgQry服务失败！");
	} 


%>
<script>
	if(<%=spos%>>=0){
		rdShowMessageDialog("该用户是中高端用户！");
		}
	var userInfo = "<%= userInfo1 %>" ;
	var userType = oneTok(userInfo,"~",1);
	var stopFlag = oneTok(userInfo,"~",2);
	var stopDesc = "";
	if ( stopFlag == "N" ) {
		stopDesc = "免停用户";
		}
	else {
		stopDesc = "非免停用户";
		}
	
	function init(){
	//document.all.attrCode.value = userType;
	//document.all.stop.value = stopDesc;
	$("#attrCode").html(userType);
	$("#stop").html(stopDesc);

}
</script>
</HEAD>
<%
/* ningtn@20100707 修改页面数据显示方式 start */

		custNameStr 		  = (String)arlist.get(3);
		custAddressStr 		  = (String)arlist.get(9);
		idIccidStr 			  = (String)arlist.get(11);
		idAddressStr 		  = (String)arlist.get(12);
		contactPersonStr      = (String)arlist.get(14);
		contactPhoneStr       = (String)arlist.get(15);
		contactAddressStr     = (String)arlist.get(16);
		contactPostStr        = (String)arlist.get(17);
		contactAddress1Str    = (String)arlist.get(18);
		contactMailaddressStr = (String)arlist.get(20);
		contactFaxStr         = (String)arlist.get(19);
		conNameStr         = (String)arlist.get(48);
		pwdcheck 						= (String)arlist.get(70);

/* ningtn@20100707 修改页面数据显示方式 end */
%>

<body onLoad="init()">
<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>

<table cellspacing="0" name="t1" id="t1">
  <tr> 
	<td colspan="8">
  	<div class="title">
		  <div id="title_zi">客户信息</div>	
    </div>
    </td>
 </tr>
  <tr> 

 
    <tr> 
      <td class="blue">客户标识</td>
      <td> 
        <%=(String)arlist.get(2)%>
      </td>
      <td class="blue">客户名称</td>
      <td> 
        <%=custNameStr%>
        </td>
      <td class="blue">归属地点</td>
      <td> 
       <%=(String)arlist.get(4)%>
      </td>
      <td class="blue">客户状态</td>
      <td > 
        <%=(String)arlist.get(5)%>
      </td>
    </tr>
    <tr> 
      <td class="blue">状态时间</td>
      <td> 
        <%=(String)arlist.get(6)%>
        </td>
      <td class="blue">客户级别</td>
      <td> 
        <%=(String)arlist.get(7)%>
        </td>
      <td class="blue">客户类别</td>
      <td> 
        <%=(String)arlist.get(8)%>
        </td>
      <td class="blue">客户地址</td>
      <td> 
        <%=custAddressStr%>
      </td>
    </tr>
    <tr> 
      <td class="blue">证件类型</td>
      <td> 
        <%=(String)arlist.get(10)%>
        </td>
      <td class="blue">证件号码</td>
      <td> 
        <%=idIccidStr%>
      </td>
      <td class="blue">证件地址</td>
      <td> 
        <%=idAddressStr%>
      </td>
      <td class="blue">证件有效期</td>
      <td> 
        <%=(String)arlist.get(13)%>
      </td>
    </tr>
    <tr> 
      <td class="blue">联系人</td>
      <td> 
        <%=contactPersonStr%>
        </td>
      <td class="blue">联系电话</td>
      <td> 
        <%=contactPhoneStr%>
        </td>
      <td class="blue">联系地址</td>
      <td> 
        <%=contactAddressStr%>
      </td>
      <td class="blue">邮政编码</td>
      <td > 
        <%=contactPostStr%>
      </td>
    </tr>
    <tr> 
      <td class="blue">通讯地址</td>
      <td> 
        <%=contactAddress1Str%>
        </td>
      <td class="blue">联系人传真</td>
      <td> 
       <%=contactFaxStr%>
      </td>
      <td class="blue">电子邮箱</td>
      <td > 
        <%=contactMailaddressStr%>
      </td>
      <td class="blue">建档渠道标识</td>
      <td> 
        <%=(String)arlist.get(21)%>
      </td>
    </tr>
    <tr> 
      <td class="blue">建档时间</td>
      <td> 
        <%=(String)arlist.get(22)%>
      </td>
      <td class="blue">销档时间</td>
      <td> 
        <%=(String)arlist.get(23)%>
      </td>
      <td class="blue">上级客户ID</td>
      <td > 
        <%=(String)arlist.get(24)%>
      </td>

      <td > 
       
      </td>
      <td > 
       
      </td>
    </tr>
    <tr>
    	<td class="blue">经办人姓名</td>
    	<td><%=gestoresName %></td>
    	<td class="blue">经办人联系地址</td>
    	<td><%=gestoresAddr %></td>
    	<td class="blue">经办人证件类型</td>
    	<td><%=gestoresIdTypeName %></td>
    	<td class="blue">经办人证件号码</td>
    	<td><%=gestoresIccId %></td>
    </tr>
    
    <tr>
    	<td class="blue">责任人姓名</td>
    	<td><%=responsibleName %></td>
    	<td class="blue">责任人联系地址</td>
    	<td><%=responsibleAddr %></td>
    	<td class="blue">责任人证件类型</td>
    	<td><%=responsibleTypeName %></td>
    	<td class="blue">责任人证件号码</td>
    	<td><%=responsibleIccId %></td>
    </tr>
    
         <tr> 
      <td class="blue">用户备注信息</td>
      <td> 
        <%=(String)arlist.get(69)%>
      </td>
    </tr>

  <tr> 
	<td colspan="8">
      	&nbsp;
    </td>
 </tr> 
 
  
  <tr> 
	<td colspan="8">
  	<div class="title">
		  <div id="title_zi">用户信息</div>	
    </div>
    </td>
 </tr>
  <tr> 
    <td class="blue" nowrap>服务号码</td>
    <td> 
      <%=phoneNos%>
    </td>
    <td class="blue" nowrap>业务品牌</td>
    <td> 
      <%=(String)arlist.get(26)%>
    </td>
    <td class="blue" nowrap>入网时间</td>
    <td > 
      <%=(String)arlist.get(28)%>
    </td>
      <td > 
       
      </td>
      <td > 
       
      </td>
  </tr>
  <tr> 
    <td class="blue">用户属性</td>
    <td id="attrCode"> 
      
    </td>
    <td class="blue">大客户标志</td>
    <td> 
      <%=(String)arlist.get(30)%>
      </td>
    <td class="blue">信用度</td>
    <td> 
      <%=(String)arlist.get(31)%>
    </td>
    <td class="blue" nowrap>旧运行状态</td>
    <td> 
      <%=(String)arlist.get(32)%>
    </td>
  </tr>
  <tr> 
    <td class="blue">当前状态</td>
    <td> 
     <%=(String)arlist.get(33)%>
    </td>
    <td class="blue">状态修改时间</td>
    <td> 
      <%=(String)arlist.get(34)%>
    </td>
    <td class="blue">出帐时间</td>
    <td> 
      <%=(String)arlist.get(35)%>
    </td>
    <td class="blue">出帐周期</td>
    <td> 
      <%=(String)arlist.get(36)%>
    </td>
  </tr>
  <tr> 
    <td class="blue">套餐类型</td>
    <td> 
      <%=(String)arlist.get(37)%>
      </td>
    <td class="blue">下月套餐</td>
    <td> 
      <%=(String)arlist.get(38)%>
      </td>
    <td class="blue">套餐起始时间</td>
    <td> 
      <%=(String)arlist.get(39)%>
      </td>
    <td class="blue">生效时间</td>
    <td> 
      <%=(String)arlist.get(40)%>
      </td>
  </tr>
  
  <tr > 
    <td  class="blue">小区代码--小区名称(当前)</td>
    <td > 
      <%=xq_info_old%>
      </td>
    <td  class="blue">小区代码--小区名称(下档)</td>
    <td > 
      <%=xq_info_new%>
    </td>
          <td > 
       
      </td>
      <td > 
       
      </td>
            <td > 
       
      </td>
      <td > 
       
      </td>
  </tr>
  
  <tr> 
    
    <td class="blue">免停标志</td>
    <td id="stop"> 
     
    </td>
    <td class="blue">主资费单双向属性</td>
    <td>
      <%=(String)arlist.get(43)%>
    </td>
    <td class="blue"  style="display:block">宽带账号</td>
    <td  style="display:block">
      <%=(String)arlist.get(63)%>
    </td>
        <td class="blue"  style="display:block">电信分局</td>
    <td  style="display:block">
      <%=(String)arlist.get(67)%>
    </td>
  </tr>
      <tr> 
      <td class="blue">客户等级</td>
      <td> 
        <%
        		custLevelVal = (String)arlist.get(74);
        		custLevelStartTime = (String)arlist.get(75);
        		custLevelEndTime = (String)arlist.get(76);
        %>
        <%=custLevelVal%>
      </td>
      
      <td class="blue">客户等级开始时间</td>
      <td> 
        
        <%=custLevelStartTime%>
      </td>
      
      <td class="blue">客户等级结束时间</td>
      <td> 
       
        <%=custLevelEndTime%>
      </td>
      
      <%
      	/*** begin diling add for 关于利用相关渠道开展客户网龄、星级查询需求@2014/2/19 ***/
      %>
      <td class="blue">客户网龄</td>
      <td> 
        <%
            innetYear = (String)arlist.get(71) ;
						innetDay = (String)arlist.get(72) ;
						innetInfo = innetYear+"年"+innetDay+"天";
        %>
        <%=innetInfo%>
      </td>
      </tr>
			<td class="blue">到期主资费</td>
      <td> 
				<%=(String)arlist.get(73)%>
      </td>
    
<%if(!"".equals(oBroadBand)){%>
	 <td class="blue">宽带带宽</td>
	 <td> 
		<%=oBroadBand%>
   </td>
<%}%>
 
		<%if(!"没有宽带账号".equals(arlist.get(63))){%>
	      <td class="blue">宽带安装地址</td>
	      <td>
	        <%=(String)arlist.get(64)%>
	      </td>
      <%}%>
</tr>

</table>


 

    <table cellspacing=0>
      <tr id="footer"> 
		<td>
			  <input class="b_foot" name=back onClick="window.location.href='f5082_1.jsp'" type=button value=返回>
			  <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
			  <input class="b_foot_long" name=print onclick="printTable(t1);" type=button value=导出为XLS表格>
		</td>
	  </tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<script ="javascript">
var excelObj;

function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.t1.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =13;//设置列宽 
  sheet.Columns("B").ColumnWidth =21;//设置列宽 
  sheet.Columns("B").numberformat="@";
  sheet.Columns("C").ColumnWidth =13;//设置列宽 
  sheet.Columns("D").ColumnWidth =21;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =13;//设置列宽
  sheet.Columns("F").ColumnWidth =21;//设置列宽
  sheet.Columns("F").numberformat="@"; 
  sheet.Columns("G").ColumnWidth =13;//设置列宽 
  sheet.Columns("H").ColumnWidth =21;//设置列宽 
	sheet.Columns("H").numberformat="@"; 


		for(a=0;a<document.all.t1.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						var g=0;
						for(j=0;j<cells;j++)
						{
							if(obj[a].rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj[a].rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value='';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj[a].rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj[a].rows[i].cells[j].innerText;
							g++;
							}
						}
					}
				}
				catch(e)
				{
					alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
   var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;  
  sheet.Columns("A").ColumnWidth =13;//设置列宽 
  sheet.Columns("B").ColumnWidth =21;//设置列宽 
  sheet.Columns("B").numberformat="@";
  sheet.Columns("C").ColumnWidth =13;//设置列宽 
  sheet.Columns("D").ColumnWidth =21;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =13;//设置列宽
  sheet.Columns("F").ColumnWidth =21;//设置列宽
  sheet.Columns("F").numberformat="@"; 
  sheet.Columns("G").ColumnWidth =13;//设置列宽 
  sheet.Columns("H").ColumnWidth =21;//设置列宽 
	sheet.Columns("H").numberformat="@"; 

		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					var g=0;
					for(j=0;j<cells;j++)
					{
							if(obj.rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj.rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value = '';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj.rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj.rows[i].cells[j].innerText;
							g++;
							}
					}
				}
			}
			catch(e)
			{
				alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
	excelObj.Range('A1:'+str.charAt(cells+colspan-2)
+total_row).Borders.LineStyle=1;
}

</script>
