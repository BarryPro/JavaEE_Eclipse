<%
/********************
 version v2.0
开发商: si-tech
功能:综合信息查询之预存分类信息
update:liutong@2008-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1500";
	String opName = "综合信息查询之预存分类信息";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String contract_no  = request.getParameter("contractNo");
	String bank_cust  = request.getParameter("bankCust");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String cust_name=request.getParameter("custName");
	String phoneNo = request.getParameter("phoneNo");
 
	
	String sql_str0="";
	String[] inParas2 = new String[2];
	inParas2[0]="SELECT bill_flag FROM cBillCond WHERE run_flag=1 and to_number(to_char(sysdate,'ddhh24')) between begin_dayhour and end_dayhour";
%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=inParas2[0]%>"/>
	</wtc:service>
	<wtc:array id="result0" scope="end" />
<%	
	String bill_flag ="";
	if(result0==null||result0.length==0){
	}else{
		bill_flag  = (result0[0][0]).trim();
	}
 
	String sql_str;
	
	if(bill_flag.equals("1")){
		inParas2[0]="select pay_name,prepay_fee,last_prepay,add_prepay,live_flag,case when (allow_pay>prepay_fee) then to_char(prepay_fee) else to_char(allow_pay) end,begin_dt,end_dt ,b.pay_type,decode(b.trans_flag,'0','可转','1','不可转'),to_char(b.order_code)  from dConMsgPreMid36 a,sPayType b where a.pay_type=b.pay_type and a.contract_no=:contractNo and a.pay_type not in (select new_pay_type from cbillcond where rownum < 2) union all select pay_name,prepay_fee,last_prepay,add_prepay,live_flag,allow_pay,begin_dt,end_dt ,b.pay_type,decode(b.trans_flag,'0','可转','1','不可转'),to_char(b.order_code) from dConMsgPre a,sPayType b where a.pay_type=b.pay_type  and begin_dt<=to_char(sysdate,'yyyymmdd') and end_dt> to_char(sysdate,'yyyymmdd') and a.contract_no=:contractNo2 and a.pay_type = (select new_pay_type from cbillcond where rownum < 2)";
		inParas2[1]="contractNo="+contract_no+",contractNo2="+contract_no;
	 

	}else{
		inParas2[0]="select pay_name||'('||b.pay_type||')',prepay_fee,last_prepay,add_prepay,live_flag,case when (allow_pay>prepay_fee) then to_char(prepay_fee) else to_char(allow_pay) end,begin_dt,end_dt,b.pay_type,decode(b.trans_flag,'0','可转','1','不可转'),to_char(b.order_code),case  when (prepay_fee=0.00) then '' when (allow_pay=999999.00) then ''  else to_char(floor(months_between(to_date(end_dt,'yyyymmdd'),to_date(to_char(sysdate,'YYYYMMDD'),'yyyymmdd')))) end ,case when (allow_pay!=999999.00) then '1' when (a.pay_type='T') then '5' else '' end,case when (allow_pay=0.00) then '拆包' when (allow_pay!=999999.00) then '未拆包'  else '' end from dConMsgPre a,sPayType b  where a.pay_type=b.pay_type and begin_dt<=to_char(sysdate,'yyyymmdd') and end_dt> to_char(sysdate,'yyyymmdd')  and a.contract_no=:contractNo order by begin_dt asc";
		inParas2[1]="contractNo="+contract_no;
	}
	 
	 
%>

	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="14">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
	
	<%

	/**try{
	 	S1100View callView = new S1100View();
		arlist = callView.view_spubqry32("8",sql_str);
	}
	catch(Exception e)
	{
		//System.out.println("调用EJB发生失败！");
	}
	String [][] result = new String[][]{{"0","1","2","3","4","5","6","7"}};
	int result_row = Integer.parseInt((String)arlist.get(1));
	**/
	
	
if(!retCode2.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("服务未能成功,服务代码<%=retCode2%><br>服务信息<%=retMsg2%>!");
			history.go(-1);
		</script>
<%
		return;
	}


	if (result==null||result.length==0)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("<br>没有符合条件的数据",1);
	history.go(-1);
</script>
<%	}
%>

<HTML><HEAD><TITLE>预存分类信息</TITLE>
</HEAD>
<body>
	<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">预存分类信息</div>
			</div>
<FORM method=post name="f1500_dConMsgPre">
     
            <TABLE  cellSpacing="0">
              <TBODY>
                <TR align="center">
                  <th>帐户科目</th>
                  <th>预存金额</th>
                  <th>上次预存</th>
                  <th>本期发生</th>
                  <th>活动标志</th>
                  <th>当前可划拨</th>
                  <th>专款开始日期</th>
                  <th>专款结束日期</th>
				  <th>专款类型</th>
				  <th>专款是否可转</th>
				  <th>预存优先级别</th>
				  <th>剩余返还月数(月数)</th>
				  <th>每月返还时间(日)</th>
				  <th>上月是否拆包</th>
				  
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
		    System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA phoneNo is "+phoneNo+" and result[0].length is "+result[0].length);
			for(int j=0;j<result[0].length;j++)
	        {
				if((j==0) &&(result[y][8].equals("AQ")||result[y][8].equals("R")||result[y][8].equals("CC")||result[y][8].equals("CD")||result[y][8].equals("CZ")))
				{
					%><td class="<%=tbClass%>"><a href="f1500_details.jsp?paytype=<%=result[y][8]%>&phoneNo=<%=phoneNo%>"><%= result[y][j]%></a></td><%
				}
				else if(j==0)
				{
					%><td class="<%=tbClass%>"><a href="f1500_spec_func.jsp?paytype=<%=result[y][8]%>&phoneNo=<%=phoneNo%>"><%= result[y][j]%></a></td><%
				} 
				else if((j==13) )
				{
					%>
						<td class="<%=tbClass%>">
						<%
							if(result[y][13]=="拆包"||result[y][13].equals("拆包"))
							{
								%>
								<a href="f1500_cb.jsp?paytype=<%=result[y][8]%>&phoneNo=<%=phoneNo%>&begindt=<%=result[y][6]%>"><%= result[y][j]%></a></td>
								<%
							}
							else
							{
								%>
								<%= result[y][j]%></td>
								<%
							}
						%>
						
					<%
				}
				else  
				{
					%><td class="<%=tbClass%>"><%= result[y][j]%></td><%
				}
				 
%>				
	          
<%	        
					}
%>
	          </tr>
<%	      }
%>	
	<!--
	<tr>
		<td colspan=10>
			注：预存优先级别数字越大，优先级别越低。
		</td>
	</tr>
	-->
        </TBODY>
	    </TABLE>
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id=footer>
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
