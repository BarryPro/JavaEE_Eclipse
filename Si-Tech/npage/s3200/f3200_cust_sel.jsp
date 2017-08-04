   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "3200";
  String opName = "VPMN集团开户";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=Gb2312"%>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>

<%
    //得到输入参数
    String return_code,return_message;
    String[][] result = new String[][]{};
    String[][] allNumStr =  new String[][]{};
    
    String regionCode = (String)session.getAttribute("regCode");
    
    
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
    String cust_id = request.getParameter("cust_id");
    String unit_id = request.getParameter("unit_id");
    String sqlFilter = "";

        int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
        int iPageSize = 25;
        int iStartPos = (iPageNumber-1)*iPageSize;
        int iEndPos = iPageNumber*iPageSize;

    if (iccid.trim().length() > 0)
        sqlFilter = sqlFilter + " and a.id_iccid = '" + iccid + "'";
    if (unit_id.trim().length() > 0)
        sqlFilter = sqlFilter + " and b.unit_id = " + unit_id;                                          
    if (cust_id.trim().length() > 0)
        sqlFilter = sqlFilter + " and b.cust_id = " + cust_id;

    String sqlStr = "select nvl(count(*),0) num from dCustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id " + sqlFilter;
		/** add by daixy 20081127,group_id来自dCustDoc中的org_id
		 ** String sqlStr1 = "select * from (select a.id_iccid, a.cust_id, a.cust_name, b.unit_id, b.unit_name, a.org_code,b.contact_person ,b.unit_addr ,b.contact_phone, rownum id from dCustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id " + sqlFilter + ") where id <"+iEndPos+" and id>="+iStartPos;
		**/   
   	String sqlStr1 = "select * from (select a.id_iccid, a.cust_id, a.cust_name, b.unit_id, b.unit_name, a.org_code,b.contact_person ,b.unit_addr ,b.contact_phone, a.org_id, rownum id from dCustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id " + sqlFilter + ") where id <"+iEndPos+" and id>="+iStartPos;
   /**add by daixy 20081127,group_id来自dcustDoc的org_id end **/
        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@"+sqlStr1);
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    //System.out.print("sqlStr="+sqlStr);
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    if(selType.compareTo("N") == 0)
    {   selType = "";   }
    //=====================
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
                                            obj = "Rinput" + rIndex + fieldNo;
                                            //alert(obj);
                                            retValue = retValue + document.all(obj).value + "|";
                                            tempQuence = tempQuence.substring(chPos + 1);
                                         }
                             //alert(retValue);                                  
                                                 window.returnValue= retValue;
                       }
                    }
                }               
                if(retValue =="")
                {
                    rdShowMessageDialog("请选择信息项！",0);
                    return false;
                }
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
</HEAD>
<BODY>

<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>


	<div class="title">
		<div id="title_zi">集团客户查询</div>
	</div>
	 
  <table cellspacing="0">
    <tr>
<TR bgcolor='649ECC' height=25>
	<TD align=center class="blue">证件号码</TD>
	<TD align=center class="blue">客户ID</TD>
	<TD align=center class="blue">客户名称</TD>
	<TD align=center class="blue">集团ID</TD>
	<TD align=center class="blue">集团名称</TD>
	<TD align=center class="blue">归属地</TD>
	<TD align=center class="blue">联系人姓名</TD>
	<TD align=center class="blue">集团联系地址</TD>
	<TD align=center class="blue">集团联系电话</TD>
	<TD align=center class="blue">归属组织</TD>
</TR> 
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


		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="allNumStr_t" scope="end"/>


		<wtc:pubselect name="sPubSelect" outnum="<%=fieldNum%>" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_t" scope="end"/>

<%             
                //retArray = callView.sPubSelect(fieldNum,sqlStr1);
                //retArray1 = callView.sPubSelect("1",sqlStr);
                result = result_t;
                
                allNumStr = allNumStr_t;
                int recordNum = Integer.parseInt(allNumStr[0][0].trim());
                for(int i=0;i<recordNum;i++)
                {
                    typeStr = "";
                    inputStr = "";
                    out.print("<TR bgcolor='#EEEEEE'>");
                    for(int j=0;j<Integer.parseInt(fieldNum)-1;j++)
                    {
                    if(j==0)
                    {
                        typeStr = "<TD>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
                                typeStr = typeStr + "<input type='" + selType +  
                                            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
                                            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
                                                }                                           
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
                                    " id='Rinput" + i + j + "' class='button' value='" + 
                                    (result[i][j]).trim() + "'readonly></TD>";                                      
                    }
                    else
                    {                           
                                inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                                    " id='Rinput" + i + j + "' class='button' value='" + 
                                    (result[i][j]).trim() + "'readonly></TD>";                                      
                    }                               
                    }
                    out.print(typeStr + inputStr);
                    out.print("</TR>");
                }
        }catch(Exception e){
                
        }          
%>
<%


%>   
   </tr>
  </table>
<%      
    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
        PageView view = new PageView(request,out,pg); 
         
%>
<div style="position:relative;font-size:12px" align="center">

<%
    view.setVisible(true,true,0,0);      
%>

</div>

<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer">
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
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    