<%
   /*
   * 功能::集团产品查询
　 * 版本: v1.0
　 * 日期: 2006/10/13
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-16    qidp        新版集团产品改造
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.text.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%
	Logger logger = Logger.getLogger("f5079_main.jsp");
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String op_name="统付产品查询";
	
	String opCode = "5079";
	String opName = "统付产品查询";
	
	//yyyyMMdd形式的当前日期
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());


SimpleDateFormat df=new SimpleDateFormat("yyyyMM"); 
Date d; 
Date d1;
Calendar c = Calendar.getInstance(); 
Calendar c1 = Calendar.getInstance(); 
c.add(Calendar.MONTH,-1); 
c1.add(Calendar.MONTH,-6); 
d = c.getTime(); 
d1 = c1.getTime();
String dataStr = df.format(d);
String dataStr1 = df.format(d1);

	

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>统付产品查询</title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head> 
<script language=javascript>
function onkeydown(event) 
{
	if (event.srcElement.type!="button")
	{
		if (event.keyCode == 13)
		{
			event.keyCode = 9;
		}
	}
}

var fontcode="1";
//-----变换上面所选类型的颜色-----
function showtbs(font)
{	
	fontcode=font;
	for(var i=0;i<=4;i++)/*diling update for 新增“集团按账目项付费查询”项@2012/5/25*/
	{
		if(i==fontcode)
		{
			frm[i].style.display="";
		}
		else
		{
			frm[i].style.display="none";
		}	
	} 

}

function subform1()
{
	if(document.form1.QryValues.value=="")
	{
		rdShowMessageDialog("查询条件信息不能为空!");
		return;	
	}
	var path = "<%=request.getContextPath()%>/npage/s5079/f5079_query.jsp?formtype=form1&QryValues="+document.form1.QryValues.value+"&QryFlag="+document.form1.QryFlag.value;
    window.open(path,'_blank','height=600,width=900,scrollbars=yes');
}

function showList1()
{
	if(!checkElement(document.getElementById("QryValues1")))
	{
		return;
	}
	document.form1.action="<%=request.getContextPath()%>/npage/s5079/f5079_list1.jsp";
	document.form1.target="listFrame";	
	document.form1.submit();
	parent.document.body.rows="220,*";
}

function subform2()
{
	if(document.form2.QryValues.value=="")
	{
		rdShowMessageDialog("查询条件信息不能为空!");
		return;	
	}
	var path = "<%=request.getContextPath()%>/npage/s5079/f5079_query.jsp?formtype=form2&QryValues="+document.form2.QryValues.value+"&QryFlag="+document.form2.QryFlag.value;
    window.open(path,'_blank','height=600,width=900,scrollbars=yes');
}

function showList2()
{
	if(!checkElement(document.getElementById("QryValues2")))
	{
		return;
	}
	document.form2.action="<%=request.getContextPath()%>/npage/s5079/f5079_list2.jsp";
	document.form2.target="listFrame";	
	document.form2.submit();
	parent.document.body.rows="220,*";
}


function showList4()
{
	if(!checkElement(document.getElementById("QryValues4")))
	{
		return;
	}
	document.form4.action="<%=request.getContextPath()%>/npage/s5079/f5079_list4.jsp";
	document.form4.target="listFrame";	
	document.form4.submit();
	parent.document.body.rows="220,*";
}

/*begin diling add for 新增集团按账目项付费查询 @2012/5/26 */
function showList5(){
  if(!checkElement(document.getElementById("QryValues5")))
	{
		return;
	}
	document.form5.action="<%=request.getContextPath()%>/npage/s5079/f5079_list5.jsp";
	document.form5.target="listFrame";	
	document.form5.submit();
	parent.document.body.rows="220,*";
}
/*end diling add  */

function subform3()
{
	if(document.form3.QryValues.value=="")
	{
		rdShowMessageDialog("查询条件信息不能为空!");
		return;	
	}
	var path = "<%=request.getContextPath()%>/npage/s5079/f5079_query.jsp?formtype=form3&QryValues="+document.form3.QryValues.value+"&QryFlag="+document.form3.QryFlag.value;
    window.open(path,'_blank','height=600,width=900,scrollbars=yes');
}

