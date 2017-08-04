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
	
	String contract_no = request.getParameter("contract_no");	
	String print_date = request.getParameter("print_date");	
	String show_mode = request.getParameter("show_mode_select");	
	String workNo = request.getParameter("workNo");	
	String org_code = request.getParameter("org_code");	
	String op_code = request.getParameter("op_code");	
	String in_print_type1 = request.getParameter("in_print_type1");	
	
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	String paramsIn1[] = new String[6];
	paramsIn1[0]=contract_no;
	paramsIn1[1]=print_date.substring(0,6);
	paramsIn1[2]=show_mode;
	
	paramsIn1[3]=workNo;
	paramsIn1[4]=org_code;
	paramsIn1[5]="2765";
	
	
	System.out.println(contract_no+","+print_date+","+show_mode+","+in_print_type1+","+workNo+","+org_code);
	ArrayList acceptList = new ArrayList();
	
	acceptList = callView.callFXService("s2736Cfm", paramsIn1, "18");	
	//callView.printRetValue();
	int errCode = callView.getErrCode();
	String errMsg = callView.getErrMsg();

	String[][] return_code = new String[][]{};
	String[][] return_msg  = new String[][]{}; 
	String[][] show_name    = new String[][]{};
	String[][] line         = new String[][]{};
	String[][] list         = new String[][]{};
	String[][] font_num     = new String[][]{};

	System.out.println("$$$$$$$$$$$$$$$"+errCode);
	
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
	 show_name    = (String[][])acceptList.get(17);     //2 ��ʾ����       
	 line         = (String[][])acceptList.get(5);     //3	��ʾ����       
	 list         = (String[][])acceptList.get(6);     //4	��ʾ����   	
	 font_num     = (String[][])acceptList.get(7);     //5	�����С  		
		
		
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
<title>�˵�ģ��Ԥ��</title>
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