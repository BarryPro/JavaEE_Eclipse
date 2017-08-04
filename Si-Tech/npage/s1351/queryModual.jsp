<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.util.DateTrans"%>

<%
    response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);


		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String date1="";
		String date2="";
		DateTrans dt=new DateTrans();
		date1=dt.getYear()+""+dt.getMonth();
		dt.addMonth(-1);
		date2=dt.getYear()+""+dt.getMonth();
		dt.addMonth(1);


		    //String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"","","","","",""};

  Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=5;i++)
      {
              if(i!=5)
              {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
      }
    String opCode = "XXXX";
    String opName = "个人统一账单模板查询结果";
    String id_no="";
	  String phoneNO=(request.getParameter("phoneno")).trim();
	  session.setAttribute("phoneno",phoneNO);
	  String regioncode=request.getParameter("regioncode");
	  String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
	  String sql1="select a.show_mode,c.mode_name,to_char(a.total_date) from dBillListDetail a,dcustmsg b,sBillListDefine c where a.show_mode=c.show_mode and a.id_no=b.id_no and b.phone_no="+phoneNO;
    String sql2="select to_char(count(*)) from dcustmsg where phone_no="+phoneNO;
    System.out.println("---------------------------zss---------------------------"+sql1);
    

  
  %>
    
	<wtc:pubselect name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="3">
	<wtc:sql><%=sql1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="ret_val1" scope="end" />
  <%
  String[][] ret_val=ret_val1;

  
	System.out.println("-------------------------"+ret_val1.length);
	
	if(ret_val1.length==0)
	{
%>
    <script language="JavaScript">
     
     
      rdShowMessageDialog("该用户没有定制模板！");
      var	prtFlag = rdShowConfirmDialog("是否定制模板！");
		  if(prtFlag==1)
		  {
		  //alert("<%=phoneNO%>");
		  window.location.href="makeModual.jsp?phoneno=<%=phoneNO%>";
		
		  }
		  
    </script>
<% 
  } 
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>XX查询</TITLE>
<SCRIPT language="JavaScript">


    function print()
    {
        
        if(!forDate(document.frm.beginDate)) return;
      
        var userRole =document.getElementsByName("modual");
        
        for(var i=0;i<userRole.length;i++){
          if(userRole[i].checked ==true){
          	  
              document.frm.modual1.value=userRole[i].value;
             
              break;
          }
         }  
         if(i==userRole.length)
         {
         	  rdShowMessageDialog("请选择打印模板！",0);
		        return;
         	}
         

      	if(parseFloat(document.frm.beginDate.value)<190001)
      	{
		    rdShowMessageDialog("帐务年月不能小于1900年！",0);
		    return;
	      }
	     
	      
        document.frm.action='printModual.jsp?phoneno='+document.frm.phoneno.value+'&show_mode='+document.frm.modual1.value+'&yearmonth='+document.frm.beginDate.value+'&workno='+document.frm.workno.value+'&org_code='+document.frm.org_code.value;
        frm.submit();
    }
     function dingzhi()
    {
           document.frm.action='makeModual.jsp?phoneno='+document.frm.phoneno.value;
           frm.submit();
    }
</SCRIPT>


</HEAD>
<body>

<%@ include file="/npage/include/header.jsp" %>
<FORM method=post name="frm" action='makeModual.jsp'>
<input type="hidden" name="phoneno"  value="<%=phoneNO%>">
<input type="hidden" name="workno"  value="<%=workno%>">
<input type="hidden" name="org_code"  value="<%=org_code%>">
<input type="hidden" name="modual1"  value="">

<div class="title">
	<div id="title_zi">查询结果</div>
</div>

      <table cellspacing="0">
                <tr> 
                	<th align="center" >选择</th>
                  <th>模板代码</th>
                  <th>模板名称</th>
                  <th>定制日期</th>
                  
                  
                </tr>
<%	      for(int y=0;y<ret_val.length;y++)
	      {
	      
%>

	        <tr>
	        	 <td > 
				      <div align="center"> 
				        <input type="radio" name="modual" value="<%=ret_val[y][0].trim()%>" >
			      	</div>
			       </td>
<%    	        for(int j=0;j<ret_val[0].length;j++)
	        {
%>
	              <td><%= ret_val[y][j]%></td>
<%	        }
%>
	        </tr>
<%	      }
%>            
              <table cellspacing="0" align="center">
              <tr>
              <div class="title"  align="center">
	            <div id="title_zi">输入账单年月</div>
              </div>
									<td nowrap align="center">
										账单年月：<input name="beginDate" type="text" v_format="yyyyMM"  class="input-write" value="<%=mon[1]%>" maxlength="6">
									</td>
									
              </tr>
               </table>
                </table>
           <table cellSpacing="0">
             <tr> 
                <td id="footer"> 
          
    	      <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	       <input class="b_foot" name=back onClick="dingzhi()" type=button value=定制模板>
    	       <input class="b_foot" name=back onClick="print()" type=button value=打印>
    	      <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
    	          </td>
              </tr>
         </table>
      	
    	    
        


</FORM>
<%@ include file="/npage/include/footer.jsp" %>
</BODY></HTML>