/* begin by diling for 集团按账目项付费查询@2012/5/25 */
function subform5(){
  if(document.form5.QryValues.value=="")
	{
		rdShowMessageDialog("查询条件信息不能为空!");
		return;	
	}
	var path = "<%=request.getContextPath()%>/npage/s5079/f5079_query.jsp?formtype=form5&QryValues="+document.form5.QryValues.value+"&QryFlag=2";
  window.open(path,'_blank','height=600,width=900,scrollbars=yes');
}
/* end by diling */

function subform4()
{
	
	var a = document.form4.dataStr.value;
	var b = document.form4.dataStr1.value;
	var c = document.form4.huaboym.value;
	if(document.form4.QryValues.value=="")
	{
		rdShowMessageDialog("查询条件信息不能为空!");
		return;
	}
	
	
	if(document.form4.huaboym.value=="")
	{
		rdShowMessageDialog("划拨年月不能为空!");
		return;
	}else{
		
		if(isNaN(c)){
				rdShowMessageDialog("划拨年月应该由数字组成!");
				return ;
		}else{
						if(c.length!=6){
						rdShowMessageDialog("请正确输入划拨年月，格式为YYYYMM!");
						return;
				    }else{
				  			if(c.substr(4,6)>12||c.substr(4,6)<=0){
				  				rdShowMessageDialog("请正确输入划拨年月，月份应该在01－12之间！");
				  				return;
				  			}
				    	
				    }
		     }
	  }

	if(c<b||c>a){
		rdShowMessageDialog("只能查询上一个月的近六个月以内的划拨信息，请重新输入！");
		return;
	}
	
	 var path = "<%=request.getContextPath()%>/npage/s5079/f5079_query.jsp?formtype=form4&QryValues="+document.form4.QryValues.value+"&QryFlag="+document.form4.QryFlag.value+"&huaboym="+document.form4.huaboym.value+"&tongfulb="+document.form4.tongfulb.value;
  
    window.open(path,'_blank','height=600,width=900,scrollbars=yes');
}


function showList3()
{
	if(!checkElement(document.getElementById("QryValues3")))
	{
		return;
	}
	document.form3.action="<%=request.getContextPath()%>/npage/s5079/f5079_list3.jsp";
	document.form3.target="listFrame";	
	document.form3.submit();
	parent.document.body.rows="220,*";
}
	

function doChange1()
{
	//wuxy add 20090208 多了两个查询类型
	if(document.form1.QryFlag.value=="1")
	{
		tbs1.style.display="";
		tbs2.style.display="none";
		tbs0.style.display="none";
		tbs4.style.display="none";	
		tbs3.style.display="none";	
		document.form1.QryValues.v_type="0_9";
		document.form1.QryValues.v_name="证件号码";
		document.form1.QryValues.value="";
		document.form1.QryValues.maxLength="18";
	} 
	else if(document.form1.QryFlag.value=="2")
	{
		tbs1.style.display="none";
		tbs2.style.display="";
		tbs0.style.display="none";	
		tbs4.style.display="none";	
		tbs3.style.display="none";	
		document.form1.QryValues.v_type="string";
		document.form1.QryValues.v_name="集团编号";
		document.form1.QryValues.value="";
		document.form1.QryValues.maxLength="18";
	}
	else if(document.form1.QryFlag.value=="0")
	{
		tbs1.style.display="none";
		tbs2.style.display="none";
		tbs0.style.display="";	
		tbs4.style.display="none";	
		tbs3.style.display="none";	
		document.form1.QryValues.v_type="0_9";
		document.form1.QryValues.v_name="客户编号";
		document.form1.QryValues.value="";
		document.form1.QryValues.maxLength="18";
	}
	else if(document.form1.QryFlag.value=="3")
	{
		tbs1.style.display="none";
		tbs2.style.display="none";
		tbs0.style.display="none";	
		tbs4.style.display="none";	
		tbs3.style.display="";	
		document.form1.QryValues.v_type="0_9";
		document.form1.QryValues.v_name="统付账号";
		document.form1.QryValues.value="";
		document.form1.QryValues.maxLength="18";
	}
	else
	{
		tbs1.style.display="none";
		tbs2.style.display="none";
		tbs0.style.display="none";	
		tbs4.style.display="";	
		tbs3.style.display="none";	
		document.form1.QryValues.v_type="0_9";
		document.form1.QryValues.v_name="成员号码";
		document.form1.QryValues.value="";
		document.form1.QryValues.maxLength="18";
	}
}	

