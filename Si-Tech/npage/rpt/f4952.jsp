<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 银行代收移动话费全省汇总表4952
   * 版本: 1.0
   * 日期: 2009/07/29
   * 作者: zhenghan
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page import="com.sitech.boss.RoleManage.ejb.*"%>
<%@ page import="java.util.ArrayList"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>


<%
	String opCode="2145";
	String opName="银行代收移动话费全省汇总表";
	Logger logger = Logger.getLogger("f4952.jsp");
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String rpt_right= (String)session.getAttribute("rptRight");
	String regionCode=(String)session.getAttribute("regCode");
//	System.out.println("rpt_right============="+rpt_right);

	String sqlStr="";
	int recordNum=0;
	int i=0;

	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());


	//ArrayList retArray = new ArrayList();
	String region="";
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	S1100View callView = new S1100View();
%>

<script language=JavaScript>
//----弹出一个新页面选择组织节点--- 增加
function select_groupId()
{
	var path = "<%=request.getContextPath()%>/npage/rpt/common/grouptree.jsp";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>新营业员操作明细表</TITLE>
</HEAD>
<body>

<SCRIPT language="JavaScript">

function doSubmit()
{

  if(document.form1.all("begin_time").value.length == 8)
      document.form1.begin_time.value=document.form1.begin_time.value+" 00:00:00";
  if(document.form1.all("end_time").value.length == 8)
      document.form1.end_time.value=document.form1.end_time.value+" 23:59:59";

  if(!check(form1))
  {
    return false;
  }

  var begin_time=document.form1.begin_time.value;
  var end_time=document.form1.end_time.value;
  if(begin_time>end_time)
  {
    rdShowMessageDialog("开始时间比结束时间大");
    return false;
  }
  with(document.forms[0])
  {
      hTableName.value="t1788rpt";
	  	hParams1.value= "prc_4952_01('"+document.form1.workNo.value+"','"+document.form1.region_code.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
      submit();
  }
}

</SCRIPT>
<FORM method=post name="form1" action="/npage/rpt/print_rpt_crm_report.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">请选择条件</div>
	</div>
<table cellSpacing="0">
    <tr >
		<td class="blue" >地区</td>
		<td colspan="3">
<select id=region_code name=region_code onChange="tochange()">
<option class='button' value='xxx'>xx-- >全省</option>
<%                  try
                    {
                      if(rpt_right.compareTo("2")<0)
                      {
                        sqlStr ="select region_code,region_code||'-- >'||nvl(region_name,region_code),' ',' ' from sRegionCode where region_code<>'00' and use_flag='Y' Order By region_code";
                      }
                      else
                      {
                        //当不是省级工号时，就只要提取一次数据
                        sqlStr ="select a.region_code,a.region_name,b.region_code||district_code,district_code||'-- >'||nvl(district_name,district_code) from sRegionCode a,sDisCode b where a.region_code=b.region_code and b.region_code='"+org_code.substring(0,2)+"' Order By district_code";
                      }
                      retArray = callView.view_spubqry32("4",sqlStr);
                      result = (String[][])retArray.get(0);
                      recordNum = result.length;
                      region=result[0][0];
                      if(rpt_right.compareTo("2")<0)
                      {
                        for(i=0;i<recordNum;i++)
                        {
                          out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                        }
                      }
                      else
                      {
                        out.println("<option class='button' value='" + result[0][0] + "'>" + result[0][1] + "</option>");
                      }
                    }catch(Exception e)
                    {
                      logger.error("Call sunView is Failed!");
                    }
%>
                    </select>
		</td>
	</tr>
	<tr>
		<td class="blue">开始时间</td>
		<td>
			<input type="text"    name="begin_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
		<td class="blue">结束时间</td>
		<td>
			<input type="text"    name="end_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
	</tr>

	<tr>
		<td colspan="4" align="center" id="footer">
		&nbsp; <input id=submits class="b_foot" name=submits onclick="return(doSubmit())" type=button value=确认>
		&nbsp; <input class="b_foot" name=reee  type=button onClick="form1.reset()" value=清除>
		&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
		</td>
	</tr>
</table>
	<input type="hidden" name="rpt_code" value="0">
	<input type="hidden" name="rpt_code1" value="1">
	<input type="hidden" name="rpt_right" value="<%=rpt_right.trim()%>">
	<input type="hidden" name="workNo" value="<%=work_no%>">
	<input type="hidden" name="org_code" value="<%=org_code%>">
	<input type="hidden" name="hDbLogin" value ="dbchange">
	<input type="hidden" name="hParams1" value="">
	<input type="hidden" name="op_code" value="1610">
	<input type="hidden" name="login_accept" value="">
	<input type="hidden" name="hTableName" value="">

	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

<script language="javascript">
/*----------------------------调用RPC处理连动问题------------------------------------------*/


 onload=function(){
	form1.reset();
	}
var change_flag = "";					//定义RPC联动全局变量 查询区县:flag_dis  查询营业厅:flag_town 默认:""
function tochange(par)
{
	if(par == "change_dis")//查询区县
			{
				change_flag = "flag_dis";
				var region_code = document.all.region_code[document.all.region_code.selectedIndex].value.substring(0,2);
				var myPacket = new AJAXPacket("select_rpc.jsp","正在获得区县信息，请稍候......");
				var sqlStr = "select region_code||district_code,district_code||'-- >'||district_name from sDisCode where region_code = '"+region_code+"' Order By district_code";
			}

		else if(par == "change_town")//查询营业厅
			{
				change_flag = "flag_town";
				var region_code = document.all.region_code[document.all.region_code.selectedIndex].value.substring(0,2);
				var district_code = document.all.district_code[document.all.district_code.selectedIndex].value.substring(2,4);
				var myPacket = new AJAXPacket("select_rpc.jsp","正在获得营业厅信息，请稍候......");
				var sqlStr = "select region_code||district_code||town_code,town_code||'-- >'||TOWN_NAME from sTownCode where region_code = '"+region_code+"' and district_code = '"+district_code+"' Order By town_code";
			}
		else if(par == "change_workno")//查询营员
			{
				change_flag = "flag_workno";
				var town_code = document.all.town_code[document.all.town_code.selectedIndex].value.substring(0,7);
				var myPacket = new AJAXPacket("select_rpc.jsp","正在获得工号信息，请稍候......");
				var sqlStr = "select login_no,login_no||'-- >'||nvl(login_name,login_no) from dLoginMsg where org_code like '"+town_code+"%' Order By login_no";
			}
		else if(par == "change_rpt")//报表
			{
				change_flag = "flag_rpt";
				var sqlStr ="";
				var rpt_type = document.all.rpt_type[document.all.rpt_type.selectedIndex].value.substring(0,2);
				var myPacket = new AJAXPacket("select_rpc.jsp","正在获得操作信息，请稍候......");

				if(rpt_type == "1" || rpt_type == "2" || rpt_type == "3"  || rpt_type == "8" || rpt_type == "12" ||rpt_type == "13")
					sqlStr = "select a.function_code,a.function_code||'-->'||a.function_name from sFuncCode a,sFuncCodeRpt b where a.function_code = b.function_code and b.rpt_type = '"+rpt_type+"' order by a.function_code";
				else if(rpt_type == "4")
					sqlStr = "select store_type,store_type||'-->'||store_name from sStoreType";
				else if(rpt_type == "5")
					sqlStr = "select distinct function_code,function_code||'-->'||function_name from sFuncList";
				else if(rpt_type == "7")
					sqlStr = "select function_code,function_code||'-->'||function_name from sFuncCode where function_code like 'a%' and main_code <> '0' order by function_code";
				else if(rpt_type == "9")
					sqlStr = "select distinct a.mach_code,a.mach_code||'-->'||b.machine_name from dPackRes a,sMachCode b where a.region_code=b.region_code and a.mach_code=b.machine_code";
				else if(rpt_type == "10")
					sqlStr = "select function_code,function_code||'-->'||function_name from sFuncCode where main_code <> '0'  order by function_code";
				else if(rpt_type == "28")
					sqlStr = "select 1 from dual where 1=2";
				else
					sqlStr = "select function_code,function_code||'-->'||function_name from sFuncCode where main_code <> '0'  order by function_code";

			}
		myPacket.data.add("sqlStr",sqlStr);
		core.ajax.sendPacket(myPacket);
		delete(myPacket);
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
			  triList[0]="town_code";
			  document.all("town_code").length=0;
			  document.all("town_code").options.length=triListdata.length;//triListdata[i].length;
			  for(j=0;j<triListdata.length;j++)
			  {
				document.all("town_code").options[j].text=triListdata[j][1];
				document.all("town_code").options[j].value=triListdata[j][0];
			  }//营业厅结果集
			  document.all("town_code").options[0].selected=true;
			  tochange("change_workno");
		}
	else if(change_flag == "flag_workno")
		{
			  triList[0]="login_no";
			  document.all("login_no").length=0;
			  document.all("login_no").options.length=triListdata.length;//triListdata[i].length;
			  for(j=0;j<triListdata.length;j++)
			  {
				document.all("login_no").options[j].text=triListdata[j][1];
				document.all("login_no").options[j].value=triListdata[j][0];
			  }//工号结果集

		}
	else if(change_flag == "flag_rpt")
		{
			  triList[0]="function_code";
			  document.all("function_code").length=0;
			document.all("function_code").options.length=triListdata.length+1;//triListdata[i].length;
			document.all("function_code").options[0].text="ZZZZ -->全部操作";
			document.all("function_code").options[0].value="ZZZZ";
			//alert(triListdata.length);
			  for(j=0;j<triListdata.length;j++)
			  {
				document.all("function_code").options[j+1].text=triListdata[j][1];
				document.all("function_code").options[j+1].value=triListdata[j][0];
		  	   }//工号结果集

		}
//////////////////////////////////////////////////////////////////////////////////////////


   }

function getLoginNo(){
    if(document.all.groupName.value==''){
	    rdShowMessageDialog("请先查询组织节点!");
		form1.town_code.focus();
	    return;
	}
    var pageTitle = "营业员查询";
    var fieldName = "营业员工号|营业员名称";
	/****************************************************
	var sqlStr=" select rtrim(login_no),rtrim(login_name)   from dloginmsg" +
				         " where org_code like '" +document.all.district_code.value+document.all.town_code.value+
				         "%' ";
    *****************************************************/
    var sqlStr=" select rtrim(login_no),rtrim(login_name)   from dloginmsg" +
				         " where group_id= '"+document.all.groupId.value+"'";

    if("<%=rpt_right%>" >= "9")
    {
    	sqlStr = sqlStr + " and login_no = '<%=work_no%>'";
    }

    if(document.form1.login_no.value != "")
    {
        sqlStr = sqlStr + " and login_no like '" + document.form1.login_no.value + "%'";
    }
    sqlStr = sqlStr + " order by login_no" ;
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1";
    var retToField = "login_no|login_name";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}
function changeLoginNo(){
   document.all.login_name.value="";
}
</script>
