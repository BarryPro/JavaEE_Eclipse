<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 新区县操作统计报表(铁通)8559
   * 版本: 1.0
   * 日期: 2010/06/14
   * 作者: wangyua
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	request.setCharacterEncoding("GBK");%>
<%@ page import="org.apache.log4j.Logger"%>
<%
	String opCode="8559";
	String opName="新区县操作统计报表(铁通)";
	Logger logger = Logger.getLogger("f8559_upg.jsp");
	String work_no = (String)session.getAttribute("workNo");
	String rpt_right = (String)session.getAttribute("rptRight");
	String org_code = (String)session.getAttribute("orgCode");
    String sqlStr="";
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>新区县操作统计表(铁通)</TITLE>
</HEAD>
<body>
<!-------------------------------------------------------------------------------->
<%if(rpt_right.compareTo("7")>=0){%>
<script language="jscript">
	rdShowMessageDialog('您没有操作此报表的权限!');
	window.close();
</script>
<%}%>
<!-------------------------------------------------------------------------------->
<script language="JavaScript">
//----弹出一个新页面选择组织节点--- 增加
function select_groupId()
{
	var path = "<%=request.getContextPath()%>/npage/rpt/common/grouptreeTT.jsp";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
</script>
<SCRIPT language="JavaScript">
function doSubmit()
{
	getAfterPrompt()
  if(!check(form1))
  {
    return false;
  }
  
  if(document.form1.bGroupId.value>document.form1.eGroupId.value)
  {
    rdShowMessageDialog("开始组织节点比结束组织节大");
    return false;
  }
  /********************
  if(document.form1.begin_town.value>document.form1.end_town.value)
  {
    alert("开始营业厅比结束营业厅大");
    return false;
  }
  ********************/

  var begin_time=document.form1.begin_time.value;
  var end_time=document.form1.end_time.value;
  if(begin_time>end_time)
  {
    rdShowMessageDialog("开始时间比结束时间大");
    return false;
  }
  
  with(document.forms[0])
  {
    if(document.form1.rpt_type.value==1)
    {
      hTableName.value="rcd002";
      hParams1.value= "PRC_1630_TD195_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
    }
    else if(document.form1.rpt_type.value==2)
    {
      hTableName.value="rcd002";
      hParams1.value="PRC_1630_TD196_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
    }
    else if(document.form1.rpt_type.value==3)
    {
      hTableName.value="rcd002";
      hParams1.value="PRC_1630_TD197_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
    }
    else if(document.form1.rpt_type.value==4)
    	{
      hTableName.value="rcd002";
      hParams1.value= "PRC_1630_TD198_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
    }
    else if(document.form1.rpt_type.value==5)
    	{
      hTableName.value="rcd002";
			hParams1.value= "DBCUSTADM.PRC_8559_PD002_UPG('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";

    	document.form1.action="print_rpt_boss.jsp";
    }
        else if(document.form1.rpt_type.value==6)
    	{
      hTableName.value="rbd002";
      hParams1.value= "PRC_8558_OP002_UPG('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
    }
            else if(document.form1.rpt_type.value==7)
    	{
      hTableName.value="rcd002";
      hParams1.value= "PRC_8559_KH003_UPG('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
      document.form1.action="print_rpt_crm_report.jsp";
    }
                else if(document.form1.rpt_type.value==8)
    	{
      hTableName.value="rcd002";
      hParams1.value= "PRC_8559_302TD_upg('"+document.form1.workNo.value+"','"+document.form1.groupId.value+"','"+document.form1.bGroupId.value+"','"+document.form1.eGroupId.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
    }
		submit();
  }
  
}

</SCRIPT>

<FORM method=post name="form1" action="/npage/rpt/print_rpt.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">请选择操作报表</div>
	</div>
<table cellSpacing="0">
	<tr>
		<td class="blue">操作报表</td>
		<td colspan="3">
			<select name=rpt_type onChange="onChangeRptType()" style='width:400px'>
			
				  <option class='button' value=1>1->区县预存话费赠TD固话(铁通)统计报表</option>
			    <option class='button' value=2>2->区县预存话费赠TD商务固话统计报表(铁通)</option>
			    <option class='button' value=3>3->区县重新购TD商务固话，赠通信费(铁通)统计报表</option>
			    <option class='button' value=4>4->区县重新预存话费赠TD固话(铁通)统计报表</option>
			    <option class='button' value=5>5->区县交费操作(铁通)统计报表</option>
			    <option class='button' value=6>6->区县业务操作统计表(铁通)</option>
			    <option class='button' value=7>7->区县业务开户业务统计报表(铁通)</option>
			    <option class='button' value=8>8->区县购TD商务固话赠通信费统计报表(铁通)</option>
			</select>
		</td>
	</tr>
	
    <tr>
		<td class="blue">组织节点</td>
		<td colspan="3">
			<input type="hidden" name="groupId" >
			<input type="text" name="groupName" v_must="1" v_type="string" maxlength="60" readonly onpropertychange="tochange('change_group')">&nbsp;<font color="orange">*</font>
			<input name="addButton" class="b_text" type="button" value="选择" onClick="select_groupId()" >	
			<input name="refbutton" class="b_text" type="button" value="刷新" onClick= "tochange('change_group')" >	
		</td>
	</tr>
	<tr>
		<td class="blue">开始组织节点</td>
		<td>	
			<select name="bGroupId" style="width:420px;">
				<option class='button' value='0'> 未选定 </option>
			</select>
		</td>
		<td class="blue">结束组织节点</td>
		<td>
			<select name="eGroupId" style="width:420px;">
				<option class='button' value='0'> 未选定 </option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="blue">开始时间</td>
		<td>
			<input type="text" v_type="date"  name="begin_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
		<td class="blue">结束时间</td>
		<td>
			<input type="text" v_type="date"  name="end_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
	</tr>
	<tr id="phone_head" style="display:none">
		<td class="blue">开始号段</td>
		<td>
			<input type="text" class="button" name="begin_phonehead"  size="17" maxlength="7" >
		</td>
		<td class="blue">开始号段</td>
		<td>
			<input type="text" class="button" name="end_phonehead"  size="17" maxlength="7"  >
		</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4">
		&nbsp; <input id=submits class="b_foot" name=submits onclick="return(doSubmit())" type=button value=确认>
		&nbsp; <input class="b_foot" name=reee  type=button onClick="form1.reset()" value=清除>
		&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
		</td>
	</tr>
</table>
      <input type="hidden" name="workNo" value="<%=work_no%>">
      <input type="hidden" name="org_code" value="<%=org_code%>">
      <input type="hidden" name="hDbLogin" value ="dbchange">
      <input type="hidden" name="rptright" value="D">
      <input type="hidden" name="hParams1" value="">
      <input type="hidden" name="hTableName" value="">
	<%@ include file="/npage/include/footer.jsp" %> 

</FORM>
</BODY></HTML>
<script language="javascript">
/*----------------------------调用RPC处理连动问题------------------------------------------*/

 onload=function(){
	form1.reset();
		
	}
var change_flag = "";//定义RPC联动全局变量 查询区县:flag_dis  查询营业厅:flag_town 默认:""
function tochange(par){
	    if(par == "change_dis")//查询区县
			{   

				change_flag = "flag_dis";
				var region_code = document.all.region_code[document.all.region_code.selectedIndex].value.substring(0,2);
				var myPacket = new AJAXPacket("select_rpc.jsp","正在获得区县信息，请稍候......");
				//var sqlStr = "select region_code||district_code,district_code||'-- >'||district_name from sDisCode where region_code = '"+region_code+"' Order By district_code,district_name";

				var sqlStr = "90000067" ;
				var params = region_code+"|";
				var outNum = "2";		
				
				myPacket.data.add("sqlStr",sqlStr);
				myPacket.data.add("params",params);				
				myPacket.data.add("outNum",outNum);
				core.ajax.sendPacket(myPacket);
				myPacket=null
			}
		else if(par == "change_town")//查询营业厅
			{
				change_flag = "flag_town";
				var region_code = document.all.region_code[document.all.region_code.selectedIndex].value.substring(0,2);
				var district_code = document.all.district_code[document.all.district_code.selectedIndex].value.substring(2,4);
				var myPacket = new AJAXPacket("select_rpc.jsp","正在获得营业厅信息，请稍候......");
				//var sqlStr = "select region_code||district_code||town_code,town_code||'-- >'||TOWN_NAME from sTownCode where region_code = '"+region_code+"' and district_code = '"+district_code+"' Order By town_code";
				
				var sqlStr = "90000068" ;
				var params = region_code+"|"+district_code+"|";
				var outNum = "2";		
				
				myPacket.data.add("sqlStr",sqlStr);
				myPacket.data.add("params",params);				
				myPacket.data.add("outNum",outNum);
				core.ajax.sendPacket(myPacket);
				myPacket=null
			}
		else if(par == "change_group")//查询组织机构节点
			{
				change_flag = "flag_group";

				var group_id = document.all.groupId.value;
				var myPacket = new AJAXPacket("select_rpc.jsp","正在获得组织机构信息，请稍候......");
				//var sqlStr = "select a.group_id,a.group_id||'-- >'||group_name   from dChnGroupMsg a,dbresadm.dChnGroupInfo b  where a.group_id=b.group_id   and a.class_code='200'   and b.parent_group_id='"+group_id+"'   and b.denorm_level=1  Order By a.group_id";
				
				             
				var sqlStr = "90000069" ;
				var params = group_id+"|";
				var outNum = "2";		
				myPacket.data.add("sqlStr",sqlStr);
				myPacket.data.add("params",params);				
				myPacket.data.add("outNum",outNum);
				core.ajax.sendPacket(myPacket);
				myPacket=null
			}

}

/*-----------------------------RPC处理函数------------------------------------------------*/
  function doProcess(packet)
  {
	  var rpc_page=packet.data.findValueByName("rpc_page");
 
	    var triListdata = packet.data.findValueByName("tri_list"); 
    
    
  	    var triList=new Array(triListdata.length);
	if(change_flag == "flag_dis")
		{
			  triList[0]="district_code";
			  document.all("district_code").length=0;
			  document.all("district_code").options.length=triListdata.length;//triListdata[i].length;
			  for(j=0;j<triListdata.length;j++)
			  {
				document.all("district_code").options[j].text=triListdata[j][1];
				document.all("district_code").options[j].value=triListdata[j][0];
			  }//区县结果集
			  document.all("district_code").options[0].selected=true;
			  tochange("change_town");
		}
	else if(change_flag == "flag_town")
		{
			  triList[0]="begin_town";
			  document.all("begin_town").length=0;
			  document.all("begin_town").options.length=triListdata.length+1;//triListdata[i].length;
				document.all("begin_town").options[0].text='未选定';
				document.all("begin_town").options[0].value=document.all.district_code[document.all.district_code.selectedIndex].value.substring(0,4);
			  for(j=0;j<triListdata.length;j++)
			  {
				document.all("begin_town").options[j+1].text=triListdata[j][1];
				document.all("begin_town").options[j+1].value=triListdata[j][0];
			  }//开始营业厅结果集
			  document.all("end_town").length=0;
			  document.all("end_town").options.length=triListdata.length+1;//triListdata[i].length;
				document.all("end_town").options[0].text='未选定';
				document.all("end_town").options[0].value=document.all.district_code[document.all.district_code.selectedIndex].value.substring(0,4);
			  for(j=triListdata.length-1;j>=0;j--)
			  {
			  	k=triListdata.length-1-j;
				document.all("end_town").options[k+1].text=triListdata[j][1];
				document.all("end_town").options[k+1].value=triListdata[j][0];
			  }//结束营业厅结果集
		}
	else if(change_flag == "flag_group")
		{
			  triList[0]="bGroupId";
			  document.all("bGroupId").length=0;
			  document.all("bGroupId").options.length=triListdata.length+1;//triListdata[i].length;
				document.all("bGroupId").options[0].text='未选定';
				document.all("bGroupId").options[0].value='0';
			  for(j=0;j<triListdata.length;j++)
			  {
				document.all("bGroupId").options[j+1].text=triListdata[j][1];
				document.all("bGroupId").options[j+1].value=triListdata[j][0];
			  }//开始组织节点结果集
			  document.all("eGroupId").length=0;
			  document.all("eGroupId").options.length=triListdata.length+1;//triListdata[i].length;
				document.all("eGroupId").options[0].text='未选定';
				document.all("eGroupId").options[0].value='0';
			  for(j=triListdata.length-1;j>=0;j--)
			  {
			  	k=triListdata.length-1-j;
				document.all("eGroupId").options[k+1].text=triListdata[j][1];
				document.all("eGroupId").options[k+1].value=triListdata[j][0];
			  }//结束组织节点结果集
		}
//////////////////////////////////////////////////////////////////////////////////////////
		
	  
   }

 function onChangeRptType()
{
	
	if(document.form1.rpt_type.value==71||document.form1.rpt_type.value==73)
	{
		document.all.phone_head.style.display="block";
	}
	else
	{
		document.all.phone_head.style.display="none";
	}
}	
  
</script>
