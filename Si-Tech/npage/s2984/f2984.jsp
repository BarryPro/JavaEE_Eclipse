 <%
   /*
   * 功能: 参数代码配置
　 * 版本: v1.0
　 * 日期: 2008/04/21
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   	2009/11/11	   niuhr	   集团配置功能改造
 　*/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%
    //==============================获取营业员信息
	String opCode = "2984";
	String opName = "参数集明细配置";
	String regionCode=(String)session.getAttribute("regCode");
	int len=0;
	String sqlStr = "select param_type,type_name from sBizParamType order by param_type";

    String nopass = WtcUtil.repNull((String)session.getAttribute("password"));
    String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));   
    String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String strDate=new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());

	String srvname = "sPubSelect";	 
%> 

 
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:sql><%=sqlStr%> </wtc:sql>
</wtc:pubselect>
<wtc:array id="rows" scope="end"/>
<%			
	if(retCode.equals("000000"))
	{	
	    //System.out.println("rows.length="+rows.length);
		for(int i=0;i<rows.length;i++)
		{
             //System.out.println("rows["+i+"][0]"+rows[i][0]);
             //System.out.println("rows["+i+"][1]"+rows[i][1]);
		}	
        len=rows.length;
	}
	else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("查询参数类型信息出错！!",0);
			removeCurrentTab();
		</script>
<%
	}		
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<script language=javascript>   

	onload=function() {
		self.status="";
	 	core.ajax.onreceive = doProcess;
	}
	
//处理rpc返回结果
function doProcess(packet) 
{	
	 self.status="";	

	 var qryType=packet.data.findValueByName("rpcType");
	 var errCode=packet.data.findValueByName("errCode");
	 var errMsg=packet.data.findValueByName("errMsg");
	
	if(qryType == "checkParamCode")
	{	 
		if(errCode == "000000")
		{
			  rdShowMessageDialog("校验成功！",2);
			  document.form1.check.disabled=true; 
			  document.form1.param_type.disabled=false; 
			  document.form1.addButt.disabled=false;
			  document.form1.AddBtn.disabled=false;
			  document.form1.param_code.readOnly=true;
		}
		else{		   	   	
			rdShowMessageDialog("错误信息："+errMsg + "<br>错误代码："+errCode, 0);
		}
	}	
}	  
	//校验参数代码
function checkParamCode()
{
		if(document.form1.param_code.value=="")
		{
			rdShowMessageDialog("请输入参数代码！");
			document.form1.param_code.focus();
			return false;
		}
		var myPacket = new AJAXPacket("fcheckParamCode_rpc.jsp","正在提交，请稍候......"); 
		myPacket.data.add("param_code",document.form1.param_code.value);
		myPacket.data.add("rpcType","checkParamCode");
		core.ajax.sendPacket(myPacket);
		myPacket = null;	
} 
//选择不同参数类类型
function showTab(){
	if(document.form1.param_type.value=="10"){
		tabSelect.style.display="";
		tabSql.style.display="none";
	}
	else if(document.form1.param_type.value=="20"){
		tabSelect.style.display="none";
		tabSql.style.display="";
	}else{
		tabSelect.style.display="none";
		tabSql.style.display="none";
	}
}
//提交
function addParam(){
	if(document.all.param_name.value=="")
	{
		rdShowMessageDialog("请输入参数名称！");
		document.all.set_name.focus();
		return false;
	}
		if(rdShowConfirmDialog('确认提交参数代码配置')==1)
		{
		  document.form1.action="f5629_2.jsp"; 
		  document.form1.submit();
	   }
}

var  n=1;
//增加一行
function addConfig()
{
	n++;
	var newRow = document.all.tabSelect.insertRow();
	newRow.insertCell().innerHTML = '<TD class="blue">配置项代码'+n +'</TD>';
	newRow.insertCell().innerHTML = '<TD ><input type="text" name="config_code'+n+'" v_type="string"  maxlength=8 value=""> </TD';
	newRow.insertCell().innerHTML = '<TD class="blue">配置项名称'+n +'</TD>';
	newRow.insertCell().innerHTML = '<TD ><input type="text" name="config_name'+n+'" v_type="string"  maxlength=8 value=""> </TD';
	newRow.insertCell().innerHTML = '<TD class="blue">配置项顺序</TD>';
	newRow.insertCell().innerHTML = '<TD ><input type="text" name="config_order'+n+'" v_type="string"  maxlength=8 value=""> </TD';	
	document.all.delButt.disabled = false;
	document.all.delButt.style.cursor = "hand";
	document.all.num.value = n;	
}

//减少一行
function delConfig()
{
	var newTable = document.getElementById("tabSelect");
	
	if (newTable.rows.length > 2)
	{
		newTable.deleteRow(newTable.rows.length-1);
		n--;
		document.all.num.value = n;
	}
	
	if (newTable.rows.length == 2)
	{
		document.all.delButt.disabled = true;
		document.all.delButt.style.cursor = "";
	}		
}
</script>

