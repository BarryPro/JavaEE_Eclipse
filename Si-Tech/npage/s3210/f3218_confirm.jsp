<%/********************
 version v2.0
 开发商 si-tech
 update hejw@ 2009-10-10
********************/
%>
              
<%
  String opName = "查询集团成员列表";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.config.INIT_DATA"%>
<%@ page import="com.sitech.boss.s3210.viewBean.S3210Impl"%>
<jsp:useBean id="s3210" class="com.sitech.boss.s3210.viewBean.S3210Impl" />

<script type="text/javascript" src="date.js"></script>

<%
		
	    String loginNo = (String)session.getAttribute("workNo");
	    String loginName = (String)session.getAttribute("workName");
	    String orgCode = (String)session.getAttribute("orgCode");
	    String ip_Addr = (String)session.getAttribute("ipAddr");
	    
	    String regionCode = (String)session.getAttribute("regCode");
	    String regionName = regionCode;
	    
 
	String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
	String errorCode="444444";
	String[][] errCodeMsg = null;
	String[][] input_paras = new String[1][12];
	String[][] recv_num = new String[3][2];
	String[][] callData = new String[][]{};
	String[][] callData1 = new String[][]{};
	int no=0;
	
	String TOKEN = "~";

	List al = null;
	boolean showFlag=false;	//showFlag表示是否有数据可供显示
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误

  	String opCode = request.getParameter("opCode");
  	String opNote = request.getParameter("opNote");
  	String grpId = request.getParameter("GRPID");
  	String tmpDEPT = request.getParameter("tmpDEPT");
  	String OVERDUE = request.getParameter("OVERDUE");
  	String tmpSTARTDATE = request.getParameter("tmpSTARTDATE");
  	String tmpENDDATE = request.getParameter("tmpENDDATE");
  	String QRYTYPE = request.getParameter("QRYTYPE");
  	String ACCEPTNO = request.getParameter("ACCEPTNO");
  	String BEGINPOSI = request.getParameter("BEGINPOSI");
  	
	input_paras[0][0] = request.getParameter("loginNo"); 	/* 操作工号   */ 
	input_paras[0][1] = request.getParameter("orgCode");	/* 机构编码   */
	input_paras[0][2] = request.getParameter("opCode");		/* 操作代码   */
	input_paras[0][3] = request.getParameter("opNote");		/* 操作备注   */
	input_paras[0][4] = request.getParameter("GRPID");		/* 集团号     */
	input_paras[0][5] = request.getParameter("tmpDEPT");	/* 用户部门     */
	input_paras[0][6] = request.getParameter("OVERDUE");	/* 欠费金额     */
	input_paras[0][7] = request.getParameter("tmpSTARTDATE");/* 起始日期     */
	input_paras[0][8] = request.getParameter("tmpENDDATE");	/* 终止日期     */
	input_paras[0][9] = QRYTYPE;	/* 查询方式     */
	input_paras[0][10] = ACCEPTNO;	/* 流水     */
	input_paras[0][11] = BEGINPOSI;	/* 记录开始位置     */

 	//[0]:开始位置,[1]:列数
	recv_num[0][0] = "0";
	recv_num[0][1] = "2";	
	recv_num[1][0] = "2";
	recv_num[1][1] = "3";	
	recv_num[2][0] = "5";
	recv_num[2][1] = "1";	
		
	for(int i=0; i<input_paras[0].length; i++){
		
		if( input_paras[0][i] == null ){
			input_paras[0][i] = "";
		}
		System.out.println("["+i+"]="+input_paras[0][i]);
	}

    String region_code = orgCode.substring(0,2);
    