function doChange2()
{
	if(document.form2.QryFlag.value=="1")
	{
		tbs21.style.display="";
		tbs22.style.display="none";
		tbs20.style.display="none";
		tbs24.style.display="none";	
		tbs23.style.display="none";	
		document.form2.QryValues.v_type="0_9";
		document.form2.QryValues.v_name="证件号码";
		document.form2.QryValues.value="";
		document.form2.QryValues.maxLength="18";
	}
	else if(document.form2.QryFlag.value=="2")
	{
		tbs21.style.display="none";
		tbs22.style.display="";
		tbs20.style.display="none";	
		tbs24.style.display="none";	
		tbs23.style.display="none";	
		document.form2.QryValues.v_type="string";
		document.form2.QryValues.v_name="集团编号";
		document.form2.QryValues.value="";
		document.form2.QryValues.maxLength="18";
	}
	else if(document.form2.QryFlag.value=="0")
	{
		tbs21.style.display="none";
		tbs22.style.display="none";
		tbs20.style.display="";	
		tbs24.style.display="none";	
		tbs23.style.display="none";	
		document.form2.QryValues.v_type="0_9";
		document.form2.QryValues.v_name="客户编号";
		document.form2.QryValues.value="";
		document.form2.QryValues.maxLength="18";
	}
	else if(document.form2.QryFlag.value=="3")
	{
		tbs21.style.display="none";
		tbs22.style.display="none";
		tbs20.style.display="none";	
		tbs24.style.display="none";	
		tbs23.style.display="";	
		document.form2.QryValues.v_type="0_9";
		document.form2.QryValues.v_name="统付账号";
		document.form2.QryValues.value="";
		document.form2.QryValues.maxLength="18";
	}
	else
	{
		tbs21.style.display="none";
		tbs22.style.display="none";
		tbs20.style.display="none";	
		tbs24.style.display="";	
		tbs23.style.display="none";	
		document.form2.QryValues.v_type="0_9";
		document.form2.QryValues.v_name="成员号码";
		document.form2.QryValues.value="";
		document.form2.QryValues.maxLength="18";
	}
}

function doChange3()
{
	if(document.form3.QryFlag.value=="1")
	{
		tbs31.style.display="";
		tbs32.style.display="none";
		tbs30.style.display="none";
		tbs33.style.display="none";
		tbs34.style.display="none";
		document.form3.QryValues.v_type="0_9";
		document.form3.QryValues.v_name="证件号码";
		document.form3.QryValues.value="";
		document.form3.QryValues.maxLength="18";
	}
	else if(document.form3.QryFlag.value=="2")
	{
		tbs31.style.display="none";
		tbs32.style.display="";
		tbs30.style.display="none";	
		tbs33.style.display="none";
		tbs34.style.display="none";
		document.form3.QryValues.v_type="string";
		document.form3.QryValues.v_name="集团编号";
		document.form3.QryValues.value="";
		document.form3.QryValues.maxLength="18";
	}
	else if(document.form3.QryFlag.value=="0")
	{
		tbs31.style.display="none";
		tbs32.style.display="none";
		tbs30.style.display="";	
		tbs33.style.display="none";
		tbs34.style.display="none";
		document.form3.QryValues.v_type="0_9";
		document.form3.QryValues.v_name="客户编号";
		document.form3.QryValues.value="";
		document.form3.QryValues.maxLength="18";
	}
	else if(document.form3.QryFlag.value=="3")
	{
		tbs31.style.display="none";
		tbs32.style.display="none";
		tbs30.style.display="none";	
		tbs33.style.display="";
		tbs34.style.display="none";
		document.form3.QryValues.v_type="0_9";
		document.form3.QryValues.v_name="统付账号";
		document.form3.QryValues.value="";
		document.form3.QryValues.maxLength="18";
	}
	else
	{
		tbs31.style.display="none";
		tbs32.style.display="none";
		tbs30.style.display="none";	
		tbs33.style.display="none";
		tbs34.style.display="";
		document.form3.QryValues.v_type="0_9";
		document.form3.QryValues.v_name="成员号码";
		document.form3.QryValues.value="";
		document.form3.QryValues.maxLength="18";
		
	}
}



