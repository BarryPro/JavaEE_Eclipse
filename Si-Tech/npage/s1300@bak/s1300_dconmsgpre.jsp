<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-18 页面改造,修改样式
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String result[][];
	String opCode = "1302";
	String opName="账号缴费";
	String contract_no  = request.getParameter("contractNo");
	String sql_str0="SELECT to_char(bill_flag) FROM cBillCond WHERE run_flag=1 and to_number(to_char(sysdate,'ddhh24')) between begin_dayhour and end_dayhour";
	String bill_flag ="" ;
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String[] inParas2 = new String[2];
	inParas2[0]="SELECT to_char(bill_flag) FROM cBillCond WHERE run_flag=1 and to_number(to_char(sysdate,'ddhh24')) between begin_dayhour and end_dayhour";
	 
%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:param value="<%=inParas2[0]%>"/>
		</wtc:service>
		<wtc:array id="result0" scope="end" />
		
<%	
	if (result0.length>0){
		bill_flag=(result0[0][0]).trim();
	 
	}
	System.out.println("next");	
	
	String sql_str;
		
	if(bill_flag.equals("1"))	{
		inParas2[0]="select pay_name,to_char(prepay_fee),to_char(last_prepay),to_char(add_prepay),to_char(live_flag),case when (allow_pay>prepay_fee) then to_char(prepay_fee) else to_char(allow_pay) end,begin_dt,end_dt from dConMsgPreMid36 a,sPayType b where a.pay_type=b.pay_type and a.contract_no=:contractNo and a.pay_type not in (select new_pay_type from cbillcond where rownum < 2) union all select pay_name,to_char(prepay_fee),to_char(last_prepay),to_char(add_prepay),live_flag,to_char(allow_pay),begin_dt,end_dt from dConMsgPre a,sPayType b where a.pay_type=b.pay_type  and begin_dt<=to_char(sysdate,'yyyymmdd') and end_dt> to_char(sysdate,'yyyymmdd')  and a.contract_no=::contractNo2 and a.pay_type = (select new_pay_type from cbillcond where rownum < 2)";
		inParas2[1]="contractNo="+contract_no+",contractNo2="+contract_no;
	  //inParas1[1]="service_no="+serviceno+",service_type="+serviceno;	 
	%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="8">
		 
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
result=result1;
	}
	else{
		inParas2[0]="select pay_name,to_char(prepay_fee),to_char(last_prepay),to_char(add_prepay),to_char(live_flag),case when (allow_pay>prepay_fee) then to_char(prepay_fee) else to_char(allow_pay) end,begin_dt,end_dt from dConMsgPre a,sPayType b where a.pay_type=b.pay_type  and begin_dt<=to_char(sysdate,'yyyymmdd') and end_dt> to_char(sysdate,'yyyymmdd')  and a.contract_no=:contractNo";
		inParas2[1]="contractNo="+contract_no; 
	  %>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="8">
		 
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
		
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
    result=result1;
	 
	}

	//System.out.println("sql_str="+sql_str);

	int result_row = result.length;
	if (result_row==0)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("没有符合条件的数据!");
	history.go(-1);
</script>
<%	
	return;
	}
%>

<HTML><HEAD><TITLE>预存分类信息</TITLE>
</HEAD>
<body>
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">预存分类信息</div>
		</div>
    <TABLE cellSpacing="0">
      <TBODY>
        <tr align="center">
          <th>帐户科目</th>
          <th>预存金额</th>
          <th>上次预存</th>
          <th>本期发生</th>
          <th>活动标志</th>
          <th>当前可划拨</th>
          <th>专款开始日期</th>
          <th>专款结束日期</th>
        </TR>
<%	    
			String tbClass="";
		  for(int y=0;y<result.length;y++){
		  		if(y%2==0){
			  		tbClass="Grey";
			  	}else{
			  		tbClass="";	
			  	}
%>
	        <tr align="center">
<%    	        
				for(int j=0;j<result[y].length;j++){
%>
	          <td class="<%=tbClass%>"><%= result[y][j]%></td>
<%	        
				}
%>
	        </tr>
<%	      
			}
%>
        </TBODY>
	    </TABLE>
          
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp;
    	      &nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
   </DIV>
</DIV>
</FORM>
</BODY></HTML>
