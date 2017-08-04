 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-04 页面改造,修改样式
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="import java.text.*"%>

<%
	String opCode = "5252";	
	String opName = "空中充值代理商注册";	//header.jsp需要的参数   
	
	//---------------------------------java代码区------------------------------------
	//读取session信息	    
	String loginNo=(String)session.getAttribute("workNo");    //工号 
	String loginName =(String)session.getAttribute("workName");//工号名称  	   
	String orgCode = (String)session.getAttribute("orgCode");   
	 String regionCode = (String)session.getAttribute("regCode");           
	String districtCode = orgCode.substring(2,4);
	String retFlag="0";
	String retMsg="";
	
	//----------------生成代理商新代码----------------------
	//int errCode = 0;
	String errCode="0";
	String errMsg = "";
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList retList = new ArrayList();
	String sqlStr = "select max(to_number(group_id)) from dChnGroupMsg where to_char(group_id) like '"+regionCode+districtCode+"%'";
	String outParaNums = "1";
	//调用公共数据库查询函数
	//retList = impl.sPubSelect(outParaNums,sqlStr,"region",regionCode);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="<%=outParaNums%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%
	//打印错误代码
		
	errCode=retCode1; //错误代码
	System.out.println("errCode:"+errCode);		
	errMsg=retMsg1;//错误信息
	System.out.println("errMsg:"+errMsg);	

	//获取结果
	String[][] retListString = null;
	String countG="";
	String groupIDInit="";	
	if(errCode.equals("000000")){
		//retListString = (String[][])retList.get(0);
		if(result1!=null&&result1.length>0){
			retListString=result1;
			countG=retListString[0][0];
			System.out.println("countG:"+countG);
		}
					
		if(!"".equals(countG)){
			if(countG.length() == 8){
				if(Integer.parseInt(countG.substring(4))<9){
					groupIDInit="000"+String.valueOf(Integer.parseInt(countG.substring(4))+1);
				}
				else if(Integer.parseInt(countG.substring(4))<99){
					groupIDInit="00"+String.valueOf(Integer.parseInt(countG.substring(4))+1);
				}
				else if(Integer.parseInt(countG.substring(4))<999){
					groupIDInit="0"+String.valueOf(Integer.parseInt(countG.substring(4))+1);
				}
				else if(Integer.parseInt(countG.substring(4))>=10000){
					retFlag="1";
					retMsg="代理商编号已经注册满，请与管理员联系！";
				}
				else{
					groupIDInit=String.valueOf(Integer.parseInt(countG.substring(4))+1);
				}
			}else if(countG.length() == 7){
				if(Integer.parseInt(countG.substring(3))<9){
					groupIDInit="000"+String.valueOf(Integer.parseInt(countG.substring(4))+1);
				}
				else if(Integer.parseInt(countG.substring(3))<99){
					groupIDInit="00"+String.valueOf(Integer.parseInt(countG.substring(4))+1);
				}
				else if(Integer.parseInt(countG.substring(3))<999){
					groupIDInit="0"+String.valueOf(Integer.parseInt(countG.substring(4))+1);
				}
				else if(Integer.parseInt(countG.substring(3))>=10000){
					retFlag="1";
					retMsg="代理商编号已经注册满，请与管理员联系！";
				}
				else{
					groupIDInit=String.valueOf(Integer.parseInt(countG.substring(3))+1);
				}
			}
		} 
		else{
			groupIDInit="0001";
		}
	}
	System.out.println("groupIDInit:"+groupIDInit);


	//----------------获取网点类型----------------------
	//int errCode2 = 0;
	String errCode2="0";
	String errMsg2 = "";
	//SPubCallSvrImpl impl2 = new SPubCallSvrImpl();

	//ArrayList retList2 = new ArrayList();
	String sqlStr2 = "select agt_type,agt_name from sagttype where region_code='"+regionCode+"'";
	String outParaNums2 = "2";

	//调用公共数据库查询函数
	//retList2 = impl2.sPubSelect(outParaNums2,sqlStr2,"region",regionCode);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="<%=outParaNums2%>">
	<wtc:sql><%=sqlStr2%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="result2" scope="end" />

