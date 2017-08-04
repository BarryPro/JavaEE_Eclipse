<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

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
        String opCode="g839";
        String opName="动优势银行代收折扣明细报表";
        Logger logger = Logger.getLogger("fg839.jsp");
        String work_no = (String)session.getAttribute("workNo");
        String org_code = (String)session.getAttribute("orgCode");
        String rpt_right= (String)session.getAttribute("rptRight");
        String regionCode=(String)session.getAttribute("regCode");
        
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
<HEAD><TITLE>联动优势代收折扣明细报表</TITLE>
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
          hParams1.value= "prc_g839_01('"+document.form1.workNo.value+"','"+document.form1.region_code.value+"','"+document.form1.begin_time.value+"','"+document.form1.end_time.value+"' ";
      submit();
  }
}

</SCRIPT>
<FORM method=post name="form1" action="/npage/rpt/print_rpt_crm.jsp">
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
        <input type="hidden" name="op_code" value="g839">
        <input type="hidden" name="login_accept" value="">
        <input type="hidden" name="hTableName" value="">

        <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
