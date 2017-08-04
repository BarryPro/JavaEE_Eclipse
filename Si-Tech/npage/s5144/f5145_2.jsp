<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%
    Logger logger = Logger.getLogger("f4523_main.jsp");
     
    //读取用户session信息   
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");   
    String[][] baseInfo = (String[][])arrSession.get(0);
    String workNo   = baseInfo[0][2];               //工号
    String workName = baseInfo[0][3];               //工号姓名
    String org_code = baseInfo[0][16];
    String group_id = baseInfo[0][21];

    String ip_Addr  = request.getRemoteAddr();  
    String[][] pass = (String[][])arrSession.get(4);   
    String nopass  = pass[0][0];                    //登陆密码 
    String regionCode = baseInfo[0][16].substring(0,2);
    String regionBitCode = "";
    String regionName = "";
    String startTime = "";
    String endTime = "";
    SimpleDateFormat DateFormat=new SimpleDateFormat("yyyyMMdd");
    
    try
    {
        Date now=new Date();
        startTime = DateFormat.format(now);
        now.setYear(now.getYear()+2);
        endTime = DateFormat.format(now);
    }
    catch(Exception e)
    {
    }
    if( "10014".equals(group_id) )
    {
        regionCode = "99";
    }

    comImpl com = new comImpl();

    String sql = "select count(*) from shighlogin where login_no='" +workNo+"' and op_code='5144'";
    ArrayList resultArr = com.spubqry32("1",sql);
    String [][]resultCount = (String[][])resultArr.get(0);
    if(resultCount[0][0].equals("0")) {
%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script language="javascript" >
alert("此工号无操作此页面权限");
window.close();
</script>
<%
    }
    
    if(!regionCode.equals("99"))
    {
        sql = "select a.bit_region_code,b.region_name from sFAQBitRegionCode a,sRegionCode b where a.region_code = b.region_code and a.region_code = '"+regionCode+"'";
        System.out.println("sql="+sql);
        resultArr = com.spubqry32("2",sql);
        resultCount = (String[][])resultArr.get(0);
        regionBitCode = resultCount[0][0];
        regionName = resultCount[0][1];
    }
    
    String op_name = "新增资费FAQ-基本资料录入";
%>

<html>
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<link href="<%=request.getContextPath()%>/css/jl.css"  rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablabel.css">
</head> 
<body bgcolor="#FFFFFF" text="#000000" background="<%=request.getContextPath()%>/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
    
    <table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td background="<%=request.getContextPath()%>/images/jl_background_1.gif">
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%"> 
            <p><img src="<%=request.getContextPath()%>/images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
          <td width="55%" align="right"><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=workNo%><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=workName%>
            </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" background="<%=request.getContextPath()%>/images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="<%=request.getContextPath()%>/images/jl_logo.gif"></td>
                <td align="right"><img src="<%=request.getContextPath()%>/images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="73%"> 
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b><%=op_name%></b></font></td>
                      <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="289" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%"> 
            <table border="0" cellspacing="0" cellpadding="2" align="right">
              <tr>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>  
    <form name="frm" id="frm" action="f5145_3.jsp" method="post">
<!--隐藏域-->
<input type="hidden" name="manage_region" maxlength="8" value="<%=regionCode%>" >
<input type="hidden" name="request_privs" maxlength="8" value="32" >
<input type="hidden" name="show_type" maxlength="8" value="0"  >
<input type="text" name="faq_bit_region" maxlength="8" value="0"  >
<input type="hidden" name="real_mode_name" value="">

    <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
    <tr><td>
      <table width=100% height=25 border=0 align="center" cellspacing=2>
        <tr bgcolor="#E8E8E8"> 
          <td width="13%">资费名称：</td>
          <td width="35%"> 
            <input type="text" name="mode_name" maxlength="30" value="" class="button" >
            <font color="#FF0000"> *</font>
          </td>