</head>
<body>
<FORM METHOD=POST ACTION="" name="form1"> 
<%@ include file="/npage/include/header.jsp" %> 
<input type="hidden" name="workNo" value="<%=loginNo%>">
<input type="hidden" name="loginPass" value="<%=nopass%>">
<input type="hidden" name="ipAddr" value="<%=ip_Addr%>">
<input type="hidden" name="opNote" value="<%=loginNo%>进行参数代码配置">
<input type="hidden" name="loginAccept" value="0">   
<input type="hidden" name="num" value="1">
<div class="title">
	<div id="title_zi">参数集明细配置</div>
</div>	  

	<table cellspacing="0" >
		<tr>
			<TD class="blue">参数代码 </TD>
			<TD>	
				<input type=text v_type="string" class="button" v_must=1 v_minlength=5  v_maxlength=5 v_name="参数代码" name=param_code value="" maxlength=5 ></input>
				<font color="orange">*</font>
				<input type="button" class="b_text"  name="check"  onClick="checkParamCode()"  value="校验"  >                	              
			</TD>
			<TD class="blue">参数名称 </TD>
			<TD>
				<input type=text v_type="string" class="button" v_must=1 v_minlength=8  v_maxlength=30 v_name="参数名称"  name=param_name value="" maxlength=30  ></input>
				<font color="orange">*</font>
			</TD>	                
		</tr>	
		<tr>
			<TD class="blue">参数类型 </TD>
			<td>	
				<select name="param_type"  onClick="showTab()" disabled>
					<option value="">---请选择---</option>
    	             	<% for(int i = 0; i < len; i++){%>
    	               	 	<option value="<%=rows[i][0].trim()%>"><%=rows[i][0].trim()%>&nbsp;-&gt&nbsp;<%=rows[i][1].trim()%></option>
						<%}%>
				</select>
				<font color="orange">*</font>
			</td>
			<td class='blue'>参数长度</td>				
			<td >
					<input type="text" name="param_length" v_type="string"  maxlength=8 value="">
					<font color="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class='blue'>参数备注</td>				
			<td colspan=3>
					<input type="text" name="param_note" v_type="string"  maxlength=256 value="" size=50>
					<Font color="orange">*</font>
			</td>
		</tr>
	</table>
				
	<TABLE id="tabSelect" style="display:none" cellSpacing=0 >						
			<TR> 
					<TD colspan="4"><strong><font color="green">请输入以下配置项信息:</font></strong></TD>	 
					<TD width=15%>				
						<input type="button" name="addButt" class="b_text" value="增加配置项" disabled onClick="addConfig()" <% if(len <= 1){out.println("disabled"); out.println("style='cursor:\"\";'");} else {out.println("style='cursor:hand;'");} %>>
					</TD>	
					<TD width=15%>			
						<input type="button" name="delButt" class="b_text" value="删除配置项" onClick="delConfig()" disabled>
					</TD>	                   	              
        	</TR>   
     	    <tr>
     	       	 <td class='blue'>配置项代码1</td>
				 <td align="left" >
				     <input type="text" name="config_code1" v_type="string"  maxlength=8 value="">	    
				 </td>
				 <td class='blue'>配置项名称1</td>
				 <td align="left" >
					  <input  type="text" name="config_name1"  v_type="string"  maxlength=8 value=""  >
				 </td>
				 <td class='blue'>配置项顺序</td>
				 <td align="left" >
					   <input  type="text" name="config_order1"  v_type="string"  maxlength=8  value=""  >      	    
				 </td>
			
	</TABLE>
            
	<TABLE  id="tabSql"  style="display:none"  cellSpacing=0 >
     	    <TR> 
					<TD colspan="5"><strong><font color="green">请输入以下配置项信息:</font></strong></TD>	                    	              
        	</TR>
     	    <tr>
     	       	<td class='blue'>配置项代码</td>
				<td>
				     <input type="text" name="config_code" v_type="string"  maxlength=8 value="">	    
				</td>
				<td class='blue'>配置项名称</td>
				<td>
					  <input  type="text" name="config_name"  v_type="string"  maxlength=8 value=""  >
				</td>
			</tr>
			<TR>
					<td class='blue'>SQL语句</td>
	         		<TD colspan=3>	        
	         	    	<input type="text"  name="config_sql"  v_type="string"  maxlength=255  size=80 value="" >
			 		</TD>
			</TR>
	</TABLE>
	
	<TABLE cellSpacing="0" >
		<TR id='footer'>
			<TD id="footer" align="center">				
				<input name="AddBtn" type="button" class="b_foot" value="提交"   onClick="addParam();"  disabled>
				<input name="closeBtn"  type="button" class="b_foot" value="关闭"   onClick="removeCurrentTab();">
			</TD>
		</TR>
	</table>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
		