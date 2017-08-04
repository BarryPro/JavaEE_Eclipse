<%
  /*
   * 功能: 集团产品预销恢复 e844
   * 版本: 1.0
   * 日期: 2012-5-14
   * 作者: diling
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>    
<%
  String opCode = "e844";
  String opName = "集团产品预销恢复";
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String workno = (String)session.getAttribute("workNo");
  String workname = (String)session.getAttribute("workName");
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");

  /*
    SQL语句        sql_content
    选择类型       sel_type
    标题           title
    字段1名称      field_name1
  */
  String pageTitle = request.getParameter("pageTitle");
  String fieldNum = "";
  String fieldName = request.getParameter("fieldName");
  String iccid = WtcUtil.repNull(request.getParameter("iccid"));
  String cust_id = WtcUtil.repNull(request.getParameter("cust_id"));
  String unit_id = WtcUtil.repNull(request.getParameter("unit_id"));
  String user_no = WtcUtil.repNull(request.getParameter("user_no"));
  String chance_id =WtcUtil.repNull(request.getParameter("chance_id"));
  String op_code= WtcUtil.repNull(request.getParameter("op_code"));


  String op_type="";
	if("e844".equals(op_code))
		op_type="u08";
	

  String selType = request.getParameter("selType");
  String retQuence = request.getParameter("retQuence");

  if(selType.compareTo("S") == 0)
  {   selType = "radio";    }
  if(selType.compareTo("M") == 0)
  {   selType = "checkbox";   }
  if(selType.compareTo("N") == 0)
  {   selType = "";   }

  int chPos = 0;
  String typeStr = "";
  String inputStr = "";
  String valueStr = "";
%>

<HTML><HEAD>
<TITLE>黑龙江BOSS-集团客户查询</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0">
<SCRIPT type=text/javascript>
function saveTo()
{
      
      var rIndex;        //选择框索引
      var retValue = ""; //返回值
      var chPos;         //字符位置
      var obj;
      var fieldNo;        //返回域序列号
      var retFieldNum = document.fPubSimpSel.retFieldNum.value;
      var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列
      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
      var tempQuence;
      if(retFieldNum == "")
      {     return false;   }
       //返回单条记录
          for(i=0;i<document.fPubSimpSel.elements.length;i++)
          {
                  if (document.fPubSimpSel.elements[i].name=="List")
                  {    //判断是否是单选或复选框
                       if (document.fPubSimpSel.elements[i].checked==true)
                       {     //判断是否被选中
                             //alert(document.fPubSimpSel.elements[i].value);
                             rIndex = document.fPubSimpSel.elements[i].RIndex;
                             tempQuence = retQuence;
                             for(n=0;n<retNum;n++)
                             {
                                chPos = tempQuence.indexOf("|");
                                fieldNo = tempQuence.substring(0,chPos);
                                //alert(fieldNo);
                                obj = "Rinput" + rIndex +"-"+ fieldNo;
                                //alert(obj);
                                //alert(document.all(obj).value);
                                //alert(retValue);
                                retValue = retValue + document.all(obj).value + "|";
                                //alert(retValue);
                                tempQuence = tempQuence.substring(chPos + 1);
                             }
                             //alert(retValue);
                             window.returnValue= retValue;
                             //alert(retValue);
                             
                       }
                }
            }
        if(retValue =="")
        {
            rdShowMessageDialog("请选择信息项！",0);
            return false;
        }
        retValue=retValue+"0.00|0.00|"
        //alert(retValue);
        opener.getvaluecust(retValue);
        window.close();
}

function allChoose()
{   //复选框全部选中
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    {
        if(document.fPubSimpSel.elements[i].type=="checkbox")
        {    //判断是否是单选或复选框
            document.fPubSimpSel.elements[i].checked = true;
        }
    }
}

function cancelChoose()
{   //取消复选框全部选中
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    {
        if(document.fPubSimpSel.elements[i].type =="checkbox")
        {    //判断是否是单选或复选框
            document.fPubSimpSel.elements[i].checked = false;
        }
    }
}
</SCRIPT>

