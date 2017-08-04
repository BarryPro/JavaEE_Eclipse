 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s5010.viewBean.S5010Impl"%>
<%
	   String opCode = "5003";		
	   String opName = "局方银行代码管理";	//header.jsp需要的参数 	
		
	 
	    String loginNo =  (String)session.getAttribute("workNo");
	    String loginName =  (String)session.getAttribute("workName");	
	    String orgCode = (String)session.getAttribute("orgCode");
	    String ip_Addr = (String)session.getAttribute("ipAddr");	    
	    String regionCode = (String)session.getAttribute("regCode");
	    String regionName = orgCode.substring(2,4);	 
	    System.out.println("===========regionName"+regionCode);   
	    int		LISTROWS=16;
	    //进行工号权限检验
%>

<%
	//List al = null;
	String[][] postBankCodeData = new String[][]{};
	String[][] postBankDetailData = new String[][]{};


	int isGetDataFlag = 1;	//0:正确,其他错误. add by yl.
	String errorMsg ="";
	String tmpStr="";
	
	StringBuffer  insql = new StringBuffer();	
	dataLabel:
	while(1==1){	
	//1.SQL 局方银行代码
	insql.delete(0,insql.length());
	insql.append("select trim(post_bank_code),post_bank_code||'-->'||trim(bank_name) from sPostCode");
	insql.append(" where region_code='"+ regionCode +"'");
	insql.append(" order by post_bank_code ");
	
	//al = s5010.getCommONESQL(insql.toString(),2,0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=insql.toString()%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
	//al=result;
	//if( al == null ){
	if( result == null ){
		isGetDataFlag = 2;
		break dataLabel;
	}		
	//postBankCodeData = (String[][])al.get(1);
	postBankCodeData=result;

	//2.SQL 局方银行代码的明细
	insql.delete(0,insql.length());
	insql.append("select trim(post_bank_code), ");
	insql.append(" trim(bank_name),trim(post_account),trim(post_name)  ");
	insql.append(" from sPostCode ");
	insql.append(" where region_code='"+ regionCode +"'");
	insql.append(" order by post_bank_code  ");
	
	//al = s5010.getCommONESQL(insql.toString(),4,0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="4">
		<wtc:sql><%=insql.toString()%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%
	//if( al == null ){
	if( result1 == null ){
		isGetDataFlag = 3;
		break dataLabel;
	}		
	//postBankDetailData = (String[][])al.get(1);	
	postBankDetailData=result1;	
	isGetDataFlag = 0;
 break;
 }	


	 errorMsg = "取数据错误:"+Integer.toString(isGetDataFlag);	    
	 //System.out.println(errorMsg);
%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<%=errorMsg%>");
	window.close();
	window.opener.focus();
//-->
</script>
<%}%>