<%
        if("99".equals(regionCode) )
        {
%>
          <td colspan="2">
            <input type="hidden" name="mode_code" maxlength="30" value="" class="button" >
          <td >
<%
        }
        else
        {
%>
          <td >
            资费代码：
          </td>
          <td >
            <input type="text" name="mode_code" maxlength="30" value="" class="button" >
            <input type="button" value="选择" class="button" onclick="getModeCode('frm')" >
          </td>
<%
        }
%>
        </tr>
        <tr bgcolor="#E8E8E8"> 
          <td width="13%">资费可见范围：</td>
          <td width="35%"> 
            <input type="radio" name="privs" value="128" onclick="changePrivs()"> 管理员
            <input type="radio" name="privs" value="32" onclick="changePrivs()"> 营业员<br>
            <input type="radio" name="privs" value="8" onclick="changePrivs()" checked> 登陆客户
            <input type="radio" name="privs" value="2" onclick="changePrivs()"> 公开
            <font color="#FF0000"> *</font>
          </td>
          <td width="13%">排序代码：</td>
          <td width="39%"> 
            <input type="text" name="show_index" maxlength="2" value="" class="button" >
            <font color="#FF0000"> * </font>
            <font color="#FF0000">(按序号排序)</font>
          </td>
        </tr>
        <tr bgcolor="#E8E8E8"> 
          <td width="13%">开始时间：</td>
          <td width="35%"> 
            <input type="text" name="begin_time" maxlength="8" value="<%=startTime%>" class="button" readonly="readonly">
          </td>
          <td width="13%">结束时间： </td>
          <td width="39%"> 
            <input type="text" name="end_time" maxlength="8" value="<%=endTime%>" class="button" readonly="readonly">
            <img src="../../images/calender_btn.gif" style="cursor:hand"  onclick="dispDateWindow(document.all.end_time);return false" alt=点击选择时间 align=absMiddle readonly>
          </td>
        </tr>
        <tr bgcolor="#E8E8E8"> 
            <td>展示地市：</td>
            <td>全选/全不选 <input type="checkbox" name="all_region" onclick="selectAllRegion(this.checked)">
            <td colspan="2"/>
        </tr>
        <tr bgcolor="#E8E8E8"> 
          <td width="100%" colspan="4" align="center"> 
            <input type="hidden" value="0" name="bit_region" >
<%
        if("99".equals(regionCode) )
        {
%>
            <input type="checkbox" value="4096" name="bit_region" onclick="changeBitRegion()">哈尔滨
            <input type="checkbox" value="2048" name="bit_region" onclick="changeBitRegion()">齐齐哈尔
            <input type="checkbox" value="1024" name="bit_region" onclick="changeBitRegion()">牡丹江
            <input type="checkbox" value="512" name="bit_region" onclick="changeBitRegion()">佳木斯
            <input type="checkbox" value="256" name="bit_region" onclick="changeBitRegion()">双鸭山
            <input type="checkbox" value="128" name="bit_region" onclick="changeBitRegion()">七台河
            <br>
            <input type="checkbox" value="64" name="bit_region" onclick="changeBitRegion()">鸡西
            <input type="checkbox" value="32" name="bit_region" onclick="changeBitRegion()">鹤岗
            <input type="checkbox" value="16" name="bit_region" onclick="changeBitRegion()">伊春
            <input type="checkbox" value="8" name="bit_region" onclick="changeBitRegion()">黑河
            <input type="checkbox" value="4" name="bit_region" onclick="changeBitRegion()">绥化
            <input type="checkbox" value="2" name="bit_region" onclick="changeBitRegion()">大兴安岭
            <input type="checkbox" value="1" name="bit_region" onclick="changeBitRegion()">大庆
<%
        }
        else
        {
%>
            <input type="checkbox" value="<%=regionBitCode%>" name="bit_region" onclick="changeBitRegion()"><%=regionName%>
<%
        }
%>
          </td>
        </tr>
        <tr bgcolor="#E8E8E8"> 
            <td colspan="4" align="center">
                <input type="button" value="下一步" onclick="doNext()"/>
            </td>
        </tr>
      </table>
    </td></tr>
    </table>
    </form>
  </body>
