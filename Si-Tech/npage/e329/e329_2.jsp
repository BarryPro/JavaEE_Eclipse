<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
 <%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
 <%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>

<%@ page import="java.util.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
    String opCode = "e329";
    String opName = "宽带交费信息查询";
    String phoneNo_tt = request.getParameter("phoneNo");
	String phoneNo="";
	String count = request.getParameter("contractNo");
	String userType = request.getParameter("userType");
	System.out.println("contractNocontractNocontractNocontractNocontractNocontractNo"+userType);
    String otherFlag = request.getParameter("otherFlag");	
	String beginTime = request.getParameter("beginTime");
	String endTime = request.getParameter("endTime");
    	//String contractPasswd = Pub_lxd.repNull(request.getParameter("conPass"));
    	
    	//String rtnPage = "./f1528_1.jsp";	
    	//String error_msg = "用户密码错误！";
    	//String sql = "select contract_passwd from dconmsg where contract_no = '"+count+"'";
    	
    	//System.out.println("contractPasswd==="+contractPasswd);
    
    	//comImpl com = new comImpl();
    	//ArrayList agentCodeArr = com.spubqry32("1",sql);
    	//String[][] agentCodeStr = (String[][])agentCodeArr.get(0);
	
    String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String busy_name="";
    //xl add for 铁通 begin
	String[] inParam_idno = new String[2]; 
	inParam_idno[0]="4";
	inParam_idno[1]="phoneNo_tt="+phoneNo_tt;
	//inParam_idno[1]="phoneNo_tt="+phoneNo_tt;
	// 
	%>
	<wtc:service name="sBossDefSqlSel"   retcode="retCodett" retmsg="retMsgtt" outnum="1" >
    	<wtc:param value="<%=inParam_idno[0]%>"/> 
		<wtc:param value="<%=inParam_idno[1]%>"/>
    </wtc:service>
    <wtc:array id="resulttt" scope="end"/>
	<%
	if(resulttt.length==0)
	{
		%><script language="javascript">alert("此号码没有找到对应的帐号！");</script><%
	}
	else
	{
		phoneNo=resulttt[0][0];
	}
	//xl add for 铁通 end	 
 
	String op_code = "e329";
	busy_name="铁通交费信息";
	// tianyang 修改 20090818
	//ArrayList arlist = new ArrayList();
	String inParas[] = new String[7];
	inParas[0] = phoneNo;
	inParas[1] = count;
	inParas[2] = beginTime;
	inParas[3] = endTime ;
	inParas[4] = otherFlag;
	inParas[5] = region_code;
	inParas[6] = userType;      //0 在网, 1 离网
System.out.println("inParas[0]==="+inParas[0]);
System.out.println("inParas[1]==="+inParas[1]);
System.out.println("inParas[2]==="+inParas[2]);
System.out.println("inParas[3]==="+inParas[3]);
System.out.println("inParas[4]==="+inParas[4]);
System.out.println("inParas[5]==="+inParas[5]);
System.out.println("inParas[6]==="+inParas[6]);
	//String outNum="17";
	//int[] lens={17,13,3};
	//HashMap map = new HashMap();
	//map.put("0" , "000000"); 	 
	//ScallSvrViewBean viewBean = new ScallSvrViewBean();//实例化viewBean
	//CallRemoteResultValue value=  viewBean.callService("0",null,"sConMoreQry",outNum,lens, inParas,map);	
%>


<wtc:service name="sConMoreQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="sConMoreQryCode" retmsg="sConMoreQryMsg" outnum="34">
    <wtc:param value="<%=inParas[0]%>"/> 
    <wtc:param value="<%=inParas[1]%>"/>
    <wtc:param value="<%=inParas[2]%>"/>
    <wtc:param value="<%=inParas[3]%>"/>
    <wtc:param value="<%=inParas[4]%>"/>
    <wtc:param value="<%=inParas[5]%>"/>
    <wtc:param value="<%=inParas[6]%>"/>
</wtc:service>
<wtc:array id="sConMoreQryArr" start="0"  length="17"  scope="end" />
<wtc:array id="sConMoreQryArr1" start="17"  length="13"  scope="end" />
<wtc:array id="result2" start="30" length="3" scope="end" />
<%
	//增加统一接触
	String cnttLoginAccept = "";
	String url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+opCode+"&retCodeForCntt="+sConMoreQryCode+"&opName=交费信息查询&workNo="+workNo+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+inParas[0]+"&retMsgForCntt="+sConMoreQryMsg+"&opBeginTime="+opBeginTime;
%>	
	<jsp:include page="<%=url%>" flush="true" />