<html>
	<head>
	<title>局方银行代码管理</title>
	<script language="JavaScript">
	<!--
		//定义应用全局的变量
		var SUCC_CODE	= "0";   		//自己应用程序定义
		var ERROR_CODE  = "1";			//自己应用程序定义
		var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改
	
		var oprType_Add = "a";
	    	var oprType_Upd = "u";
	    	var oprType_Del = "d";
	    	var oprType_Qry = "q";
	
	
		var INDEX_PostBankCode = 0;
		INDEX_BankName = 1;
		INDEX_PostAccount = 2;
		INDEX_PostName = 3;
	
		    
	
	    var postBankDetailArr = <%=S5010Impl.createArraySelf("postBankDetailArr",postBankDetailData.length)%>;
	    <% for(int i=0; i<postBankDetailData.length; i++){ 
	    	for(int j=0; j<postBankDetailData[i].length; j++){
	    %>
	    		postBankDetailArr[<%=i%>][<%=j%>] = "<%=postBankDetailData[i][j]%>";
	    <%	}
	    }
	    %>	
	            	    
		onload=function(){		
			init();
			
		}
	
		//---------1------RPC处理函数------------------
		function doProcess(packet){
			//使用RPC的时候,以下三个变量作为标准使用.
			error_code = packet.data.findValueByName("errorCode");
			error_msg =  packet.data.findValueByName("errorMsg");
			verifyType = packet.data.findValueByName("verifyType");
			backArrMsg = packet.data.findValueByName("backArrMsg");
		
			self.status="";
			
		}
	
		function fillSelectUseValue_noArr(fillObject,indValue)
		{	
				for(var i=0;i<document.all(fillObject).options.length;i++){
					if(document.all(fillObject).options[i].value == indValue){
						document.all(fillObject).options[i].selected = true;
						break;
					}
				}							
		}
	
		function init()
		{
			chg_opType();
			//DoList();
			
		}
		
		function chg_opType()
		{
			with(document.frm)
			{
				var op_type = opType[opType.selectedIndex].value;
				if( op_type == oprType_Add )
				{
					showAdd.style.display="";
					showOther.style.display="none";				
				}
				else
				{
					showAdd.style.display="none";
					showOther.style.display="";				
				}
				
				enabledInput();
				chg_sPostBankCode();
				if( op_type == oprType_Add )
				{
					aPostBankCode.value = "";
					clearInput();			
				}
							
			}
		}	
	
		function enabledInput()
		{
			with(document.frm)
			{
				var op_type = opType[opType.selectedIndex].value;
				if( (op_type == oprType_Add) ||
					(op_type == oprType_Upd)
				)
				{
					bankName.disabled =  false;
					postAccount.disabled =  false;
					postName.disabled =  false;				
				}
				else
				{
					bankName.disabled =  true;
					postAccount.disabled =  true;
					postName.disabled =  true;		
				}						
			}
		}
		
		function clearInput()
		{
			with(document.frm)
			{
				bankName.value = "";
				postAccount.value = "";
				postName.value = "";
	
			}		
		}
	
	
		function chg_sPostBankCode()
		{
		  with(document.frm)
		  {
	
		   if( sPostBankCode.selectedIndex > -1 )
		   {
			var postBankCode = sPostBankCode[sPostBankCode.selectedIndex].value;
			for( var i=0; i<postBankDetailArr.length; i++ )
			{		
				if( (postBankCode == postBankDetailArr[i][INDEX_PostBankCode])
				)
				{
					bankName.value = postBankDetailArr[i][INDEX_BankName];
					postAccount.value = postBankDetailArr[i][INDEX_PostAccount];
					postName.value = postBankDetailArr[i][INDEX_PostName];
					break;
				}
			
			}
		   }			
		  }	
		
		}	

		function call_aPostBankCodeQry()
		{
		    var pageTitle = "银行代码查询";               
		    var fieldName = "银行代码|银行名称";
			var sqlStr ="";
						 
			sqlStr ="select trim(post_bank_code), trim(bank_name) from sPostCode "+
					" where region_code='" + "<%=regionCode%>" +"'" +
					" order by post_bank_code ";
			
		    var selType = "S";    //'S'单选；'M'多选      
		    var retQuence = "0|1";             
		    var retToField = "aPostBankCode";		    
		    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 			    
		}
	
		function judge_valid()
		{
		var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
	
			if( op_type == oprType_Add )
			{	
				if(!checkElement(document.frm.aPostBankCode)) return false;	
			}
	
			 if( (op_type == oprType_Add) || (op_type == oprType_Upd) )
			 {
				if(!checkElement(document.frm.bankName)) return false;
				if(!checkElement(document.frm.postAccount)) return false;
				if(!checkElement(document.frm.postName)) return false;			
			 }
		 			
			return true;
		}
	
		function DoList()
		{
			//if (IList.style.visibility != "hidden")
			if (IList.style.display != "none")
			{
				//IList.style.visibility="hidden";
				IList.style.display = "none";
			}
			else
			{
				//IList.style.visibility="visible";
				IList.style.display = "";
			}
		}
	
		function resetJsp()
		{
			 op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
		
			if( op_type == oprType_Add )
			{	
			document.frm.aPostBankCode.value = "";
			clearInput();
			}	
			
		}
		
		function commitJsp()
		{
			getAfterPrompt();
			var tmpStr="";
			var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
			var procSql = "";
			
			if( op_type == oprType_Qry )
			{
				rdShowMessageDialog("查询不能确认!");
				return false;					
			}else if( op_type == oprType_Upd )
			{
				if( document.frm.sPostBankCode.selectedIndex == -1 )
				{
					rdShowMessageDialog("请配置局方银行代码的数据!");
					return false;
				}	
			}
				
			if( !judge_valid() )
			{
				return false;
			}
	
			//2.对form的隐含字段赋值
			document.frm.opCode.value="5003";
				
			//4.提交页面
			 procSql = "prc_5003_cfm('" + document.all.opType.value+ "'";
			 procSql = procSql + ",'" + document.all.regionCode.value+ "'";		 
			 if( op_type == oprType_Add ){
			 	procSql = procSql + ",'" + document.all.aPostBankCode.value+ "'";
			 	tmpStr = "增加 " + ",银行代码:"+document.frm.aPostBankCode.value+"";
			 }else{
			 	procSql = procSql + ",'" + document.all.sPostBankCode.value+ "'";
			 	tmpStr = "修改 " + ",银行代码:"+document.frm.sPostBankCode.value+"";
			 }
			 
			 procSql = procSql + ",'" + document.all.bankName.value+ "'";
			 procSql = procSql + ",'" + document.all.postAccount.value+ "'";
			 procSql = procSql + ",'" + document.all.postName.value+ "'";
	
			 		  
			 procSql = procSql + ",'" + document.frm.loginNo.value + "'";
			 procSql = procSql + ",'" + document.frm.opCode.value + "'";
			 procSql = procSql + ",'" + document.frm.IpAddr.value + "'";
			 
			 document.frm.opNote.value =  tmpStr;
			 procSql = procSql + ",'" + document.frm.opNote.value + "'";	
	
	
			//8.提交页面
			document.frm.confirm.disabled = true;
			page = "f5003_confirm.jsp?procSql="+procSql;
			frm.action=page;
			frm.method="post";
		  	frm.submit();	
		}		
	//-->
	</script>