function doChange4()
{
	if(document.form4.QryFlag.value=="1")
	{
		tbs41.style.display="";
		tbs42.style.display="none";
		tbs40.style.display="none";
		tbs43.style.display="none";
		tbs44.style.display="none";
		document.form4.QryValues.v_type="0_9";
		document.form4.QryValues.v_name="证件号码";
		document.form4.QryValues.value="";
		document.form4.QryValues.maxLength="18";
	}
	else if(document.form4.QryFlag.value=="2")
	{
		tbs41.style.display="none";
		tbs42.style.display="";
		tbs40.style.display="none";	
		tbs43.style.display="none";
		tbs44.style.display="none";
		document.form4.QryValues.v_type="string";
		document.form4.QryValues.v_name="集团编号";
		document.form4.QryValues.value="";
		document.form4.QryValues.maxLength="18";
	}
	else if(document.form4.QryFlag.value=="0")
	{
		tbs41.style.display="none";
		tbs42.style.display="none";
		tbs40.style.display="";	
		tbs43.style.display="none";
		tbs44.style.display="none";
		document.form4.QryValues.v_type="0_9";
		document.form4.QryValues.v_name="客户编号";
		document.form4.QryValues.value="";
		document.form4.QryValues.maxLength="18";
	}
	else if(document.form4.QryFlag.value=="3")
	{
		tbs41.style.display="none";
		tbs42.style.display="none";
		tbs40.style.display="none";	
		tbs43.style.display="";
		tbs44.style.display="none";
		document.form4.QryValues.v_type="0_9";
		document.form4.QryValues.v_name="统付账号";
		document.form4.QryValues.value="";
		document.form4.QryValues.maxLength="18";
	}
	else
	{
		tbs41.style.display="none";
		tbs42.style.display="none";
		tbs40.style.display="none";	
		tbs43.style.display="none";
		tbs44.style.display="";
		document.form4.QryValues.v_type="0_9";
		document.form4.QryValues.v_name="成员号码";
		document.form4.QryValues.value="";
		document.form4.QryValues.maxLength="18";
		
	}
}




