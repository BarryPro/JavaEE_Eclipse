<% request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>


<%
		String regionCode = (String)session.getAttribute("regCode");
    //String regionCode = request.getParameter("regionCode");
    
    Date date = new Date();
	  DateFormat df = new SimpleDateFormat("yyyyMM");
	  String str = df.format(date);
	  
    String[][] result = new String[1][3];
    String aaa = "0";
    String bbb = "0";
    String ccc = "0";
    String ddd = "0";
    String sqlStr="select"
    								+" to_char(case when limit_month_beg <= to_number(to_char(sysdate,'yyyymm'))  and limit_month_end >=to_number(to_char(sysdate,'yyyymm')) then limit_month_spe"
                    		 +" else limit_month_def end ) as v_month_limit,to_char(nvl(b.total_month,0)),"
                    +" to_char(case when limit_month_beg <= to_number(to_char(sysdate,'yyyymm'))  and limit_month_end >=to_number(to_char(sysdate,'yyyymm')) then limit_month_spe"
                         +" else limit_month_def end - nvl(b.total_month,0)),to_char(substr(b.TOTAL_DATE,0,6))"  
                   	+" from slimitpay a,wlimitedfee b"
                    +" where a.region_code=b.region_code and a.limit_type=b.limit_type"
                    +" and b.limit_type='zz' and b.region_code='"+regionCode+"'";

   System.out.println("---------sql----------="+sqlStr);
%>
		<wtc:pubselect name="TlsPubSelBoss" outnum="4">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="retList" scope="end" />
  <%
  	result = retList;
  	
  	if(result.length == 0){
  	}else{
  		aaa = result[0][0];
  		bbb = result[0][1];
  		ccc = result[0][2];
			ddd = result[0][3];
			
	  	if(!str.equals(ddd)){
	  		bbb = "0";
	  		ccc = aaa;
	  	}
  	}
  	
		String aa = aaa.charAt(0)+"";
		if(aa.equals(".")){
			aaa="0"+aaa;
			System.out.println(aaa);
		}
		
		String bb = bbb.charAt(0)+"";
  	if(bb.equals(".")){
  		bbb="0"+bbb;
  	}
  	
  	String cc = ccc.charAt(0)+"";
  	if(cc.equals(".")){
  		ccc="0"+ccc;
  	}

	%>

<HTML>
<HEAD>
<TITLE>黑龙江BOSS-当月账户转账信息</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="<%=request.getContextPath()%>/images/jl_background_2.gif">
<FORM action="" method=post name=form ENCTYPE="multipart/form-data">
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td background="<%=request.getContextPath()%>/images/jl_background_1.gif">
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
          <td align="right"> 
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                        <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b>账户转账信息</b></font></td>
                      	<td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="389" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td width="45%"> <br>            
            <table id=tbs9 width=100% height=25 border=0 align="center" cellspacing=2>
              <tr bgcolor="E8E8E8">
              	<td width="30%">当前月限额：</td><td width="33%"><%=aaa%>元</td>
              </tr>
              <tr bgcolor="F5F5F5"> 
                  <td width="30%">当月已累计的转账金额：</td><td width="36%"><%=bbb%>元</td>
              </tr>
              <tr bgcolor="E8E8E8"> 
                  <td width="30%" align="left">当月尚可转账的金额：</td>  <td width="87%" colspan="3"><%=ccc%>元</td>
              </tr>
            </table>
            <table width="100%" border=0 align=center cellpadding="4" cellspacing=1>
              <tbody>
              <tr bgcolor="#EEEEEE">
                <td bgcolor="F5F5F5" width="100%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <input class="button" name=reset type=reset value=关闭 onClick="window.close()">
                </td>
              </tr>
              </tbody> 
            </table>
            <p>&nbsp;</p>
          </td>
        </tr>
      </table>
      <br>
    </td>
  </tr>
</table>
</FORM>
</BODY>
</HTML>