%>

    <wtc:service name="s3218Cfm" outnum="10" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=input_paras[0][0]%>" />
			<wtc:param value="<%=input_paras[0][1]%>" />	
			<wtc:param value="<%=input_paras[0][2]%>" />
			<wtc:param value="<%=input_paras[0][3]%>" />
			<wtc:param value="<%=input_paras[0][4]%>" />
			<wtc:param value="<%=input_paras[0][5]%>" />
			<wtc:param value="<%=input_paras[0][6]%>" />
			<wtc:param value="<%=input_paras[0][7]%>" />
			<wtc:param value="<%=input_paras[0][8]%>" />
			<wtc:param value="<%=input_paras[0][9]%>" />
			<wtc:param value="<%=input_paras[0][10]%>" />
			<wtc:param value="<%=input_paras[0][11]%>" />
		</wtc:service>
		<wtc:array id="result_t1" scope="end" start="0"  length="2" />
		<wtc:array id="result_t2" scope="end" start="2"  length="3" />
		<wtc:array id="result_t3" scope="end" start="5"  length="1" />	

<%
    //al = s3210.get_commDyn( opCode,"s3218Cfm",recv_num,input_paras );

  if( result_t1 == null||result_t2 == null||result_t3 == null ){
 		System.out.println("======jsp3212:array is null!!===");
		valid = 1;
	}
	else
	{
		errCodeMsg = result_t1;
		errorCode = errCodeMsg[0][0];
		if (errorCode != null)
		{
			errorCode.trim();
		}
		if( Integer.parseInt(errorCode) != 0)
		{
			valid = 2;
			//errorMsg= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errCodeMsg[0][0]));
			errorMsg = errCodeMsg[0][1];
		}
		else
		{
			valid = 0;
			callData = result_t3;
			callData1 = result_t2;	
			no = Integer.parseInt(BEGINPOSI)+1;
		}
	}

	for(int i=0;i<callData1.length;i++){
		for(int j=0; j<callData1[0].length;j++){
			//System.out.println("callData1["+i+"]["+j+"]="+callData1[i][j] );
		}
	
	}

%>