</script>
<body scroll="no">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">统付产品查询</div>
</div>
        <TABLE cellSpacing=0>
        	<tr>
              	<TD>
              	    <input type="radio" id="tabhead1" name="tabhead1" onclick="showtbs('0')" checked>&nbsp;统付关系查询
    			  	<input type="radio" id="tabhead1" name="tabhead1" onclick="showtbs('1')">&nbsp;统付集团成员查询
    			 	<input type="radio" id="tabhead1" name="tabhead1" onclick="showtbs('2')">&nbsp;付费关系查询
                	<input type="radio" id="tabhead1" name="tabhead1" onclick="showtbs('3')">&nbsp;划拨记录查询
                	<input type="radio" id="tabhead1" name="tabhead1" onclick="showtbs('4')">&nbsp;集团按账目项付费查询
            	</TD>
            </tr>   
        </table>
      <!--统付关系 -->  
			<div id=frm style='display:'>
			<form name="form1"  method="get">
				<input type="hidden" name="turnValue" value="">
					  <TABLE id="mainOne" cellspacing="0">
			            <TR id="line_1"> 
							<td class='blue' nowrap>查询条件</TD>
		            		<TD colspan="3">
		            			<select name="QryFlag" onchange="doChange1()">
		            				<option value="0">按客户编号查询</option>
		            				<option value="1" selected>按证件号码查询</option>
		            				<option value="2">按集团编号查询</option>
		            				<option value="3">按统付账号查询</option><!-- wuxy add 20090208 -->
		            				<option value="4">按成员号码查询</option><!-- wuxy add 20090208 -->
		            			</select>
		            		</TD>
		            	</tr>
		            	<TR> 
		            		<td class='blue' nowrap>
		            		<div id=tbs1 style='display:'>
							证件号码
							</div>
							<div id=tbs2 style='display:none'>
							集团编号			
							</div>
							<div id=tbs0 style='display:none'>
							客户编号				
							</div>
							<div id=tbs3 style='display:none'>
							统付账号				
							</div>
							<div id=tbs4 style='display:none'>
							成员号码				
							</div>
							</TD>
		            		<TD colspan="3">
		            		  	<input type=text v_type="string" v_must=1 id="QryValues1" name="QryValues" maxlength=18>
		            			<font class='orange'>*</font>
		            		</TD> 
			            </TR>
			        </TABLE> 
			        <TABLE cellSpacing=0>
						<TR id="footer"> 
				         	<TD> 
				         	    <input name="queryButton" type="button" class="b_foot" value="查询" onClick="subform1()" >
						 	</TD>
				       	</TR>
				    </TABLE>
			</form>
			</div>
			
			
			
			
			<!--统付集团查询 --> 
			<div id=frm style='display:none'>
			<form name="form2"  method="get">
				<input type="hidden" name="turnValue" value="">
					  <TABLE id="mainOne" cellspacing="0">
			            <TR id="line_1"> 
							<td class='blue' nowrap>查询条件</TD>
		            		<TD colspan="3">
		            			<select name="QryFlag" onchange="doChange2()">
		            				<option value="0">按客户编号查询</option>
		            				<option value="1" selected>按证件号码查询</option>
		            				<option value="2">按集团编号查询</option>
		            				<option value="3">按统付账号查询</option><!-- wuxy add 20090208 -->
		            				<option value="4">按成员号码查询</option><!-- wuxy add 20090208 -->
		            			</select>
		            		</TD>
		            	</tr>
		            	<TR>
		            		<td class='blue' nowrap>
		            		<div id=tbs21 style='display:'>
							证件号码
							</div>
							<div id=tbs22 style='display:none'>
							集团编号					
							</div>
							<div id=tbs20 style='display:none'>
							客户编号					
							</div>
							<div id=tbs23 style='display:none'>
							统付账号				
							</div>
							<div id=tbs24 style='display:none'>
							成员号码				
							</div>
							</TD>
		            		<TD colspan="3">
		            		  	<input type=text v_type="string" v_must=1 id="QryValues2" name="QryValues" maxlength=18>
		            			<font class='orange'>*</font>
		            		</TD> 
			            </TR>
			        </TABLE> 
			        <TABLE cellSpacing=0>
						<TR id="footer"> 
				         	<TD> 
				         	    <input name="queryButton" type="button" class="b_foot" value="查询" onClick="subform2()" >
						 	</TD>
				       	</TR>
				    </TABLE>
			</form>
			</div>
			
			
			
			
			<!--付费关系 --> 
			<div id=frm style='display:none'>
			<form name="form3"  method="get">
				<input type="hidden" name="turnValue" value="">
					  <TABLE id="mainOne" cellspacing="0">
			            <TR id="line_1"> 
							<td class='blue' nowrap>查询条件</TD>
		            		<TD colspan="3">
		            			<select name="QryFlag" onchange="doChange3()">
		            				<option value="0">按客户编号查询</option>
		            				<option value="1" selected>按证件号码查询</option>
		            				<option value="2">按集团编号查询</option>
		            				<option value="3">按统付账号查询</option><!-- wuxy add 20090208 -->
		            				<option value="4">按成员号码查询</option><!-- wuxy add 20090208 -->
		            			</select>
		            		</TD>
		            	</tr>
		            	<TR> 
		            		<td class='blue' nowrap>
		            		<div id=tbs31 style='display:'>
							证件号码
							</div>
							<div id=tbs32 style='display:none'>
							集团编号				
							</div>
							<div id=tbs30 style='display:none'>
							客户编号				
							</div>
							<div id=tbs33 style='display:none'>
							统付账号				
							</div>
							<div id=tbs34 style='display:none'>
							成员号码				
							</div>
							</TD>
		            		<TD colspan="3">
		            		  	<input type=text v_type="string" v_must=1 id="QryValues3" name="QryValues" maxlength=18>
		            			<font class='orange'>*</font>
		            		</TD> 
			            </TR>
			        </TABLE> 
			        <TABLE cellSpacing=0>
						<TR id="footer"> 
				         	<TD> 
				         	    <input name="queryButton" type="button" class="b_foot" value="查询" onClick="subform3()" >
						 	</TD>
				       	</TR>
				    </TABLE>
			</form>
			</div>
			
			
			
			
			
				<!--划拨记录 --> 
			<div id=frm style='display:none'>
			<form name="form4"  method="get">
				<input type="hidden" name="turnValue" value="">
				<input type="hidden" name="dataStr" value="<%=dataStr%>"/>
				<input type="hidden" name="dataStr1" value="<%=dataStr1%>"/>
					  <TABLE id="mainOne" cellspacing="0">
			            <TR id="line_1"> 
							<td class='blue' nowrap>查询条件</TD>
		            		<TD>
		            			<select name="QryFlag" onchange="doChange4()">
		            				<option value="0">按客户编号查询</option>
		            				<option value="1" selected>按证件号码查询</option>
		            				<option value="2">按集团编号查询</option>
		            				<option value="3">按统付账号查询</option><!-- wuxy add 20090208 -->
		            				<option value="4">按成员号码查询</option><!-- wuxy add 20090208 -->
		            			</select>
		            		</TD>
		            		
		            		
		            		
		            		<td class='blue' nowrap>
		            		<div id=tbs41 style='display:'>
							证件号码
							</div>
							<div id=tbs42 style='display:none'>
							集团编号					
							</div>
							<div id=tbs40 style='display:none'>
							客户编号					
							</div>
							<div id=tbs43 style='display:none'>
							统付账号					
							</div>
							<div id=tbs44 style='display:none'>
							成员号码					
							</div>
							</TD>
		            		<TD>
		            		  	<input type=text v_type="string" v_must=1 id="QryValues4" name="QryValues" maxlength=18>
		            			<font class='orange'>*</font>
		            		</TD> 
		            	</tr>
		            	<TR> 
		            		<td class='blue' nowrap>划拨年月</TD>
		            		<TD>
		            		<input type=text v_type="string" v_must=1 id="" name="huaboym" maxlength=6><font class='orange'>*</font>(格式：YYYYMM)
		            		</TD>
		            		<td class='blue' nowrap>统付关系</TD>
		            		<TD>
		            		<select name="tongfulb" >
		            				<option value="0">统付</option>
		            				<option value="1" >按帐目项统付</option>
		            			</select>
		            		</TD>
			            </TR>
			        </TABLE> 
			        <TABLE cellSpacing=0>
						<TR id="footer"> 
				         	<TD> 
				         	    <input name="queryButton" type="button" class="b_foot" value="查询" onClick="subform4()" >
						 	</TD>
				       	</TR>
				    </TABLE>
			</form>
			</div>
      <!--add by diling for 集团按账目项付费查询@2012/5/25 --> 
			<div id=frm style='display:none' >
			<form name="form5"  method="get">
				<input type="hidden" name="turnValue" value="" />
				<input type="hidden" name="idNo" value="" />
				<input type="hidden" name="QryFlag" value="2"  />
					  <TABLE id="mainOne" cellspacing="0">
		            	<TR> 
		            		<td class='blue' nowrap>
							<div id=tbs62 style='display:'>
							集团编号				
							</div>
							</TD>
		            		<TD colspan="3">
		            		  
		            		  	<input type=text v_type="string" v_must=1 id="QryValues5" name="QryValues" maxlength=18>
		            			<font class='orange'>*</font>
		            		</TD> 
			            </TR>
			        </TABLE> 
			        <TABLE cellSpacing=0>
						<TR id="footer"> 
				         	<TD> 
				         	    <input name="queryButton" type="button" class="b_foot" value="查询" onClick="subform5()" >
						 	</TD>
				       	</TR>
				    </TABLE>
			</form>
			</div>
       <!--add by diling --> 
<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>