</html>


<script language="javascript" >
function doNext()
{
    var year1=document.all.begin_time.value.substring(0,4);
    var month1=document.all.begin_time.value.substring(4,6)
    var day1=document.all.begin_time.value.substring(6,8); 
    var year2=document.all.end_time.value.substring(0,4);   
    var month2=document.all.end_time.value.substring(4,6);
    var day2=document.all.end_time.value.substring(6,8);  

    if (document.all.mode_name.value == "") 
        {
        rdShowMessageDialog("资费名称不能为空，请重新输入！");
          document.all.mode_name.focus();
          return false;
    }
    else if (document.all.show_index.value == "")
    {
        rdShowMessageDialog("排序代码不能为空，请重新输入！");
          document.all.begin_time.focus();
        return false;
    } 
    else if (document.all.end_time.value.length < 8)
    {
        rdShowMessageDialog("结束时间不满足格式要求，请重新输入！");
          document.all.end_time.focus();
        return false;
    } 
    else if (document.all.faq_bit_region.value == 0)
    {
        rdShowMessageDialog("展示地市不能为空，请重新输入！");
          document.all.faq_bit_region.focus();
        return false;       
    }
    else if (Date.parse(month1+"/"+day1+"/"+year1) > Date.parse(month2+"/"+day2+"/"+year2))
	{                                                                                             
        rdShowMessageDialog("录入结束日期不能早于开始日期！");
          document.all.end_time.focus();
        return false;
	}
        else
        {
              document.frm.submit();
        }
    }
    
    function changePrivs()
    {
        for(var i=0; i< document.all.privs.length; i++)
        {
            if(document.all.privs[i].checked)
            {
                document.all.request_privs.value=document.all.privs[i].value;
            }
        }
    }
    
    function changeBitRegion()
    {
        var bitValue = 0;
        for(var i=0; i< document.all.bit_region.length; i++)
        {
            if(document.all.bit_region[i].checked)
            {
                bitValue += parseInt(document.all.bit_region[i].value);
            }
        }
        document.all.faq_bit_region.value = bitValue;
    }
    
    function selectAllRegion(check)
    {
        for(var i=0; i< document.all.bit_region.length; i++)
        {
            document.all.bit_region[i].checked = check;
        }
        changeBitRegion();
    }
    
    function getModeCode(form_name)
    {
        var form = document.getElementById(form_name);
        var mode_code = document.frm.mode_code.value;
        
        mode_code = replaceSpacialCharacter(mode_code);
        var title_name="资费代码,资费名称";
        var element_name="mode_code,mode_name,";
        var element_return="mode_code,real_mode_name,";
        
        //var sql_str="select a.mode_code,a.mode_name from sbillmodecode a where a.region_code = '<%=org_code.substring(0,2)%>' and power_right != '99' and sysdate between start_time and stop_time and mode_code like '%25"+mode_code+"%25'";
        var sql_str="SELECT a.offer_id ,a.offer_name FROM product_offer a, region b, dchngroupmsg c WHERE a.offer_id = b.offer_id AND b.GROUP_ID = c.GROUP_ID and substr(c.boss_org_code,1,2) ='<%=org_code.substring(0,2)%>' and sysdate between a.eff_date and a.exp_date and a.offer_code like '%25"+mode_code+"%25'";
        
        var op_name1="资费代码选择";
        var request_url = "../s5087/fpublicQuery.jsp?form_name="+form_name+"&element_num=2&return_num=2&op_name1="+op_name1+"&title_name="+title_name+"&element_name="+element_name+"&element_return="+element_return+"&sql_str="+sql_str;
        window.open(request_url ,"","height=600,width=400,scrollbars=yes");
    }
    
    function dispDateWindow(node)
    {
		var s = "./calendar.html";                                                       
		var ret = window.showModalDialog(s,"","dialogWidth:440px;dialogHeight:483px;center:1");
		if(String(ret) != "undefined" && ret != "$$$") node.value = ret.replace('-','').replace('-','');                       
	} 
</script>