<%if( valid != 0 ){ //System.out.println("===111valid=="+valid); %>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<br>错误代码:"+"<%=errorCode%></br>"+"错误信息:"+"<%=errorMsg%>");
	history.go(-1);

//-->
</script>
<%}else{%>


<head>
<title>查询集团成员列表</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<script language="JavaScript">
<!--
	//定义应用全局的变量
	var SUCC_CODE	= "0";   		//自己应用程序定义
	var ERROR_CODE  = "1";			//自己应用程序定义
	var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改
	var dynTbIndex=1;				//用于动态表数据的索引位置,开始值为1.考虑表头
	var LIST_ROWS =  20;
	

function DoPageDown()
{
	document.all.QRYTYPE.value="1";
	if ( parseInt(document.all.curPosi.value) >= parseInt(document.all.TOTALNUM.value) )
	{
		rdShowMessageDialog("数据显示完毕！");
		return false;
	}
	
	document.all.BEGINPOSI.value= parseInt(document.all.BEGINPOSI.value) + LIST_ROWS;
	document.frm.submit();	
}
function DoOnePage()
{
	document.all.QRYTYPE.value="0";//0:第一次,1:折返
	document.all.BEGINPOSI.value= "0";
	document.frm.submit();	
}
function DoPageUp()
{
	document.all.QRYTYPE.value="1";

	if ( parseInt(document.all.TOTALNUM.value) <= LIST_ROWS ){
		rdShowMessageDialog("目前只有一页数据");
		return false;
	}
	if ( parseInt(document.all.BEGINPOSI.value) < LIST_ROWS )
	{
		rdShowMessageDialog("目前是第一页！");
		return false;
	}	

	document.all.BEGINPOSI.value= parseInt(document.all.BEGINPOSI.value) - LIST_ROWS;
	
	document.frm.submit();	
}
           			
//-->
</script>

</head>


<body>
<form name="frm" method="post" action="">
<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">查询集团成员列表</div>
	</div>
                 
        
        <table cellspacing="0">
          <tr > 
            <td class="blue">集团号</td>
            <td ><input name="GRPID" type="text" class="button" id="GRPID" value="<%=grpId%>" disabled></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>
        <table cellspacing="0">
          <tr> 
            <th  nowrap align="center">短号    </th>
            <th  nowrap align="center">真实号码</th>
            <th  nowrap align="center">用户姓名</th>
            <th  nowrap align="center">证件号码</th>
            <th  nowrap align="center">描述信息</th>
            <th  nowrap align="center">用户部门</th>
            <th  nowrap align="center">封锁标志</th>
            <th  nowrap align="center">欠费金额</th>
            <th  nowrap align="center">开户时间</th>
          </tr>
          <%for (int i=0;i<callData.length;i++){
          	String tdClass = ((i%2)==1)?"Grey":"";
          %>
          <tr>
          <td  class="<%=tdClass%>">
            <div align="center"><%=S3210Impl.getOneTok(callData[i][0],TOKEN,1)%></div>
          </td>
          <td  class="<%=tdClass%>">
          	<div align="center"><%=S3210Impl.getOneTok(callData[i][0],TOKEN,2)%></div>
           </td>
          <td  class="<%=tdClass%>"> 
          	<div align="center"><%=S3210Impl.getOneTok(callData[i][0],TOKEN,3)%></div>
          </td>
          <td  class="<%=tdClass%>"> 
          	<div align="center"><%=S3210Impl.getOneTok(callData[i][0],TOKEN,4)%></div>
          </td>
          <td  class="<%=tdClass%>"> 
          	<div align="center"><%=S3210Impl.getOneTok(callData[i][0],TOKEN,5)%></div>
          </td>
          <td  class="<%=tdClass%>"> 
          	<div align="center"><%=S3210Impl.getOneTok(callData[i][0],TOKEN,6)%></div>
          </td>
          <td  class="<%=tdClass%>"> 
          	<div align="center"><%=S3210Impl.getOneTok(callData[i][0],TOKEN,7)%></div>
          </td>
          <td  class="<%=tdClass%>"> 
          	<div align="center"><%=S3210Impl.getOneTok(callData[i][0],TOKEN,8)%></div>
          </td>
          <td  class="<%=tdClass%>"> 
          	<div align="center"><%=S3210Impl.getOneTok(callData[i][0],TOKEN,9)%></div>
          </td>          
          </tr>
          <%}%>
        </table>  
        <TABLE cellSpacing="0">
          <TBODY> 
          <TR  > 
            <TD noWrap colspan="5" width="40%"> 
              <div align="center">显示第<%=no%>条到第<%=callData1[0][2]%>条 </div>
            </TD>
            <TD noWrap width="15%" colspan='4'> 
              <input type="button" name="close1" class="b_text" value="返回" onClick="window.location='f3218.jsp'">
            </TD>
          </TR>
          </TBODY> 
        </TABLE>                
  </table>
  
  	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
  	<input type="hidden" name="loginName" id="loginName" value="">
  	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
  	<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
  	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">

	<input type="hidden" name="opNote" id="opNote" value="<%=opNote%>">
	<input type="hidden" name="GRPID" id="GRPID" value="<%=grpId%>">
	<input type="hidden" name="tmpDEPT" id="tmpDEPT" value="<%=tmpDEPT%>">
	<input type="hidden" name="OVERDUE" id="OVERDUE" value="<%=OVERDUE%>">
	<input type="hidden" name="tmpSTARTDATE" id="tmpSTARTDATE" value="<%=tmpSTARTDATE%>">
	<input type="hidden" name="tmpENDDATE" id="tmpENDDATE" value="<%=tmpENDDATE%>">

  	<input type="hidden" name="QRYTYPE" id="QRYTYPE" value="">
  	<input type="hidden" name="ACCEPTNO" id="ACCEPTNO" value="<%=callData1[0][0]%>">
  	<input type="hidden" name="TOTALNUM" id="TOTALNUM" value="<%=callData1[0][1]%>">
  	<input type="hidden" name="BEGINPOSI" id="BEGINPOSI" value="<%=BEGINPOSI%>">
  	<input type="hidden" name="curPosi" id="curPosi" value="<%=callData1[0][2]%>">
  	  	  	
		<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<%}%>