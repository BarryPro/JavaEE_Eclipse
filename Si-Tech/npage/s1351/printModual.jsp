<%@ page contentType="text/html;charset=GB2312"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.s1210.viewBean.S1210Impl"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.pub.util.ErrorMsg"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<%
	
	String phoneno = request.getParameter("phoneno");	
	String print_date = request.getParameter("yearmonth");	
	String show_mode = request.getParameter("show_mode");	
	String workNo = request.getParameter("workno");	
	String org_code = request.getParameter("org_code");	
	String op_code = request.getParameter("op_code");	
	String moren=request.getParameter("moren");	
	int errCode=0;	String errMsg = "";
	ArrayList acceptList = new ArrayList();
	String[][] return_code = new String[][]{};
	String[][] return_msg  = new String[][]{}; 
	String[][] show_name    = new String[][]{};
	String[][] line         = new String[][]{};
	String[][] list         = new String[][]{};
	String[][] font_num     = new String[][]{};
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
 String paramsIn1[] = new String[8];
	if(moren!=null&&!moren.equals(""))
	{

	

	paramsIn1[0]=phoneno;
	paramsIn1[1]=print_date.substring(0,6);
	paramsIn1[2]="moren";
	paramsIn1[3]=workNo;
	paramsIn1[4]=org_code;
	paramsIn1[5]="2787";

	
	
	
	acceptList = callView.callFXService("s2734Cfm", paramsIn1, "18");	
	//callView.printRetValue();
  errCode = callView.getErrCode();
  errMsg = callView.getErrMsg();


	
	
	}
else{

	

	

	paramsIn1[0]=phoneno;
	paramsIn1[1]=print_date.substring(0,6);
	paramsIn1[2]=show_mode;
	paramsIn1[3]=workNo;
	paramsIn1[4]=org_code;
	paramsIn1[5]="2787";

	
	
	
	acceptList = callView.callFXService("s2734Cfm", paramsIn1, "18");	
	//callView.printRetValue();
  errCode = callView.getErrCode();
  errMsg = callView.getErrMsg();


	
	}
	if(errCode!=0)
	{
	%>
	<script>
		rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	  history.go(-1);
	</script>
		<%
	}else{
	
	 return_code  = (String[][])acceptList.get(0);     //0	code  		
	 return_msg   = (String[][])acceptList.get(1);		 //1	msg
	 show_name    = (String[][])acceptList.get(17);     //2 显示名称       
	 line         = (String[][])acceptList.get(5);     //3	显示行数       
	 list         = (String[][])acceptList.get(6);     //4	显示列数   	
	 font_num     = (String[][])acceptList.get(7);     //5	字体大小  		
		
		
	for(int i=0;i<show_name.length;i++){
		for(int j=0;j<show_name[i].length;j++){
			System.out.println("show_name["+i+"]["+j+"]:"+show_name[i][j]);
			System.out.println("line["+i+"]["+j+"]:"+line[i][j]);
			System.out.println("list["+i+"]["+j+"]:"+list[i][j]);
		}
	}

	}
			
	%>

<html>
<head>
<title>账单模板预览</title>
<SCRIPT language="JavaScript">
function printInvoice() {
	  
	  
	  var infoStr="aaa";

    printctrl.Setup(0) ;
	  printctrl.StartPrint();
	  printctrl.PageStart();

		var startCol=20;
    var startRow=7;
    

<%
		for(int i=0;i<line.length;i++)
		{
%>
      printctrl.Print(<%=list[i][0]%>,<%=line[i][0]%>,<%=font_num[i][0]%>,0,"<%=show_name[i][0]%>");     
<%	
		}
%>
      
	printctrl.PageEnd() ;
	printctrl.StopPrint();
	

}

function ifprint() {
   printInvoice();
   window.close();
}
</SCRIPT>
</head>


<body onload="ifprint()">
<OBJECT ID="printctrl" CLASSID="CLSID:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
	classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"

	codebase="/ocx/printatl.dll#version=1,0,0,1"

	id="printctrl"
	
	VIEWASTEXT>
</OBJECT>
</html>