<!--**************************************************************************************-->
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
</HEAD>
<BODy>
<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">集团产品查询</div>
	</div>

  <table cellspacing="0">
    <tr>
<TR>
	<TH nowrap>证件号码</TH>
	<TH nowrap>集团客户ID</TH>
	<TH nowrap>集团客户名称</TH>
	<TH nowrap>集团产品ID</TH>
	<TH nowrap>集团用户编号</TH>
	<TH nowrap>用户名称</TH>
	<TH nowrap>产品代码</TH>
	<TH nowrap>产品名称</TH>
	<TH nowrap>集团编号</TH>
	<TH nowrap>产品付费帐户</TH>
	<TH nowrap>品牌名称</TH>
	<TH nowrap style='display:none'>品牌代码</TH>
	<TH nowrap>产品号码</TH></TR>
<%  //绘制界面表头
     chPos = fieldName.indexOf("|");
     out.print("");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {
        valueStr = fieldName.substring(0,chPos);
        titleStr = "";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("");
     fieldNum = String.valueOf(tempNum+1);
%>

<%
    //根据传人的Sql查询数据库，得到返回结果
    try
    {
%>	  	
<wtc:service name="s3096QryCheckE" outnum="<%=fieldNum%>" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=workno%>" />	
		<wtc:param value="<%=unit_id%>" />	
		<wtc:param value="<%=op_type%>" />	
		<wtc:param value="<%=chance_id%>" />	
		<wtc:param value="<%=iccid%>" />	
		<wtc:param value="<%=cust_id%>" />			
		<wtc:param value="<%=user_no%>" />	
		<wtc:param value="<%=opCode%>" />
</wtc:service>
<wtc:array id="result" scope="end"/>

<%
      System.out.println(code2);
            
            if(!code2.equals("000000")){
            %>
            <script>
              alert("错误代码：<%=code2%> <br>错误信息：<%=msg2%>");
              window.close();
            </script>
            <%
            }else{
              for(int i=0;i<result.length;i++)
              {
                  typeStr = "";
                  inputStr = "";
                  out.print("<TR bgcolor='#EEEEEE'>");
                  for(int j=0;j<13;j++)
                  {
                     System.out.println("2222222==="+result[i][j]);
                      if(j==0)
                      {
                          typeStr = "<TD>";
                          if(selType.compareTo("") != 0)
                          {
                              typeStr = typeStr + "<input type='" + selType +
                                  "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                  "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                          }
  
        					        typeStr = typeStr + result[i][j] + "<input type='hidden' " +
                          " id='Rinput" + i +"-"+ j + "' class='button' value='" +
                          result[i][j] + "' readonly></TD>";
        					
                      }
                      else if(j==11)
                      {
        					        inputStr = inputStr + "<TD style='display:none'>" + (result[i][j]).trim() + "<input type='hidden' " +
                          " id='Rinput" + i +"-"+ j + "'  value='" +
                          (result[i][j]).trim() + "' readonly></TD>";
        					
                      }
                      else
                      {
        					        inputStr = inputStr + "<TD>" + result[i][j] + "<input type='hidden' " +
                          " id='Rinput" + i +"-"+ j + "' class='button' value='" +
                          result[i][j] + "' readonly></TD>";
        					
                      }
                  }
                  System.out.print(typeStr + inputStr);
                  out.print(typeStr + inputStr);
                  out.print("</TR>");
              }
           }
        }catch(Exception e){

        }
%>

 </tr>
  </table>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR id="footer">
            <TD align=center>
<%
    if(selType.compareTo("checkbox") == 0)
    {
        out.print("<input class='button' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input class='button' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");
    }
%>

<%
                if(selType.compareTo("") != 0)
                {
%>
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
<%
                }
%>
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>
 

  <!------------------------>
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>
  <%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY></HTML>