<%
	//打印错误代码		
	errCode2=retCode2;//错误代码
	System.out.println("errCode2:"+errCode2);		
	errMsg2=retMsg2;//错误信息
	System.out.println("errMsg2:"+errMsg2);
	
	//获取结果
	String[][] retListString2 = null;
	String[] agentType=new String[500];
	String[] typeName=new String[500];
	int i=0;
	if(errCode2.equals("000000")){
	       if(result2!=null&&result2.length>0){	
	       		retListString2=result2;
	       		//retListString2 = (String[][])retList2.get(0);
	       }
	       
		//if(retListString2.length!=0){
		if(retListString2!=null&&retListString2.length!=0){
			for(i=0;i<retListString2.length;i++){
				System.out.println(i);
				agentType[i]=retListString2[i][0];
				typeName[i]=retListString2[i][1];
			}
		}
		else{
			retFlag="1";
			retMsg="您的代理商类型为空！";
		}
	}

	//----------------获取系统时间--------------------- 
	SimpleDateFormat dateFormatter =new SimpleDateFormat("yyyyMMdd");
	GregorianCalendar gc=new GregorianCalendar();
	String nDate=dateFormatter.format(gc.getTime());
%>

<html>
	<head>
		<title>空中充值代理商注册</title>
	<%//-----------------------------------js区域-------------------------------------%>
	<script language=javascript>
	//-------------------------------------处理RPC------------------------------------
	<%
		if(retFlag.equals("1")){%>
    			rdShowMessageDialog("<%=retMsg%>");
  	<%}%>
  
	//core.loadUnit("debug");
	//core.loadUnit("rpccore");

	onload=function() {
		self.status="";
	 	//core.rpc.onreceive = doProcess;
	}

	function doProcess(packet) {
		self.status="";
		var type = packet.data.findValueByName("type");
		if(type == "call_UserCodeQuery"){
			var bank_cust = packet.data.findValueByName("bank_cust");
			var pw_flag = packet.data.findValueByName("pw_flag");
			var phone_num = packet.data.findValueByName("phone_num");//帐户是否已经与代理商绑定
			var n_flag= packet.data.findValueByName("n_flag");       //有无帐户信息

			if(n_flag == "1"){
				document.form1.UserPassword.value = "";
				rdShowMessageDialog("没有该充值帐户号码的记录");
			}
			else if(phone_num>=1){
				rdShowMessageDialog("该帐户号码已经与现有空中充值代理商绑定!");
			}
			else if(pw_flag=="1"){
				document.form1.UserPassword.value = "";
				rdShowMessageDialog("帐户密码错误");
			}
			else{
				document.form1.submit1.disabled = false;
			}
		}
		else if(type == "call_getagentPhoneQuery"){		
			var cust_id = packet.data.findValueByName("cust_id");
			var phone_num = packet.data.findValueByName("phone_num");
			if(cust_id == ""){
				//document.form1.UserCodeQuery.disabled = true;
				rdShowMessageDialog("没有该手机号码的记录!");
			}
			else if(phone_num>=1){
				rdShowMessageDialog("该手机号码已经与现有空中充值代理商绑定!");
			}
			
			else{
				document.form1.agentType.disabled = false;
				//document.form1.UserCodeQuery.disabled = false;
			}
		}
	}

	function call_UserCodeQuery(){
		if(!checkElement(document.form1.UserCode)||!checkElement(document.form1.UserPassword)){
			return false;
		}
		else{
		  if(document.form1.UserCode.value.length == 0 || document.form1.UserPassword.value.length == 0){
			  rdShowMessageDialog("充值帐户号码或密码不能为空!");
		  }
		  else{
		  	var UserCode = document.form1.UserCode.value;
		  	var type = "call_UserCodeQuery";
		  	var newPwd=document.form1.UserPassword.value;
		  	var myPacket = new AJAXPacket("f5252_RPC1.jsp","正在提交，请稍候......");
		  	myPacket.data.add("UserCode",UserCode);
		  	myPacket.data.add("type",type);
		  	myPacket.data.add("newPwd",newPwd);
		  	core.ajax.sendPacket(myPacket);
		  	myPacket=null;
		  	//delete(myPacket);
		  }
		}
	}
	
	function call_getagentPhoneQuery(){
		if(!checkElement(document.form1.agentPhone)){
			return false;
		}else{
			var agentPhone = document.form1.agentPhone.value;
			var type = "call_getagentPhoneQuery";
			var myPacket = new AJAXPacket("f5252_RPC2.jsp","正在提交，请稍候......");
			myPacket.data.add("agentPhone",agentPhone);
			myPacket.data.add("type",type);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
			//delete(myPacket);
		}
	}
	
	//------------------------------获取用户信息---------------------------
	function getUser(){
		var agentType;
		var path;
		var groupId = document.form1.groupId.value;		
		for(i=0;i<document.form1.elements.length;i++){
			if (document.form1.elements[i].name=="agentType"){
				if (document.form1.elements[i].checked==true){
					agentType = document.form1.elements[i].value;
				}
			}
		}
		
		if(agentType == 0){
			document.form1.UserCode.readOnly = true;
			if(document.form1.legalId.value==""){
				rdShowMessageDialog("请先输入法人代表身份证号!");
				return;
			}
			var agentPaper = document.form1.legalId.value;
			path = "f1102_1.jsp?agentPaper=" + agentPaper;
			window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		}else if(document.form1.groupId.value.length > 1 && agentType != 0){
			document.form1.UserCode.readOnly = false;
			document.form1.UserPassword.readOnly = false;
		}
	}

	//--------------------------------提交表单------------------------------------
	function commit(){
		  if(document.form1.entryType.value=='')
	    {
	        rdShowMessageDialog("请选择'网点是否为公司现有其他实体渠道'!");
	        return false;
	     }
	    if(document.form1.entryType.value=='1'&&document.form1.Entity_groupName.value=='')
	    {
	        rdShowMessageDialog("请选择'实体渠道组织节点'!");
	        return false;
	     }
		getAfterPrompt();
		if(document.form1.opNote.value==""){
			document.form1.opNote.value = "工号:"+"<%=loginNo%>"+"进行空中充值代理商注册,代理商编号:"+document.form1.groupId.value;
		}
		if(checkform1()){
			form1.action="f5252_add.jsp";
			form1.submit();
			return true;
		}
	}

	//-----------------------------------空验证-----------------------------------------
	function checkform1(){
		if(check(document.form1))
			return true;
	}

	//---------------------------------清空表单---------------------------------------
	function resetJSP(){
		for(i=0;i<document.form1.elements.length;i++){
			if (document.form1.elements[i].type=="text"){
				document.form1.elements[i].value = "";
			}else if (document.form1.elements[i].type=="password"){
				document.form1.elements[i].value = "";
			}else if(document.form1.elements[i].name=="agentState"){
				document.form1.agentState.options[0].selected = true;
			}
		}
	}

	//------------------------------------动作控制---------------------------------------
	function agentPhoneChange(obj){
		//document.form1.UserCodeQuery.disabled = true;
		document.form1.agentType.disabled = true;
		document.form1.submit1.disabled = true;
		document.form1.UserCode.value = "";
		document.form1.UserPassword.value = "";
		return forMobil(obj);
	}
	
	
	function UserCodeChange(obj){
		document.form1.submit1.disabled = true;
		if(this.v_type="int"){			
			//return for0_9(obj);			
			return forNonNegInt(obj);
		}
		if(this.v_type="String"){			
			//return forString(obj);
			return forString(obj);
		}
	}
	
