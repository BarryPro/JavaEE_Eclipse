<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by leimd @ 2009-04-15
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
    String opName = "集团包年产品信息查询";
    String regionCode = (String)session.getAttribute("regCode");
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    //得到输入参数
    String[][] result = new String[][]{};
    String[][] allNumStr =  new String[][]{};
    String opCode = "1036";
    
%>

<%
/*
	SQL语句        sql_content
	选择类型       sel_type
	标题           title
	字段1名称      field_name1
*/
	String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
	String iccid = request.getParameter("iccid");
    String unit_id = request.getParameter("unit_id");
    String user_no = request.getParameter("user_no");
	
	 String jituanchanpinid = request.getParameter("jituanchanpinid");
	  String product_id = request.getParameter("product_id");
	  String sm_code = request.getParameter("sm_code");
	  String request_type = request.getParameter("request_type");
	  if(request_type==null) {
	  request_type="";
	  }

    
    
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    
    int iPageSize = 25;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;
    String distyle="block";
   

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
 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-集团客户查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<SCRIPT type="text/javascript">
function saveTo()
{
      var rIndex;        //选择框索引
      var retValue = ""; //返回值
      var chPos;         //字符位置
      var obj;
      var fieldNo;        //返回域序列号
      var sretvalueshai;
      var retFieldNum = document.fPubSimpSel.retFieldNum.value;
      var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列
      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
      var tempQuence;
      var strs;
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
                             tempQuence = retQuence;
                             for(n=0;n<retNum;n++)
                             {
                                chPos = tempQuence.indexOf("|");
                                fieldNo = tempQuence.substring(0,chPos);
                                obj = "Rinput" + rIndex +"0"+ fieldNo;
                                retValue = retValue + document.all(obj).value + "|";
                                tempQuence = tempQuence.substring(chPos + 1);
                             }
                             var sretvalueshaiss=retValue.split("|");
                             strs=sretvalueshaiss[2]+"|"+sretvalueshaiss[3]+"|";
                             window.returnValue= strs;
                       }
                }
            }
        if(retValue =="")
        {
            rdShowMessageDialog("请选择信息项！",0);
            return false;
        }
        opener.getvaluecust2(strs);
        
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

</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
<table cellspacing="0">
    <tr>
	<TR align="center">
<TH> </TH>
	    <TH>资费代码 </TH>
	    <TH>资费名称</TH>

    </TR>
<% 
 //绘制界面表头
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
     fieldNum = String.valueOf(tempNum);
%>

<%
    //根据传人的Sql查询数据库，得到返回结果
    try
    {

	
    %>
        <wtc:service name="sGetAddProduct" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >

        	<wtc:param value=""/>
        	<wtc:param value="<%=jituanchanpinid%>"/> 
            <wtc:param value=""/> 
            <wtc:param value="<%=product_id%>"/> 
            <wtc:param value="<%=regionCode%>"/> 
            <wtc:param value="<%=sm_code%>"/> 
            <wtc:param value="<%=request_type%>"/> 
            <wtc:param value="g221"/>  
        
        		<wtc:param value=""/>
        		<wtc:param value=""/> 
            <wtc:param value=""/> 
            <wtc:param value="<%=workNo%>"/> 
            
            <wtc:param value="<%=unit_id%>"/> 
            <wtc:param value="01"/> 
            <wtc:param value="<%=iccid%>"/> 

        </wtc:service>
        <wtc:array id="retArr1"  scope="end"  />
    <%
        result=retArr1;
        //out.println(result.length);
        int recordNum = result.length;
    
        //allNumStr = retArr2;
        //System.out.println("---------------"+allNumStr[0][0]);
        //System.out.println("---------------"+retArr2[0][0]);
        //int recordNum = Integer.parseInt(allNumStr[0][0].trim());
        for(int i=0;i<recordNum;i++)
        {
            typeStr = "";
            inputStr = "";
            out.print("<TR>");
            for(int j=0;j<Integer.parseInt(fieldNum);j++)
            {
                if(j==0)
                {
                    typeStr = "<TD>";
                    if(selType.compareTo("") != 0)
                    {
                        typeStr = typeStr + "<input type='" + selType +
                            "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                            "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                    }
                    typeStr = typeStr + "<input type='hidden' " +
                        " id='Rinput" + i + "0" + j + "' value='" +
                        (result[i][j]).trim() + "'readonly></TD>";
                }
                else
                {
                      if(j==1)  {
                    	distyle="none";
                    }else {
                    	distyle="block";
                    	}
                    inputStr = inputStr + "<TD style='display:"+distyle+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                        " id='Rinput" + i + "0" + j + "' value='" +
                        (result[i][j]).trim() + "'readonly></TD>";
                }
            }
            out.print(typeStr + inputStr);
            out.print("</TR>");
        }
      }catch(Exception e){
            e.printStackTrace();
        }
%>
	</tr>
</table>



<TABLE cellSpacing=0>
    <TBODY>
        <TR id="footer">
            <TD>
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
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>
<%
                }
%>
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>
            </TD>
        </TR>
    </TBODY>
</TABLE>
	<input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  	<input type="hidden" name="retQuence" value=<%=retQuence%>>
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>  	
