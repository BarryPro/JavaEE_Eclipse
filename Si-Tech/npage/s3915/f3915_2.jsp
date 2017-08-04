<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.23
 模块: MAS/ADC业务暂停/恢复功能
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>MAS/ADC业务暂停/恢复功能</TITLE>
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>


<%
	String opCode  =request.getParameter("opCode");
	String opName  =request.getParameter("opName");
	System.out.println("opcode====="+opCode+"===="+opName);
	
	String regCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");

	String unitId = request.getParameter("unitId");//查询条件
	
	StringBuffer sqlsBUF=new StringBuffer("");
	sqlsBUF.append("select unit_id,unit_name,BOSS_VPMN_CODE,cust_id,service_no,b.login_name,a.contact_phone ");
	sqlsBUF.append("from dCustDocOrgAdd a, dloginmsg b ");
	sqlsBUF.append("where a.service_no=b.login_no(+) and a.unit_id="+unitId+";");

	sqlsBUF.append("select a.contract_no, a.bank_cust from dconmsg a, dconconmsg b where a.contract_no=b.contract_pay ");
	sqlsBUF.append("and a.con_cust_id=(select cust_id from dCustDocOrgAdd where unit_id="+unitId+");");

	
	String sqls=sqlsBUF.toString();  
	System.out.println(" sqls = " + sqls);                                

	int[] colNum=new int[2];
	colNum[0]=7;
	colNum[1]=2;
	/*colNum[2]=8;*/
	//arlist=co.multiSql(colNum,sqls); 
%>
	<wtc:mutilselect name="sPubMultiSel" routerKey="region" routerValue="regCode" id="mutilList" type="list">
	<wtc:sql><%=sqls%></wtc:sql>
	</wtc:mutilselect>
<%

	String [][] result1 = new String[][]{};
	String [][] result2 = new String[][]{};	
	/*String [][] result3 = new String[][]{};*/
	result1 = (String[][])mutilList.get(0);    
	result2 = (String[][])mutilList.get(1);	
	/*result3 = (String[][])arlist.get(2);*/
	System.out.println("result1.length = " + result1.length);
	System.out.println("result2.length = " + result2.length);		
	System.out.println("cust_id = " +result1[0][3]);
	/*System.out.println("result3 = " + result3.length);*/
	
	/*查询产品相关信息列表*/
	String errCode = "";
	String errMsg = "";
	
    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String password = (String)session.getAttribute("password");
    
    
    String[] inParas = new String[5];
    inParas[0] = "3915";//op_code,暂时写死
    inParas[1] = loginNo;
    inParas[2] = password;
    inParas[3] = ip_Addr;
    inParas[4] = result1[0][3];//chendx 为将s3915QryE部署到boss修改了服务入参
    
	
	//retList = impl.callFXService("s3915QryE", inParas, "12");
%>
	<wtc:service name="s3915QryE" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="12">			
	<wtc:param value="3915"/>	
	<wtc:param value="<%=loginNo%>"/>	
	<wtc:param value="<%=password%>"/>	
	<wtc:param value="<%=ip_Addr%>"/>	
	<wtc:param value="<%=result1[0][3]%>"/>	
	</wtc:service>	
	<wtc:array id="result" scope="end"/>
<%
	
	errCode = retCode1;
	errMsg  = retMsg1;
	if(errCode.equals("000000"))
	{
		
	}
	else
	{%>
		<script language="javascript">
		rdShowMessageDialog("服务未查询到产品信息[<%=errCode%>][<%=errMsg%>]",0);
		history.go(-1);
		</script>
	<%
		return;
	}
	
%>

</HEAD>
<script language="javascript">