</script>

<script language=JavaScript>
//----弹出一个新页面选择组织节点--- 增加
function select_groupId()
{
	var path = "/npage/rpt/common/grouptree.jsp?grpId=Entity_groupId&grpName=Entity_groupName&grpType=form1";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}

function entryTypeChange()
{
	if (document.form1.entryType.value == 1) 
	{
		entryId.style.display = "";
	}
	if (document.form1.entryType.value == 0||document.form1.entryType.value == '') 
	{
		entryId.style.display = "none";
	}
}

	function chgSelParterType(){
		var g3role = document.getElementById("g3roleid").value;
		if(g3role=="01"){
			//代理商
			document.getElementById("parter_row").style.display="block";
		}
		if(g3role=="02"){
			//零售商
			document.getElementById("parter_row").style.display="none";
			document.getElementById("parterid").value="";
		}
	}
	
</script>

</head>
	<%//--------------------------------------页面区域--------------------------------------------%>
	<body>
	<form name="form1" method="post"> 
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">空中充值代理商注册</div>
		</div>
      	<table  cellspacing="0">
      		<tbody>
      			<tr> 
           			<td class="blue">代理商编号</td>
            			<td> 
			  		<input  type="text" name="groupId" value="<%=regionCode+districtCode+groupIDInit%>" v_must="1" maxlength="8" readonly class="InputGrey">
            				<font class="orange">*</font>
            			</td>
            			<td class="blue">代理商名称</td>
	            		<td>
	            			<input  type="text" v_must="1" name="agentName" value="" v_type="string" maxlength="60" onblur="checkElement(this)">
				  	<font class="orange">*</font>		
	            		</td>
        		</tr>
        		<tr> 
		            <td class="blue">代理商地址</td>
		            <td colspan="3"> 
				<input type="text"   v_must="1" name="agentAddress" value="" v_type="string" maxlength="60" size="50" onblur="checkElement(this)">
		            	<font class="orange">*</font>
		            </td>
        		</tr>
		        <tr> 
		            <td class="blue">地市代码</td>
		            <td> 
				<input   type="text"  v_must="1" name="regionCode"  value="<%=regionCode%>" readonly class="InputGrey">
		            	<font class="orange">*</font>
		            </td>
		            <td class="blue">区县代码</td>
		            <td> 
		              	<input   type="text"  v_must="1" name="districtCode" value="<%=districtCode%>" readonly  class="InputGrey">
				<font class="orange">*</font>
		            </td>
		        </tr>
		        <tr> 
		            <td class="blue"> 法人代表姓名</td>
		            <td> 
				<input  type="text"  v_must="1" name="legalPresent" value="" v_type="string" maxlength="60" onblur="checkElement(this)">
		            	<font class="orange">*</font>
		            </td>
		            <td class="blue">法人代表身份证号</td>
		            <td> 
		              	<input  type="text" name="legalId" v_must="1" value="" maxlength="18"  v_type="idcard" onChange="return forIdCard(this)" onblur="checkElement(this)">
				<font class="orange">*</font>
		            </td>
		        </tr>
		        <tr> 
		            <td class="blue">网点类型</td>
		            <td> 
				<select  name="angentClass" v_must="1" >
					 <%
					  	for(i=0;i<agentType.length;i++){
					  		if(agentType[i]!=null){
					  		%>	  						
					  			<option value="<%=agentType[i]%>"><%=agentType[i]%>-><%=typeName[i]%></option>
					  	<%}}
					  %>
				</select>
		            	<font class="orange">*</font>
		            </td>
		            <td class="blue">邮编</td>
		            <td> 
		              	<input  type="text" name="zip" value="" v_must="1"  v_type="zip" maxlength="6" onChange="if(forPostCode(this)) return forNonNegInt(this)" v_minlength="6" onblur="checkElement(this)">
				<font class="orange">*</font>
		            </td>
		        </tr>
		        <tr> 
		            <td class="blue">联系人姓名</td>
		            <td> 
				<input  type="text" name="contactName" v_must="1" v_type="string" value="" maxlength="60"  onblur="checkElement(this)">
		            	<font class="orange">*</font>
		            </td>
		            <td class="blue">联系人身份证</td>
		            <td> 
		              	<input  type="text" name="contactId" v_must="1" value="" v_type="idcard" maxlength="18"  onblur="checkElement(this)" onChange="return forIdCard(this)">
				<font class="orange">*</font>
		            </td>
		        </tr>  
		        <tr> 
		            <td class="blue">联系人电话</td>
		            <td> 
				<input  type="text" name="contactPhone" v_must="1" value=""  v_type="phone" maxlength="11" onblur="checkElement(this)" onChange="return forTel(this)">
		            	<font class="orange">*</font>
		            </td>
		            <td class="blue">开户银行</td>
		            <td> 
		              	<input  type="text" name="bankName" v_must="1" value="" maxlength="60"  onblur="checkElement(this)" v_type="string">
				<font class="orange">*</font>
		            </td>
		        </tr>
		        <tr> 
		            <td class="blue">相应帐号</td>
		            <td> 
				<input  type="text" name="accountNo"  v_must="1" value="" v_type="0_9" maxlength="20" onChange="return forNonNegInt(this)" onblur="checkElement(this)">
		            	<font class="orange">*</font>
		            </td>
		            <td class="blue">押金金额</td>
		            <td> 
		              	<input  type="text" name="deposit" value="0" maxlength="20" v_type="money" v_must="1"  onChange="return forMoney(this)" onblur="checkElement(this)">
				<font class="orange">*</font>
		            </td>
        		</tr>
		        <tr> 
		            <td class="blue">牌匾尺寸</td>
		            <td> 
				<input  type="text" name="pb_size" v_must="1" value="0" maxlength="20"  v_type="0_9" onChange="return forNonNegInt(this)" onblur="checkElement(this)">
		            	<font class="orange">*</font>
		            </td>
		            <td class="blue">签约时间</td>
		            <td> 
		              	<input  type="text" name="signTime" v_must="1" value="<%=nDate%>" maxlength="8"  v_type="date" onChange="return forDate(this)" readonly class="InputGrey">
				<font class="orange">*</font>
		            </td>
		        </tr>	
		        <tr> 
		            <td class="blue" >捆绑手机号</td>
		            <td colspan="3"> 
				<input name="agentPhone" type="text"  id="agentPhone" maxlength="11"  v_type="mobphone" v_must="1" onChange="agentPhoneChange(this)" onblur="checkElement(this)">
				<input type="button" class="b_text" name="getagentPhone" value="验证" onClick="call_getagentPhoneQuery()" >
		            	<font class="orange">*</font>
		            </td>
		        </tr>
		        <tr> 
		            <td class="blue" >充值帐户类型</td>
		            <td>
				<input type="radio" name="agentType" style='cursor:hand' value="0" onClick="getUser()" disabled>新建帐户&nbsp;
				<input name="contract_no" type="hidden"  id="contract_no">
			    </td>
		            <td >&nbsp;</td>
		            <td >&nbsp;</td>
		        </tr>
		  	
		  	
		  	<tr > 
			     <td class="blue" >充值帐户号码</td>
			     <td>
						<input name="UserCode" type="text" id="UserCode" readonly="true"  v_type="int" v_must="1" maxlength="11" onChange="UserCodeChange(this)" v_minlength="11" class="InputGrey">
						<font class="orange">*</font>
				    </td>
			      <td class="blue" >帐户密码</td>
			      <td>
							<input name="UserPassword" type="password"  id="UserPassword" readonly="true" class="InputGrey"  v_type="string" v_must="1"  onChange="UserCodeChange(this)" autocomplete="off" maxlength="6" v_minlength="6">
							<font class="orange">*</font>						
				    </td>
		    </tr>
		    
		    <!--wanglz 20141009-->
		  	<tr > 
			     <td class="blue" >
			     	是否销售G3产品
			     	<select name="is_ghtree">
			     			<option value=""></option>
								<option value='Y'>是</option>
								<option value='N'>否</option>
							</select>
			     	</td>
			     <td class="blue">
							G3销售平台角色类型
						<select name="g3roleCode" id="g3roleid" onchange="chgSelParterType()">
							<option value=""></option>
							<option value="01">代理商</option>
							<option value="02">零售商</option>
						</select>
				    </td>
			      <td class="blue">登录手机号码</td>
			      <td>
							<input name="gthree_phone" type="text"  id="gthree_phone"  v_type="string" >
							<font class="orange">*</font>						
				    </td>
		    </tr>	 
		    
		    
		    	<tr id="parter_row" style="display:none;">
		    		<td class="blue">
		    			供货商
		    		</td>	
		    			<td>
							<%
								String mysql = "select parter_id,parter_name from dpartermsg where parter_type='06' order by parter_id";
								outParaNums = "2";
							%>
							<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="<%=outParaNums%>">
								<wtc:sql><%=mysql%></wtc:sql>
								</wtc:pubselect>
							<wtc:array id="retList" scope="end" />
								<select name="parterid" id="parterid">
									<option></option>
									<%
									if(retList!=null&&retList.length>0){
									for(int kkk = 0 ;kkk<retList.length ;kkk++){
									%>
									<option value="<%=retList[kkk][0]%>"><%=retList[kkk][1]%></option>	
									<%}}%>
									
								</select>
		    		  </td>
		    		  <td></td><td></td>	
		    	</tr>
		    
		    
		       	<tr > 
		            <td class="blue">网点是否为公司现有其他实体渠道
		            </td>
		            <td colspan="3"> 
		              <select name="entryType" onChange="entryTypeChange()">
		                <option value=""></option>
		              	<option value="0">否</option>
		              	<option value="1">是</option>
		              </select><font class="orange"> *</font>
		            </td>
		         </tr>
		         
		         <tr style="display:none" id="entryId">
		            <td class="blue">具体对应网点
		            </td>
								<td colspan="3">
									<input type="hidden" name="Entity_groupId">
									<input type="text" name="Entity_groupName" value="" v_type="string" maxlength="60" size="40" class="InputGrey" readonly>&nbsp;<font class="orange">*</font>
									<input name="addButton" class="b_text" type="button" value="选择" onClick="select_groupId()" >
								</td>
		        </tr>
		       	        
		        
		        <tr> 
		            <td class="blue">备注
		            </td>
		            <td colspan="3"> 
		              <input name="opNote" type="text"  id="opNote" size="50" maxlength="60"  v_type="string" readOnly class="InputGrey">
		            </td>
		        </tr>
    		</tbody>
    	</table>
    	<table>
    		<tbody>
		        <tr> 
		            <td id="footer"> 		              
		                <input name="submit1" class="b_foot" type="button"  value="确认" onClick="commit()" >
		                &nbsp; 
		                <input name="reset" class="b_foot" type="button"  value="清除" onClick="resetJSP()">
		                &nbsp; 
		                <input name="back" class="b_foot" onClick="removeCurrentTab()" type="button"  value="返回">
		                &nbsp; 
		            </td>
		        </tr>
  	</table>
  	 <%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
</html>
