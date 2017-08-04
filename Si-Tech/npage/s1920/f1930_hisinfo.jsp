<%
  /*
   * 功能: 用户定购关系查询显示页面
   * 版本: 1.8.2
   * 日期: 2005/11/09
   * 作者: huyan
   * 版权: si-tech
  */
%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.15
 模块:订购关系历史查询
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%     
	String opCode = "1933";
	String opName = "订购关系历史查询";
	String org_code = request.getParameter("org_code");
	String work_no = request.getParameter("work_no");
	String password = request.getParameter("login_passwd");
	String ip_address = request.getParameter("ip_address");
	String op_code = "1933";
	String op_note = "";
	String phone_no = request.getParameter("phoneNo");
	String begin_pos = "";
	String maxretnum = "";
	String biztype =request.getParameter("busytype");
	if(biztype==null||biztype.length()<=0){
		biztype="al";
	}
	String workName = request.getParameter("loginName");
	String spid= request.getParameter("spCode");
	String spbizcode= request.getParameter("spBizCode");
	String begintime= request.getParameter("begintime");
	String endtime= request.getParameter("endtime");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String opNote = "订购关系历史查询";
%>
<%
/**
	ArrayList list = new ArrayList();
	String[][] temp=new String[][]{};
	String[][] tmpresult1= new String[][]{};
	String[][] tmpresult2= new String[][]{};
	String[][] tmpresult3= new String[][]{};
	String[][] tmpresult4= new String[][]{};
	String[][] tmpresult5= new String[][]{};
	String[][] tmpresult6= new String[][]{};
	String[][] tmpresult7= new String[][]{};
	String[][] tmpresult8= new String[][]{};
	String[][] tmpresult9= new String[][]{};
	String[][] tmpresult10= new String[][]{};

	String[][] tmpresult11= new String[][]{};
	String[][] tmpresult12= new String[][]{};
	String[][] tmpresult13= new String[][]{};
	String[][] tmpresult14= new String[][]{};
	String[][] tmpresult15= new String[][]{};

	String[][] tmpresult16= new String[][]{};
	String[][] tmpresult17= new String[][]{};
	String[][] tmpresult18= new String[][]{};
	String[][] tmpresult19= new String[][]{};
	String[][] tmpresult20= new String[][]{};
	String[][] tmpresult21= new String[][]{};
	String[][] tmpresult22= new String[][]{};
**/


	String retCode = "";
	String retMessage="";
	String serviceName = "sBizHisQuery";
	
	String[] paraStrIn = new String[]{work_no,org_code,password,op_code,phone_no,biztype,spid,spbizcode,begintime,endtime,begin_pos,maxretnum,ipAddr,opNote};
	String outParaNums= "44";   	
	
	//list = callSvrImpl.callFXService(serviceName, paraStrIn, outParaNums);
%>
	<wtc:service name="sBizHisQuery" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode1" retmsg="retMsg1" outnum="44">			
	<wtc:param value="<%=paraStrIn[0]%>"/>
	<wtc:param value="<%=paraStrIn[1]%>"/>
	<wtc:param value="<%=paraStrIn[2]%>"/>
	<wtc:param value="<%=paraStrIn[3]%>"/>
	<wtc:param value="<%=paraStrIn[4]%>"/>	
	<wtc:param value="<%=paraStrIn[5]%>"/>
	<wtc:param value="<%=paraStrIn[6]%>"/>
	<wtc:param value="<%=paraStrIn[7]%>"/>
	<wtc:param value="<%=paraStrIn[8]%>"/>
	<wtc:param value="<%=paraStrIn[9]%>"/>	
	<wtc:param value="<%=paraStrIn[10]%>"/>
	<wtc:param value="<%=paraStrIn[11]%>"/>
	<wtc:param value="<%=paraStrIn[12]%>"/>
	<wtc:param value="<%=paraStrIn[13]%>"/>
	</wtc:service>	
	<wtc:array id="listTemp"  start="0" length="6" scope="end"/>	
	<wtc:array id="listTemp2" start="6" length="38" scope="end"/>