</head>


<body>
<form name="frm" method="post" action="">	
  <%@ include file="/npage/include/header.jsp" %>     	
  <div class="title">
	<div id="title_zi">局方银行代码管理</div>
  </div>	
  <table cellspacing="0">
    <tr> 
      <td class="blue" >操作类型</td>
      <td>
      	<select name="opType"  id="select" onChange="chg_opType()">
          <option value="a">增加</option>
          <option value="u">修改</option>
          <option value="d">删除</option>
          <option value="q" selected>查询 </select> </td>
      <td class="blue" >地市代码</td>
      <td>
      	<input name="regionName" type="text"  id="regionName" value="<%=regionName%>" maxlength="2" readonly class="InputGrey"> 
      </td>
    </tr>
    <tr  id="showOther" > 
      <td class="blue">局方银行代码</td>
      <td>
      	<select name="sPostBankCode"  id="sPostBankCode" onchange="chg_sPostBankCode()">
               <%
        	for(int i=0;i<postBankCodeData.length; i++){
			out.println("<option  value='"+postBankCodeData[i][0]+"'>"+postBankCodeData[i][1]+"</option>");
			}
		  %>         
        </select></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr id="showAdd"  > 
      <td class="blue" >局方银行代码</td>
      <td>
      	<input name="aPostBankCode" type="text"  id="aPostBankCode" maxlength="12" v_must=1 v_minlength=5 > 
        <input name="aPostBankCodeQry" type="button" class="b_text" id="aPostBankCodeQry" value="查询" onClick="call_aPostBankCodeQry()"> 
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td class="blue">银行名称</td>
      <td colspan="3"><input name="bankName" type="text"  id="bankName" size="60" maxlength="60"  v_must=1 v_type=string ></td>
    </tr>
    <tr> 
      <td class="blue">局方帐号</td>
      <td><input name="postAccount" type="text"  id="postAccount" maxlength="30" v_must=1 v_type=string ></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td class="blue">局方户名</td>
      <td colspan="3"><input name="postName" type="text"  id="postName" size="60" maxlength="60" v_must=1 v_type=string ></td>
    </tr>
   </table>
   <table cellspacing="0">
    <tr> 
      <td id="footer">
          <input name="IList" type="button"  class="b_foot" id="IList" value="列表" onClick="DoList()">
          &nbsp; 
          <input name="confirm" type="button"  class="b_foot" value="确认" onClick="commitJsp()">
          &nbsp; 
          <input name="reset" type="button"  class="b_foot" value="清除" onClick="resetJsp()">
          &nbsp; 
          <input name="back" class="b_foot" onClick="removeCurrentTab()" type="button"  value="返回">
          &nbsp; </div></td>
    </tr>
  </table>
   <table  cellSpacing=0 style="display:none" id="IList" >
		 <%
		 	out.println("<tr>");
		 	out.println("<th>局方银行代码</th>");
		 	out.println("<th>银行名称</th>");
		 	out.println("<th>局方帐号</th>");
		 	out.println("<th>局方户名</th>");
		 	out.println("</tr>");
		 	for(int i =0; i < postBankDetailData.length; i++)
		 	{
			 		out.println("<tr>");
			 		out.println("<td>" + postBankDetailData[i][0]  +  "</td>");
			 		out.println("<td>" + postBankDetailData[i][1]  +  "</td>");
			 		out.println("<td>" + postBankDetailData[i][2]  +  "</td>");
			 		out.println("<td>" + postBankDetailData[i][3]  +  "</td>");
			 		out.println("</tr>");
		 	} 
		 %>
 </table>
  
  	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
  	<input type="hidden" name="loginName" id="loginName" value="">
  	<input type="hidden" name="opCode" id="opCode" value="">
  	<input type="hidden" name="orgCode" id="orgCode" value="">
  	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">  	  	
	<input type="hidden" name="opNote" id="opNote" value="">
	 <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>
