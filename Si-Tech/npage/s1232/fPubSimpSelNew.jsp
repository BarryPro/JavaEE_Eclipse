<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<!-------------------------------------------->
<%/*
* 功能    :
* 版本    : 1.0
* 日期    : 2003-11-01
* 作者    : zhangwjl
* 修改    : wanglei on 20100107 添加自动选择一行
* 版权    : si-tech
* update  @ 2008-5-20
*/%>
<!-------------------------------------------->

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName = request.getParameter("pageTitle");
    String v_opCode = request.getParameter("v_opCode");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlStr = request.getParameter("sqlStr");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    String id_iccid = request.getParameter("id_iccid"); //身份证号码
    String regionCode=(String)session.getAttribute("regCode"); 
    String work_no = (String)session.getAttribute("workNo");
    String loginPwd    = (String)session.getAttribute("password");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String notestr="根据iccid=["+id_iccid+"]进行查询";
    System.out.print("sqlStr="+sqlStr);
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
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>黑龙江BOSS-<%=pageTitle%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
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
      //var tempQuence;
      var tmpArr = retQuence.split('|');
      if(retFieldNum == "")
      {     return false;   }
       //返回单条记录
          for(i=0;i<document.fPubSimpSel.elements.length;i++)
          {
    		      if (document.fPubSimpSel.elements[i].name=="List")
    		      {    //判断是否是单选或复选框
    				   if (document.fPubSimpSel.elements[i].checked==true)
    				   {     //判断是否被选中
        			         rIndex = document.fPubSimpSel.elements[i].RIndex;
        			         //tempQuence = retQuence;
        			         for(n=0;n<retNum;n++)
        			         {
        			            //chPos = tempQuence.indexOf("|");
        			            //fieldNo = tempQuence.substring(0,chPos);
        			            obj = "Rinput" + rIndex + tmpArr[n];
        			            retValue = retValue + document.all(obj).value + "|";
        			            //tempQuence = tempQuence.substring(chPos + 1);
        			         }
        					 window.returnValue= retValue
                       }
    		    }
    		}
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择信息项！",0);
		    return false;
		}

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

/*
 * @author wanglei
 * @date   20100107
 * @desc   once the page has only a single row
 					 then it will be selected automatic
 */
function SimpBySel(){
	var _rows = document.getElementById('tabData').rows;
	if(_rows.length == 3){
		document.getElementById('List').checked=true;
	}
	return;
}

</SCRIPT>
</HEAD>
<body style="overflow-x:hidden" onload=SimpBySel()>
<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">查询结果</div>
	</div>
  <table cellspacing="0" id="tabData">
    <tr>
<%  //绘制界面表头
     chPos = fieldName.indexOf("|");
     out.print("<TR>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TH nowrap>&nbsp;&nbsp;" + valueStr + "</TH>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
%>
	<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="100" >
    <wtc:param value="0"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=v_opCode%>"/>
    <wtc:param value="<%=work_no%>"/>	
    <wtc:param value="<%=loginPwd%>"/>		
    <wtc:param value=""/>	
    <wtc:param value=""/>
    <wtc:param value="<%=ipAddr%>"/>
    <wtc:param value="<%=notestr%>"/>
    <wtc:param value=""/>
    <wtc:param value=""/>
    <wtc:param value="<%=id_iccid%>"/>
    <wtc:param value=""/>
  </wtc:service>
  <wtc:array id="returnFlag" start="0" length="1" scope="end"/>
  <wtc:array id="result" start="1" length="5" scope="end"/>	
<%
    //根据传人的Sql查询数据库，得到返回结果

      		int recordNum = result.length;
      		if("000000".equals(retCode)){
      		  if(result.length>0){
      		    if("02".equals(returnFlag[0][0])){
      		      for(int i=0;i<recordNum;i++)
            		{
            		  for(int j =0;j<result[i].length;j++){
            		    //System.out.println("diling---result["+i+"]["+j+"]="+result[i][j]);
            		  }
            		   String tdClass = ((i%2)==1)?"Grey":"";
            		    typeStr = "";
            		    inputStr = "";
            		    out.print("<TR>");
            		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
            		    {
                          if(j==0)
                          {
                              typeStr = "<TD title=\'"+(result[i][0]).trim()+"\' class='"+tdClass+"'>&nbsp;";
                              if(selType.compareTo("") != 0)
                              {
      	                        typeStr = typeStr + "<input type='" + selType +
      	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" +
      	          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
      						            }
                              typeStr = typeStr + (result[i][0]).trim() + "<input type='hidden' " +
                		            " id='Rinput" + i + j + "'  value='" +
                		            (result[i][0]).trim() + "'readonly></TD>";
                          }
                          else
                          {
                		        inputStr = inputStr + "<TD title=\'"+(result[i][4]).trim()+"\' class='"+tdClass+"'>&nbsp;" + (result[i][4]).trim() + "<input type='hidden' " +
                		            " id='Rinput" + i + j + "'  value='" +
                		            (result[i][4]).trim() + "'readonly></TD>";
                          }
            		    }
            		    out.print(typeStr + inputStr);
            		    out.print("</TR>");
            		 }
      		    }
      		  }
      		  
      		}
      		
%>

   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellspacing="0">
        <TR>
            <TD id="footer">
<%
    if(selType.compareTo("checkbox") == 0)
    {
        out.print("<input  name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input  name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");
    }
%>

<%
				if(selType.compareTo("") != 0)
				{
%>
                <input  name=commit onClick="saveTo()" class="b_foot" style="cursor:hand" type=button value=确认>&nbsp;
<%
				}
%>
                <input  name=back onClick="window.close()" class="b_foot" style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TABLE>

  <!------------------------>
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>
 <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</body></HTML>
