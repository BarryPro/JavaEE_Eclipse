<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-19
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%@ page import="java.util.ArrayList" %>

<%
    String opName = "成员用户查询";
    //得到输入参数
    ArrayList retArray = new ArrayList();
    ArrayList retArray1 = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
    String[][] allNumStr =  new String[][]{};
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
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
    String user_no = request.getParameter("user_no");
    String busi_type = request.getParameter("busi_type");
    String sqlFilter = "";

    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 25;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;

	System.out.println("AAAAAAAAAb");
    if (iccid != null)
    {
	    if (iccid.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and a.id_iccid = '" + iccid + "'";
	    }
	}    
    if (cust_id != null)
    {
	    if (cust_id.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and a.cust_id = " + cust_id + " and b.cust_id = " + cust_id + " and c.cust_id = " + cust_id;
	    }
    }
    if (unit_id != null)
    {
	    if (unit_id.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and b.unit_id = " + unit_id;
	    }
    }
    if (user_no != null)
    {
	    if (user_no.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and e.service_type = c.sm_code and e.service_no = '" + user_no + "'";
	    }
    }
    if (busi_type != null)
    {
	    if (user_no.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and f.busi_type = '" + busi_type + "'";
	    }
    }
	sqlFilter=sqlFilter + " order by a.id_iccid,a.cust_id,b.unit_name";
    String sqlStr =  "SELECT nvl(count(*),0) num"
    				+"  FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, dAccountIdInfo e, sBusiTypeSmCode f"
    				+" WHERE c.product_code = d.product_code"
    				+"   AND a.cust_id = b.cust_id"
    				+"   AND c.run_code = 'A'"
    				+"   AND b.cust_id = c.cust_id"
    				+"   AND d.product_level = 1"
    				+"   AND d.product_status = 'Y'"
    				+"   AND c.bill_date > Last_Day(sysdate) + 1"
    				+"   and c.user_no = e.msisdn  "
    				+"   and c.sm_code = f.sm_code and c.sm_code = any('pe') "
    				+ sqlFilter;

    String sqlStr1 = "select * from ("
    				+"SELECT a.id_iccid, a.cust_id, TRIM (b.unit_name), c.id_no, Trim(e.service_no),"
    				+"       c.product_code, d.product_name, b.unit_id,"
    				+"       c.account_id,c.sm_code, g.sm_name"
    				+"  FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, dAccountIdInfo e, sBusiTypeSmCode f, sSmCode g"
    				+" WHERE c.product_code = d.product_code"
    				+"   AND a.cust_id = b.cust_id"
    				+"   AND b.cust_id = c.cust_id"
    				+"   AND c.run_code = 'A'"
    				+"   AND d.product_level = 1"
    				+"   AND d.product_status = 'Y'"
    				+"   AND c.bill_date > Last_Day(sysdate) + 1"
    				+"   and c.user_no = e.msisdn"
    				+"   and c.sm_code = f.sm_code and c.sm_code = any('pe') "
    				+"   and c.region_code = g.region_code"
    				+"   and c.sm_code = g.sm_code"
    				+ sqlFilter
    				+ " )-- where rowid <"+iEndPos+" and rowid>="+iStartPos;

	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!sqlStr1="+sqlStr1);
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

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>集团客户查询</TITLE>
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
	  //alert(retFieldNum);
      var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列

      var retNum = retQuence.substring(0,retQuence.indexOf("|"));

      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
//      alert(retQuence);
      var tempQuence;
      if(retFieldNum == "")
      {     return false;   }
       //返回单条记录retValue
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
                                 obj = "Rinput" + rIndex+"a"+ fieldNo;
                                								
                                retValue = retValue + document.all(obj).value + "|";
						        tempQuence = tempQuence.substring(chPos + 1);
                             }
                             //alert(retValue);
                             //alert(retNum);
                             window.returnValue= retValue;
                       }
                }
            }
        if(retValue =="")
        {
            rdShowMessageDialog("请选择信息项！",0);
            return false;
        }
        
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
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
  <table cellspacing="0">
<TR align=center>
<%  //绘制界面表头
     chPos = fieldName.indexOf("|");
     //out.print("");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {
        valueStr = fieldName.substring(0,chPos);
        //titleStr = "";
        out.print("<TH>" + valueStr + "</TH>");
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("");
     fieldNum = String.valueOf(tempNum);
%>
</TR>

<%
    //根据传人的Sql查询数据库，得到返回结果
    try
    {
            //retArray = callView.sPubSelect(fieldNum,sqlStr1);
            %>
        	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="12">
            	<wtc:sql><%=sqlStr1%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="retArr1" scope="end" />
        	<%
        	if(retCode1.equals("000000")){
        	    result = retArr1;
        	}
        	
            //retArray1 = callView.sPubSelect("1",sqlStr);
            %>
        	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="1">
            	<wtc:sql><%=sqlStr%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="retArr2" scope="end" />
        	<%
        	if(retCode2.equals("000000")){
        	    allNumStr = retArr2;
        	}
        	
            //result = (String[][])retArray.get(0);
            //allNumStr = (String[][])retArray1.get(0);
            int recordNum = Integer.parseInt(allNumStr[0][0].trim());
            for(int i=0;i<recordNum;i++)
            {
                typeStr = "";
                inputStr = "";
                out.print("<TR>");
                for(int j=0;j<Integer.parseInt(fieldNum);j++)
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
                            " id='Rinput" + i+"a"+j + "'  class='button' value='" +
                            (result[i][j]).trim() + "'   readonly></TD>";
                    }
                    else
                    {
                        inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                            " id='Rinput" + i+"a"+j + "' class='button' value='" +
                            (result[i][j]).trim() + "'   readonly></TD>";
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
  <TABLE cellSpacing=0>
    <tr><td align=center>
<%
    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
    PageView view = new PageView(request,out,pg);
    view.setVisible(true,true,0,0);
%>
</td></tr>
</table>

<!------------------------------------------------------>
    <TABLE cellSpacing=0>
    <TBODY>
        <TR id="footer">
            <TD>
<%
    if(selType.compareTo("checkbox") == 0)
    {
        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>");
        out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>");
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

  <!------------------------>
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>
