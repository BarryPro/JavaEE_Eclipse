<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-06
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
    String opCode = "1508";
    String opName = "优惠操作查询";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String begin_date = "";

	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=3;i++)
        {
              if(i!=3)
              {
                begin_date = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                begin_date = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
        }
        begin_date=begin_date+"01";

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>优惠操作查询</TITLE>
</HEAD>
<body>
<SCRIPT language="JavaScript">
function doCheck(){
  if(document.frm1508.queryType.value == "phoneNo")
  { 
    if (document.frm1508.begin_phoneNo.value=="")
    {
      rdShowMessageDialog("请输入开始手机号码！");
      document.frm1508.begin_phoneNo.value="";
      document.frm1508.begin_phoneNo.select();
      return false;
    }
    if (document.frm1508.end_phoneNo.value=="")
    {
      document.frm1508.end_phoneNo.value=document.frm1508.begin_phoneNo.value;
      document.frm1508.end_phoneNo.select();
      return false;
    }
  } 
  else
  {
    if (document.frm1508.begin_loginNo.value=="")
    {
      rdShowMessageDialog("请输入开始工号！");
      document.frm1508.begin_loginNo.value="";
      document.frm1508.begin_loginNo.select();
      return false;
    }
    if (document.frm1508.all("begin_loginNo").value.length < 6)
    {
      rdShowMessageDialog("输入的开始工号长度不对！");
      document.frm1508.begin_loginNo.value="";
      document.frm1508.begin_loginNo.select();
      return false;
    }
    if (document.frm1508.end_loginNo.value=="")
    {
      rdShowMessageDialog("请输入结束工号！");
      document.frm1508.end_loginNo.value=document.frm1508.begin_loginNo.value;
      document.frm1508.end_loginNo.select();
      return false;
    }
    if (document.frm1508.all("end_loginNo").value.length < 6)
    {
      rdShowMessageDialog("输入的结束工号长度不对！");
      document.frm1508.end_loginNo.value="";
      document.frm1508.end_loginNo.select();
      return false;
    }
  }

  if(document.frm1508.all("begin_time").value.length == 0)
  {
    rdShowMessageDialog("请输入开始时间！");
    document.frm1508.begin_time.value="";
    document.frm1508.begin_time.select();
    return false;
  }
  if(document.frm1508.all("end_time").value.length == 0)
  {
    rdShowMessageDialog("请输入结束时间！");
    document.frm1508.end_time.value="";
    document.frm1508.end_time.select();
    return false;
  }

  if(document.frm1508.all("begin_time").value.length == 8)
      document.frm1508.begin_time.value=document.frm1508.begin_time.value+" 00 00 00";
  if(document.frm1508.all("end_time").value.length == 8)
      document.frm1508.end_time.value=document.frm1508.end_time.value+" 23 59 59";

  var begin_time=document.frm1508.begin_time.value;
  var end_time=document.frm1508.end_time.value;
  if(begin_time>end_time){
    rdShowMessageDialog("开始时间比结束时间大");
    return false;
  }
  document.frm1508.action="f1508_2.jsp?queryType="+document.frm1508.queryType.value+"&begin_phoneNo="+document.frm1508.begin_phoneNo.value+"&end_phoneNo="+document.frm1508.end_phoneNo.value+"&begin_loginNo="+document.frm1508.begin_loginNo.value+"&end_loginNo="+document.frm1508.end_loginNo.value+"&begin_time="+begin_time+"&end_time="+end_time+"&work_no=<%=work_no%>&work_name=<%=work_name%>&function_code="+document.frm1508.function_code.value+"&favour_code="+document.frm1508.favour_code.value;
  frm1508.submit();
  return true;
}
function change(){      
        if(document.frm1508.queryType.value == "phoneNo")
        {
          document.frm1508.all("phoneNo").style.display="";
          document.frm1508.all("loginNo").style.display="none";
          document.frm1508.begin_phoneNo.value ="";
          document.frm1508.end_phoneNo.value ="";
          document.frm1508.begin_loginNo.value ="a";
          document.frm1508.end_loginNo.value ="a";
          document.frm1508.begin_time.value =document.frm1508.begin_date.value;
        }
        else
        {
          document.frm1508.all("phoneNo").style.display="none";
          document.frm1508.all("loginNo").style.display="";
          document.frm1508.begin_phoneNo.value ="a";
          document.frm1508.end_phoneNo.value ="a";
          document.frm1508.begin_loginNo.value ="";
          document.frm1508.end_loginNo.value ="";
          document.frm1508.begin_time.value =document.frm1508.end_date.value;
        }   
}
function curLost(){ 
	document.frm1508.end_phoneNo.value=document.frm1508.begin_phoneNo.value;
	document.frm1508.end_loginNo.value=document.frm1508.begin_loginNo.value;
	return true;
}
</SCRIPT>

<FORM method=post name="frm1508">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户信息</div>
</div>

<table cellspacing="0">
    <TR>
        <TD class=blue>查询方式</td>
        <td colspan=3>
            <select name="queryType" onChange="change()">
                <option value=phoneNo>按号码</option>
                <option value=loginNo>按工号</option>
            </select>
        </TD>
    </tr>
    <TR id=phoneNo style="display:">
        <TD class=blue>开始号码</td>
        <td><input type="text" name="begin_phoneNo" size="15" onBlur="curLost()" maxlength="11"></TD>
        <TD class=blue>结束号码</td>
        <td><input type="text" name="end_phoneNo" size="15" maxlength="11"></TD>
    </TR>
    <TR id=loginNo style="display:none">
        <TD class=blue>开始工号</td>
        <td><input type="text" name="begin_loginNo" onBlur="curLost()" size="15" maxlength="6"></TD>
        <TD class=blue>结束工号</td>
        <td><input type="text" name="end_loginNo" size="15" maxlength="6"></TD>
    </tr>
    <TR>
        <TD class=blue>操作代码</TD>
        <TD>
            <select align="left" name=function_code width=50>
            <%/*
                try
                {
                    ArrayList retArray = new ArrayList();
                    String[][] result = new String[][]{};
                    S1100View callView = new S1100View();
                    String sqlStr = "select function_code,function_code||'-->'||function_name from sFuncCode where function_code<'9999' and length(rtrim(function_code))=4";
                    retArray = callView.view_spubqry32("2",sqlStr);
                    result = (String[][])retArray.get(0);
                    int recordNum = result.length;      		
                    out.println("<option class='button' value='ZZZZ'>ZZZZ-->全部操作</option>");
                    for(int i=0;i<recordNum;i++)
                    {
                        out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                    }
                }catch(Exception e)
                {
                    //System.out.println("Call sunView is Failed!");
                }          
            */%>
                <option value='ZZZZ'>ZZZZ -->全部操作</option>
                <wtc:qoption name="sPubSelect" outnum="2">
                    <wtc:sql>select function_code,function_code||'-->'||function_name from sFuncCode where function_code<'9999' and length(rtrim(function_code))=4</wtc:sql>
                </wtc:qoption>
            </select>             
        </TD>
        <TD class=blue>优惠类型</TD>
        <TD>
            <select align="left" name=favour_code width=50>
            <%/*
                try
                {
                    ArrayList retArray = new ArrayList();
                    String[][] result = new String[][]{};
                    S1100View callView = new S1100View();
                    String sqlStr = "select function_code,function_code||'-->'||function_name from sFuncCode where function_code>'a'";
                    retArray = callView.view_spubqry32("2",sqlStr);
                    result = (String[][])retArray.get(0);
                    int recordNum = result.length;      		
                    out.println("<option class='button' value='ZZZZ'>ZZZZ-->全部优惠</option>");
                    for(int i=0;i<recordNum;i++)
                    {
                        out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                    }
                }catch(Exception e)
                {
                    //System.out.println("Call sunView is Failed!");
                }          
            */%>
                <option value='ZZZZ'>ZZZZ -->全部优惠</option>
                <wtc:qoption name="sPubSelect" outnum="2">
                    <wtc:sql>select function_code,function_code||'-->'||function_name from sFuncCode where function_code>'a'</wtc:sql>
                </wtc:qoption>
            </select>             
        </TD>
    </TR>
    
    <TR>
        <TD class="blue">开始时间</td>
        <td><input type="text" v_type="date_time" name="begin_time" value=<%=begin_date%> size="17" maxlength="17" v_format="yyyyMMdd"></TD>
        <TD class="blue">结束时间</td>
        <td><input type="text" v_type="date_time" name="end_time" value=<%=dateStr%> size="17" maxlength="17" v_format="yyyyMMdd"></TD>
    </tr>
    
    <tr id="footer"> 
        <td colspan=4>
            <input class="b_foot" name=commit onClick="doCheck()" type=button value=确认>
            <input class="b_foot" name=reset  type=reset onClick="" value=清除>
            <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
        </td>
    </tr>
</table>
<input type="hidden" name="begin_date" value=<%=begin_date%>>
<input type="hidden" name="end_date" value=<%=dateStr%>>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
