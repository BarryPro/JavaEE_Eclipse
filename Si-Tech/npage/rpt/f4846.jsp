<%
/********************
version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	request.setCharacterEncoding("GBK");

%>


<%
	//String opCode="4847";
	//String opName="��ά������̼ҵı���";
	String opCode=(String)request.getParameter("opCode");
	System.out.println("yuanqs+++++++++++++++" + opCode);
	String opName= (String)request.getParameter("opName");
	Logger logger = Logger.getLogger("f4847.jsp");
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String rpt_right= (String)session.getAttribute("rptRight");
	String regionCode=(String)session.getAttribute("regCode");

	String sqlStr="";
	int recordNum=0;
	/*int i=0;*/

	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

	String region="";

	String merchant_sql="select a.agent_name,a.agent_id from dbchnadn.dChnAgentMsg a,dchngroupmsg b "
	+" where a.belong_group=b.group_id and substr(b.boss_org_code,1,2)='"+ regionCode +"' and a.agent_application = '1'";

	String actionSql = "select action_code,action_name from sSaleAction order by action_code";
 	System.out.println(merchant_sql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode01" retmsg="errMsg01" outnum="2">
	<wtc:sql><%=merchant_sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="merchantList" scope="end"/>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode01" retmsg="errMsg01" outnum="2">
<wtc:sql><%=actionSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="actionList" scope="end"/>


<script language=JavaScript>
//----����һ����ҳ��ѡ����֯�ڵ�--- ����
function select_groupId()
{
	var path = "<%=request.getContextPath()%>/npage/rpt/common/grouptreeTcode.jsp";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>��ά��Ӫ��ͳ�Ʊ���</TITLE>
</HEAD>
<body>

<SCRIPT language="JavaScript">

function doSubmit()
{

  if(!check(form1))
  {
    return false;
  }

  /*var begin_date = document.form1.begin_date.value;
  var end_date = document.form1.end_date.value;
  if(begin_date > end_date)
  {
    rdShowMessageDialog("��ʼʱ��Ƚ���ʱ���");
    return false;
  }*/
  with(document.forms[0])
  {
  		 //yuanqs add ����BOSSϵͳ���ӵ���ƾ֤��ϸͳ�Ʊ�����begin
  		 if("b036" == "<%=opCode%>") {
	     	hTableName.value="rbo005";
	     	hParams1.value= "prc_b036('"
	     	+document.form1.agent_code.value+"','"
	     	+document.form1.shop_code.value+"','"
	     	+document.form1.action_code.value+"','"
	     	+document.form1.project_code.value+"','"
	     	+document.form1.begin_time.value+" 00:00:00','"
	     	+document.form1.end_time.value+" 23:59:59','"
	     	+document.form1.workNo.value+"','"
	     	+document.form1.opCode.value+"','"
		 	+document.form1.opName.value+"'";
  		 } else {
  		 //yuanqs add ����BOSSϵͳ���ӵ���ƾ֤��ϸͳ�Ʊ�����end
  		 	hTableName.value="rbo005";
	     	hParams1.value= "PRC_4846('"
	     	+document.form1.agent_code.value+"','"
	     	+document.form1.shop_code.value+"','"
	     	+document.form1.action_code.value+"','"
	     	+document.form1.project_code.value+"','"
	     	+document.form1.begin_time.value+" 00:00:00','"
	     	+document.form1.end_time.value+" 23:59:59','"
	     	+document.form1.workNo.value+"','"
	     	+document.form1.opCode.value+"','"
		 	+document.form1.opName.value+"'";
		 	
  		 }
	  	 
      submit();
  }
}

</SCRIPT>
<FORM method=post name="form1" action="/npage/rpt/print_rpt.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ѡ������</div>
	</div>

<table cellSpacing="0">
  <%    if (opCode.equals("4847")){   %>
  <tr>
  	<td class="blue">�̼�</td>
  	<td><select name="agent_code" onChange="tochange('change_shop')">
		<option value="ZZZZ">--��ѡ��--</option>
		<%for(int i=0;i<merchantList.length;i++){%>
		<option class='button' value="<%=merchantList[i][1]%>"><%=merchantList[i][0]%></option>
		<%}%>
	</select></td>
  	<td class="blue">����</td>
  	<td><select name="shop_code" >
		<option value="ZZZZ">--��ѡ��--</option>
	</select></td>
		<!--<td colspan="3">
			<input type="hidden" name="groupId" >
			<input type="text" name="groupName" v_must="1" v_type="string" maxlength="60" readonly onpropertychange="tochange('change_group')">&nbsp;<font color="orange">*</font>
			<input name="addButton" class="b_text" type="button" value="ѡ��" onClick="select_groupId()" >
			<input name="refbutton" class="b_text" type="button" value="ˢ��" onClick= "tochange('change_group')" >
		</td>-->
	</tr>
	<% } else {%>
	<input type="hidden" name ="agent_code" value="ZZZZ">
	<input type="hidden" name ="shop_code" value="ZZZZ">
	<%}%>
	<tr>
	  	<td class="blue">Ӫ�������</td>
	  	<td><select name="action_code" onChange="tochange('find_project_code')">
					<option value="ZZZZ">--��ѡ��--</option>
					<%for(int i=0;i<actionList.length;i++){%>
					<option class='button' value="<%=actionList[i][0]%>"><%=actionList[i][1]%></option>
					<%}%>
				</select></td>
	   	<td class="blue">Ӫ��������</td>
		<td><select name="project_code">
			<option value="ZZZZ">--��ѡ��--</option>
			</select></td>
	</tr>
	<tr>
		<td class="blue">��ʼʱ��</td>
		<td>
			<input type="text"    name="begin_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
		<td class="blue">����ʱ��</td>
		<td>
			<input type="text"    name="end_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
		&nbsp; <input id=submits class="b_foot" name=submits onclick="return(doSubmit())" type=button value=ȷ��>
		&nbsp; <input class="b_foot" name=reee  type=button onClick="form1.reset()" value=���>
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
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
	<input type="hidden" name="opCode" value=<%=opCode%>>
	<input type="hidden" name="opName" value=<%=opName%>>
	<input type="hidden" name="login_accept" value="">
	<input type="hidden" name="hTableName" value="">

	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

<script language="javascript">
/*----------------------------����RPC������������------------------------------------------*/


 onload=function(){
	form1.reset();
	}
var change_flag = "";					//����RPC����ȫ�ֱ��� ��ѯ����:flag_dis  ��ѯӪҵ��:flag_town Ĭ��:""
function tochange(par)
{
	if(par == "find_project_code")
	{
		change_flag="find_project_code";
		var vActionCode = document.all.action_code.value;
		var myPacket = new AJAXPacket("select_rpc.jsp","���ڻ��Ӫ������Ϣ�����Ժ�......");
		var sqlStr = "90000053";
		var params = vActionCode;
		var outNum = "2";
	}
	else if (par == "change_shop")
	{
		change_flag = par;

		var agent_code = document.all.agent_code.value;
		var myPacket = new AJAXPacket("select_rpc.jsp","���ڻ�õ�����Ϣ�����Ժ�......");
		var sqlStr = "90000054" ;
		
		var params = agent_code+"|";
		var outNum = "2";
	}
	//alert("sqlStr = "+sqlStr+"\nparams = "+params);
	myPacket.data.add("sqlStr",sqlStr);
	myPacket.data.add("params",params);
	myPacket.data.add("outNum",outNum);
	core.ajax.sendPacket(myPacket);

	delete(myPacket);
}

/*-----------------------------RPC������------------------------------------------------*/
  function doProcess(packet)
  {
	  var rpc_page=packet.data.findValueByName("rpc_page");


	    var triListdata = packet.data.findValueByName("tri_list");
  	    var triList=new Array(triListdata.length);
		if(change_flag == "find_project_code")
		{
			  triList[0]="project_code";
			  document.all("project_code").length=0;
			  document.all("project_code").options.length=triListdata.length+1;
			  document.all("project_code").options[0].text="--��ѡ��--";
			  document.all("project_code").options[0].value="ZZZZ";
			  document.all("project_code").options[0].selected=true;

			  for(j=1;j<=triListdata.length;j++)
			  {
				document.all("project_code").options[j].text=triListdata[j-1][1];
				document.all("project_code").options[j].value=triListdata[j-1][0];
			  }
		}
		else if (change_flag=="change_shop")
		{
			  triList[0]="shop_code";
			  document.all("shop_code").length=0;
			  document.all("shop_code").options.length=triListdata.length+1;
			  document.all("shop_code").options[0].text="--��ѡ��--";
			  document.all("shop_code").options[0].value="ZZZZ";
 		      document.all("shop_code").options[0].selected=true;

			  for(j=1;j<=triListdata.length;j++)
			  {
				document.all("shop_code").options[j].text=triListdata[j-1][1];
				document.all("shop_code").options[j].value=triListdata[j-1][0];
			  }
		}


   }

</script>
