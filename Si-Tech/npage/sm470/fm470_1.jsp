<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------duming 2017.4.13------------------
 关于新固话产品账期调整情况及现存问题报备的函  融合通信暂停与恢复业务
 
 
 -------------------------后台人员：gudd--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

%> 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>

//重置刷新页面
function reSetThis(){
	  location = location;	
}

//
function tablehide(){
	$(".table tr:gt(0)").hide();
	}
	
function tableshow(){
	$(".table tr:gt(0)").show();
}


function doreturn(param){
	//alert(param);	
	$("#iccid").val(param[0]);//证件号码
	$("#unit_name").val(param[1]);//集团名称
	$("#unit_id").val(param[2]);//集团编码
	$("#id_no").val(param[3]);//产品编码
	$("#user_name").val(param[4]);//产品名称
	$("#account_id").val(param[5]);//产品账号
	if(param[6]=='A'){//业务状态
		$("#run_code").val("正常")
			$("#sel_opType option[value='r']").remove();
	
		}
	if(param[6]=='G'){
		$("#run_code").val("报停");
	
		$("#sel_opType option[value='p']").remove();
		}
	if(param[0]==''){
		rdShowMessageDialog("查询失败",0);
		reSetThis();
		}
	
		
	}


//
function go_Query(){
	
	if($("#unitid").val().trim()==""){
		rdShowMessageDialog("请输入集团编码");
		return;
	}
		var unitid = $("#unitid").val().trim();	
 	 var path = "<%=request.getContextPath()%>/npage/sm470/fm470_Qry.jsp?unitid="+unitid;
	  window.open(path);
}



function go_Cfm(){
		var id_no = $("#id_no").val().trim();
		var sel_opType = $("#sel_opType option:selected").val();
		var opr = "";	
		var run_code ="";
		if("p"==sel_opType){
			opr = "00";
			}
		if("r"==sel_opType){
			opr = "01";
			}
		if("p"==sel_opType){
		run_code = "G";
		}
		if("r"==sel_opType){
			run_code = "A";
		}       
		
	
		
		//alert(run_code);
	
		if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
		var pactket = new AJAXPacket("fm470_Cfm.jsp","正在操作，请稍候......");
 			
 			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("id_no",id_no);
			pactket.data.add("sel_opType",sel_opType);
			pactket.data.add("opr",opr);
			pactket.data.add("run_code",run_code);
			core.ajax.sendPacket(pactket,do_Cfm);
			pactket=null;
		

		
}

//回调
function do_Cfm(pactket){
	var code = pactket.data.findValueByName("code");
	var msg  = pactket.data.findValueByName("msg"); 
	var retArray  = pactket.data.findValueByName("retArray"); 

	
	if(code=="000000"){	
		rdShowMessageDialog("操作成功",2);
	}else{
		rdShowMessageDialog("失败，"+code+"："+msg,0);
	}
	
	reSetThis();
}



</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0" class="table">
	<tr>
	    <td class="blue" width="15%" >集团编码</td>
			<td colspan="3">
		  <input type="text" id="unitid" name="unitid" value="4510976840"/>
		  <input type="button" class="b_text" value="查询" onclick="go_Query()"/>
		  </td>
	</tr>

	<tr style="display:none">
	    <td class="blue">证件号码</td>
		  <td>
			    <input type="text" name="iccid" id="iccid" value=""   /> 
		  </td>
		  <td class="blue" >集团客户名称</td>
		  <td>
		  	 <input type="text" name="unit_name" id="unit_name"  value=""   /> 
		  </td>
	</tr>
	<tr style="display:none">
	    <td class="blue">集团ecid</td>
		  <td>
			    <input type="text" name="unit_id" id="unit_id" value=""   /> 
		  </td>
		  <td class="blue" >产品代码</td>
		  <td>
		  	 <input type="text" name="id_no" id="id_no" value=""   /> 
		  </td>
	</tr>
	<tr style="display:none">
	    <td class="blue">产品名称</td>
		  <td>
			    <input type="text" name="user_name" id="user_name" value=""   /> 
		  </td>
		  <td class="blue" >账户id</td>
		  <td>
		  	 <input type="text" name="account_id" id="account_id" value=""   /> 
		  </td>
	</tr>
	<tr style="display:none">
	    <td class="blue">业务状态</td>
		  <td>
			    <input type="text" name="run_code" id="run_code" value=""   /> 
		  </td>
		   <td class="blue">操作类型</td>
		  <td>
			    <select id="sel_opType" name="sel_opType" >
				    <option id="p" value="p">暂停</option>
				    <option id="r" value="r" >恢复</option>
				</select>
		  </td>
	</tr>

</table>



<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="修改" onclick="go_Cfm()"          />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  />
	 	</td>
	</tr>
</table>
</FORM>
</BODY>
</HTML>