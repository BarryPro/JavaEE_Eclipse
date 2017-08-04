<%
  /*
   * 功能: 客服一级报表录入信息表
　 * 版本: 1.0.0
　 * 日期: 2009/09/07
　 * 作者: yinzx
　 * 版权: sitech
   * 
　 */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.*,com.sitech.boss.util.excel.*"%>


<%!
//导出Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
        XLSExport e  =   new  XLSExport(null);
        String headname = "业务咨询结点信息导出";//Excel文件名
        try {
        OutputStream os = response.getOutputStream();//取得输出流
        response.reset();//清空输出流
        response.setContentType("application/ms-excel");//定义输出类型
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//设定输出文件头
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7],queryList[i][8],queryList[i][10]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
           System.out.println( " 导出Excel文件[成功] ");
        }catch  (Exception e1) {
           System.out.println( " 导出Excel文件[失败] ");
           e1.printStackTrace();
        } 
    }
    
    
    public void getExecl(String[][] queryList,String[] strHead,HttpServletResponse response){
       this.toExcel(queryList, strHead, response); 
    }
     
%>

<%
  String strSql="";
  String addvalxin = "";
 
 
  String querySql = (String)request.getParameter("querySql");
  
  	String[] strHead = { "结点编号", "父结点编号", "特定流程标志", "流程的中文名称", "接入码",
			"地市代码","用户级别", "按键路由", "用户类别","短信内容"  };
 
 
    
     
%>

<wtc:service name="s151Select" outnum="13">
	<wtc:param value="<%=querySql%>" />
</wtc:service>
<wtc:array id="queryList" start="0" length="11" scope="end" />

 


<%
   this.toExcel(queryList, strHead, response); 
  
%>
<script language="javascript"  >
	window.close();
</script>