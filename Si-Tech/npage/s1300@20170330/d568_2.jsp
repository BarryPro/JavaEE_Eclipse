<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "d568";
    String opName = "自助终端缴费信息查询结果";
	  String check_code=request.getParameter("check_code");
	  String check_no=request.getParameter("check_no");
	  String loginno=request.getParameter("loginno");
	  String phoneno=request.getParameter("phoneno");
	  //开始 结束
	  String print_begin = request.getParameter("print_begin");
	  String print_end = request.getParameter("print_end");
	  String ret_val[][];
	  String ret_val_new[][];
	  int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
		int recordcount=0;
	
 
		
 
 
 

//拼接sql 使用stringBuffer where 1=1 and~~   sbuffer.append("");
/*
设计： 这里应该是for循环,分别取出每个月的分表的记录，然后展现?
	   for循环的条件是 YYYYMM取出月数。
	   for(k=vBeginTime;k<=vEndTime;)
*/
int iBegin = Integer.parseInt(print_begin);
int iEnd = Integer.parseInt(print_end);
int vYear=0;
int vMonth = 0;
vYear = iBegin/100;
vMonth=iBegin%100;	
int k = 0;



 
%>
   
	 
 
<script language = "javascript">
	function toExcel(){
		 var oXL = new ActiveXObject("Excel.Application"); 
	　　 var oWB = oXL.Workbooks.Add(); 
	　　 var oSheet = oWB.ActiveSheet; 
	　　 var Lenr = PrintA.rows.length;
	　　 for (i=0;i<Lenr;i++) 
	　　 { 
	　　 var Lenc = PrintA.rows(i).cells.length; 
	　　 for (j=0;j<Lenc;j++) 
	　　 { 
	　　 oSheet.Cells(i+1,j+1).value = PrintA.rows(i).cells(j).innerText; 
	　　 } 
	　　 } 
	　　 oXL.Visible = true; 
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>自助终端查询结果</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询结果</div>
</div>

      <table cellspacing="0" id = "PrintA">
                <tr> 
                  <th>发票代码</th>
				  <th>发票号码</th>
                  <th>终端编号(设备号)</th> 
				  <th>受理工号</th>
				  <th>受理流水</th>
				  <th>交费日期</th>
				  <th>交费号码</th>
				  <th>品牌</th>
				  <th>客户名称</th>
				  <th>交费金额(大写)</th>
				  <th>交费金额(小写)</th>
				  <th>原话费余额</th>
				  <th>本次交话费</th>
				  <th>话费余额</th>
				  <th>未出帐话费</th>
				  <th>当前可用余额</th>
				  <th>协议号码</th>
				  <th>银行卡卡号</th>
				  <th>检索参考号</th>
				  <th>卡类别名称</th>
				  <th>终端号</th>
				  <th>商户号</th>
				  <th>统一预存赠礼活动信息描述</th>
				  <th>备注信息</th>
				  <th>打印时间</th>
				  <th>打印地点</th>
				  <th>发票类型标识(01:现金交费;02:统一预存赠礼;03:银行卡缴费)</th>
				  <th>发票内容记录日期</th>
				  <th>其他备注信息</th>
				  
                </tr>
<%
for(k=iBegin;k<=iEnd;  )
{
		
	StringBuffer sbuffer = new StringBuffer();
	sbuffer.append(" select * from DBSELFADM.TD_PTL_LOG_INVOICEPRINT");	 
	sbuffer.append(k);
	//sbuffer.append("201105");
	sbuffer.append(" where 1 =1 ");
	//拼接查询条件
	//发票代码
	if((check_code!=null) && !(check_code.equals(""))){
		sbuffer.append(" and INVOICE_CODE = "+"'"+check_code+"'" );
	}
	//发票号码
	if((check_no!=null) && !(check_no.equals(""))){
		sbuffer.append(" and INVOICE_NO = "+"'"+check_no+"'" );
	}
	//受理工号
	if((loginno!=null) && !(loginno.equals(""))){
		sbuffer.append(" and LOGIN_NO = "+"'"+loginno+"'" );
	}
	//缴费号码
	if((phoneno!=null) && !(phoneno.equals(""))){
		sbuffer.append(" and PHONE_NO = "+"'"+phoneno+"'" );
	}
	//System.out.println("\n11111111111111111111111111111111111111111tets the sql is \n"+sbuffer.toString());
	%>
	<script>
	//	alert("sql is "+"<%=sbuffer.toString()%>");
	</script>
	<%
		vMonth++;
		if(vMonth==13)
		{
			vYear++;
			vMonth=1;
		}
		k=vYear*100+vMonth;
    //xl 处理分表查询~~
%>
<wtc:pubselect name="TlsPubSelCrm"   retcode="retCode2" retmsg="retMsg2" outnum="29">
	<wtc:sql><%=sbuffer.toString()%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="ret_val3" scope="end" />
	<%
		ret_val_new =ret_val3 ;
		 
	 //无法做成查询无结果的显示 因为是对分表的循环查询 无法判断是否都无记录~~
for(int y=0;y<ret_val_new.length;y++)
	      {
	
%>
	        <tr>
<%    	        for(int j=0;j<ret_val_new[0].length;j++)
	        {
				
			 
					%>				  
	              <td><%= ret_val_new[y][j]%></td>
<%
				 
	        }
%>
	        </tr>
<%	      
		}
 
	 
	//xl end处理分表查询

}
//end 循环

%>

         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="window.location = 'd568.jsp?activePhone=<%=phoneno%>' " type=button value=返回>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
			  <input class="b_foot" name=back onClick="toExcel();" type=button value=导出EXCEL>
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

