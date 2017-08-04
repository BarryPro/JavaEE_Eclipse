<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:liutong@2008-8-18
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script language="JavaScript" src="/npage/s1300/common_1300.js"></script>
<%
        String opCode = "1304";
        String opName = "缴费(托收)";
        String workno = (String)session.getAttribute("workNo");
        String org_code = (String)session.getAttribute("orgCode");
        String workname = (String)session.getAttribute("workName");
        
        String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
        String dateStr2 = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
  
        //取上个月
        Calendar calendar = new GregorianCalendar();
		    int year = calendar.get(Calendar.YEAR);
		    int month = calendar.get(Calendar.MONTH);
        
        Date date = new Date();
		    date.setYear(year-1900);
		    date.setMonth(month - 1);
		
		    String yearMonth = new java.text.SimpleDateFormat("yyyyMM").format(date);

%>
<HTML>
<HEAD>
    <title>黑龙江BOSS-普通缴费</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<FORM action="" method="post" name="form">
    <input type="hidden" name="busy_type" value="1">
    <input type="hidden" name="op_code" value="1304">
    <input type="hidden" name="Op_Code" value="1304">
    <input type="hidden" name="count" value="">
    <input type="hidden" name="totaldate" value="<%=dateStr1%>">
    <input type="hidden" name="yearmonth" value="<%=dateStr%>">
    <input type="hidden" name="billdate" value="<%=dateStr.substring(0,6)%>">
    <input type="hidden" name="phoneno" value="">
    <input type="hidden" name="phoneNo" value="">
    <input type="hidden" name="contractno" value="">
    <input type="hidden" name="water_number" value="">
    <%@ include file="/npage/include/header.jsp" %>

    <div class="title">
        <div id="title_zi">请选择缴费方式</div>
    </div>

    <table cellspacing="0">
        <tbody>
            <tr>
                <td class="blue" width="15%">缴费方式</td>
                <td colspan="3">
                	<q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel1()" value="1">
                    服务号码
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType2" type="radio" onClick="sel2()" value="2">
                    帐户号码
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType5" type="radio" onClick="sel5()" value="5">
                    托收用户交费
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType3" type="radio" onClick="sel3()" value="3" checked>
                    托收单
                  </q>
                    <!--<input name="busyType4" type="radio"  onClick="sel4()" value="4"  >付费号码-->
                </td>
            </tr>
        </tbody>
    </table>
    <table cellspacing="0">
        <tr>
            <td width="15%" class="blue" nowrap>托收批次</td>
            <td>
                <input type="text" name="batch" maxlength="8" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" value="">
            </td>
            <td class="blue">托收年月</td>
            <td>
                <input type="text" name="sBillDate" maxlength="6" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" value="<%=yearMonth%>" v_format="yyyyMM">
            </td>
            <td class="blue" nowrap>合同号</td>
            <td>
                <input type="text" name="TContractNo" maxlength="14" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) DoCheck();">
            </td>
        </tr>
    </table>
    <TABLE cellSpacing="1">
        <TR>
            <TD noWrap colspan="6">
                <div align="center" id="footer">
                    <input type="button" name="Submit1" class="b_foot" value="查询" onclick="DoCheck()" index="9">
                    &nbsp;
                    <input type="button" name="return" class="b_foot" value="清除" onclick="doclear()" index="10">
                    &nbsp;
                    <input type="button" name="nopay" class="b_foot_long" value="上笔缴费冲正" onclick="donopay()" index="12">
                    &nbsp;
                    <input type="button" name="return" class="b_foot" value="关闭" onClick="parent.removeTab('<%=opCode%>');" index="13">
                </div>
            </TD>
        </TR>
    </TABLE>
      
	<%@ include file="/npage/include/footer_simple.jsp"%>
</FORM>

