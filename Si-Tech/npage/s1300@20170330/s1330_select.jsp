<%
	/********************
	 version v2.0
	开发商: si-tech
	update:zhaoht@2009-03-10 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gbk" %>

<%/*
* name    :
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%

    String opName=request.getParameter("opName");
    String workno =  (String)session.getAttribute("workNo");
    String workname =  (String)session.getAttribute("workName");
	String belongName =  (String)session.getAttribute("orgCode");
	String regCode = (String)session.getAttribute("regCode");

	String op_code  =  request.getParameter("optype");
	op_code = op_code.substring(1,5);
	String billdate=request.getParameter("billdate");
	String optype="2";
	String water_number=request.getParameter("water_number");
	String card_price=request.getParameter("card_price");

	String opCode = op_code;

	String [][] result = new String[][]{};
	String [][] result2 = new String[][]{};
	System.out.println("card_price="+card_price);

	ArrayList arlist = new ArrayList();

	try
	{
		//arlist = viewBean.s1330Sel(billdate,water_number,workno,belongName,op_code);
%>
		<wtc:service name="s1330_Sel" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11">
		<wtc:param value="<%=billdate%>"/>
		<wtc:param value="<%=water_number%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=belongName%>"/>
		<wtc:param value="<%=op_code%>"/>
		</wtc:service>
		<wtc:array id="resultTemp" start="0" length="5" scope="end"/>
		<wtc:array id="result2Temp" start="5" length="6" scope="end"/>
<%
		result = resultTemp;
		result2 = result2Temp;
	}
	catch(Exception e)
	{
		//System.out.println("调用EJB发生失败！");
	}


	//result = (String[][])arlist.get(0);
	String return_code =result[0][0];
	String return_message =result[0][1];
	System.out.println("return_message"+return_message);
	String error_msg = return_message;
	String ss1="aa";
%>
<%
if (!return_code.equals("000000")) {
%><script language="JavaScript">
rdShowMessageDialog("查询错误！<br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=return_message%>'。",0);
history.go(-1);
</script>
	return;
<%}
	//result2 = (String[][])arlist.get(1);
	String infilling_number = result[0][2];
	String infilling_price =result[0][3];
	String infilling_income =result[0][4];
	infilling_number = infilling_number.trim();
	infilling_price = infilling_price.trim();
	infilling_income = infilling_income.trim();

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>黑龙江BOSS-有价卡销售及回退</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
<!--
function form_load()
{
form.sure.disabled=false;
form.comp.disabled=true;
}
function gohome()
{
document.location.replace("s1330.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
}
// -->
</script>
</HEAD>

<BODY onLoad="form_load();">
<FORM action="s1330_2.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">操作信息</div>
		</div>
<INPUT TYPE="hidden" name="card_price" value="000">
<INPUT TYPE="hidden" name="card_begin_no" value="0">
<INPUT TYPE="hidden" name="card_end_no" value="0">
<INPUT TYPE="hidden" name="card_number" value="0">
<INPUT TYPE="hidden" name="should_sum" value="0">
<INPUT TYPE="hidden" name="real_income" value="0">
<input type="hidden" name="billdate" value="<%=billdate%>">
<INPUT TYPE="hidden" name="optype" value="2">
<INPUT TYPE="hidden" name="opcode" value="<%=op_code%>">
<INPUT TYPE="hidden" name="opName" value="<%=opName%>">

            <table cellspacing="0">
              <tbody>
              <tr>
                <td>操作类型：<b>充值卡销售回退</b></td>
                <td>部门：<%=belongName%></td>
              </tr>
              </tbody>
            </table>

          <table id=tb1 cellspacing="0" style="display:none">
            <tr>
              <td>流水号</td>
              <td>
               <input type="text" name="water_number" readonly maxlength="22" class="InputGrey" value="<%=water_number%>">
              </td>
            </tr>
          </table>

            <table id="dyntb" cellspacing="0">
              <tbody>
              <tr>
                <th>
                  <div align="center">面值</div>
                </th>
                <th>
                  <div align="center">开始卡号</div>
                </th>
                <th>
                  <div align="center">结束卡号</div>
                </th>
                <th>
                  <div align="center">卡数量</div>
                </th>
                <th>
                  <div align="center">应收合计</div>
                </th>
                <th>
                  <div align="center">实收</div>
                </th>
              </tr>
<%
	  for(int y=0;y<result2.length;y++){
	  	String tdClass = (y%2==0)?"Grey":"";
		if ((y%2)==1)%>

		  <tr>
		<%else %>
		  <tr>
		<%
		      for(int j=0;j<result2[0].length;j++){
		       ss1=result2[y][0];
		%>
			<td class="<%=tdClass%>"><div align="center"><%= result2[y][j]%></div></td>

		<%
		    }

		%>
		</tr>
		<script language="JavaScript">
		<!--

		 ss="<%= ss1%>";
		 //alert(ss.substring(0,5));
		/* wangmei delete 20060331
		 if(ss.substring(0,5)=="彩铃包年卡"){
		 alert("请收回销售彩铃包年卡所赠的电池！");
		 }
		 */
		// -->
		</script>
<%
    }

%>
              </tbody>
            </table>
             </div>
        <div id="Operation_Table">
<div class="title">
	<div id="title_zi">业务信息</div>
</div>
              <table cellspacing="0">
                <tbody>

                <tr nowrap>
                  <td>
                    <div align="center">充值卡总张数：
                      <input type="text" readonly name="infilling_number" size="14" class="InputGrey"  value="<%=infilling_number%>">
                    </div>
                  </td>
                  <td>
                    <div align="center">充值卡总面值：
                       <input type="text" readonly name="infilling_price" size="14" class="InputGrey"  value="<%=infilling_price%>">
                    </div>
                  </td>
                  <td>
                    <div align="center">充值卡总实收：
                       <input type="text" readonly name="infilling_income" size="14" class="InputGrey"  value="<%=infilling_income%>">
                    </div>
                  </td>
                </tr>
                </tbody>
              </table>
            <table cellspacing="0">
              <tbody>
              <tr>
                <td id="footer">
                  <input class="b_foot" name="comp" type=button value=计算>
				  &nbsp;
                  <input class="b_foot" name=sure type=submit value=确认>
                  &nbsp;
				  <input class="b_foot" name="reset" type=reset value=返回 onClick="gohome()">
				  &nbsp;
                </td>
              </tr>
              </tbody>
            </table>
          <%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY></HTML>
