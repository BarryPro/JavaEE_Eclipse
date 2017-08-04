   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-10
********************/
%>
              
<%
  String opName = "服务兑换";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>

 <%
    response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	
	
	String phoneNo  =request.getParameter("phoneNo");
 	String opCode   =request.getParameter("opCode");
 	String clubType =request.getParameter("clubType");
	

    //==============================获取营业员信息
    String[][] result = new String[][]{};
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	//=======================获得操作流水
	String printAccept="";
	printAccept = getMaxAccept();
	
    String [] inParas = new String[4];
	
	inParas[0] = phoneNo;
	inParas[1] = opCode;
	inParas[2] = workno;
	inParas[3] = clubType;
	
	//String[] ret = impl.callService("s3530Qry",inParas,"15");
%>

    <wtc:service name="s3530Qry" outnum="17" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />
			<wtc:param value="<%=inParas[3]%>" />		
		</wtc:service>
		<wtc:array id="result_t1" scope="end"/>
			
<%	

	String retCode= code1;
	String retMsg = msg1;
	
	
	if (result_t1 != null && code1.equals("000000"))
	{ 
		String custName = result_t1[0][2];
		String custAddress = result_t1[0][3];
		String icType = result_t1[0][4];
		String icIccid = result_t1[0][5];
		String smName = result_t1[0][6];
		String belongCode = result_t1[0][7];
		String runCode = result_t1[0][8];
		String vipGrade = result_t1[0][9];
		String currentPoint = result_t1[0][10];
		String inTime = result_t1[0][11];
		String expTime = result_t1[0][12];
		String cardNo = result_t1[0][13];
		String clubStatus = result_t1[0][14];

		
	
		System.out.println("custName="+custName);
		System.out.println("custAddress="+custAddress);
		System.out.println("icType="+icType);
		System.out.println("icIccid="+icIccid);
		//System.out.println("smCode="+smCode);
		System.out.println("belongCode="+belongCode);
		System.out.println("runCode="+runCode);
		System.out.println("vipGrade="+vipGrade);
		System.out.println("currentPoint="+currentPoint);
		System.out.println("inTime="+inTime);
		System.out.println("expTime="+expTime);
		System.out.println("cardNo="+cardNo);

%>

<HTML>
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<title>黑龙江BOSS-VIP俱乐部</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY >
<FORM action="s3530Cfm.jsp" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">会籍管理</div>
	</div>
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="loginAccept" value="<%=printAccept%>">
<input type="hidden" name="markname" value="">

              <table   cellspacing="0">
                <tr> 
                  <td width="14%" class="blue">操作类型</td>
                  <td width="33%"> 
                   服务兑换
                  </td>
                  <td  width="14%">&nbsp;</td>
                  <td  width="39%">&nbsp; 
				  </td>
                <tr> 
                  <td width="14%" class="blue">客户姓名</td>
                  <td width="33%"> 
                    <input type="text"  readonly Class="InputGrey"  name="custName" value="<%=custName%>">
                  </td>
                  <td width="14%" class="blue">手机号码 </td>
                  <td width="39%"> 
                    <input type="text" name="phoneNo"  readonly Class="InputGrey" value="<%=phoneNo%>">
                  </td>
                </tr>

				<tr> 
                  <td width="14%" class="blue">客户地址</td>
                  <td width="33%"> 
                    <input type="text"  size="38" readonly Class="InputGrey" name="custAddress" value="<%=custAddress%>">
                  </td>
                 <td width="14%" class="blue">业务品牌</td>
                  <td width="33%"> 
                    <input type="text"   readonly  Class="InputGrey" name="smName" value="<%=smName%>">
                  </td> 
                </tr>

                <tr id="bat_id"> 
                <td width="14%" class="blue">证件类型 </td>
                  <td width="39%"> 
                    <input type="text" name="icType"  readonly  Class="InputGrey"  value="<%=icType%>">
                  </td>  
				  <td width="14%" class="blue">证件号码</td>
                   <td width="39%"> 
                    <input type="text"  readonly  Class="InputGrey" name="icIccid" value="<%=icIccid%>">
                  </td>
                </tr>
                <tr id="phoneId"> 
                  <td width="14%" class="blue">归属地市</td>
                  <td width="33%"> 
                    <input type="text" readonly  Class="InputGrey"  name="belongCode" value="<%=belongCode%>" >
                  </td>
                  <td width="14%" class="blue">运存状态</td>
                  <td width="39%"> 
                    <input type="text"   readonly  Class="InputGrey" name="runCode" value="<%=runCode%>">
                  </td>
                </tr>
                 <tr   nowrap> 
                  <td width="14%" class="blue">VIP级别</td>
                  <td width="33%"> 
                    <input type="text"   readonly  Class="InputGrey" name="vipGrade" value="<%=vipGrade%>">
                  </td>
                  <td width="14%" class="blue">当前积分</td>
                  <td width="39%"> 
                    <input type="text"  readonly  Class="InputGrey" name="currentPoint"  value="<%=currentPoint%>">
                  </td>
				  </tr>
                 <tr   nowrap> 
                  <td width="14%" class="blue">入会时间</td>
                  <td width="33%"> 
                    <input type="text"    name="inTime" value="<%=inTime%>" readonly Class="InputGrey" >
                  </td>
                  <td width="14%" class="blue">会员有效期至</td>
                  <td width="39%"> 
                    <input type="text"   name="expTime"  value="<%=expTime%>" readonly Class="InputGrey" >
                  </td>
				  </tr>
				<tr   nowrap> 
                  <td width="14%" class="blue">会员卡号</td>
                  <td width="33%"> 
                    <input type="text"    name="cardNo" value="<%=cardNo%>" readonly Class="InputGrey" >
                  </td>
                  <td width="14%" class="blue">会员状态</td>
                  <td width="39%"> 
                    <input type="text"   name="clubStatus"  value="<%=clubStatus%>" readonly Class="InputGrey" >
                    <input type="hidden"    name="clubType" value="<%=clubType%>">
                  </td>
				  </tr>
                <tr nowrap>
				   <td width="14%" class="blue">服务种类</td>
				   <td width="33%">
					<select name=favour_type id="favour_type" onchange="favTypeChange()" >
<%                  try
                    {
					  String[][] result1 = new String[][]{};
					  String sqlStr ="";
					  if(clubType.equals("01"))
					  	sqlStr ="select favour_code,favour_name,favour_point from sMarkFavCode where favour_type='1021' and region_code ='"+regionCode+"' and sm_code='gn' and favour_code!='CL01' order by favour_code" ;
					  else if(clubType.equals("02"))
					  	sqlStr ="select favour_code,favour_name,favour_point from sMarkFavCode where favour_type='1022' and region_code ='"+regionCode+"' and sm_code='gn' and favour_code!='YM01' order by favour_code" ;
                      //retArray = callView.view_spubqry32("3",sqlStr);
%>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%                      
                      result1 = result_t2;
                      int recordNum = result1.length;
					  int j;
					  out.println("<option  value='" +  result1[0][0] + "'>" + "--请选择--"+ "</option>");
                      for(j=1;j<recordNum+1;j++)
                      {
                        out.println("<option  value='" +  result1[j-1][2]+ "'>"+result1[j-1][0]+"-->" +result1[j-1][1]+ "</option>");

					  }
                    }catch(Exception e)
                    {
                      //logger.error("Call sunView is Failed!");
                    }
%>
                    </select>   
				</td>
				<td width="14%" class="blue">服务积分</td>
                  <td width="39%"> 
                    <input type="text"   name="serviceMark"  value="" readonly Class="InputGrey" >
                  </td>
				</tr>
				<tr   nowrap> 
                  <td width="14%" class="blue">数量</td>
                  <td width="33%"> 
                    <input type="text"    name="num" value="" onChange= "consumeFee1()" onkeyup="if(event.keyCode==13)consumeFee1()" >
					 <font class="orange">*</font>
                  </td>
                  <td width="14%" class="blue">本次消费积分</td>
                  <td width="39%"> 
                    <input type="text"   name="sumMark"  value="" readonly Class="InputGrey" >
                  </td>
				  </tr>
				<tr nowrap> 
                  <td width="14%" class="blue">备注</td>
                  <td colspan="3" width="86%"> 
                    <input type="text"  name="opNote" value=""  size="80"readonly  Class="InputGrey"  >
				  </td>
                </tr>
				<tr> 
            <td noWrap colspan="6">
				<div align="center"> 
	     		<input type="button" name="print"  value="确认&打印" onClick="doprint()"    class="b_foot_long">
                      &nbsp;
                <input type="button" name="return1"  value="返回" onClick="history.go(-1);" class="b_foot">
                      &nbsp; 
                <input type="button" name="close1"  value="关闭" onClick="removeCurrentTab();" class="b_foot">
              </div>
            </td>
        </tr>
			</table>

 <%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="JavaScript">
<!--

function favTypeChange()
{	
	with(document.frm){
		var  markpoint = favour_type.options[favour_type.options.selectedIndex].value;
		markname.value = favour_type.options[favour_type.options.selectedIndex].text;
		
		if(	markpoint>currentPoint){
			rdShowMessageDialog("当前积分小于该项服务积分，不能兑换此项服务！",0);
			print.disabled="true";
			return false;
		}else{
			serviceMark.value=markpoint;
			return true;
		}

	}
}
function consumeFee1()
{
    var a = parseInt(document.frm.num.value,10) ;
    var b = parseInt(document.frm.serviceMark.value,10) ;
    var c = a*b;
	document.frm.sumMark.value= c;
	if(parseInt(document.frm.currentPoint.value,10) < c)
	{
		rdShowMessageDialog("用户当前积分小于兑换积分！",0);
		document.all.print.disabled=true;
		return false;
	}else
	{
		document.all.print.disabled=false;
	}
	return true;

}
function doprint()
{
	 getAfterPrompt();
	 with (document.frm)
    {
        if (serviceMark.value == "")
        {
            rdShowMessageDialog(" 奖品积分不能为空！",0);
            return false;
        }

        if (num.value == "")
        {
            rdShowMessageDialog(" 数量不能为空！",0);
            num.focus();
            return false;
        }
    }
	document.all.print.disabled=true;	

	//打印工单并提交表单
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
        {
	      frmCfm();
        }
	  }
	  if(ret=="continueSub")
	  {
        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
        {
	      frmCfm();
        }
	  }
    }
    else
    {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
	     frmCfm();
       }
    }
	document.all.print.disabled=false;
	return true;
  }