{
	//core.rpc.onreceive = doProcess;//为function()函数设立监听器
}
function doProcess(myPacket)
{
	var errCode    = myPacket.data.findValueByName("errCode");
	var retMessage = myPacket.data.findValueByName("errMsg");//声明返回的信息
	var retFlag    = myPacket.data.findValueByName("retFlag");
			
	if (errCode==000000)
	{  
		if(retFlag=="queryMod")
		{			
			rdShowMessageDialog("操作成功！",2);
			window.location="f3915_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
	}
	
	//-----如果返回错误代码-----
	if(errCode!=000000)
	{
		rdShowMessageDialog(retMessage,0);	
	}
}
	
	
function queryMod(OprCode,v_id)
{				
	getAfterPrompt();
	var myPacket = new AJAXPacket("f3915Cfm.jsp","正在执行停机恢复操作,请稍候......");
	
	myPacket.data.add("OprCode",OprCode);
	myPacket.data.add("id_no",v_id);
	myPacket.data.add("unitId",<%=unitId%>);
	
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}
</script>


<% if (result1[0][0].trim().equals("")) 
{%>
<script language="javascript">
	rdShowMessageDialog("没有找到任何数据",0);
	history.go(-1);
</script>
<%}
else
{%>
<body>
<FORM method=post name="frm">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

	 <table cellspacing="0">
		<TR> 
		  <TD class="blue">集团编号</TD>
		  <TD><input type="text" class="InputGrey" readonly  name="phoneNo" size="20" maxlength="11" value="<%=result1[0][0]%>">
		  </TD>
		  <TD class="blue">集团名称</TD>
		  <TD><input type="text" class="InputGrey" readonly  name="beginFlag" size="20" maxlength="1" value="<%=result1[0][1]%>"></TD>
		</TR>
		<TR> 
		  <TD class="blue">VPMN代码</TD>
		  <TD><input type="text" readonly class="InputGrey"  name="openTime" size="20" maxlength="20" value="<%=result1[0][2]%>"></TD>
		  <TD class="blue">客户ID</TD>
		  <TD><input type="text" readonly class="InputGrey" name="oldExpire" size="20" maxlength="20" value="<%=result1[0][3]%>"></TD>
		</TR>
		<TR> 
		  <TD class="blue">客户经理工号</TD>
		  <TD><input type="text" readonly class="InputGrey" name="expireTime" size="20" maxlength="20" value="<%=result1[0][4]%>" ></TD>
		  <TD class="blue">经理姓名</TD>
		  <TD><input type="text" readonly class="InputGrey" name="remain_fee" size="20" maxlength="20" value="<%=result1[0][5]%>"></TD>
		</TR>         
		<TR> 
		  <TD class="blue">联系电话</TD>
		  <TD colspan="3"><input type="text" readonly class="InputGrey" name="opNote" size="20" maxlength="60" value="<%=result1[0][6]%>"></TD>
		</TR>         
		<TR> 
		  <TD class="blue">一点支付账户</TD>
		  <TD><input type="text" readonly class="InputGrey" name="current_code" size="20" maxlength="20" value="<% if (result2[0].length>0) out.print(result2[0][0]);%>"></TD>
		  <TD class="blue">账户名称</TD>
		  <TD><input type="text" readonly class="InputGrey" name="opNote" size="20" maxlength="60" value="<% if (result2[0].length>1) out.print(result2[0][1]);%>"></TD>
		</TR>         
	  </TABLE>


    <table cellspacing="0">
      <tr align="center">
        <th nowrap>集团产品ID</th>
		<th nowrap>产品类型</th>
        <th nowrap>产品帐号</th>
        <th nowrap>产品状态</th>
        <th nowrap>产品号码</th>
        <th nowrap>开户时间</th>
        <th nowrap>产品名称</th>
        <th nowrap>APN号码</th>
        <th nowrap>欠费金额</th>
        <th nowrap>未出帐话费</th>
        <th nowrap>产品停开机操作</th>
      </tr>
	<%
	for(int y=0;y<result.length;y++)
	{%>
	  <tr>
	    <td><div align="center"><a href="f5082_3.jsp?idNo=<%=result[y][0]%>&opCode=<%=opCode%>&opName=<%=opName%>"><%=result[y][0].equals("")?"&nbsp;":result[y][0]%></a></div></td>
	    <td><div align="center"><%=result[y][1].equals("")?"&nbsp;":result[y][1]%></div></td>
	    <td><div align="center"><%=result[y][2].equals("")?"&nbsp;":result[y][2]%></div></td>	    
	    <td><div align="center"><%=result[y][4].equals("")?"&nbsp;":result[y][4]%></div></td>
	    <td><div align="center"><%=result[y][5].equals("")?"&nbsp;":result[y][5]%></div></td>
	    <td><div align="center"><%=result[y][6].equals("")?"&nbsp;":result[y][6]%></div></td>
	    <td><div align="center"><%=result[y][7].equals("")?"&nbsp;":result[y][7]%></div></td>
	    <td><div align="center"><%=result[y][8].equals("")?"&nbsp;":result[y][8]%></div></td>
	    <td><div align="center"><%=result[y][9].equals("")?"&nbsp;":result[y][9]%></div></td>
	    <td><div align="center"><%=result[y][11].equals("")?"&nbsp;":result[y][11]%></div></td>
	  	<td>
	  	  <div align="center">
	  		<input name="operator<%=y+1%>"  style="cursor:hand" type="button" value="停机" class="b_text" <%if(!"A".equals(result[y][3])||(!"AD".equals(result[y][10])&&!"MA".equals(result[y][10])&&!"ML".equals(result[y][10]))){%> disabled <%}%> onclick="queryMod('03','<%=result[y][0]%>')">&nbsp;
	  		<input name="operator<%=y+1%>"  style="cursor:hand" type="button" value="开机" class="b_text" <%if(!"F".equals(result[y][3])||(!"AD".equals(result[y][10])&&!"MA".equals(result[y][10])&&!"ML".equals(result[y][10]))){%> disabled <%}%> onclick="queryMod('04','<%=result[y][0]%>')">
	  	  </div>
	  	</td>
	  </tr>
	<%
	}%>
    </table>

	 <table cellspacing="0">
	  <tr align="center" id="footer"> 
		<td>
			  &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
			  &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
			  &nbsp; 
		</td>
	  </tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>   
</FORM>
</BODY></HTML>
<%}%>
