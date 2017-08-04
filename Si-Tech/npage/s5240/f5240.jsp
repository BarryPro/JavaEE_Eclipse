   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5240";
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>

<%
	//读取用户session信息
	String region_code = (String)session.getAttribute("regCode");
	DateFormat df = new SimpleDateFormat("yyyyMMdd");
	Date d1=new Date();
	String sysdate=df.format(d1);
	
%>

<html>
<head>
<base target="_self">
<title>产品发布</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 
//选择地区代码
function queryRegionCode()
{
	
	if(document.form1.region_code.value!="")
	{
	    window.open("f5240_queryRegionCode.jsp","","height=600,width=400,scrollbars=yes");
	}
	else
	{
		rdShowMessageDialog("请先选择产品代码！",0);
		document.form1.mode_code.focus();
	}
}

//选择区县代码
function queryDistrictCode()
{
	
	if(document.form1.region_code.value=="")
	{
		rdShowMessageDialog("请先选择地市代码！",0);
		return false;
	}

    var region_code= document.form1.region_code.value;
	var retToField = "district_code|";
	var url = "f5240_queryDistrictCode.jsp?region_code="+region_code+"&retToField="+retToField;
	
	window.open(url,"","height=600,width=400,scrollbars=yes");
	
}


function queryModeType()
{
	if(!checkElement("region_code")) return ;
	if(!checkElement("sm_code")) return ;

    var retToField = "mode_type|mode_type_name|";
    var url = "f5238_queryModeType.jsp?clear_mode_use=1&region_code="+document.form1.region_code.value+"&smCodeCond="+document.form1.sm_code.value+"&retToField="+retToField;
	window.open(url,'','height=600,width=400,scrollbars=yes');
}






//选择品牌代码
function querySmCode()
{
	if(document.form1.region_code.value!="")
	{
	    var url = "f5240_querySmCode.jsp?region_code="+document.form1.region_code.value;
		window.open(url,'','height=600,width=400,scrollbars=yes');
	}
	else
	{
		rdShowMessageDialog("请先选择产品代码！",0);
		document.form1.mode_code.focus();
	}
}

//选择到期资费
function queryNextModeCode()
{

	  var url = "f5240_queryNextModeCode.jsp?region_code="+document.form1.region_code.value+"&nextModeCode="+document.form1.nextModeCode.value;
		window.open(url,'','height=600,width=600,scrollbars=yes');
}

//选择产品代码
function queryModeCode()
{
	var url = "f5240_queryModeCode.jsp?mode_code="+document.all.mode_code.value+"&login_accept="+document.all.login_accept.value;
	escape(url);
	window.open(url,"","height=600,width=600,scrollbars=yes");
}

//选择产品目录
function queryDirectId()
{
	var url = "productTree.jsp?productType=2"
	escape(url);
	window.open(url,"","height=600,width=400,scrollbars=yes");
}

//产品审核
function f5240_show()
{
	var url = "f5240_show.jsp?mode_code="+document.all.mode_code.value
	+"&login_accept="+document.all.login_accept.value
	+"&region_code="+document.all.region_code.value
	+"&sm_code="+document.all.sm_code.value
	+"&mode_name="+document.all.mode_name.value
	+"&begin_time="+document.all.mode_begin_time.value
	+"&end_time="+document.all.mode_end_time.value;
	escape(url);
	window.open(url,"","height=650,width=1000,scrollbars=yes");
}
//选择业务功能
function queryFuncCode()
{
	window.open("f5240_queryFuncCode.jsp","","height=600,width=400,scrollbars=yes");
}