<%
	//arlist  = value.getList();

 	if (userType.equals("0"))  userType="1";
	String[][] result = new String[][]{}; 
	String[][] result1 = new String[][]{};
	//String[][] result2 = new String[][]{};
	if (sConMoreQryArr.length > 0)
		result = sConMoreQryArr;
  if (sConMoreQryArr1.length > 0)
  	result1 = sConMoreQryArr1;
	
	//result = (String[][])arlist.get(0);
	String return_code = sConMoreQryCode;
	String return_msg = sConMoreQryMsg;

	if (return_code.equals("000000"))
	{
		String countName  = result[0][2];   
		String minMonth   = result[0][3];  
		String prepayFee=result[0][4];  
		String oweFee   =result[0][5];  
		String balFee   =result[0][6];  
		String oddment   =result[0][7];  
		String payCode  =result[0][8];  
		String status    =result[0][9];  
		String deposit   =result[0][10];  
		String bankName =result[0][11];  
		String accountNo =result[0][12];  
		String postBank = result[0][13];  
		String idNo = result[0][14];
		String bill_name = result[0][15];
		String belong_name = result[0][16];
		
		//result1= (String[][])arlist.get(1);
		
		//StringBuffer sqlsBUF=new StringBuffer("");
		//sqlsBUF.append("select count(*) from dHighMsg  where id_no=to_number('" +idNo+ "')");  
		//String sqls=sqlsBUF.toString();
		
		String sql = "select to_char(count(*)) from dHighMsg  where id_no=to_number(:idNo)";
		String [] paraIn = new String[2];
        paraIn[0] = "5";    
        paraIn[1]="idNo="+idNo;

		//ArrayList arlist3 = new ArrayList();
		//System.out.println(sqls);
		//comImpl co=new comImpl();
		//arlist3=co.spubqry32("1",sqls); 
%>

<wtc:service name="sBossDefSqlSel" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="1" >
	<wtc:param value="<%=paraIn[0]%>"/>
	<wtc:param value="<%=paraIn[1]%>"/> 
</wtc:service>
<wtc:array id="result3" scope="end"/>
<%
		//String [][] result3 = new String[][]{};
		//result3 = (String[][])arlist3.get(0);
		System.out.println(result3[0][0]);
		int l2=Integer.parseInt(result3[0][0]);
		
		// tianyang 修改 20090818
		//result2= (String[][])arlist.get(2);
		String nowprepayFee = result2[0][0];
		String nobillpay = result2[0][1];   //未出账话费：
		System.out.println("f1528_2.jsp nowprepayFee="+nowprepayFee);
		String nowfee = result2[0][2];
%>

<script language="JavaScript" >
if(<%=l2%>>0){rdShowMessageDialog("该用户为中高端用户!");}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>



<title>交费信息查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>

<BODY>
<FORM action="PayCfm.jsp" method="post" name="form" onSubmit="return DoCheck()">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户信息</div>
</div>
<input type="hidden" name="Op_Code"  value=<%=op_code%>>

	  <table cellspacing="0">
      <tr>
           <td class=blue>交费类型</td>
           <td>
             <input type="text" class="InputGrey" readonly name="TbusyName" size="16" maxlength="12"  value=<%=busy_name.trim()%>>
           </td>
           <td class=blue>服务号码</td>
           <td>
             <input type="text"  class="InputGrey" readonly name="phoneNo" size="11" maxlength="11" value=<%=phoneNo.trim()%>>
           </td>
           <td class=blue>帐户号码</td>
           <td>
             <input type="text" class="InputGrey" readonly name="count" size="18" maxlength="12"  onKeyPress="" value=<%=count.trim()%>>
           </td>
           <td class=blue>帐户名称</td>
           <td> 
             <input type="text" name="countName"  readonly class="InputGrey" size="30" maxlength="36" value=<%=countName.trim()%>>
           </td>
         </tr>
         <tr id="BigId" nowrap> 
           <td class=blue>欠费最小年月</td>
           <td> 
             <input type="text"  class="InputGrey" readonly name="MinMonth" size="16" maxlength="10" value=<%=minMonth.trim()%>>
           </td>
                                                                  
           <!--td class=blue>帐户预存款</td-->
           <td class=blue>归属地</td>
           <td>
             <input type="text" class="InputGrey" readonly name="prepayFee" size="12" maxlength="30"  value=<%=belong_name.trim()%> >
           </td>
           <td class=blue>帐户欠费</td>
           <td> 
             <input type="text"  class="InputGrey" readonly name="oweFee" size="16" maxlength="12" value=<%=oweFee.trim()%>>
           </td>
           <!--td class=blue>帐户余额</td>
           <td> 
             <input type="text"  class="InputGrey orange" readonly name="balFee" size="12" maxlength="12" value=<%=balFee%>>
           </td-->
           <td>&nbsp;</td>
           <td>&nbsp;</td>           
         </tr>
         <tr id="phoneId"> 
           <td class=blue>帐户上期结转零头</td>
           <td> 
             <input type="text" readonly class="InputGrey" name="oddment" size="16" maxlength="11" value=<%=oddment.trim()%> >
           </td>
           <td class=blue>付款方式</td>
           <td> 
             <input type="text"  class="InputGrey" readonly name="payCode" size="12" maxlength="10" value=<%=payCode.trim()%>>
           </td>
           <td class=blue>帐户状态</td>
           <td> 
             <input type="text" readonly class="InputGrey" name="oddment" size="16" maxlength="11" value=<%=status.trim()%> >
           </td>
           <td class=blue>帐户押金</td>
           <td> 
             <input type="text"  class="InputGrey" readonly name="deposit" size="12" maxlength="10" value=<%=deposit.trim()%>>
           </td>
         </tr>
         
		 <tr id="phoneId"> 
           <td class=blue>托收银行</td>
           <td> 
             <input type="text" readonly class="InputGrey" name="oddment" size="16" maxlength="11" value=<%=bankName.trim()%> >
           </td>
           <td class=blue>托收帐号</td>
           <td> 
             <input type="text"  class="InputGrey" readonly name="deposit" size="12" maxlength="10" value=<%=accountNo.trim()%>>
           </td>
           <td class=blue>局方银行</td>
           <td> 
             <input type="text" readonly class="InputGrey" name="postBank" size="16" maxlength="11" value=<%=postBank.trim()%> >
           </td>
           <td class=blue>资费套餐</td>
           <td>
		     <input type="text" readonly class="InputGrey" name="bill_name" size="16" maxlength="11" value=<%=bill_name.trim()%> >
		   </td>
         </tr>
         
					<tr id="phoneId"> 
						<td class=blue>当前预存</td>
						<td> 
							<input type="text" readonly class="InputGrey" style="color:red" name="prepayFee" size="16" maxlength="11" value=<%=prepayFee.trim()%> >
						</td>
						<td class=blue>当前可划拨预存</td>
						<td>
							<input type="text" readonly class="InputGrey" style="color:red" name="nowprepayFee" size="16" maxlength="11" value=<%=nowprepayFee.trim()%> >
						</td>
						<td class=blue>未出账话费</td>
						<td>
							<input type="text" readonly class="InputGrey" style="color:red" name="nobillpay" size="16" maxlength="11" value=<%=nobillpay.trim()%> >
						</td>
						<td class=blue>当前可用预存</td>
						<td>
							<input type="text" readonly class="InputGrey" style="color:red" name="nowfee" size="16" maxlength="11" value=<%=nowfee.trim()%> >
						</td>										
					</tr>
        </table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
        <table cellspacing="0">
          <tr> 
            <th nowrap> 
              <div align="center">宽带号码</div>
            </th>
            <th nowrap> 
              <div align="center">操作时间</div>
            </th>
			<th nowrap> 
              <div align="center">缴费流水</div>
            </th>
			<th nowrap> 
              <div align="center">退费标志</div>
            </th>
            <th nowrap> 
              <div align="center">操作模块</div>
            </th>
            <th nowrap> 
              <div align="center">交费方式</div>
            </th>
            <th nowrap> 
              <div align="center">缴费金额</div>
            </th>                        
            <th nowrap> 
              <div align="center">冲销欠费</div>
            </th>
            <th nowrap> 
              <div align="center">滞纳金</div>
            </th>
			<th nowrap> 
              <div align="center">其他费</div>
            </th>
			<th nowrap> 
              <div align="center">预存变化</div>
            </th>
			<th nowrap> 
              <div align="center">操作工号</div>
            </th>
			<th nowrap> 
              <div align="center">兑换发票</div>
            </th>            
          </tr>
		  <%
            if (!result1[0][1].equals("0")) {
                for (int i=0;i<result1.length;i++){
                    String tdClass = "";
                    if (i%2==0){
                        tdClass = "Grey";
                    }
		  %>
                <tr> 
                    <td class="<%=tdClass%>"><%=phoneNo_tt%></td>
                    <td class="<%=tdClass%>"><%=result1[i][1]%></td>
                    <td class="<%=tdClass%>"><%=result1[i][2]%></td>
                    <td class="<%=tdClass%>"><%=result1[i][3]%></td>
                    <td class="<%=tdClass%>"><%=result1[i][4]%></td>
                    <td class="<%=tdClass%>"><%=result1[i][5]%></td> 
                    <td class="<%=tdClass%>"><%=result1[i][6]%></td>
                    <td class="<%=tdClass%>"><%=result1[i][7]%></td>
                    <td class="<%=tdClass%>"><%=result1[i][8]%></td>
                    <td class="<%=tdClass%>"><%=result1[i][9]%></td>
                    <td class="<%=tdClass%>"><%=result1[i][10]%></td>						
                    <td class="<%=tdClass%>"><%=result1[i][11]%></td>
                    <td class="<%=tdClass%>"><%=result1[i][12]%></td>
                </tr>
		  <%}}%>
        </table>
        

<!------------------------>
	   <table cellspacing="0">
	     <tr id="footer">
           <TD nowrap colspan="8"> 
               <input type="button" name="return" class="b_foot" value="返回" onClick="window.history.go(-1)">
               <input type="button" name="return" class="b_foot" value="关闭" onClick="removeCurrentTab()">
           </TD>
         </TR>
        </table>
<%@ include file="/npage/include/footer.jsp" %>
</Form>
 
</body>
</html>

<%if (result1[0][1].equals("0")) {%>
<script language="JavaScript">
   rdShowMessageDialog("该用户没有交费记录！");
</script>
<%}%>

<%}else{%>
<script language="JavaScript">
	rdShowMessageDialog("<%=return_msg%><br>错误代码 '<%=return_code%>'。",0);
	history.go(-1);
</script>
<%}%>	
