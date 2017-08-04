<%
   /*
   * 功能: 参数集明细配置
　 * 版本: v1.0
　 * 日期: 2008/04/21
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期:2009/05/14      修改人:leimd      修改目的:适应新需求
 　*/
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%
	String opCode = "2985";
	String opName = "参数集明细配置";
	String loginNo = (String)session.getAttribute("workNo");
	String nopass  = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
     
    String param_set   = request.getParameter("param_set");
	String  set_name    = request.getParameter("set_name");
     
    String [] check = request.getParameterValues("check");    
    String [] vParamCodeIn   = {""};     
	String [] vParamNameIn      = {""};   

    if(check!=null)
    { 		
		String [] vParamCode   = request.getParameterValues("ParamCode");
		String [] vParamName       = request.getParameterValues("ParamName");
		
		vParamCodeIn         = new String [check.length];	
		vParamNameIn         = new String [check.length];	
		
		for(int i=0;i<check.length;i++)
		{
			vParamCodeIn[i]    =vParamCode[new Integer(check[i]).intValue()];
			vParamNameIn[i]    =vParamName[new Integer(check[i]).intValue()];
		}
	}
	 
 	for( int m=0;m<check.length;m++)
	{
	   System.out.println("vParamCodeIn[0]="+vParamCodeIn[m]);
	   System.out.println("vParamNameIn[0]="+vParamNameIn[m]);
	}  
	
	 int len=0;
	 String sqlStr = "select Param_Group,Group_Name from sBizParamGroup";
%>  
<wtc:pubselect name="sPubSelect" outnum="2" retcode="retCode" retmsg="retMesg" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:sql><%=sqlStr%> </wtc:sql>
</wtc:pubselect>

<wtc:array id="rows" scope="end"/>
<%			
	if(retCode.equals("000000"))
	{	
	        System.out.println("rows.length="+rows.length);
             for( int n=0;n<rows.length;n++){
	             System.out.println("rows["+n+"][0]"+rows[n][0]);
	             System.out.println("rows["+n+"][1]"+rows[n][1]);
            }	
        len=rows.length;
      }
	else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("查询业务参数分组表出错！!",0);
			document.location.replace("<%=request.getContextPath()%>/npage/s2985/f2985.jsp");
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
function doProcess(packet) {	
	  self.status="";	

	 var qryType=packet.data.findValueByName("rpcType");
	 var errCode=packet.data.findValueByName("errCode");
	 var errMsg=packet.data.findValueByName("errMsg");
	
 if(qryType == "checkParamSet"){	 
	 if(errCode == "000000")
	    {
		  rdShowMessageDialog("返回信息："+errMsg + "<br>返回代码："+errCode,1);
		  document.form1.AddBtn.disabled=false; 
		  document.form1.allSelectt.disabled=false;
		  document.form1.noSelectt.disabled=false;
	   }else
	   	   {		   	   	
	   	   rdShowMessageDialog("错误信息："+errMsg + "<br>错误代码："+errCode, 0);
	        }
      }	
}	  
//校验参数代码
function checkParamSet()
{
	if(document.form1.param_set.value=="")
	{
		rdShowMessageDialog("请输入参数集代码！");
		document.form1.param_set.focus();
		return false;
	}
	var myPacket = new AJAXPacket("fcheckParamSet_rpc.jsp","正在提交，请稍候......"); 
	myPacket.data.add("param_set",document.form1.param_set.value);
	myPacket.data.add("rpcType","checkParamSet");
	core.ajax.sendPacket(myPacket);
	myPacket=null;	
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
	}
}
//提交
function Submit(){
	  if(document.all.check==undefined)
		{
			rdShowMessageDialog("没选任何参数代码！");
			return;
		}
       if(rdShowConfirmDialog('确认提交参数集配置')==1)
	   {
		  document.form1.action="f5630Cfm.jsp"; 
		  document.form1.submit();
	   }
}	

//页面删除行
function dynDelRow(){			 		        			
		 var args=dynDelRow.arguments[0];
		 var objTD =args.parentElement;
		 var objTR =objTD.parentElement;
		 var currRowIndex = objTR.rowIndex;
		 tbs1.deleteRow(currRowIndex);	   
 }
 
 //调用公共界面，进行目标平台选择
function getBizTarget(num)
{ 
    var pageTitle = "业务参数选择";
    var fieldName = "参数代码|参数名称|";
    var sqlStr = "";
    var selType = "M";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "target_code"+num+"|target_name"+num+"|";

    if(PubSimpSelBizTarget(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,num));
}