/*--------- 提交 -------------*/
function submitRelease()
{
	getAfterPrompt();
	var myPacket = new AJAXPacket("f5240_release_rpc.jsp?note="+document.all.note.value,"正在提交信息，请稍候......");		
	myPacket.data.add("mode_code",document.all.mode_code.value);
	myPacket.data.add("group_id",document.all.group_id.value);
	myPacket.data.add("sm_code",document.all.sm_code.value);
	myPacket.data.add("direct_id",document.all.direct_id.value);
	myPacket.data.add("op_code",document.all.op_code.value);
	myPacket.data.add("before_ctrl_code",document.all.before_ctrl_code.value);
	myPacket.data.add("end_ctrl_code",document.all.end_ctrl_code.value);
	myPacket.data.add("begin_time",document.all.begin_time.value);
	myPacket.data.add("end_time",document.all.end_time.value);
	myPacket.data.add("power_right",document.all.power_right.value);
	myPacket.data.add("region_code",document.all.region_code.value);
	myPacket.data.add("cfg_login_accept",document.all.login_accept.value);
	myPacket.data.add("district_code",document.all.district_code.value);
	myPacket.data.add("markFlag",document.all.markFlag.value);
	myPacket.data.add("nextModeCode",document.all.nextModeCode.value);
	core.ajax.sendPacket(myPacket);
	myPacket = null;

}
//---------------------------获取rpc返回的用户信息--------------------------------
function doProcess(myPacket)
{
	var errCode    = myPacket.data.findValueByName("errCode");
	var retMessage = myPacket.data.findValueByName("errMsg");//声明返回的信息		
	var retFlag    = myPacket.data.findValueByName("retFlag");	
	self.status="";
	//操作成功
	if(retFlag=="submit")
	{
		if (errCode==000000)
		{
			
			rdShowMessageDialog("操作成功！",2);	
			self.status="操作成功！";
			window.location.reload();
		}
		else
		{
			rdShowMessageDialog("操作失败！错误代码"+errCode+"。错误信息"+retMessage,0);
		}
	}	
	
}

//查询资费控制代码
function queryCtrlCode(flag)
{
	//alert(flag);
	var region_code = document.all.group_id.value;
	window.open("f5240_qryBillCtrlCode.jsp?region_code=" + region_code + "&ctrlFlag=" + flag + "&clear_sm_code=1&clear_mode_use=1","","height=600,width=400,scrollbars=yes");
}	

</script>
</head>

