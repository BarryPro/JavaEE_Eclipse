<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>

<%
	  String workno=(String)session.getAttribute("workNo");    //工号
	  String beginDate = request.getParameter("beginDate");
	  String endDate = request.getParameter("end_dt");
	  String opCode = "g468";
      String opName = "终端刷码/二码拆包不认可充值查询结果";
	  String check_code=request.getParameter("check_code");
	  String check_no=request.getParameter("check_no");
	  //String loginno=request.getParameter("loginno");
	  String phoneno=request.getParameter("phoneno");
	  //开始 结束
	  String print_begin = request.getParameter("print_begin");
	  String print_end = request.getParameter("print_end");
	  // xl add for gjz
	  String gjz = request.getParameter("gjz");
	  String sjhm = request.getParameter("sjhm");
	  String ret_val_new[][];
	  //xl add 查询
	  String[] inParas2 = new String[2];
	  String q_flag = request.getParameter("q_flag"); //0手机号码 1日期+关键字
	  System.out.println("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF q_flag is "+q_flag);
	  if(q_flag=="0" || q_flag.equals("0"))
	  {
		  System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
		  /*
		  inParas2[0]=" select to_char(phone_no),substr(note,0,200)||op_note from wbackchgopr where phone_no =:phone_No and      to_char(op_time,'YYYYMMDD')>=:s_date and to_char(op_time,'YYYYMMDD') <=:s_end_date and back_flag in ('1','2') and login_No=:login_No ";
		  inParas2[1]="phone_No="+sjhm+",s_date="+beginDate+",s_end_date="+endDate+",login_No="+workno;
		  */
		  inParas2[0]=" select to_char(phone_no),substr(note,0,200)||op_note from wbackchgopr where phone_no =:phone_No and back_flag in ('1','2') and login_No=:login_No ";
		  inParas2[1]="phone_No="+sjhm+",login_No="+workno;
	  }
	  if(q_flag=="1" || q_flag.equals("1"))
	  {
		  System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
		  if(gjz.equals(""))
		  {
		     System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCCCC");
			  inParas2[0]=" select to_char(phone_no),substr(note,0,200)||op_note from wbackchgopr where to_char(op_time,'YYYYMMDD')  >=:s_date and to_char(op_time,'YYYYMMDD') <=:s_end_date and back_flag in ('1','2') and login_No=:login_No ";
			  inParas2[1]="s_date="+beginDate+",s_end_date="+endDate+",login_No="+workno;
	  	  }
	  	  else if(beginDate.equals("") && endDate.equals(""))
	  	  {
	  	  	  System.out.println("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
	  	  	  inParas2[0]=" select to_char(phone_no),substr(note,0,200)||op_note from wbackchgopr where back_flag in ('1','2') and op_note =:s_note and login_No=:login_No ";
			  inParas2[1]="s_note="+gjz+",login_No="+workno;
	  	  }
	      else
	      {
	      	  System.out.println("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
	      	  inParas2[0]=" select to_char(phone_no),substr(note,0,200)||op_note from wbackchgopr where to_char(op_time,'YYYYMMDD')  >=:s_date and to_char(op_time,'YYYYMMDD') <=:s_end_date and back_flag in ('1','2') and op_note =:s_note and login_No=:login_No ";
			  inParas2[1]="s_date="+beginDate+",s_end_date="+endDate+",s_note="+gjz+",login_No="+workno;
	      }
	  }	

	  /*
	  if(gjz=="" || gjz.equals("")  )
	  {
			
	  }
	  else
	  {
		  inParas2[0]=" select to_char(phone_no),substr(note,0,200)||op_note from wbackchgopr where to_char(op_time,'YYYYMMDD')=:s_date and back_flag in ('1','2') and login_No=:login_No and op_note=:notes ";
		 
		  inParas2[1]=" s_date="+beginDate+",login_No="+workno+",notes="+gjz;
	   }*/
	   System.out.println("FFFFFFFFFFFFFFFFFFFFFFf inParas2[0] is "+inParas2[0]+" and inParas2[1] is "+inParas2[1]);
%>
	
	  
   
	 <wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
	<%
		if(ret_val==null||ret_val.length==0)
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("查询结果为空,请重新查询！");
					window.location.href='g468show.jsp';
				</script>
			<%
		}
		else
		{
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
	function exportExcel(DivID){
 //先声明Excel插件、Excel工作簿等对像
 var jXls, myWorkbook, myWorksheet;
 
 try {
  //插件初始化失败时作出提示
  jXls = new ActiveXObject('Excel.Application');
 }catch (e) {
	return false;
 }
 
 //不显示警告 
 jXls.DisplayAlerts = false;
 
 //创建AX对象excel
 myWorkbook = jXls.Workbooks.Add();
 //myWorkbook.Worksheets(3).Delete();//删除第3个标签页(可不做)
 //myWorkbook.Worksheets(2).Delete();//删除第2个标签页(可不做)
 
 //获取DOM对像
 var curTb = document.getElementById(DivID);
 
 //获取当前活动的工作薄(即第一个)
 myWorksheet = myWorkbook.ActiveSheet; 
 
 //设置工作薄名称
 myWorksheet.name="NP统计";
 
 //获取BODY文本范围
 var sel = document.body.createTextRange();
 
 //将文本范围移动至DIV处
 sel.moveToElementText(curTb);
 
 //选中Range
 sel.select();
 
 //清空剪贴板
 window.clipboardData.setData('text','');
 
 //将文本范围的内容拷贝至剪贴板
 sel.execCommand("Copy");
 
 //将内容粘贴至工作簿
 myWorksheet.Paste();
 
 //打开工作簿
 jXls.Visible = true;
 
 //清空剪贴板
 window.clipboardData.setData('text','');
 jXls = null;//释放对像
 myWorkbook = null;//释放对像
 myWorksheet = null;//释放对像
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
<div id="Operation_Table">
      <table cellspacing="0" id = "PrintA">
                <tr> 
                  <th>手机号码</th>
				  <th>异常原因</th>
                   
				  
                </tr>
			<%
				for(int i=0;i<ret_val.length;i++)
				{
					%>
						<tr>
							<td><%=ret_val[i][0]%></td>
							<td><%=ret_val[i][1]%></td>
						</tr>
					<%
				}	
			%>
</div>			
         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="window.location = 'g468_1.jsp' " type=button value=返回>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
			 <!-- <input class="b_foot" name=back onClick="toExcel();" type=button value=导出EXCEL>
			 -->
			  <input class="b_foot" name=back onClick="exportExcel('Operation_Table')" type=button value=导出>
			  
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
			<%
		}
	%>	