<%
	retCode = retCode1;
	retMessage = retMsg1;
	//callSvrImpl.printRetValue();
	
	
	
	for(int i=0;i<listTemp2.length;i++){
		for(int j=0;j<listTemp2[i].length;j++){
			System.out.println("#################################listTemp2["+i+"]["+j+"]->"+listTemp2[i][j]);
		}
	}
	

			
	if(!retCode.equals("000000"))
	{%>
	 <script language='jscript'>
		rdShowMessageDialog('<%=retMessage%>' + '[' + '<%=retCode%>' + ']',0);
		history.go(-1);
	</script>
	<%}else{
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>订购关系历史查询</TITLE>
</HEAD>

<script language="JavaScript">
<!--
function docheckbox(seq,ojb){
	/*if(val=="04"){
		var resume="resume"+seq;
		var cancle="cancle"+seq;
		form1[eval('resume')].checked=false;
		form1[eval('cancle')].checked=false;		
	}	
	else if(val=="05"){
		var pause="pause"+seq;
		var cancle="cancle"+seq;
		form1[eval('pause')].checked=false;
		form1[eval('cancle')].checked=false;		
	}
	else if(val=="07"){
		var pause="pause"+seq;
		var resume="resume"+seq;
		form1[eval('pause')].checked=false;
		form1[eval('resume')].checked=false;	
	}*/
	if(ojb.checked){
		var biztype="name"+seq+"10";
		var spid="name"+seq+"12";
		var spbizcode="name"+seq+"14";
		ojb.value=form1[eval('biztype')].value+","+form1[eval('spid')].value+","+form1[eval('spbizcode')].value;
		alert(ojb.value);
	}
	
	
}

//--------全选--------------
function allSelect()
{
	var i = 0;
	
	//一行都没有
	if(document.all.check==undefined)
	{
		rdShowMessageDialog("此目录下没有权限,无法全部选中！");
		return;
	}
	//只有一行
	if(document.all.check.length==undefined)
	{
		document.all.check.checked=true;	
	}
	for(i=0;i<document.all.check.length;i++)
	{
		document.all.check[i].checked=true;	
	}
	
}


function doconfirm(){
	var flag=0;
	if(document.all.cancle.length==undefined)
	{
		if(document.form1.cancle.checked){
			flag=1;
		}	
	}	
	else{
		for(var i=0;i<document.form1.cancle.length;i++)	{
			if(document.form1.cancle[i].checked){
				flag=1;
				break;
			}
		}
	}
	if(flag==0){
		rdShowMessageDialog("请选择要退订的订购关系!!");
		return false;
	}	
	document.form1.action="f1930_cfm.jsp";
	document.form1.submit();
}
</script>
<body>
<FORM method=post name="form1" onKeyUp="chgFocus(form1)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
      
	<table cellspacing="0">			  
        <TBODY> 
        	<tr>     		
        	<%
            String sqlStr1="select dispflag,item_name from oneboss.SOBORDERQUERYLIST where item_type='ORDERHIS' and qryflag='1' order by item_index";
            //ArrayList al=callSvrImpl.sPubSelect("2",sqlStr1);
%>
			<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone_no%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
			<wtc:sql><%=sqlStr1%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="tmpTemp" scope="end" />
<%
            if(tmpTemp.length>0){
            	String[][] tmp=tmpTemp;
              	for(int i=0;i<tmp.length;i++){
	              	String dispflag=tmp[i][0];	                  	
	              	String item_name=tmp[i][1];
              	if(Integer.parseInt(dispflag)==1){
              %>
              	<th nowrap><%=item_name%></th>
              <%
              	}
              }
            }
          	%>
			</tr>				
			<%
				String[][] countArray=listTemp;
				int retNum=Integer.parseInt(countArray[0][5]);
				System.out.println("retNum="+retNum);
				String sqlStr2="select dispflag,item_seq from oneboss.SOBORDERQUERYLIST where item_type='ORDERHIS' and qryflag='1' order by item_index";
    			//ArrayList result=callSvrImpl.sPubSelect("2",sqlStr2);
    		%>
    			<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone_no%>"  retcode="retCode3" retmsg="retMsg3" outnum="2">
				<wtc:sql><%=sqlStr2%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="resultTemp" scope="end" />
    		<%
				for(int k=0;k<retNum;k++){
					System.out.println("k="+k);
														
			%>
				<tr>						
			<%            
		            if(resultTemp.length>0){
		            	String[][] tmpArr=resultTemp;
		            	System.out.println("tmpArr="+tmpArr.length);
		                for(int i=0;i<tmpArr.length;i++){	
		              	String dispflag=tmpArr[i][0];                  	
		              	String item_seq=tmpArr[i][1];
		              	int item_seqTmp = Integer.parseInt(item_seq)-6;
		              	System.out.println("dispflag="+dispflag);
		              	System.out.println("item_seq="+item_seq);
		              	//String[][] tmpresult=(String[][])list.get(Integer.parseInt(item_seq));              	
		              	if(Integer.parseInt(dispflag)==1){
		              %>
		              	<TD><%=listTemp2[k][item_seqTmp]%>&nbsp;</TD>
		              <%
		              	}
		              }
		            }
          	%>          		
				 </tr>
			<%}%>
          </TBODY>
        </TABLE>
        <TABLE cellSpacing="0">
            <TR> 
              <TD id="footer" align="center">
              	 <input type="hidden" class="button" name="phoneno" value="<%=phone_no%>">
                  <input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
                  <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">&nbsp;
			  </td>	
            </TR>
        </TABLE>
  	 <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
<%}%>