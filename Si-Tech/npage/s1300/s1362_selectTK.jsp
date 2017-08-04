<!--
	add liuxmc
-->
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<% request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>


<%
		String regionCode= (String)session.getAttribute("regCode");
	String time = request.getParameter("time");
	String[][] result_tot = new String[1][1];
    String[][] result = new String[1][7];
    
    String[][] result2 = new String[1][6];
    Date date = new Date();
    DateFormat df = new SimpleDateFormat("yyyyMMdd");   
		String now = df.format(date);
		String sqlStr="";
		String aaa = "0";
		String bbb = "0";
		String ccc = "0";
		String ddd = "0";
		String eee = "0";
		String fff = "0";
		String ggg = "0";
		String tot_dt="0";
		sqlStr = "select "+" to_char(total_date)   from wlimitedfee where limit_type='tf' and  region_code='"+regionCode+"'";
		 System.out.println("---------sql----------="+sqlStr);
		  int temp4=Integer.parseInt(now);
		int temp2=Integer.parseInt(time);
		int flag=0;
		 if(temp2>temp4)
		{
		   flag=0;
		 }
		else{
		  flag=1;
		 try{
		 
		
		 
		 
%>
		<wtc:pubselect name="TlsPubSelBoss" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="retList_tot" scope="end" />
<%		
		result_tot = retList_tot;
		tot_dt = result_tot[0][0];
		
		int temp1=Integer.parseInt(tot_dt);
		
		System.out.println("---------sql----------="+temp1);
		System.out.println("---------sql----------="+temp2);
 	
	
 
    if(temp2>=temp1)
    {
    	sqlStr = "select"  
		+" to_char(case when limit_month_beg<=to_number(to_char(sysdate,'yyyymm'))  and limit_month_end>=to_number(to_char(sysdate,'yyyymm')) then limit_month_spe"  
                                     +" else limit_month_def end)," 
        +" to_char(case when limit_day_beg <= to_number(to_char(sysdate,'yyyymmdd')) and limit_day_end>=to_number(to_char(sysdate,'yyyymmdd')) then limit_day_spe" 
                                      +" else limit_day_def end ),"
        +" to_char(nvl(b.total_month,0)),"
        +" to_char(case when limit_month_beg<=to_number(to_char(sysdate,'yyyymm'))  and limit_month_end>=to_number(to_char(sysdate,'yyyymm')) then limit_month_spe"  
                                      +" else limit_month_def end  -nvl(b.total_month,0))," 
        +" to_char(nvl(b.total_day,0)),"
        +" to_char(case when limit_day_beg<=to_number(to_char(sysdate,'yyyymmdd')) and limit_day_end>=to_number(to_char(sysdate,'yyyymmdd')) then limit_day_spe" 
                                      +" else limit_day_def end- nvl(b.total_day,0) )" 
                                      +" ,  trim(to_char(b.total_date)) " 
		+" from    slimitpay a,wlimitedfee b "  
		+" where   a.region_code=b.region_code "
		+" and     a.limit_type=b.limit_type and b.limit_type='tf'"
		+" and     b.region_code='"+regionCode+"'"
		+" and     	b.total_date<='"+time+"'"
		+" and      b.total_date>=to_number(to_char(sysdate,'yyyymm'))*100+1";
	}
    else
    	{
    		sqlStr = "select"     +"  to_char(case when limit_month_beg<= round(b.total_date/100)   and limit_month_end>=round(b.total_date/100) then limit_month_spe"  
                                      +" else limit_month_def end),"  
            +" to_char(case when limit_day_beg <= b.total_date and limit_day_end>=b.total_date then limit_day_spe"  
                                      +" else limit_day_def end ),"
            +" to_char(nvl(b.total_month,0)),"  
            +" to_char(case when limit_month_beg <= round(b.total_date/100)   and limit_month_end>=round(b.total_date/100) then limit_month_spe"  
                                      +" else limit_month_def end  -nvl(b.total_month,0)),  "
            +" to_char(nvl(b.total_day,0)),  "
            +" to_char(case when limit_day_beg <= b.total_date and limit_day_end >=b.total_date then limit_day_spe"  
                                      +" else limit_day_def  end- nvl(b.total_day,0) ) "
                                      +" ,  trim(to_char(b.total_date)) "
			+" from        slimitpay a, wlimitedfeehis b "  
			+" where       a.region_code=b.region_code "
			+" and         a.limit_type=b.limit_type and b.limit_type='tf' " 
			+" and         b.region_code='" + regionCode + "'"
			+" and     	b.total_date<='"+time+"'"
			+" and      b.total_date>=to_number(to_char(sysdate,'yyyymm'))*100+1"
			+" order by b.total_date desc"; 
   	    }
System.out.println("---------sql----------="+sqlStr);
  
%>
		<wtc:pubselect name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="7">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="retList" scope="end" />
<%
		result = retList;
		if(result.length == 0){
			sqlStr="";
			if(now.equals(time))
			{
				sqlStr = "select"
        +" to_char(case when limit_month_beg<=to_number(to_char(sysdate,'yyyymm'))   and limit_month_end>=to_number(to_char(sysdate,'yyyymd'))  then limit_month_spe"  
                                      +" else limit_month_def end),"  
        +" to_char(case when limit_day_beg<=to_number(to_char(sysdate,'yyyymmdd'))  and limit_day_end>=to_number(to_char(sysdate,'yyyymmdd'))  then limit_day_spe"  
                                      +" else limit_day_def end ),"
        +" 0,"
        +" to_char(case when limit_month_beg<=to_number(to_char(sysdate,'yyyymm'))   and limit_month_end>=to_number(to_char(sysdate,'yyyymd'))  then limit_month_spe"  
                                      +" else limit_month_def end)," 
        +" 0," 
        +" to_char(case when limit_day_beg<=to_number(to_char(sysdate,'yyyymmdd'))  and limit_day_end>=to_number(to_char(sysdate,'yyyymmdd'))  then limit_day_spe"  
                                      +" else limit_day_def end )"
		+" from    slimitpay a" 
		+" where   a.limit_type='tf' "  
		+" and     a.region_code='" + regionCode + "'";
			}
			else
			{
				sqlStr = "select"  
				+" to_char(case when limit_month_beg <= round('" + time + "'/100)   and limit_month_end >=round('" + time + "'/100)    then limit_month_spe"  
                                      +" else limit_month_def end), " 
        +" to_char(case when limit_day_beg <= '" + time + "'   and limit_day_end >='" + time + "'   then limit_day_spe"  
                                      +" else limit_day_def end ),"
        +" 0,"
        +" to_char(case when limit_month_beg <= round('" + time + "'/100)   and limit_month_end >=round('" + time + "'/100)    then limit_month_spe"  
                                      +" else limit_month_def end)," 
        +" 0," 
        +" to_char(case when limit_day_beg <= '" + time + "'   and limit_day_end>='" + time + "'   then limit_day_spe"  
                                      +" else limit_day_def end )"
		+" from    slimitpay a "
		+" where   a.limit_type='tf'"   
		+" and     a.region_code='" + regionCode + "'";
			}
			System.out.println("---------sql----------="+sqlStr);
		 
%>
	<wtc:pubselect name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="6">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="retList2" scope="end" />
<%
		    result2 = retList2;
		    aaa = result2[0][0];
			bbb = result2[0][1];
			ccc = result2[0][2];
			ddd = result2[0][3];
			eee = result2[0][4];
			fff = result2[0][5];
			
			
			
		}
		else{
	 
	 		
			aaa = result[0][0];
			bbb = result[0][1];
			ccc = result[0][2];
			ddd = result[0][3];
			eee = result[0][4];
			fff = result[0][5];
			ggg = result[0][6];
			int temp3=Integer.parseInt(ggg);
			System.out.println("---------sql333----------="+temp3);
		System.out.println("---------sql3333----------="+temp2);
			if(temp2!=temp3)
			{
				eee = "0";
            	fff = bbb;
			}
			
			
			
			}
	 }  
	 catch(Exception ex){
		
	}
	}
	String aa = aaa.charAt(0)+"";
	if(aa.equals(".")){
		aaa="0"+aaa;
	}
		

	String bb = bbb.charAt(0)+"";
	if(bb.equals(".")){
		bbb="0"+bbb;
	}

	String cc = ccc.charAt(0)+"";
	if(cc.equals(".")){
		ccc="0"+ccc;
	}

	String dd = ddd.charAt(0)+"";
	if(dd.equals(".")){
		ddd="0"+ddd;
	}

	String ee = eee.charAt(0)+"";
	if(ee.equals(".")){
		eee="0"+eee;
	}

	String ff = fff.charAt(0)+"";
	if(ff.equals(".")){
		fff="0"+fff;
	}
	