<body>

      	  <form name="form1"  method="post">
      	  		  <input type="hidden" name="region_code" value="">
	  <input type="hidden" name="mode_begin_time" value="">
	  <input type="hidden" name="mode_end_time" value="">
	  	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">产品发布</div>
	</div>


				<table cellspacing="0" >
					<tr  height="22">
	  					<TD width="15%" class="blue">&nbsp;&nbsp;产品代码</TD>
	  					<TD width="35%">
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=8 v_name="产品代码"  name=mode_code maxlength=8 >
	  					</TD>
					    <TD width="15%" class="blue">
					    	&nbsp;&nbsp;配置流水</TD>
				        <TD width="35%">
				        	<input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=12 v_name="配置流水"  name=login_accept maxlength=12 >
				        	<input  type="button" name="query_mode"  value="查询" onclick="queryModeCode()" class="b_text">
				        </TD>
				    </tr>
					<tr  height="22">
					  <TD class="blue">&nbsp;&nbsp;产品名称</TD>
				      <TD width="15%"><input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=20 v_name="产品名称"  name=mode_name maxlength=20></TD>

				     <TD class="blue">&nbsp;&nbsp;当前状态</TD>
				      <TD width="35%"><input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=20 v_name="当前状态"  name=statusName maxlength=60 ></TD>
				   </tr>
					<tr  height="22">
					  <TD colspan="4"> &nbsp;&nbsp; <font class="orange">点击 － &gt; </font><input name="add_info" type="button"  class="b_text" value="配置信息" onClick="f5240_show()">
				       <font class="orange">对产品配置进行审核，审核通过后才可发布！ </font></TD>
				  </tr>
				</table>
	  			<TABLE  cellSpacing="0">
	  				<tr >
	  					<TD width="15%" class="blue">&nbsp;&nbsp;发布地区</TD>
	  					<TD width="85%">
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=10 v_name="发布地区群"  name=group_id maxlength=10 size="31" readonly  Class="InputGrey" >
	  					</TD>
	  				</tr>
					<tr >
	  					<TD width="15%" class="blue">&nbsp;&nbsp;发布区县</TD>
	  					<TD width="85%">
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=100 v_name="发布区县"  name=district_code maxlength=100 size="31" readonly  Class="InputGrey" >
							<input  type="button"  class="b_text" name="query_districtCode" onclick="queryDistrictCode()" value="选择"> 
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;品牌代码</TD>
	  					<TD>
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=2 v_name="品牌代码"  name=sm_code maxlength=10 size="8" readonly  Class="InputGrey" >
	  						<input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=20 v_name="品牌代码"  name=sm_name maxlength=20 readonly  Class="InputGrey" >
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;产品目录</TD>
  					 	 <TD>
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=8 v_name="产品目录"  name=direct_id maxlength=8 size="8" readonly   Class="InputGrey" ></input>
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="产品目录"  name=direct_name maxlength=20 readonly   Class="InputGrey" ></input>
                            <input  type="button" class="b_text"  name="query_regioncode"  value="选择" onClick="queryDirectId()">
						</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;到期资费</TD>
  					  	<TD>
	  						<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=8 v_name="到期资费"  name=nextModeCode maxlength=8  size="8"></input>
	  						<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=30 v_name="到期资费名称"  name=nextModeCodeName maxlength=30 readonly  Class="InputGrey" >

	  						<input  type="button" class="b_text"  name="query_nextModeCode" onclick="queryNextModeCode()" value="选择">
                            
						</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;业务范围</TD>
  					  	<TD>
	  						<input type=text  v_type="string"  v_must=1 v_minlength=4 v_maxlength=4 v_name="业务范围"  name=op_code maxlength=4 size="8"  ></input>
	  						<input type=text  v_type="string"  name=op_code_name></input>
                <input  type="button" class="b_text"  name="query_Funccode"  value="选择" onclick="queryFuncCode()">	            
						</TD>
	  				</tr>
	  				
	  				<tr  >
	  					<TD class="blue">&nbsp;&nbsp;前项控制</TD>
  					  	<TD>
  					  		<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=5 v_name="前项控制"  name=before_ctrl_code maxlength=5 size="8" value="" readonly  Class="InputGrey" >
  					  		<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=80 v_name="前项控制"  name=befCtrlCodeName maxlength=30 readonly  Class="InputGrey" ></input>
	  					  	<input  type="button" class="b_text"  name="query_befCtrlCode" onclick="queryCtrlCode('B')" value="选择">
  						</TD>
	  				</tr>
	  				<tr >
	  				  	<TD class="blue">&nbsp;&nbsp;后项控制 </TD>
  				      	<TD>
  				      		<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=5 v_name="后项控制"  name=end_ctrl_code maxlength=5 size="8" value="" readonly  Class="InputGrey" >
				      	    <input type=text  v_type="string"  v_must=0 v_minlength=5 v_maxlength=80 v_name="后向控制"  name=endCtrlCodeName maxlength=30 readonly  Class="InputGrey" ></input>
				      	    <input  type="button" class="b_text"  name="query_endCtrlCode" onclick="queryCtrlCode('E')" value="选择">							
				      	</TD>
  				  	</tr>
		         <tr >
	  					<TD class="blue">&nbsp;&nbsp;积分计算标志</TD>
  					  	<TD>
	  					<select name="markFlag" >
										<option value="Y" >Y->参与积分计算</option>
										<option value="N" >N->不参与积分计算</option>
						  </select>        
						</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;开始时间</TD>
	  					<TD>
	  						<input type=text  v_type="date" v_must=1 v_minlength=8 v_maxlength=8 v_name="开始时间" name=begin_time maxlength=8 value="<%=sysdate%>"></input>&nbsp; <font class="orange">形式YYYYMMDD<font>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;结束时间</TD>
	  					<TD>
	  						<input type=text  v_type="date" v_must=1 v_minlength=8 v_maxlength=8 v_name="结束时间" name=end_time maxlength=8 value="20500101"></input>&nbsp; <font class="orange">形式YYYYMMDD<font>
	  					</TD>
	  				</tr>
	  				<tr  style="display:none">
	  					<TD class="blue">&nbsp;&nbsp;权限代码</TD>
	  					<TD>
	  						<select name="power_right" v_name="权限代码">
	  						<%
								//获取权限代码
								String sqlStr1="";
 								sqlStr1 ="SELECT power_right,right_name FROM SPOWERVALUECODE";
 								%>
 								
 	 <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
 								
 								<%
 							//	retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
 								String[][] retListString1 = new String[][]{};
 								if(code.equals("000000")&&result_t.length>0)
 								retListString1 = result_t;
								for(int i=0;i < retListString1.length;i ++)
								{
							%>
    		          				<option value='<%=retListString1[i][0]%>'><%=retListString1[i][1]%></option>
							<%		
								}
							%>
	  						</select>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;描述信息</TD>
	  					<TD>
	  						<input type=text  v_type="string2" v_must=1 v_minlength=0 v_maxlength=100 v_name="产品描述" name=note maxlength=60 size="50"> <font class="orange">*</font></input>
	  					</TD>
	  				</tr>
	  			</table>
	          	<TABLE  cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="nextButton" type="button" class="b_foot" value="确定" onClick="submitRelease()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="reset"  class="b_foot" value="重置"  >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button"  class="b_foot"  value="关闭"  onClick="removeCurrentTab()">
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	 <%@ include file="/npage/include/footer.jsp" %>
	  </form>
 
</body>
</html>