function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo();
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     
     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =<%=printAccept%>;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = document.frm.phoneNo.value;                           //客户电话
     
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
		
  }

 function printInfo()
  {
	  if(document.frm.opNote.value==""){ 															document.frm.opNote.value="操作员"+"<%=workname%>"+"对用户"+document.frm.custName.value+"进行VIP俱乐部 服务兑换" ;
	  }
  	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
      var d= document.frm.currentPoint.value-document.frm.sumMark.value;
      cust_info+="客户姓名：" +document.frm.custName.value+"|";
      cust_info+="手机号码："+document.frm.phoneNo.value+"|";
      cust_info+="客户地址："+document.frm.custAddress.value+"|";
      cust_info+="证件号码："+document.frm.icIccid.value+"|";

      opr_info+="用户品牌："+document.frm.smName.value + "|";
      opr_info+="VIP级别："+document.frm.vipGrade.value+"|";
	    opr_info+="办理业务VIP俱乐部 " +"服务兑换："+"|";
	    opr_info+="兑换服务："+document.frm.markname.value+"|";
      opr_info+="兑换数量："+document.frm.num.value+"|";
      opr_info+="扣减积分："+document.frm.sumMark.value+"|";
	    opr_info+="操作流水："+"<%=printAccept%>" +"|";

		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

	  return retInfo;
  }
  function frmCfm(){
	document.frm.action="f3532Cfm.jsp";
 	frm.submit();
	return true;
  }
//-->
 </script> 
</body>
</html>
<%} else { %>
	 <script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码'<%=retCode%>'，错误信息'<%=retMsg%>'。",0);
		window.location.href="f3532.jsp?ph_no=<%=phoneNo%>";
	 </script>
<% } %>