%> 	

<HTML>
<HEAD>
<TITLE>黑龙江BOSS-退预存款信息</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0"  background="<%=request.getContextPath()%>/images/jl_background_2.gif">
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
          <td align="right" width="73%"> 
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                        <td background="<%=request.getContextPath()%>/images/jl_background_4.gif" align="left"><font color="FFCC00"><b>退预存款信息</b></font></td>
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
             <%if (flag==1) {%>
              <tr bgcolor="E8E8E8"> 
                  <td width="15%" class="blue">退预存款的当前月限额：</td><td width="35%"><%=aaa%>元</td>  
              </tr>
              <tr bgcolor="F5F5F5">
                  <td width="15%" class="blue">当前日限额：</td><td width="35%"><%=bbb%>元</td>
              </tr>
              <tr bgcolor="E8E8E8"> 
                  <td width="15%" class="blue">当月已累计的退预存款金额 ：</td><td width="35%"><%=ccc%>元</td>  
              </tr>
              <tr bgcolor="F5F5F5"> 
                  <td width="15%" class="blue">当月尚可退预存款的金额：</td><td width="35%"><%=ddd%>元</td>
              </tr>
              <tr bgcolor="E8E8E8"> 
                  <td width="15%" class="blue">当日已累计的退预存款金额：</td><td width="35%"><%=eee%>元</td>  
              </tr>
              <tr bgcolor="F5F5F5"> 
                  <td width="15%" class="blue">当日尚可退预存款的金额：</td><td width="35%"><%=fff%>元</td>
              </tr>
               <%}
               else{
            	%>
            	<tr bgcolor="E8E8E8"> 
                  <td width="15%" class="blue">请输入小于或等于当前时间的日期！</td> 
              </tr>
               
               <%}%>
               
            </table>             
            <table width="100%" border=0 align=center cellpadding="4" cellspacing=1>
              <tbody> 
              <tr bgcolor="#EEEEEE"> 
                <td bgcolor="F5F5F5" width="100%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;              
                  <input class="button" name=reset type=reset value=关闭 onClick="window.close();">
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