function PubSimpSelBizTarget(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,num)
{
  var path = "<%=request.getContextPath()%>/npage/s2985/fqueryBizTarget.jsp";
  path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
  path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
  path = path + "&selType=" + selType + "&retToField=" + retToField+ "&num=" +num;
     retInfo = window.open(path,"newwindow2","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
   return true;
}
//

//var n=0;
function getValueBizTarget(retInfo,num)
{
    var retToField = "target_code_array"+num+"|target_name_array"+num+"|";
    if(retInfo ==undefined)      
    {   return false;   }
    
    var target_code_array="";
    var target_name_array="";
    var flag=0;
    var chPos_retInfo = retInfo.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_retInfo > -1)
    {
        valueStr = retInfo.substring(0,chPos_retInfo);
        if(flag==0)
        {
        	target_code_array =target_code_array+ valueStr+"|";
            flag=1;
        }
        else if(flag==1)
        {
          target_name_array =target_name_array+ valueStr+"|";
        	flag=0;       	        	
        }
        else
        {
        	rdShowMessageDialog("查询传送平台返回参数错误!",0);
        	return false;
        }
      
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_retInfo = retInfo.indexOf("|");       
    }    
     var chPos_field = retToField.indexOf("|");
     var obj;
     obj = retToField.substring(0,chPos_field);
     //alert(obj);
     document.all(obj).value = target_code_array;
     retToField = retToField.substring(chPos_field + 1);
     chPos_field = retToField.indexOf("|");   
     obj = retToField.substring(0,chPos_field);
     document.all(obj).value = target_name_array; 
     //document.all.num.value = n;        
     //document.form1.target_code_array.value=target_code_array;
     //document.form1.target_name_array.value=target_name_array;
     //document.form1.subBtn.disabled=false;
}
</script>
</head>
<body>
<FORM method="post" action="" name="form1"> 
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="loginPass" value="<%=nopass%>">
<input type="hidden" name="opNote" value="<%=loginNo%>进行参数集明细配置">
<input type="hidden" name="loginAccept" value="0">   
<input type="hidden" name="num" value="<%=check.length%>">	  

<div class="title">
	<div id="title_zi">参数集明细配置</div>
</div>
<table cellspacing="0">
	<tr>
		<TD class="blue">参数集代码 </TD>
		<TD>	
			<input type=text v_type="string" class="button" v_must=1 v_minlength=8  v_maxlength=8 v_name="参数集代码"  name=param_set value="<%=param_set%>" maxlength=8  readonly></input>
			<font color="orange">*</font>
			<input type="button" class="b_text"  name="check"  onClick="checkParamSet()"  value="校验" disabled >                   	              
		</TD>
		<TD class="blue">参数集名称 </TD>
		<TD>
			<input type=text v_type="string"  class="button" v_must=1 v_minlength=8  v_maxlength=30 v_name="参数集名称"  name=set_name value="<%=set_name%>"  maxlength=30 readonly ></input>
		</TD>	                
	</TR>
</table>

</div>
<div id="Operation_Table" >
	<div class="title">
		<div id="title_zi">参数集明细 </div>
</div>					
<TABLE id="tbs1" style=display="" cellspacing="0">
	<tr align="center">	
		<th>参数代码</th>
		<th>参数名称</th>
		<th>参数顺序</th>
		<th>缺省值</th>
		<th>是否可空</th>
		<th>显示类型</th>
		<th>是否只读</th>
		<th>是否传数组</th>
		<th>是否可修改</th>	
		<th>操作</th>		
	</tr>
		<%
	  for( int j = 0;j < check.length; j++)
		{   
        %>
	       <TR align="center">
			   <TD class="blue">	
				     <%=vParamCodeIn[j] %>
				  	<input type ="hidden" name="param_code" value=<%=vParamCodeIn[j] %>   >     
	           </TD>
			   <TD class="blue">
			      <%=vParamNameIn[j] %>   
			      <input type ="hidden" name="param_name" value=<%=vParamNameIn[j] %>>     
			</TD>
			<TD class="blue">
			       <input type ="text" name="param_order" value=""  size=5  length=2   maxlength=3   v_type="int">     
			</TD>
			<TD class="blue">
			      <input type ="text" name="default_value" value=""  size=6>     
			</TD>
			 <TD class="blue">
			      <select name="Null_Able">
					<option value="Y">可以 </option>	
				     <option value= "N" >不可以 </option>
				</select>
			</TD>
			<TD class="blue">
			      <select name="Des_Able">
					<option value="Y">显示 </option>	
				     <option value= "N" >不显示 </option>
				</select>
			</TD>
			 <TD class="blue">
			      <select name="Read_Only">
			      	<option value= "N" >可编辑 </option>
					<option value="Y">只读 </option>	
				</select>
			</TD>
			
			<TD class="blue">
				  
			      <select name="open_param_flag" >
						<option value="Y">是 </option>	
						<option value= "N">否 </option>
				 </select>
			</TD>	
			
		    <TD class="blue">
			     <select name="update_flag">
			      <option value="Y">是 </option>
			      <option value="N">否 </option>	
				 </select>
				 <input type="hidden" name="Multi_Able"   value="N" readonly><!---是否组数据--->
				<input type="hidden" name="Param_Group"  value="" readonly><!---参数分组--->
	          
		  </TD>
		  	
			<td class="blue" style="display:none">
			    <input type="hidden" name="target_code_array<%=j%>" value="PADC" readonly>
			    <input type="hidden" name="target_name_array<%=j%>" value="ADC平台">
			  <!-- <input type="button" name="checkFatherBtn<%=j%>" value="查询" onclick="getBizTarget(<%=j%>)" >
			--></td>
		  <TD >
		     <input type="button" class="b_text"  name="delButton<%=j%>" onClick="dynDelRow(this)" value="删除"  >  
		 </TD>							         		                
		  </TR>					
	        <%
			}
	        %>
</TABLE> 

	<TABLE align="center" cellSpacing="0">
	   <TR>
			<TD height="30" align="center">
				<input name="backBtn"  class="b_foot" type="button" value="上一步" onClick="history.go(-1);">
				&nbsp;
				<input name="AddBtn"   class="b_foot" type="button" value="提交"  onClick="Submit()"  >
				&nbsp;
				<input name="closeBtn"  class="b_foot" type="button" value="关闭"  onClick="removeCurrentTab();">
				&nbsp;
			</TD>
	     </TR>
	</TABLE>
	        	
	       <%@ include file="/npage/include/footer.jsp" %>
	    </form>
	 </body>
	</html>
		   