<script language="JavaScript">
<!--	

 function DoCheck()
 {
 
       if(document.all.batch.value.length<1){
          rdShowMessageDialog("托收批次输入错误，请输入托收批次！");
          document.all.batch.focus();
    			return false;
      }
             
       if(document.all.sBillDate.value.length<1){
           rdShowMessageDialog("托收年月输入错误，请输入托收年月！");
           document.all.sBillDate.focus();
     			 return false;
        }
        if (!forDate(document.all.sBillDate)){
          return false;
        }
            
        if (document.all.TContractNo.value.length<1){
    	      rdShowMessageDialog("合同号输入错误，请输入帐户号码！");
       			document.all.TContractNo.focus();
    	      return false;
         }
          document.form.action="s1300_batch.jsp";
          document.form.submit();
 }


 function sel1()
 {
           window.location.href='s1300.jsp';
  }
 function sel2()
 {
           window.location.href='s1300_2.jsp';
  }
 function sel3()
 {
           window.location.href='s1300_3.jsp';
   
  }
 function sel4()
   {
           window.location.href='s1300_4.jsp';
 }
 function sel5() 
 {
           window.location.href='s1300_5.jsp';
 }
 

function doclear()
{
 			form.reset();
  	  document.all.TContractNo.focus();
}

function donopay()
{	
        var opcode = document.all.Op_Code.value;
		if(document.form.count.value.length<11 && opcode=="1300")
		{
			rdShowMessageDialog("请输入正确的帐户号码！");
			document.form.count.focus();
			return false;
		}
		else if(document.form.phoneNo.value.length<11 && opcode=="1302")
		{
			rdShowMessageDialog("请输入正确的服务号码！");
			document.form.phoneNo.focus();
			return false;
		}
		else if(opcode=="1304" && document.all.TContractNo.value.length<1)
		{
			rdShowMessageDialog("合同号输入错误，请输入帐户号码！");
			document.all.TContractNo.focus();
    			return false;
    		}
		else if(opcode=="1304" && isNaN(document.all.TContractNo.value) )
		{
			rdShowMessageDialog("合同号只能是数字!");
			document.all.TContractNo.focus();
    			return false;
		}
		else
		{
			var h=480;
			var w=650;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
			var str="";
			if (document.all.Op_Code.value=="1302"||document.all.Op_Code.value=="1306") 
			{
				str = window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneNo.value,"",prop);
	  
				if( typeof(str) != "undefined" )
				{
					if (parseInt(str)==0)
					{
				   		rdShowMessageDialog("没有找到对应的帐号！",0);
				   		document.all.phoneNo.value="";
				   		document.all.count.value="";
				   		document.form.phoneNo.focus();
	   					return false;
	   				}
	   				else
	   				{
					document.form.count.value = str;}
					}
				}
				if(opcode!="1304") 
				{
				  var str = window.showModalDialog('getlast.jsp?phoneNo='+document.form.phoneNo.value+'&count='+document.form.count.value+'&yearmonth='+document.form.yearmonth.value+'&Op_Code='+document.form.Op_Code.value,"",prop);
					if( typeof(str) != "undefined" )
					{
						if (parseInt(str)==0)
						{
					   		rdShowMessageDialog("查询失败，该号码今天未做业务！",0);
					   		document.all.phoneNo.value="";
					   		document.all.count.value="";
					   		document.form.phoneNo.focus();
					   		return false;
	   					}
	   					else
	   					{
							var chPos_str = str.indexOf(".");
							document.form.contractno.value=str.substring(0,chPos_str);
							document.form.water_number.value=str.substring(chPos_str+1);
							document.form.phoneno.value=document.form.phoneNo.value;
							document.form.action="s1310_2.jsp";
							form.submit();		
						}
					}
				}
				else if(opcode=="1304")
				{
					
					str=window.showModalDialog('getlast.jsp?phoneNo='+document.form.phoneNo.value+'&contractno='+document.form.TContractNo.value+'&yearmonth='+document.form.yearmonth.value+'&op_code='+document.form.Op_Code.value,"",prop);
					if( typeof(str) != "undefined" )
					{
						if (parseInt(str)==0)
						{
	   						rdShowMessageDialog("查询失败，该号码今天未做业务！");
	   						document.form.TContractNo.focus();
	   						return false;
	   					}
	   				else
	   				{  
						var chPos_str = str.indexOf(".");
						document.form.contractno.value=str.substring(0,chPos_str);
						document.form.water_number.value=str.substring(chPos_str+1);
						document.form.phoneno.value=document.form.phoneNo.value;
						document.form.action="s1310_2.jsp";
						form.submit();
					}
				 }
			}
	}
}

-->
</script>

</BODY>
</HTML>
