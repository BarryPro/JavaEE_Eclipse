<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!-------------------------------------------->
<!---日期   2004-11-13                    ---->
<!---作者   qinxb                        	  ---->
<!---代码   f5431_2                       ---->
<!---功能  用户历史信息查询              ---->
<!---修改                                ---->
<!-------------------------------------------->
<%request.setCharacterEncoding("GB2312");%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

      int num = 20;
      int rows = 0;
      int columns = 0;
      int pagenum = 0;
      int apage = 0;
      int begins = 0;
      int ends = 0;
      int back = 0;

      String phone_no = "";
      String contractid = "";
      String userid = "" ;
      String checktype = "";
      String beginTime = "";
      String endTime = "";
      //String ret_code = "000001";
      String iwork_no = "匿名调用";
      String workName = "匿名调用";
      String region_code = "05";



       iwork_no = (String)session.getAttribute("workNo");
       workName =  (String)session.getAttribute("workName");  //操作工号
      String iwork_pwd =(String)session.getAttribute("password");;                               //工号密码
      String iorg_code =(String)session.getAttribute("orgId");;                                   //org_code
      String ithe_ip =  (String)session.getAttribute("ipAddr");
      region_code = iorg_code.substring(0,2);

        if(iwork_no == null)
        {
          iwork_no = "匿名调用";
        }
        if(workName == null)
        {
          workName = "匿名调用";
          }


	  //String ret_msg = "调用服务出错，请与管理员联系";
	  String title_name = "";
	  title_name = (String)request.getParameter("title_name");
	  if(title_name == null) title_name = "匿名调用";
          if((String)request.getParameter("pages") != null)
          {
              apage = Integer.parseInt((String)request.getParameter("pages"));
          }
          if((String)request.getParameter("pageback") != null)
          {
            back = Integer.parseInt((String)request.getParameter("pageback") );
            }

      ArrayList retArray = new ArrayList();
      String inputparams[]=new String[6];
      if(apage == 0)
      {
          back = 0;

          phone_no = (String)request.getParameter("phone_no");
		  if(phone_no == null) phone_no = "";
          userid = (String)request.getParameter("userid") ;
		  if(userid == null) userid = "";
          contractid = (String)request.getParameter("contractid");
		  if(contractid == null) contractid = "";
          checktype = (String)request.getParameter("check_type");
		  if(checktype == null) checktype = "";
          beginTime = (String)request.getParameter("beginTime");
                  if(beginTime == null) beginTime = "";
          endTime = (String)request.getParameter("endTime");
                  if(endTime == null) endTime = "";
	   inputparams[0]=phone_no;
	   inputparams[1]=userid;
	   inputparams[2]=contractid;
	   inputparams[3]=beginTime;
       inputparams[4]=endTime;
	   inputparams[5]=checktype;

          //S5061Wrapper wrapper = new S5061Wrapper();
          int return_no=22;
         // try{

                   //retArray = wrapper.dosPublicCfm2(service_name,region_code,inputparams,return_no,4,20).getList();
                  // apage = apage + 1;
                   //session.setAttribute("wcustqryshipConlection",retArray);
              //}
             //catch(Exception e)
             //{
                   //out.print(e.getMessage()) ;
             //}

      }
%>
	<wtc:service name="sCustQryShow" routerKey="region" routerValue="<%=region_code%>" retcode="ret_code" retmsg="ret_msg" outnum="24" >
		<wtc:param value="<%=inputparams[0]%>"/>
		<wtc:param value="<%=inputparams[1]%>"/>
		<wtc:param value="<%=inputparams[2]%>"/>
		<wtc:param value="<%=inputparams[3]%>"/>
		<wtc:param value="<%=inputparams[4]%>"/>
		<wtc:param value="<%=inputparams[5]%>"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="4" scope="end"/>
	<wtc:array id="results" start="4" length="20" scope="end"/>
<%
    //retArray = (ArrayList)session.getAttribute("wcustqryshipConlection");
    back = back + 1;
    //System.out.println("size: " + retArray.size());
    //String result[][] = (String[][])retArray.get(0);
    //String results[][] = (String[][])retArray.get(1);

	if(result.length == 1)
	{
     ret_code = result[0][0];
     ret_msg  = result[0][1];
	}


    if(ret_code.equals("000000") == true)
    {
    String arow = result[0][2];
    String acolumn = result[0][3];
    System.out.println("row:" + arow + "page :" + apage);
    rows = Integer.parseInt(arow.trim());
    rows = rows -2;
    if((rows%num) == 0)
    {
      pagenum = rows/num;
    }
    else
    {
      pagenum = (rows/num) + 1;
    }

   columns = Integer.parseInt(acolumn.trim()) ;

   //session.setAttribute("backpage",String.valueOf(back));





    }
%>
<HEAD><TITLE><%=title_name%></TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script language="javascript">
function jumping(){
  document.pageform.action="f5431_2.jsp?pages="+document.pageform.pages.value+"&title_name="+"<%=title_name%>" + "&pageback="+"<%=back%>";
document.pageform.submit();
  }
function gotopage(pagenum)
{
  document.pageform.pages.value = pagenum;
  document.pageform.action="f5431_2.jsp?pages="+document.pageform.pages.value+"&title_name="+"<%=title_name%>" + "&pageback="+"<%=back%>";
  document.pageform.submit();
}
function  docheck(dialog)
{
  rdShowMessageDialog(dialog);
  window.history.back();
}
function backpage(numbers)
{
 window.history.go(-numbers);
}

var to_another;
function to_excels(rows,columns)
{
  var temp = "to_excel.jsp?rows="+rows+"&columns="+columns;
  if(to_another)
  {
   if(!to_another.closed)
     {
       to_another.focus();
     }
     else
     {
       to_another = open(temp);
     }

  }
  else
  {
      to_another = open(temp);
  }

}
var printvalue;
function doprint(rows,columns)
{
  var temp = "to_print.jsp?rows="+rows+"&columns="+columns;
    if(printvalue)
  {
   if(!printvalue.closed)
     {
        rdShowMessageDialog("正在打印！请稍候再试！");
        return false;
     }
     else
     {
       printvalue = open(temp);
     }

  }
  else
  {
      printvalue = open(temp);
  }
}
</script>
</HEAD>
<BODY bgColor=#FFFFFF  background="../../images/jl_background_2.gif" leftmargin="0" topmargin="0" >
<%
if((apage == 1) && (ret_code.equals("000000") == false))

{

  %>
   <script  language="javascript" >
   docheck("<%=ret_code%>:  <%=ret_msg%>");
   </script>
  <%
}
else
{

  %>
 <form name="pageform" action="" method="POST">

      <table>
        <tr>
                    <%
              for(int i = 0 ;i<columns;i++)
              {%>
              <td >
                <%=results[0][i]%>
              </td>
			  <%}
		  %>
        </tr>

        <%
        if(apage == pagenum)
        {
          begins = (apage-1)*num;
          ends = results.length-2;
          }
        else
        {
          begins = (apage -1) * num;
          ends = apage * num;

          }
        for(int j = begins;j <ends ;j++)
        {
          %>
        <tr>
                              <%
              for(int i = 0 ;i<columns;i++)
              {
                %>
              <td>
                <%=results[j+1][i]%>
              </td>
			  <%}
		  %>
        </tr>
        <%
         }%>
        </table>
        <table>
          <tr>
            <td>
            共[<%=pagenum%>]页  共[<%=rows%>]条查询结果  第[<%=apage%>]页
           <%
               if(apage != 1)
               {
                 if(apage == pagenum)
                  {%>
                    <a href="javascript:gotopage(1)"> 首页 </a>
                    <a href="javascript:gotopage(<%=apage-1%>)">上一页 </a>
                  <%}
                 else
                  {%>
                     <a href="javascript:gotopage(1)"> 首页 </a>
                  <a href="javascript:gotopage(<%=apage-1%>)">上一页 </a>
                  <a href="javascript:gotopage(<%=apage+1%>)">下一页 </a>
                    <a href="javascript:gotopage(<%=pagenum%>)">尾页</a>
                   <%}
                }
                else if(pagenum != 1){
                {
                %>
                  <a href="javascript:gotopage(<%=apage+1%>)">下一页 </a>
                    <a href="javascript:gotopage(<%=pagenum%>)"> 尾页</a>
               <% }}%>
                <div align="right">到第 <select  name="pages" id="pages" onchange="jumping()" >
                   <%
                   for(int k = 1;k <= pagenum; k++)

	           {
                     if(k == apage){%>
                   <option class='button' selected value="<%=k%>"> <%=k%></option>
                   <%}else{%>
                   <option class='button' value="<%=k%>"> <%=k%></option>
                   <%}}%>
                </select>  页</div> </td>
          </tr>
        </table>
      <table>
          <tr>
            <td colspan="5" >
              <div align="center">
                <input class="button" type=button name=printpage value="打印"  language=javascript onclick="doprint(<%=rows%>,<%=columns%>)"  index="7">
                <input class="button" type=button name=excel value="导入excel" onClick="to_excels(<%=rows%>,<%=columns%>)" index="8">
                <!--<input class="button" type=button name=excel value="导入excel" onClick="printTable(t1);" index="8"> -->
                  <input class="button" type=button name=back value="返回" onClick="backpage(<%=back%>)" index="8">
                <input class="button" type=button name=qryPage value="关闭" onClick="window.close()" index="9">
              </div>
            </td>
          </tr>
       </table>
</form>

<%}%>
</body>
</html>
